class ProceduralProjectile extends UTProjectile;

//class that collect data from weapon and projectiles
var TcpLinkServer tcp_server;

// time and location when this projectile has been fired
var float time_weapon;
var vector start_location;

var bool bHasBounce;

function Init(vector Direction)
{
	local string playerName;

	playerName = InstigatorController.PlayerReplicationInfo.PlayerName;
	
	ServerGame(WorldInfo.Game).SetPPParameters(playerName);
	
	AccelRate = ServerGame(WorldInfo.Game).GetPPParameters().Speed;
	Damage = ServerGame(WorldInfo.Game).GetPPParameters().Damage;
	bWideCheck = true;
	CheckRadius = ServerGame(WorldInfo.Game).GetPPParameters().DamageRadius;
	//TossZ = ServerGame(WorldInfo.Game).GetPPParameters().Gravity;
	LifeSpan = ServerGame(WorldInfo.Game).GetPWParameters().Range;
	DamageRadius = ServerGame(WorldInfo.Game).GetPPParameters().Explosive;

	Speed = AccelRate;
	
	MaxSpeed = Speed;
  
   Super.Init(Direction);

/*
	`log("[ProceduralProjectile] AccelRate "$string(AccelRate));
	`log("[ProceduralProjectile] Damage "$string(Damage));
	`log("[ProceduralProjectile] CheckRadius "$string(CheckRadius));
	`log("[ProceduralProjectile] TossZ "$string(TossZ));
	`log("[ProceduralProjectile] LifeSpan "$string(LifeSpan));	
*/
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
   /*local bool bHasKilled, bIsAlreadyKilled;

   bIsAlreadyKilled = false;
   bHasKilled = false;

   `log("[ProceduralProjectile] HitBot "$string(HitLocation)); 

   if(PWPawn(Other).Health <= 0)
   {
      bIsAlreadyKilled = true;
   }*/

   Super.ProcessTouch(Other, HitLocation, HitNormal);

   /*if(PWPawn(Other).Health <= 0 && !bIsAlreadyKilled)
   {
      bHasKilled = true;
   }*/

   if(tcp_server.currentAcceptor != none)
   {

      TcpLinkServerAcceptor(tcp_server.currentAcceptor).SetStatKill(InstigatorController.PlayerReplicationInfo.PlayerName, 
                               WorldInfo.RealTimeSeconds - time_weapon, Vsize(HitLocation - start_location));
   }
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
   local vector SpawnPos, BaseChunkDir;
   local actor HitActor;
   local rotator rot;
   local int i;
   local ProceduralProjectile NewChunk;

   Super.Explode(HitLocation, HitNormal);

   if(bHasBounce)
   {
      SpawnPos = Location + 10 * HitNormal;

      HitActor = Trace(HitLocation, HitNormal, SpawnPos, Location, false);
      if (HitActor != None)
      {
         SpawnPos = HitLocation;
      }

      if ( (Role == ROLE_Authority) && (UTVehicle(ImpactedActor) == None) )
      {
         BaseChunkDir = Normal(HitNormal + 0.8 * Normal(Velocity));
         for (i = 0; i < 5; i++)
         {
            rot = rotator(4*BaseChunkDir + VRand());
            
            if(self.isA('ProceduralProjectile'))
            {
               NewChunk = Spawn(class 'ProceduralProjectile',, '', SpawnPos, rot);
            }
            else
            {
               NewChunk = Spawn(class 'ProceduralProjectile2',, '', SpawnPos, rot);
            }

            if (NewChunk != None)
            {
               //NewChunk.bCheckShortRangeKill = false;
               NewChunk.tcp_server = tcp_server;
               NewChunk.time_weapon = time_weapon;
               NewChunk.start_location = start_location;

               NewChunk.Init(vector(rot));
            }
         }
      }
   }
}

