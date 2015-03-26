class ProceduralWeapon extends MyWeapon;

var TestLog myLog;

var float SpreadDist;

var float Gravity;
var float Speed;

var int WeaponID;

function SetTestLog(TestLog log)
{
    myLog = log;
}

function class<Projectile> GetProjectileClass()
{

    if(Gravity == 0)
    {
        return WeaponProjectiles[CurrentFireMode];
    }
    else
    {
        return class 'ProceduralProjectile2';
    }
}

function float GetAIRating()
{
    return AIRating;
}

simulated function StartFire(byte FireModeNum)
{
    if (Instigator == None || !Instigator.bNoWeaponFiring)
    {
        if( Role < Role_Authority )
        {
            // if we're a client, synchronize server
            ServerStartFire(FireModeNum);
        }

        // Start fire locally
        BeginFire(FireModeNum);
        DemoBeginFire(FireModeNum);
    }
}

function float RangedAttackTime()
{
    local UTBot B;

    B = UTBot(Instigator.Controller);
    if ( (B == None) || (B.Enemy == None) )
        return 0;

    return FMin(2,0.3 + VSize(B.Enemy.Location - Instigator.Location)/Speed);
}

function byte BestMode()
{
    local byte Best;
    if ( IsFiring() )
        return CurrentFireMode;

    if ( FRand() < 0.5 )
        Best = 1;

    if ( Best < bZoomedFireMode.Length && bZoomedFireMode[Best] != 0 )
        return 0;
    else
        return Best;
}

simulated state WeaponFiring
{
    /**
     * Called when the weapon is done firing, handles what to do next.
     */
    simulated function RefireCheckTimer()
    {
        // if switching to another weapon, abort firing and put down right away
        if( bWeaponPutDown )
        {
            PutDownWeapon();
            return;
        }

        // If weapon should keep on firing, then do not leave state and fire again.
        if( ShouldRefire() )
        {
            FireAmmunition();
            return;
        }

        // Otherwise we're done firing, so go back to active state.
        GotoState('Active');

    }
}

simulated function ImpactInfo CalcWeaponFire(vector StartTrace, vector EndTrace, optional out array<ImpactInfo> ImpactList)
{
    local vector            HitLocation, HitNormal, Dir;
    local Actor             HitActor;
    local TraceHitInfo      HitInfo;
    local ImpactInfo        CurrentImpact;
    local PortalTeleporter  Portal;
    local float             HitDist;

    // Perform trace to retrieve hit info
    HitActor = GetTraceOwner().Trace(HitLocation, HitNormal, EndTrace, StartTrace, TRUE, vect(0,0,0), HitInfo, TRACEFLAG_Bullet);

    // If we didn't hit anything, then set the HitLocation as being the EndTrace location
    if( HitActor == None )
    {
        HitLocation = EndTrace;
    }

    // Convert Trace Information to ImpactInfo type.
    CurrentImpact.HitActor      = HitActor;
    CurrentImpact.HitLocation   = HitLocation;
    CurrentImpact.HitNormal     = HitNormal;
    CurrentImpact.RayDir        = Normal(EndTrace-StartTrace);
    CurrentImpact.HitInfo       = HitInfo;

    // Add this hit to the ImpactList
    ImpactList[ImpactList.Length] = CurrentImpact;

    // check to see if we've hit a trigger.
    // In this case, we want to add this actor to the list so we can give it damage, and then continue tracing through.
    if( HitActor != None )
    {
        if (!HitActor.bBlockActors && PassThroughDamage(HitActor))
        {
            // disable collision temporarily for the trigger so that we can catch anything inside the trigger
            HitActor.bProjTarget = false;
            // recurse another trace
            CurrentImpact = CalcWeaponFire(HitLocation, EndTrace, ImpactList);
            // and reenable collision for the trigger
            HitActor.bProjTarget = true;
        }
        else
        {
            // if we hit a PortalTeleporter, recurse through
            Portal = PortalTeleporter(HitActor);
            if( Portal != None && Portal.SisterPortal != None )
            {
                Dir = EndTrace - StartTrace;
                HitDist = VSize(HitLocation - StartTrace);
                // calculate new start and end points on the other side of the portal
                StartTrace = Portal.TransformHitLocation(HitLocation);
                EndTrace = StartTrace + Portal.TransformVector(Normal(Dir) * (VSize(Dir) - HitDist));
                //@note: intentionally ignoring return value so our hit of the portal is used for effects
                //@todo: need to figure out how to replicate that there should be effects on the other side as well
                CalcWeaponFire(StartTrace, EndTrace, ImpactList);
            }
        }
    }

    return CurrentImpact;
}

