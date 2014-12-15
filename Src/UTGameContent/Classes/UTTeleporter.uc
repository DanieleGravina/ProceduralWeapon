/** UT version of the teleporter with custom effects */
class UTTeleporter extends UTTeleporterBase
	hidecategories(SceneCapture);

/** component that plays the render-to-texture portal effect */
var ParticleSystemComponent PortalEffect;

/**
 * The base of the teleporter.  We hold a reference to it so that
 * it gets serialized to disk, and so we can statically light it.
 */
var StaticMeshComponent TeleporterBaseMesh;

simulated function InitializePortalEffect(Actor Dest)
{
	Super.InitializePortalEffect(Dest);
	if (Dest != None)
	{
		SceneCapture2DComponent(PortalCaptureComponent).SetCaptureParameters(TextureTarget);
		SceneCapture2DComponent(PortalCaptureComponent).SetView(Dest.Location + vector(Dest.Rotation) * 15.0, Dest.Rotation);
		PortalEffect.SetMaterialParameter('Portal', PortalMaterialInstance);
	}
}

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent1 ObjName=ParticleSystemComponent1 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Base_Teleporter.Effects.P_Pickups_Teleporter_Idle'
      Name="ParticleSystemComponent1"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   PortalEffect=ParticleSystemComponent1
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'GP_Onslaught.Mesh.S_GP_Ons_Conduit'
      bUseAsOccluder=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      LightingChannels=(BSP=True,Static=True)
      BlockNonZeroExtent=False
      Translation=(X=0.000000,Y=0.000000,Z=-34.000000)
      Scale=0.500000
      Name="StaticMeshComponent0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   TeleporterBaseMesh=StaticMeshComponent0
   Begin Object Class=SceneCapture2DComponent Name=SceneCapture2DComponent0 ObjName=SceneCapture2DComponent0 Archetype=SceneCapture2DComponent'Engine.Default__SceneCapture2DComponent'
      NearPlane=10.000000
      FarPlane=-1.000000
      bUpdateMatrices=False
      bSkipUpdateIfOwnerOccluded=True
      FrameRate=15.000000
      MaxUpdateDist=1000.000000
      MaxStreamingUpdateDist=1000.000000
      Name="SceneCapture2DComponent0"
      ObjectArchetype=SceneCapture2DComponent'Engine.Default__SceneCapture2DComponent'
   End Object
   PortalCaptureComponent=SceneCapture2DComponent0
   PortalMaterial=Material'PICKUPS.Base_Teleporter.Material.M_T_Pickups_Teleporter_Portal_Destination'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTTeleporterBase:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTTeleporterBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTTeleporterBase:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTTeleporterBase:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'UTGame.Default__UTTeleporterBase:Sprite2'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTTeleporterBase:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTTeleporterBase:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTTeleporterBase:Arrow'
   End Object
   Components(1)=Arrow
   Components(2)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTTeleporterBase:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTTeleporterBase:PathRenderer'
   End Object
   Components(3)=PathRenderer
   Begin Object Class=AudioComponent Name=AmbientSound ObjName=AmbientSound Archetype=AudioComponent'UTGame.Default__UTTeleporterBase:AmbientSound'
      ObjectArchetype=AudioComponent'UTGame.Default__UTTeleporterBase:AmbientSound'
   End Object
   Components(4)=AmbientSound
   Components(5)=StaticMeshComponent0
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Base_Teleporter.Effects.P_Pickups_Teleporter_Base_Idle'
      Translation=(X=0.000000,Y=0.000000,Z=-40.000000)
      Name="ParticleSystemComponent0"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   Components(6)=ParticleSystemComponent0
   Components(7)=ParticleSystemComponent1
   CollisionComponent=CollisionCylinder
   Name="Default__UTTeleporter"
   ObjectArchetype=UTTeleporterBase'UTGame.Default__UTTeleporterBase'
}
