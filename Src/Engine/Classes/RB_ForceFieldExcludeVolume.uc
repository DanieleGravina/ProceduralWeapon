//=============================================================================
// RB_ForceFieldExcludeVolume:  a bounding volume which removes the effect of a physical force field.
// Currently: RB_CylindricalForceActor
//=============================================================================
class RB_ForceFieldExcludeVolume extends Volume
	native(Physics)
	placeable;

/** Used to identify which force fields this excluder applies to, ie if the channel ID matches then the excluder 
excludes this force field*/
var()	int ForceFieldChannel;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   ForceFieldChannel=1
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__Volume:BrushComponent0'
      BlockNonZeroExtent=False
      ObjectArchetype=BrushComponent'Engine.Default__Volume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   CollisionComponent=BrushComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__RB_ForceFieldExcludeVolume"
   ObjectArchetype=Volume'Engine.Default__Volume'
}
