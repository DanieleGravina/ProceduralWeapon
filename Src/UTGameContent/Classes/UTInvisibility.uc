/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTInvisibility extends UTTimedPowerup;

var Material InvisibilityMaterial;
var SoundCue AmbientSound;
var SoundCue WarningSound;

function GivenTo(Pawn NewOwner, bool bDoNotActivate)
{
	local UTPawn P;

	Super.GivenTo(NewOwner, bDoNotActivate);

	// boost damage
	P = UTPawn(NewOwner);
	if (P != None)
	{
		// apply invisibility material
		P.SetSkin(InvisibilityMaterial);
		P.SetInvisible(true);
		P.SetPawnAmbientSound(AmbientSound);
		SetTimer(TimeRemaining - 3.0, false, 'PlayWarningSound');
	}
}

/** Plays a warning the powerup is running low */
function PlayWarningSound()
{
	// reset timer if time got added
	if (TimeRemaining > 3.0)
	{
		SetTimer(TimeRemaining - 3.0, false, 'PlayWarningSound');
	}
	else
	{
		Instigator.PlaySound(WarningSound);
		SetTimer(0.75, false, 'PlayWarningSound');
	}
}


function ItemRemovedFromInvManager()
{
	local UTPlayerReplicationInfo UTPRI;
	local UTPawn P;

	P = UTPawn(Owner);
	if (P != None)
	{
		P.SetSkin(None);
		P.SetInvisible(P.default.bIsInvisible);
		P.SetPawnAmbientSound(None);
		ClearTimer('PlayWarningSound');

		//Stop the timer on the powerup stat
		if (P.DrivenVehicle != None)
		{
			UTPRI = UTPlayerReplicationInfo(P.DrivenVehicle.PlayerReplicationInfo);
		}
		else
		{
			UTPRI = UTPlayerReplicationInfo(P.PlayerReplicationInfo);
		}
		if (UTPRI != None)
		{
			UTPRI.StopPowerupTimeStat(GetPowerupStatName());
		}
	}
}

defaultproperties
{
   InvisibilityMaterial=Material'PICKUPS.Invis.M_Invis_01'
   AmbientSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Invisibility_PowerLoopCue'
   WarningSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Invisibility_WarningCue'
   HudIndex=2
   PowerupOverSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Invisibility_EndCue'
   PowerupStatName="POWERUPTIME_INVISIBILITY"
   IconCoords=(U=744.000000,V=55.000000,UL=48.000000,VL=54.000000)
   PP_Scene_HighLights=(X=0.000000,Y=-0.070000,Z=-0.140000)
   PP_Scene_Desaturation=0.160000
   bRenderOverlays=True
   bReceiveOwnerEvents=True
   PickupMessage="INVISIBILITÀ!"
   PickupSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Invisibility_PickupCue'
   Begin Object Class=StaticMeshComponent Name=MeshComponentA ObjName=MeshComponentA Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.Invis.Mesh.S_Pickups_Invisibility'
      CullDistance=8000.000000
      CachedCullDistance=8000.000000
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      CollideActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=-20.000000)
      Name="MeshComponentA"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   DroppedPickupMesh=MeshComponentA
   PickupFactoryMesh=MeshComponentA
   Begin Object Class=UTParticleSystemComponent Name=InvisParticles ObjName=InvisParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Invis.Effects.P_Pickups_Invis_Idle'
      bAutoActivate=False
      Translation=(X=0.000000,Y=0.000000,Z=-20.000000)
      Name="InvisParticles"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   DroppedPickupParticles=InvisParticles
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTTimedPowerup:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTTimedPowerup:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTInvisibility"
   ObjectArchetype=UTTimedPowerup'UTGame.Default__UTTimedPowerup'
}
