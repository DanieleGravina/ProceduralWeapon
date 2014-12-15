/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTOnslaughtCountdownNode extends UTOnslaughtPowerNode_Content
	PerObjectLocalized;

/** how long in seconds the controlling team must hold the node to gain the benefit */
var() byte CountdownTime;
/** how much longer controlling team needs to hold the node */
var byte RemainingTime;
/** special announcements played for various situations
 * if there is only one element in the array, that is played regardless of team control
 * otherwise, the announcement that corresponds with the team that controls the node is played
 */
var(Announcements) array<ObjectiveAnnouncementInfo> BuiltAnnouncements, HalfTimeAnnouncements, TenSecondsLeftAnnouncements,
						SuccessAnnouncements, DestroyedAnnouncements;
/** whether the Kismet connected to this node succeeding will damage the core (so give higher priority for AI, etc) */
var() bool bDamagesCore;

replication
{
	if (bNetDirty)
		RemainingTime;
}

simulated event PreBeginPlay()
{
	if (bDamagesCore)
	{
		DefensePriority = Max(DefensePriority, 5);
	}

	Super.PreBeginPlay();
}

simulated state ActiveNode
{
	simulated event RenderMinimap( UTMapInfo MP, Canvas Canvas, UTPlayerController PlayerOwner, float ColorPercent )
	{
		local float XL, YL;
		local Font OldFont;
		local string TimeStr;

		OldFont = Canvas.Font;
		Canvas.Font = class'UTHUD'.static.GetFontSizeIndex(2);
		TimeStr = string(RemainingTime);
		Canvas.StrLen(TimeStr, XL, YL);
		Canvas.DrawColor = class'UTHUD'.default.BlackColor;
		Canvas.SetPos(HUDLocation.X + 1 - XL * 0.25, HUDLocation.Y + 1 - YL * 0.25);
		Canvas.DrawText(TimeStr);
		Canvas.DrawColor = class'UTHUD'.default.WhiteColor;
		Canvas.SetPos(HUDLocation.X - XL * 0.25, HUDLocation.Y - YL * 0.25);
		Canvas.DrawText(TimeStr);
		Canvas.Font = OldFont;
	}
	
	simulated function DrawBeaconIcon(Canvas Canvas, vector IconLocation, float IconWidth, float IconAlpha, float BeaconPulseScale, UTPlayerController PlayerOwner)
	{
		local float XL, YL;
		local Font OldFont;
		local string TimeStr;

		OldFont = Canvas.Font;
		Canvas.Font = class'UTHUD'.static.GetFontSizeIndex(1);
		TimeStr = string(RemainingTime);
		Canvas.StrLen(TimeStr, XL, YL);
		Canvas.SetPos(IconLocation.X - XL * 0.5, IconLocation.Y - YL * 0.5);
		Canvas.DrawText(TimeStr,, BeaconPulseScale, BeaconPulseScale);
		Canvas.Font = OldFont;
	}

	function Countdown()
	{
		RemainingTime--;
		if (RemainingTime == 0)
		{
			TriggerEventClass(class'UTSeqEvent_CountdownNodeSucceeded', None);
			BroadcastLocalizedMessage(class'UTCountdownNodeMessage', 30 + DefenderTeamIndex,,, self);

			// go back to neutral
			LastDamagedBy = None;
			Scorers.length = 0;
			Global.UpdateCloseActors();
			DefenderTeamIndex = 2;
			UTGame(WorldInfo.Game).ObjectiveDisabled(self);
			FindNewObjectives();
			GotoState('NeutralNode');
		}
		else if (RemainingTime == CountdownTime / 2)
		{
			BroadcastLocalizedMessage(class'UTCountdownNodeMessage', 10 + DefenderTeamIndex,,, self);
		}
		else if (RemainingTime == 10)
		{
			BroadcastLocalizedMessage(class'UTCountdownNodeMessage', 20 + DefenderTeamIndex,,, self);
		}
	}

	function DisableObjective(Controller InstigatedBy)
	{
		BroadcastLocalizedMessage(class'UTCountdownNodeMessage', 40 + DefenderTeamIndex,,, self);

		Global.DisableObjective(InstigatedBy);
	}

	simulated event BeginState(name PreviousStateName)
	{
		bDrawBeaconIcon = true;
		bScriptRenderAdditionalMinimap = true;
		if (Role == ROLE_Authority)
		{
			RemainingTime = CountdownTime;
			SetTimer(1.0, true, 'Countdown');
			BroadcastLocalizedMessage(class'UTCountdownNodeMessage', DefenderTeamIndex,,, self);
		}

		Super.BeginState(PreviousStateName);
	}

	simulated event EndState(name NextStateName)
	{
		bDrawBeaconIcon = false;
		ClearTimer('Countdown');

		Super.EndState(NextStateName);
		bScriptRenderAdditionalMinimap = false;
	}
}

