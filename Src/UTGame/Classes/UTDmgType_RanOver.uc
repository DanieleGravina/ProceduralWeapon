/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 */
class UTDmgType_RanOver extends UTDamageType
	abstract;

var int NumMessages;

var ForceFeedbackWaveform RanOverWaveForm;

static function int IncrementKills(UTPlayerReplicationInfo KillerPRI)
{
	local int KillCount;

	KillCount = super.IncrementKills(KillerPRI);
	if ( (KillCount != Default.RewardCount)  && (UTPlayerController(KillerPRI.Owner) != None) )
	{
		SmallReward(UTPlayerController(KillerPRI.Owner), KillCount);
	}
	return KillCount;
}

static function SmallReward(UTPlayerController Killer, int KillCount)
{
	Killer.ReceiveLocalizedMessage(class'UTVehicleKillMessage', KillCount % 4);
}

static function SpawnHitEffect(Pawn P, float Damage, vector Momentum, name BoneName, vector HitLocation)
{
	local UTPawn UTP;
	local UTConsolePlayerController UTPC;

	Super.SpawnHitEffect(P,Damage,Momentum,BoneName,HitLocation);

	UTP = UTPawn(P);
	if(UTP != none)
	{
		UTP.SoundGroupClass.Static.PlayCrushedSound(P);

		//Play some rumble
		UTPC = UTConsolePlayerController(UTP.Controller);
		if(UTPC != None)
	{
			UTPC.ClientPlayForceFeedbackWaveform(default.RanOverWaveForm);
		}
	}
}

defaultproperties
{
   NumMessages=4
   RanOverWaveForm=ForceFeedbackWaveform'UTGame.Default__UTDmgType_RanOver:ForceFeedbackWaveformRanOver'
   bUseTearOffMomentum=True
   bVehicleHit=True
   GibPerterbation=0.500000
   KillStatsName="EVENT_RANOVERKILLS"
   DeathStatsName="EVENT_RANOVERDEATHS"
   RewardCount=10
   RewardAnnouncementClass=Class'UTGame.UTVehicleKillMessage'
   RewardAnnouncementSwitch=7
   RewardEvent="REWARD_ROADRAMPAGE"
   DeathString="`k ha investito `o"
   FemaleSuicide="`o si è investita."
   MaleSuicide="`o si è investito."
   bNeverGibs=True
   bLocationalHit=False
   bExtraMomentumZ=False
   GibModifier=2.000000
   Name="Default__UTDmgType_RanOver"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