simulated function Rotator GetAdjustedAim( vector StartFireLoc )
{
    local rotator R;

    // Start the chain, see Pawn.GetAdjustedAimFor()
    if( Instigator != None )
    {
        R = Instigator.GetAdjustedAimFor( Self, StartFireLoc );
    }

    return AddSpread(R);
}

simulated function CustomFire()
{
    local int i, y, z, Mag, index, r, WeaponTime;
    local vector RealStartLoc, AimDir, YDir, ZDir;
    local Projectile Proj;
    local class<Projectile> ShardProjectileClass;
    local array<int> indexes;

    IncrementFlashCount();

    if (Role == ROLE_Authority)
    {

        //possible fire areas
        for(i = 0; i < 9; i++)
        {
            indexes.Add(1);
            indexes[i] = i;
        }
        
        // this is the location where the projectile is spawned
        RealStartLoc = GetPhysicalFireStartLoc();
        // get fire aim direction
        GetAxes(GetAdjustedAim(RealStartLoc),AimDir, YDir, ZDir);

        if(myLog != None)
        {
            //Logging
            WeaponTime = myLog.AddWeaponLog(RealStartLoc, Vector(GetAdjustedAim(RealStartLoc)));
        }

        // one shard in each of 9 zones (except center)
        ShardProjectileClass = GetProjectileClass();

        //fire single projectile
        if(ShotCost[0] == 1)
        {
            Proj = Spawn(ShardProjectileClass,,, RealStartLoc);
            if (Proj != None)
            {
                ProceduralProjectile(Proj).SetProceduralProjectile(WeaponID);
                Proj.Init( Vector(AddSpread(GetAdjustedAim( RealStartLoc ))) );
            }

            if(myLog != None)
            {
                ProceduralProjectile(Proj).SetTestLog(myLog, WeaponTime);
            }
        }
        else
        {
            for(i = 0; i < ShotCost[0]; i++)
            {
                r = Rand(indexes.length);
                index = indexes[r];
                indexes.remove(r, 1);

                y = index%3 - 1;
                z = index/3 - 1;

                //`log("[PwWeapon] y, z" $ string(y) $ " " $ string(z) );

                Proj = Spawn(ShardProjectileClass,,, RealStartLoc);

                if ( (y != 0) || (z != 0) )
                {
                    Mag = (abs(y)+abs(z) > 1) ? 0.7 : 1.0;
                    if (Proj != None && !Proj.bDeleteMe)
                    {
                        ProceduralProjectile(Proj).SetProceduralProjectile(WeaponID);
                        Proj.Init(AimDir + (0.3 + 0.7*FRand())*Mag*y*SpreadDist*YDir + (0.3 + 0.7*FRand())*Mag*z*SpreadDist*ZDir );
                    }
                }
                else
                {
                    if (Proj != None && !Proj.bDeleteMe)
                    {
                        ProceduralProjectile(Proj).SetProceduralProjectile(WeaponID);
                        Proj.Init( Vector(AddSpread(GetAdjustedAim( RealStartLoc ))) );
                    }
                }

                if(myLog != None)
                {
                    ProceduralProjectile(Proj).SetTestLog(myLog, WeaponTime);
                } 
            }
        }
    }
}

function float GetOptimalRangeFor(Actor Target)
{
    return MaxRange();
}

simulated function float MaxRange()
{
    return WeaponRange;
}