defaultproperties
{
   CountdownTime=60
   BuiltAnnouncements(0)=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_RedControlsTheCountdownNode',AnnouncementText="Il rosso controlla il Nodo del conto alla rovescia.!")
   BuiltAnnouncements(1)=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_BlueControlsTheCountdownNode',AnnouncementText="Il blu controlla il Nodo del conto alla rovescia.!")
   SuccessAnnouncements(0)=(AnnouncementText="Conto alla rovescia rosso, completato!")
   SuccessAnnouncements(1)=(AnnouncementText="Conto alla rovescia blu completata!")
   DestroyedAnnouncements(0)=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_CountdownNodeDestroyed',AnnouncementText="Nodo del conto alla rovescia, distrutto.")
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:StaticMeshComponent0'
      ObjectArchetype=StaticMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:StaticMeshComponent0'
   End Object
   NodeBase=StaticMeshComponent0
   Begin Object Class=StaticMeshComponent Name=StaticMeshSpinner ObjName=StaticMeshSpinner Archetype=StaticMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:StaticMeshSpinner'
      ObjectArchetype=StaticMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:StaticMeshSpinner'
   End Object
   NodeBaseSpinner=StaticMeshSpinner
   Begin Object Class=CylinderComponent Name=CollisionCylinder2 ObjName=CollisionCylinder2 Archetype=CylinderComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:CollisionCylinder2'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:CollisionCylinder2'
   End Object
   EnergySphereCollision=CollisionCylinder2
   Begin Object Class=ParticleSystemComponent Name=CaptureSystem ObjName=CaptureSystem Archetype=ParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:CaptureSystem'
      ObjectArchetype=ParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:CaptureSystem'
   End Object
   OrbCaptureComponent=CaptureSystem
   Begin Object Class=ParticleSystemComponent Name=InvulnerableSystem ObjName=InvulnerableSystem Archetype=ParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:InvulnerableSystem'
      ObjectArchetype=ParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:InvulnerableSystem'
   End Object
   InvulnerableToOrbEffect=InvulnerableSystem
   Begin Object Class=AudioComponent Name=OrbNearbySoundComponent ObjName=OrbNearbySoundComponent Archetype=AudioComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:OrbNearbySoundComponent'
      ObjectArchetype=AudioComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:OrbNearbySoundComponent'
   End Object
   OrbNearbySound=OrbNearbySoundComponent
   Begin Object Class=StaticMeshComponent Name=NecrisCapturePipesLargeComp ObjName=NecrisCapturePipesLargeComp Archetype=StaticMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:NecrisCapturePipesLargeComp'
      ObjectArchetype=StaticMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:NecrisCapturePipesLargeComp'
   End Object
   NecrisCapturePipesLarge=NecrisCapturePipesLargeComp
   Begin Object Class=StaticMeshComponent Name=NecrisCapturePipesSmallComp ObjName=NecrisCapturePipesSmallComp Archetype=StaticMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:NecrisCapturePipesSmallComp'
      ObjectArchetype=StaticMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:NecrisCapturePipesSmallComp'
   End Object
   NecrisCapturePipesSmall=NecrisCapturePipesSmallComp
   Begin Object Class=UTParticleSystemComponent Name=NecrisCaptureComp ObjName=NecrisCaptureComp Archetype=UTParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:NecrisCaptureComp'
      ObjectArchetype=UTParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:NecrisCaptureComp'
   End Object
   PSC_NecrisCapture=NecrisCaptureComp
   Begin Object Class=UTParticleSystemComponent Name=NecrisGoodPuddleComp ObjName=NecrisGoodPuddleComp Archetype=UTParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:NecrisGoodPuddleComp'
      ObjectArchetype=UTParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:NecrisGoodPuddleComp'
   End Object
   PSC_NecrisGooPuddle=NecrisGoodPuddleComp
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent1 ObjName=SkeletalMeshComponent1 Archetype=SkeletalMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:SkeletalMeshComponent1'
      ObjectArchetype=SkeletalMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:SkeletalMeshComponent1'
   End Object
   PanelMesh=SkeletalMeshComponent1
   Begin Object Class=AudioComponent Name=AmbientComponent ObjName=AmbientComponent Archetype=AudioComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:AmbientComponent'
      ObjectArchetype=AudioComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:AmbientComponent'
   End Object
   AmbientSoundComponent=AmbientComponent
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent9 ObjName=StaticMeshComponent9 Archetype=StaticMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:StaticMeshComponent9'
      ObjectArchetype=StaticMeshComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:StaticMeshComponent9'
   End Object
   NodeBeamEffect=StaticMeshComponent9
   DefensePriority=4
   ObjectiveName="Nodo del conto alla rovescia"
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:Arrow'
      ObjectArchetype=ArrowComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:Arrow'
   End Object
   Components(0)=Arrow
   Components(1)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:PathRenderer'
   End Object
   Components(2)=PathRenderer
   Begin Object Class=LinkRenderingComponent Name=LinkRenderer ObjName=LinkRenderer Archetype=LinkRenderingComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:LinkRenderer'
      ObjectArchetype=LinkRenderingComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:LinkRenderer'
   End Object
   Components(3)=LinkRenderer
   Components(4)=AmbientComponent
   Begin Object Class=DynamicLightEnvironmentComponent Name=PowerNodeLightEnvironment ObjName=PowerNodeLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:PowerNodeLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:PowerNodeLightEnvironment'
   End Object
   Components(5)=PowerNodeLightEnvironment
   Components(6)=StaticMeshComponent0
   Components(7)=StaticMeshSpinner
   Components(8)=SkeletalMeshComponent1
   Components(9)=CollisionCylinder2
   Begin Object Class=UTParticleSystemComponent Name=AmbientEffectComponent ObjName=AmbientEffectComponent Archetype=UTParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:AmbientEffectComponent'
      ObjectArchetype=UTParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:AmbientEffectComponent'
   End Object
   Components(10)=AmbientEffectComponent
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent1 ObjName=ParticleSystemComponent1 Archetype=ParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:ParticleSystemComponent1'
      ObjectArchetype=ParticleSystemComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:ParticleSystemComponent1'
   End Object
   Components(11)=ParticleSystemComponent1
   Components(12)=StaticMeshComponent9
   Components(13)=OrbNearbySoundComponent
   Components(14)=CaptureSystem
   Components(15)=InvulnerableSystem
   Components(16)=NecrisGoodPuddleComp
   Components(17)=NecrisCaptureComp
   Components(18)=NecrisCapturePipesLargeComp
   Components(19)=NecrisCapturePipesSmallComp
   CollisionComponent=CollisionCylinder
   SupportedEvents(5)=Class'UTGameContent.UTSeqEvent_CountdownNodeSucceeded'
   Name="Default__UTOnslaughtCountdownNode"
   ObjectArchetype=UTOnslaughtPowernode_Content'UTGameContent.Default__UTOnslaughtPowernode_Content'
}
