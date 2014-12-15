/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTBerserk extends UTTimedPowerup;

/** ambient sound on the pawn when Berserk is active */
var SoundCue BerserkAmbientSound;
/** sound played when the Berserk is running out */
var SoundCue BerserkFadingSound;
/** overlay material applied to owner */
var MaterialInterface OverlayMaterialInstance;
/** particle effect played on vehicle weapons */
var MeshEffect VehicleWeaponEffect;

simulated static function AddWeaponOverlay(UTGameReplicationInfo GRI)
{
	GRI.WeaponOverlays[1] = default.OverlayMaterialInstance;
	GRI.VehicleWeaponEffects[1] = default.VehicleWeaponEffect;
}

/** adds or removes our bonus from the given pawn */
simulated function AdjustPawn(UTPawn P, bool bRemoveBonus)
{
	if (P != None && Role == ROLE_Authority)
	{
		if (bRemoveBonus)
		{
			P.FireRateMultiplier *= 2.0;
		}
		else
		{
			// halve firing time
			P.FireRateMultiplier *= 0.5;
		}
		P.FireRateChanged();
	}
}

function GivenTo(Pawn NewOwner, bool bDoNotActivate)
{
	local UTPawn P;

	Super.GivenTo(NewOwner, bDoNotActivate);

	P = UTPawn(NewOwner);
	if (P != None)
	{
		// apply Berserk overlay
		P.SetWeaponOverlayFlag(1);

		P.SetPawnAmbientSound(BerserkAmbientSound);

		AdjustPawn(P, false);

		// max ammo on all weapons
		if ( UTInventoryManager(P.InvManager) != None )
		{
			UTInventoryManager(P.InvManager).AllAmmo();
		}
		// juggernaut if already has udamage or invulnerability
		if ( ((P.DamageScaling > 1.0) || P.bIsInvulnerable) && (PlayerController(P.Controller) != None) )
		{
			PlayerController(P.Controller).ReceiveLocalizedMessage( class'UTPowerupRewardMessage', 0 );
		}
	}
	// set timer for ending sounds
	SetTimer(TimeRemaining - 3.0, false, 'PlayBerserkFadingSound');
}

reliable client function ClientGivenTo(Pawn NewOwner, bool bDoNotActivate)
{
	Super.ClientGivenTo(NewOwner, bDoNotActivate);

	if (Role < ROLE_Authority)
	{
		AdjustPawn(UTPawn(NewOwner), false);
	}
}

function ItemRemovedFromInvManager()
{
	local UTPlayerReplicationInfo UTPRI;
	local UTPawn P;

	P = UTPawn(Owner);
	if ( P != None )
	{
		P.ClearWeaponOverlayFlag(1);
		P.SetPawnAmbientSound(None);
		AdjustPawn(P, true);
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
	SetTimer(0.0, false, 'PlayBerserkFadingSound');
}

simulated event Destroyed()
{
	if (Role < ROLE_Authority)
	{
		AdjustPawn(UTPawn(Owner), true);
	}

	Super.Destroyed();
}

/** called on a timer to play Berserk ending sound */
function PlayBerserkFadingSound()
{
	// reset timer if time got added
	if (TimeRemaining > 3.0)
	{
		SetTimer(TimeRemaining - 3.0, false, 'PlayBerserkFadingSound');
	}
	else
	{
		Instigator.PlaySound(BerserkFadingSound);
		SetTimer(0.75, false, 'PlayBerserkFadingSound');
	}
}

defaultproperties
{
   BerserkAmbientSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Berzerk_PowerLoopCue'
   BerserkFadingSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Berzerk_WarningCue'
   OverlayMaterialInstance=Material'PICKUPS.Berserk.M_Berserk_Overlay'
   VehicleWeaponEffect=(Mesh=StaticMesh'Envy_Effects.Mesh.S_VH_Powerups',Material=Material'Envy_Effects.Energy.Materials.M_VH_Beserk')
   HudIndex=1
   PowerupOverSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Berzerk_EndCue'
   PowerupStatName="POWERUPTIME_BERSERK"
   IconCoords=(U=744.000000,UL=35.000000,VL=55.000000)
   PP_Scene_HighLights=(X=-0.150000,Y=-0.080000,Z=0.050000)
   bRenderOverlays=True
   bReceiveOwnerEvents=True
   PickupMessage="BERSERK!"
   PickupSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Berzerk_PickupCue'
   Begin Object Class=StaticMeshComponent Name=MeshComponentA ObjName=MeshComponentA Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.Berserk.Mesh.S_Pickups_Berserk'
      Materials(0)=Material'PICKUPS.Berserk.Materials.M_Pickups_Berserk'
      CullDistance=8000.000000
      CachedCullDistance=8000.000000
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      CollideActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=5.000000)
      Scale3D=(X=0.700000,Y=0.700000,Z=0.700000)
      Name="MeshComponentA"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   DroppedPickupMesh=MeshComponentA
   PickupFactoryMesh=MeshComponentA
   Begin Object Class=UTParticleSystemComponent Name=BerserkParticles ObjName=BerserkParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Berserk.Effects.P_Pickups_Berserk_Idle'
      bAutoActivate=False
      Translation=(X=0.000000,Y=0.000000,Z=5.000000)
      Name="BerserkParticles"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   DroppedPickupParticles=BerserkParticles
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTTimedPowerup:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTTimedPowerup:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTBerserk"
   ObjectArchetype=UTTimedPowerup'UTGame.Default__UTTimedPowerup'
}
