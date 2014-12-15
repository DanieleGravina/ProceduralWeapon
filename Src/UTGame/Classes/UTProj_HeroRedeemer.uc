/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_HeroRedeemer extends UTProj_RedeemerBase;

var repnotify bool bDoExplosionEffects;

replication
{
	if ( bNetDirty )
		bDoExplosionEffects;
}

simulated event ReplicatedEvent(name VarName)
{
	if ( VarName == 'bDoExplosionEffects' )
	{
		if ( bDoExplosionEffects == true )
		{
			SpawnExplosionEffects(Location, vect(0,0,1));
		}
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated function SpawnExplosionEffects(vector HitLocation, vector HitNormal)
{
	bDoExplosionEffects = true;
	Super.SpawnExplosionEffects(HitLocation, HitNormal);
}

defaultproperties
{
   ExplosionShake=CameraAnim'Camera_FX_02.WP_Redeemer.C_WP_Redeemer_Shake_UT3G'
   ExplosionClass=Class'UTGame.UTEmit_HeroRedeemerExplosion'
   DistanceExplosionTemplates(0)=(Template=ParticleSystem'WP_Redeemer.Particles.P_WP_Redeemer_Explo_Far',MinDistance=2200.000000)
   DistanceExplosionTemplates(1)=(Template=ParticleSystem'WP_Redeemer.Particles.P_WP_Redeemer_Explo_Mid',MinDistance=1500.000000)
   DistanceExplosionTemplates(2)=(Template=ParticleSystem'WP_Redeemer.Particles.P_WP_Redeemer_Explo_Near')
   ExplosionSound=SoundCue'A_Titan_Extras.Redeemer.A_Weapon_Redeemer_ExplodeCue'
   MyDamageType=Class'UTGame.UTDmgType_HeroBomb'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_RedeemerBase:CollisionCylinder'
      Translation=(X=40.000000,Y=0.000000,Z=0.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_RedeemerBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=DynamicLightEnvironmentComponent Name=RedeemerLightEnvironment ObjName=RedeemerLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTProj_RedeemerBase:RedeemerLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTProj_RedeemerBase:RedeemerLightEnvironment'
   End Object
   Components(1)=RedeemerLightEnvironment
   bAlwaysRelevant=True
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_HeroRedeemer"
   ObjectArchetype=UTProj_RedeemerBase'UTGame.Default__UTProj_RedeemerBase'
}
