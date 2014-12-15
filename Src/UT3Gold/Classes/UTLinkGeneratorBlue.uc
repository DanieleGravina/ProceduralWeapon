class UTLinkGeneratorBlue extends UTLinkGenerator;

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=DeployableMesh ObjName=DeployableMesh Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_Shield'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UT3Gold.Default__UTLinkGeneratorBlue:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_Shield'
      Materials(0)=Material'PICKUPS_2.Deployables.Materials.M_Deployables_LinkStation'
      LightEnvironment=DynamicLightEnvironmentComponent'UT3Gold.Default__UTLinkGeneratorBlue:MyLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      Name="DeployableMesh"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   ShieldBase=DeployableMesh
   SpawnSound=SoundCue'A_Pickups_Deployables.ShieldGenerator.ShieldGenerator_OpenCue'
   DestroySound=SoundCue'A_Pickups_Deployables.ShieldGenerator.ShieldGenerator_CloseCue'
   LinkBeamColor=(B=255,G=64,R=64,A=255)
   LinkBeamSystem=ParticleSystem'FX_Gametypes.Effects.P_Link_Generator_Beam_Blue'
   WallHitTemplate=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Beam_Impact_HIT'
   BeamEndpointTemplate=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Beam_Impact_Blue'
   BeamTemplate=ParticleSystem'FX_Gametypes.Effects.P_Link_Generator_Beam_Blue'
   Begin Object Class=ParticleSystemComponent Name=VisualEffect ObjName=VisualEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'PICKUPS_2.Deployables.Effects.FX_Deployables_LinkStation_Discharge'
      bAutoActivate=False
      Name="VisualEffect"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   DischargeEffect=VisualEffect
   MyDamageType=Class'UT3Gold.UTDmgType_LinkGenerator'
   TeamNum=1
   Begin Object Class=DynamicLightEnvironmentComponent Name=DeployedLightEnvironment ObjName=DeployedLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTLinkGenerator:DeployedLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTLinkGenerator:DeployedLightEnvironment'
   End Object
   LightEnvironment=DeployedLightEnvironment
   Components(0)=DeployedLightEnvironment
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTLinkGenerator:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTLinkGenerator:MyLightEnvironment'
   End Object
   Components(1)=MyLightEnvironment
   Begin Object Class=AudioComponent Name=AmbientSoundComponent ObjName=AmbientSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_ShieldAmbient'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="AmbientSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   Components(2)=AmbientSoundComponent
   Components(3)=DeployableMesh
   Components(4)=VisualEffect
   CollisionComponent=DeployableMesh
   Name="Default__UTLinkGeneratorBlue"
   ObjectArchetype=UTLinkGenerator'UTGame.Default__UTLinkGenerator'
}
