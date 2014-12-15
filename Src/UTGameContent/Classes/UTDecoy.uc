/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
//-----------------------------------------------------------
//  When out in the world, this can be used to decoy an avril.
//-----------------------------------------------------------
class UTDecoy extends UTProjectile;

/** Max distance a missile can be to be affected */
var float DecoyRange;
/** Protect this vehicle */
var UTVehicle_Cicada_Content ProtectedTarget;

function bool CheckRange(Actor Aggressor)
{
	return VSize(Aggressor.Location - Location) <= DecoyRange;
}

simulated event Destroyed()
{
	local int i;

	Super.Destroyed();

	if (ProtectedTarget != None)
	{
		// Remove it from the Dual Attack craft's array
		for (i = 0; i < ProtectedTarget.Decoys.Length; i++)
		{
			if (ProtectedTarget.Decoys[i] == self)
			{
				ProtectedTarget.Decoys.Remove(i, 1);
				return;
			}
		}
	}
}


simulated function Landed(vector HitNormal, Actor FloorActor)
{
	Super.Landed(HitNormal, FloorActor);
	Destroy();
}

defaultproperties
{
   DecoyRange=2048.000000
   ProjFlightTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_DecoyFlare'
   ProjExplosionTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_Decoy_Explo'
   Speed=1000.000000
   MaxSpeed=1500.000000
   Damage=50.000000
   DamageRadius=250.000000
   MomentumTransfer=10000.000000
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Physics=PHYS_Falling
   bBounce=True
   LifeSpan=5.000000
   CollisionComponent=CollisionCylinder
   Name="Default__UTDecoy"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
