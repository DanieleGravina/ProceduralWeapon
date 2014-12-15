class UTProj_HeroRocket extends UTProj_SeekingRocket;

var array<DistanceBasedParticleTemplate> DistanceExplosionTemplates;

simulated function SpawnExplosionEffects(vector HitLocation, vector HitNormal)
{
	ProjExplosionTemplate = class'UTEmitter'.static.GetTemplateForDistance(DistanceExplosionTemplates, HitLocation, WorldInfo);

	Super.SpawnExplosionEffects(HitLocation, HitNormal);
}

defaultproperties
{
   DistanceExplosionTemplates(0)=(Template=ParticleSystem'WP_AVRiL.Particles.P_WP_Avril_Explo_far',MinDistance=3500.000000)
   DistanceExplosionTemplates(1)=(Template=ParticleSystem'WP_AVRiL.Particles.P_WP_Avril_Explo_mid',MinDistance=450.000000)
   DistanceExplosionTemplates(2)=(Template=ParticleSystem'WP_AVRiL.Particles.P_WP_Avril_Explo_close')
   BaseTrackingStrength=2.000000
   ProjFlightTemplate=ParticleSystem'WP_AVRiL.Particles.P_WP_Avril_Smoke_Trail'
   ProjExplosionTemplate=ParticleSystem'WP_AVRiL.Particles.P_WP_Avril_Explo'
   Speed=1000.000000
   MaxSpeed=1000.000000
   DamageRadius=200.000000
   MyDamageType=Class'UTGame.UTDmgType_HeroRocket'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_SeekingRocket:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_SeekingRocket:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_HeroRocket"
   ObjectArchetype=UTProj_SeekingRocket'UTGame.Default__UTProj_SeekingRocket'
}
