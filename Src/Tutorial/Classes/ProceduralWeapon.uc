class ProceduralWeapon extends MyWeapon;

var float SpreadDist;

var TcpLinkServer tcp_server;

var float speed_grav;

function class<Projectile> GetProjectileClass()
{
    if(speed_grav == 0){
        if(ServerGame(WorldInfo.Game).GetPPParameters().Gravity != 0)
        {
            speed_grav = Abs(ServerGame(WorldInfo.Game).GetPPParameters().Speed / ServerGame(WorldInfo.Game).GetPPParameters().Gravity);
        }
        else
        {
            speed_grav = 1;
        }
    }

    if(speed_grav >= 7000 || speed_grav <= 5)
    {
        return WeaponProjectiles[CurrentFireMode];
    }
    else
    {
        return class 'ProceduralProjectile2';
    }
}


simulated function Rotator GetAdjustedAim( vector StartFireLoc )
{
    local rotator R;

    // Start the chain, see Pawn.GetAdjustedAimFor()
    if( Instigator != None )
    {
        R = Instigator.GetAdjustedAimFor( Self, StartFireLoc );

        if ( (PlayerController(Instigator.Controller) != None) && (CurrentFireMode == 1) )
        {
            R.Pitch = R.Pitch & 65535;
            if ( R.Pitch < 16384 )
            {
                R.Pitch += (16384 - R.Pitch)/32;
            }
            else if ( R.Pitch > 49152 )
            {
                R.Pitch += 512;
            }
        }
    }

    return R;
}

function SetStatProjectile(Projectile proj, Vector start_loc)
{
    ProceduralProjectile(proj).tcp_server = tcp_server;

    ProceduralProjectile(proj).time_weapon = WorldInfo.RealTimeSeconds;

    ProceduralProjectile(proj).start_location = start_loc;
}

simulated function CustomFire()
{
    local int i, y, z, Mag, index, r;
    local vector RealStartLoc, AimDir, YDir, ZDir;
    local Projectile Proj;
    local class<Projectile> ShardProjectileClass;
    local array<int> indexes;

    if (Role == ROLE_Authority)
    {

        ServerGame(WorldInfo.Game).SetPPParameters(Instigator.Controller.PlayerReplicationInfo.PlayerName);

        //possible fire areas
        for(i = 0; i < 9; i++)
        {
            indexes.Add(1);
            indexes[i] = i;
        }

        // this is the location where the projectile is spawned
        RealStartLoc = GetPhysicalFireStartLoc();

        //`log("[ProceduralWeapon] Fire pos "$string(RealStartLoc));
        
        // get fire aim direction
        GetAxes(GetAdjustedAim(RealStartLoc),AimDir, YDir, ZDir);

        // one shard in each of 9 zones (except center)
        ShardProjectileClass = GetProjectileClass();

        //fire single projectile
        if(ShotCost[0] == 1)
        {
            Proj = Spawn(ShardProjectileClass,,, RealStartLoc);
            if (Proj != None)
            {
                SetStatProjectile(Proj, RealStartLoc);
                Proj.Init( Vector(AddSpread(GetAdjustedAim( RealStartLoc ))) );
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
                        SetStatProjectile(Proj, RealStartLoc);
                        Proj.Init(AimDir + (0.3 + 0.7*FRand())*Mag*y*SpreadDist*YDir + (0.3 + 0.7*FRand())*Mag*z*SpreadDist*ZDir );
                    }
                }
                else
                {
                    if (Proj != None && !Proj.bDeleteMe)
                    {
                        SetStatProjectile(Proj, RealStartLoc);
                        Proj.Init( Vector(AddSpread(GetAdjustedAim( RealStartLoc ))) );
                    }
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
    speed_grav = 0
    SpreadDist=0.100000

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
    AttachmentClass=Class'UTGame.UTAttachment_ShockRifle'

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
    LockAcquiredSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_SeekLock_Cue'
    LockLostSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_SeekLost_Cue'
    
     // AI logic
    MaxDesireability=1                           // Max desireability for bots
    AIRating=1
    CurrentRating=1
    bInstantHit=false                               // Is it an instant hit weapon?
    bSplashJump=false
    bRecommendSplashDamage=false                     // Can a bot use this for splash damage?
    bSniping=false                                  // Could a bot snipe with this?
    ShouldFireOnRelease(0)=0                        // Should it fire when the mouse is released?
    ShouldFireOnRelease(1)=0                        // Should it fire when the mouse is released?
    
    FireOffset=(X=20,Y=5)                           // Holds an offset for spawning protectile effects
    PlayerViewOffset=(X=17,Y=10.0,Z=-8.0)           // Offset from view center (first person)
    
    // Homing properties
    ConsoleLockAim=0.992                            // angle for locking for lock targets when on Console
    LockRange=9000                                  // How far out should we be considering actors for a lock
    LockAim=0.997                                   // angle for locking for lock target
    LockChecktime=0.1                               // The frequency with which we will check for a lock 
    LockAcquireTime=.3                              // How long does the player need to target an actor to lock on to it
    LockTolerance=0.8
    
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