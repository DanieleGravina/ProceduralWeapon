class MyWeapon_HomingRocket extends MyWeapon;

defaultproperties
{
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
    AttachmentClass=class'UTGameContent.UTAttachment_ShockRifle'

    // Defines the type of fire for each mode
    WeaponFireTypes(0)=EWFT_InstantHit
    WeaponFireTypes(1)=EWFT_Projectile
    WeaponProjectiles(1)=class'UTProj_Rocket'

    // Damage types
    InstantHitDamage(0)=45
    FireInterval(0)=+1.0
    FireInterval(1)=+1.3
    InstantHitDamageTypes(0)=class'UTDmgType_ShockPrimary'
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
    MaxDesireability=0.65                           // Max desireability for bots
    AIRating=0.65
    CurrentRating=0.65
    bInstantHit=true                                // Is it an instant hit weapon?
    bSplashJump=false
    bRecommendSplashDamage=true                     // Can a bot use this for splash damage?
    bSniping=true                                   // Could a bot snipe with this?
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
    SeekingRocketClass=class'UTProj_SeekingRocket'
    
    // camera anim to play when firing (for camera shakes)
    FireCameraAnim(1)=CameraAnim'Camera_FX.ShockRifle.C_WP_ShockRifle_Alt_Fire_Shake'
    
    // Animation to play when the weapon is fired
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
}