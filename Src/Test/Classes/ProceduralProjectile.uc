class ProceduralProjectile extends UTProjectile
	dependson(TestGame);

var TestLog myLog;
var int WeaponTime;

function SetTestLog(TestLog log, int IdWeap)
{
    myLog = log;
    WeaponTime = IdWeap;
}

function SetProceduralProjectile(int WeaponID)
{
	local string playerName;
	local array<PWParameters> weaponPars;
	local array<PPParameters> projPars;

	playerName = InstigatorController.PlayerReplicationInfo.PlayerName;
	
	weaponPars = TestGame(WorldInfo.Game).GetPWParameters(playerName);
	projPars = TestGame(WorldInfo.Game).GetPPParameters(playerName);
	
	AccelRate = projPars[WeaponID].Speed;
	Damage = projPars[WeaponID].Damage;
	bWideCheck = true;
	CheckRadius = projPars[WeaponID].DamageRadius;
	LifeSpan = weaponPars[WeaponID].Range;
	DamageRadius = projPars[WeaponID].Explosive;

	Speed = AccelRate;
	
	MaxSpeed = Speed;
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
	local bool bHasKilled, bIsAlreadyKilled;
	//local string killer, killed;

	bIsAlreadyKilled = false;
	bHasKilled = false;

	if(myLog != None)
	{
		//killer = InstigatorController.PlayerReplicationInfo.playername;
		//killed = PWPawn(Other).PlayerReplicationInfo.playername;

		if(Other == None || PWPawn(Other).Health <= 0)
		{
			bIsAlreadyKilled = true;
		}
	}

	Super.ProcessTouch(Other, HitLocation, HitNormal);

	if(myLog != None)
	{
		if(!bIsAlreadyKilled && Other != None && PWPawn(Other).Health <= 0)
		{
			bHasKilled = true;
		}

		myLog.AddProjectileLog(HitLocation, true, bHasKilled, WeaponTime);
	}
}

simulated singular event HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp)
{
	if(myLog != None)
	{
		myLog.AddProjectileLog(Wall.Location, false, false, WeaponTime);
	}

	ImpactedActor = Wall;

	if ( !Wall.bStatic && !Wall.bWorldGeometry )
	{
		if ( DamageRadius == 0 )
		{
			Wall.TakeDamage( Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		}
	}

	Explode(Location, HitNormal);
	ImpactedActor = None;
}

simulated function bool ProjectileHurtRadius( float DamageAmount, float InDamageRadius, class<DamageType> DamageType, float Momentum,
                  vector HurtOrigin, vector HitNormal, optional class<DamageType> ImpactedActorDamageType )
{
   local bool bCausedDamage, bInitializedAltOrigin, bFailedAltOrigin;
   local Actor Victim;
   local vector AltOrigin;

   local bool bHasKilled, bIsAlreadyKilled;

   bHasKilled = false;
   bIsAlreadyKilled = false;

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

         if(PWPawn(Victim) != None && PWPawn(Victim).Health <= 0)
         {
         	bIsAlreadyKilled = true;
         }

         Victim.TakeRadiusDamage(InstigatorController, DamageAmount, DamageRadius, DamageType, Momentum, HurtOrigin, false, self);
         bCausedDamage = bCausedDamage || Victim.bProjTarget;

         if(PWPawn(Victim) != None && PWPawn(Victim).controller != InstigatorController)
         {
            if(myLog != None)
            {
            	if(PWPawn(Victim).Health <= 0 && !bIsAlreadyKilled)
            	{
            		bHasKilled = true;
            	}

            	myLog.AddProjectileLog(Victim.Location, true, bHasKilled, WeaponTime);

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
   MyDamageType=Class'Test.UTDmgType_Procedural'
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   bNetTemporary=False
   bCollideComplex=False
   bProjTarget=True
   LifeSpan=8.000000
   CollisionComponent=CollisionCylinder
   Name="Default__Procedural_Projectile"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}