simulated function bool ProjectileHurtRadius( float DamageAmount, float InDamageRadius, class<DamageType> DamageType, float Momentum,
                  vector HurtOrigin, vector HitNormal, optional class<DamageType> ImpactedActorDamageType )
{
   local bool bCausedDamage, bInitializedAltOrigin, bFailedAltOrigin;
   local Actor Victim;
   local vector AltOrigin;

   // Prevent HurtRadius() from being reentrant.
   if ( bHurtEntry || bShuttingDown )
      return false;

   bHurtEntry = true;
   bCausedDamage = false;

   // if ImpactedActor is set, we actually want to give it full damage, and then let him be ignored by super.HurtRadius()
   if ( (ImpactedActor != None) && (ImpactedActor != self)  )
   {
      ImpactedActor.TakeRadiusDamage( InstigatorController, DamageAmount, InDamageRadius,
                  (ImpactedActorDamageType != None) ? ImpactedActorDamageType : DamageType,
                  Momentum, HurtOrigin, true, self );
      // need to check again in case TakeRadiusDamage() did something that went through our explosion path a second time
      if (ImpactedActor != None)
      {
         bCausedDamage = ImpactedActor.bProjTarget;
      }
   }

   foreach CollidingActors( class'Actor', Victim, DamageRadius, HurtOrigin )
   {
      if ( !Victim.bWorldGeometry && (Victim != self) && (Victim != ImpactedActor) && (Victim.bProjTarget || (NavigationPoint(Victim) == None)) )
      {
         if ( !FastTrace(HurtOrigin, Victim.Location,, TRUE) )
         {
            // try out from wall, in case trace start was embedded
            if ( !bInitializedAltOrigin )
            {
               // initialize alternate trace start
               bInitializedAltOrigin = true;
               AltOrigin = HurtOrigin + class'UTPawn'.Default.MaxStepHeight * HitNormal;
               if ( !FastTrace(HurtOrigin, AltOrigin,, TRUE) )
               {
                  if ( Velocity == vect(0,0,0) )
                  {
                     bFailedAltOrigin = true;
                  }
                  else
                  {
                     AltOrigin = HurtOrigin - class'UTPawn'.Default.MaxStepHeight * normal(Velocity);
                     bFailedAltOrigin = !FastTrace(HurtOrigin, AltOrigin,, TRUE);
                  }
               }
            }
            if ( bFailedAltOrigin || !FastTrace(AltOrigin, Victim.Location,, TRUE) )
            {
               continue;
            }
         }
         Victim.TakeRadiusDamage(InstigatorController, DamageAmount, DamageRadius, DamageType, Momentum, HurtOrigin, false, self);
         bCausedDamage = bCausedDamage || Victim.bProjTarget;

         if(PWPawn(Victim) != None && PWPawn(Victim).controller != InstigatorController)
         {
            if(tcp_server.currentAcceptor != None)
            {
               TcpLinkServerAcceptor(tcp_server.currentAcceptor).SetStatKill(InstigatorController.PlayerReplicationInfo.PlayerName, 
                                  WorldInfo.RealTimeSeconds - time_weapon, 
                                  Vsize(HurtOrigin - start_location));
            }
         }
      }
   }
   bHurtEntry = false;

   return bCausedDamage;
}

defaultproperties
{
   bCheckProjectileLight=True
   AmbientSound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireTravelCue'
   ExplosionSound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireImpactCue'
   ProjFlightTemplate=ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball'
   ProjExplosionTemplate=ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball_Impact'
   MaxEffectDistance=7000.000000
   CheckRadius=40.000000
   ProjectileLightClass=Class'UTGame.UTShockBallLight'
   Speed=1150.000000
   MaxSpeed=1150.000000
   Damage=55.000000
   MomentumTransfer=70000.000000
   MyDamageType=Class'Tutorial.UTDmgType_Procedural'
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   bNetTemporary=False
   bCollideComplex=False
   bProjTarget=True
   LifeSpan=8.000000
   CollisionComponent=CollisionCylinder
   Name="Default__Procedural_Projectile"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'

   bHasBounce = false;
}