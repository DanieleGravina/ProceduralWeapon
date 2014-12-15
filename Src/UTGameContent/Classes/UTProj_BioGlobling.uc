/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTProj_BioGlobling extends UTProj_BioShot;

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	if ( Other.bProjTarget && (UTProj_BioGlob(Other) == None) && !bExploded )
	{
		Other.TakeDamage(Damage, InstigatorController, Location, MomentumTransfer * Normal(Velocity), MyDamageType,, self);
		Explode( HitLocation, HitNormal );
	}
}

auto state Flying
{
	simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
	{
		Global.ProcessTouch(Other, HitLocation, HitNormal);
   	}
}

state OnGround
{
	simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
	{
		Global.ProcessTouch(Other, HitLocation, HitNormal);
	}
}

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=ProjectileMesh ObjName=ProjectileMesh Archetype=StaticMeshComponent'UTGameContent.Default__UTProj_BioShot:ProjectileMesh'
      ObjectArchetype=StaticMeshComponent'UTGameContent.Default__UTProj_BioShot:ProjectileMesh'
   End Object
   GooMesh=ProjectileMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTProj_BioShot:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTProj_BioShot:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=ProjectileMesh
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_BioGlobling"
   ObjectArchetype=UTProj_BioShot'UTGameContent.Default__UTProj_BioShot'
}
