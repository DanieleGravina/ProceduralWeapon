/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTOnslaughtGodBeam_Content extends UTOnslaughtGodBeam
	notplaceable;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent9 ObjName=StaticMeshComponent9 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'Onslaught_Effects.Meshes.S_Onslaught_FX_GodBeam'
      bUseAsOccluder=False
      CastShadow=False
      bAcceptsLights=False
      CollideActors=False
      BlockActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=-400.000000)
      Scale3D=(X=2.000000,Y=2.000000,Z=2.000000)
      Name="StaticMeshComponent9"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   NodeBeamEffect=StaticMeshComponent9
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   Components(1)=StaticMeshComponent9
   bIgnoreBaseRotation=True
   Name="Default__UTOnslaughtGodBeam_Content"
   ObjectArchetype=UTOnslaughtGodBeam'UTGame.Default__UTOnslaughtGodBeam'
}
