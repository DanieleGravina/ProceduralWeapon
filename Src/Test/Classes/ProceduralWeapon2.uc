class ProceduralWeapon2 extends ProceduralWeapon;

DefaultProperties
{

	// Weapon SkeletalMesh
    Begin Object Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
      FOV=60.000000
       Rotation=(Yaw=0)
      SkeletalMesh=SkeletalMesh'WP_RocketLauncher.Mesh.SK_WP_RocketLauncher_1P'
      AnimTreeTemplate=AnimTree'WP_RocketLauncher.Anims.AT_WP_RocketLauncher_1P_Base'
      AnimSets(0)=AnimSet'WP_RocketLauncher.Anims.K_WP_RocketLauncher_1P_Base'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
    End Object

	// PickupMesh
	Begin Object Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
	  SkeletalMesh=SkeletalMesh'WP_RocketLauncher.Mesh.SK_WP_RocketLauncher_3P'
	  ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
	End Object

	IconX=460
	IconY=34
	IconWidth=51
	IconHeight=38
	IconCoordinates=(U=131.000000,V=379.000000,UL=129.000000,VL=50.000000)
	CrossHairCoordinates=(U=128.000000)

	LockerRotation=(Pitch=0,Yaw=0,Roll=-16384)
	FireOffset=(X=20,Y=5) 
	Mesh=FirstPersonMesh
	ObjectArchetype=UTWeapon'UTGame.Default__UTWeapon'

	// Attachment class
	AttachmentClass=Class'UTGame.UTAttachment_RocketLauncher'

	MuzzleFlashSocket="MuzzleFlashSocketA"
	MuzzleFlashPSCTemplate=ParticleSystem'WP_RocketLauncher.Effects.P_WP_RockerLauncher_Muzzle_Flash'
	MuzzleFlashLightClass=Class'UTGame.UTRocketMuzzleFlashLight'
}

