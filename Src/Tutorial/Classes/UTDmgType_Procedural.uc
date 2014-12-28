class UTDmgType_Procedural extends UTDamageType
	abstract;

defaultproperties
{
   DamageBodyMatColor=(R=40.000000,G=0.000000,B=50.000000,A=1.000000)
   DamageOverlayTime=0.300000
   DeathOverlayTime=0.600000
   DamageWeaponClass=Class'Tutorial.ProceduralWeapon'
   DamageWeaponFireMode=0
   KillStatsName="KILLS_PROCEDURAL"
   DeathStatsName="DEATHS_PROCEDURAL"
   SuicideStatsName="SUICIDES_PROCEDURAL"
   DeathString="`o è stato annientato dal proiettile procedurale di `k."
   FemaleSuicide="`o si è ammazzata con il proiettile procedurale."
   MaleSuicide="`o si è ammazzato con il proiettile procedurale."
   KDamageImpulse=1500.000000
   VehicleDamageScaling=0.800000
   VehicleMomentumScaling=2.750000
   Name="Default__UTDmgType_Procedural"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}