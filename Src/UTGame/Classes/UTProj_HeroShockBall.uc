/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_HeroShockBall extends UTProj_ShockBall;

var bool bAlreadyComboed;

function ComboExplosion()
{
	local UTProj_HeroShockball B;

	if ( bShuttingDown )
	{
		return;
	}

	Super.ComboExplosion();
	bAlreadyComboed = true;
	ForEach VisibleCollidingActors ( class'UTProj_HeroShockBall', B, 1000.0)
	{
		if ( !B.bAlreadyComboed )
		{
			B.bAlreadyComboed = true;
			B.SetTimer(0.35, false, 'ComboExplosion');
			break;
		}
	}
}

defaultproperties
{
   ComboDamageType=Class'UTGame.UTDmgType_HeroShockCombo'
   ComboTriggerType=Class'UTGame.UTDmgType_HeroShockPrimary'
   ComboRadius=300.000000
   ComboExplosionEffect=Class'UTGame.UTEmit_HeroShockCombo'
   MyDamageType=Class'UTGame.UTDmgType_HeroShockBall'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_ShockBall:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_ShockBall:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_HeroShockBall"
   ObjectArchetype=UTProj_ShockBall'UTGame.Default__UTProj_ShockBall'
}