defaultproperties
{
    WeaponID = 0

    SpreadDist=0.100000
    Gravity = 0;
    Speed = 1;

	// Weapon SkeletalMesh
    Begin Object class=AnimNodeSequence Name=MeshSequenceA
    End Object

    // Weapon SkeletalMesh
    Begin Object Name=FirstPersonMesh
        SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_1P'
        AnimSets(0)=AnimSet'WP_ShockRifle.Anim.K_WP_ShockRifle_1P_Base'
        Animations=MeshSequenceA
        Rotation=(Yaw=-16384)
        FOV=60.0
    End Object

    // PickupMesh
    Begin Object Name=PickupMesh
        SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_3P'
    End Object
    
    // Attachment class
    AttachmentClass=Class'UTGame.UTAttachment_RocketLauncher'

    // Defines the type of fire for each mode
    WeaponFireTypes(0)=EWFT_Custom
    WeaponFireTypes(1)=EWFT_Custom
    WeaponProjectiles(1)=class'ProceduralProjectile'
    WeaponProjectiles(0)=class'ProceduralProjectile'

    // Damage types
    InstantHitDamage(0)=0
    FireInterval(0)=+1.0
    FireInterval(1)=+1.0
    InstantHitDamageTypes(0)=None
    InstantHitDamageTypes(1)=None                   // Not an instant hit weapon, so set to "None"

    
    // Sound effects
    WeaponFireSnd[0]=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_FireCue'
    WeaponFireSnd[1]=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Fire_Cue'
    WeaponEquipSnd=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_RaiseCue'
    WeaponPutDownSnd=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_LowerCue'
    PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_Shock_Cue'
    
     // AI logic
    MaxDesireability=0.8                           // Max desireability for bots
    AIRating=0.8
    CurrentRating=0.8
    bInstantHit=false                               // Is it an instant hit weapon?
    bSplashJump=false
    bRecommendSplashDamage=true                     // Can a bot use this for splash damage?
    bSniping=false                                  // Could a bot snipe with this?
    ShouldFireOnRelease(0)=0                        // Should it fire when the mouse is released?
    ShouldFireOnRelease(1)=0                        // Should it fire when the mouse is released?
    
    FireOffset=(X=20,Y=5)                           // Holds an offset for spawning protectile effects
    PlayerViewOffset=(X=17,Y=10.0,Z=-8.0)           // Offset from view center (first person)
    
    // camera anim to play when firing (for camera shakes)
    FireCameraAnim(0)=CameraAnim'Camera_FX.ShockRifle.C_WP_ShockRifle_Alt_Fire_Shake'
    FireCameraAnim(1)=CameraAnim'Camera_FX.ShockRifle.C_WP_ShockRifle_Alt_Fire_Shake'
    
    // Animation to play when the weapon is fired
    WeaponFireAnim(0)=WeaponAltFire
    WeaponFireAnim(1)=WeaponAltFire
    
    
    // Muzzle flashes
    MuzzleFlashPSCTemplate=WP_ShockRifle.Particles.P_ShockRifle_MF_Alt
    MuzzleFlashAltPSCTemplate=WP_ShockRifle.Particles.P_ShockRifle_MF_Alt
    MuzzleFlashColor=(R=200,G=120,B=255,A=255)
    MuzzleFlashDuration=0.33
    MuzzleFlashLightClass=class'UTGame.UTShockMuzzleFlashLight'
    CrossHairCoordinates=(U=256,V=0,UL=64,VL=64)
    LockerRotation=(Pitch=32768,Roll=16384)
    
    
    // Crosshair
    IconCoordinates=(U=728,V=382,UL=162,VL=45)
    IconX=400
    IconY=129
    IconWidth=22
    IconHeight=48
    
    // The Color used when drawing the Weapon's Name on the Hud
    WeaponColor=(R=160,G=0,B=255,A=255)
    
     // Inventory
    InventoryGroup=4                                // The weapon/inventory set, 0-9
    GroupWeight=0.5                                 // position within inventory group. (used by prevweapon and nextweapon)

   // Manages the waveform data for a forcefeedback device,
    // specifically for the xbox gamepads.
    Begin Object Class=ForceFeedbackWaveform Name=ForceFeedbackWaveformShooting1
        Samples(0)=(LeftAmplitude=90,RightAmplitude=40,LeftFunction=WF_Constant,RightFunction=WF_LinearDecreasing,Duration=0.1200)
    End Object
    
    // controller rumble to play when firing
    WeaponFireWaveForm=ForceFeedbackWaveformShooting1 
    
    Priority = 11
}