/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTWarfareChildBarricade extends Actor
	abstract
	placeable;

var()		UTWarfareBarricade ParentBarricade;
var			UTWarfareChildBarricade NextBarricade;

simulated event PostBeginPlay()
{
	local UTWarfareBarricade B;
	local float NewDist, BestDist;

	Super.PostBeginPlay();

	if ( ParentBarricade == None )
	{
		// find a barricade
		LogInternal(self$" does not have parent barricade set!");
		ForEach WorldInfo.AllNavigationPoints(class'UTWarfareBarricade', B)
		{
			NewDist = VSize(Location - B.Location);
			if ( (ParentBarricade == None) || (NewDist < BestDist) )
			{
				ParentBarricade = B;
				BestDist = NewDist;
			}
		}
	}
	if ( ParentBarricade != None )
	{
		ParentBarricade.RegisterChild(self);
	}
}

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if ( ParentBarricade != None )
	{
		ParentBarricade.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
	}
}

simulated function DisableBarricade()
{
	SetCollision(false, false);
	SetHidden(true);
	CollisionComponent.SetBlockRigidBody(false);
}

simulated function EnableBarricade()
{
	SetCollision(true, true);
	SetHidden(false);
	CollisionComponent.SetBlockRigidBody(true);
}

defaultproperties
{
   bNoDelete=True
   bMovable=False
   bCollideActors=True
   bBlockActors=True
   bProjTarget=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTWarfareChildBarricade"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
