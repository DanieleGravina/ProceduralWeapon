/** Concrete version of DynamicSMActor for spawning mid-game. */
class DynamicSMActor_Spawnable extends DynamicSMActor;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__DynamicSMActor:StaticMeshComponent0'
      ObjectArchetype=StaticMeshComponent'Engine.Default__DynamicSMActor:StaticMeshComponent0'
   End Object
   StaticMeshComponent=StaticMeshComponent0
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicSMActor:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicSMActor:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Components(0)=MyLightEnvironment
   Components(1)=StaticMeshComponent0
   bCollideActors=True
   bBlockActors=True
   CollisionComponent=StaticMeshComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__DynamicSMActor_Spawnable"
   ObjectArchetype=DynamicSMActor'Engine.Default__DynamicSMActor'
}
