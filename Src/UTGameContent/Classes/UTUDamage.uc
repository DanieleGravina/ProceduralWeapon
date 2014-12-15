/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTUDamage extends UTTimedPowerup;

/** sound played when our owner fires */
var SoundCue UDamageFireSound;
/** sound played when the UDamage is running out */
var SoundCue UDamageFadingSound;
/** last time we played that sound, so it isn't too often */
var float LastUDamageSoundTime;
/** overlay material applied to owner */
var MaterialInterface OverlayMaterialInstance;
/** particle effect played on vehicle weapons */
var MeshEffect VehicleWeaponEffect;
/** ambient sound played while active*/
var SoundCue DamageAmbientSound;

simulated static function AddWeaponOverlay(UTGameReplicationInfo GRI)
{
	GRI.WeaponOverlays[0] = default.OverlayMaterialInstance;
	GRI.VehicleWeaponEffects[0] = default.VehicleWeaponEffect;
}

function GivenTo(Pawn NewOwner, bool bDoNotActivate)
{
	local UTPawn P;

	Super.GivenTo(NewOwner, bDoNotActivate);

	// boost damage
	NewOwner.DamageScaling *= 2.0;
	P = UTPawn(NewOwner);
	if (P != None)
	{
		// apply UDamage overlay
		P.SetWeaponOverlayFlag(0);
		P.SetPawnAmbientSound(DamageAmbientSound);

		// juggernaut if already has berserk or invulnerability
		if ( ((P.FireRateMultiplier < 1.0) || P.bIsInvulnerable) && (PlayerController(P.Controller) != None) )
		{
			PlayerController(P.Controller).ReceiveLocalizedMessage( class'UTPowerupRewardMessage', 0 );
		}
	}
	// set timer for ending sounds
	SetTimer(TimeRemaining - 3.0, false, 'PlayUDamageFadingSound');
}

function ItemRemovedFromInvManager()
{
	local UTPlayerReplicationInfo UTPRI;
	local UTPawn P;

	Pawn(Owner).DamageScaling *= 0.5;
	P = UTPawn(Owner);
	if (P != None)
	{
		P.ClearWeaponOverlayFlag( 0 );
		P.SetPawnAmbientSound(none);
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
	SetTimer(0.0, false, 'PlayUDamageFadingSound');
}

simulated function OwnerEvent(name EventName)
{
	if (EventName == 'FiredWeapon' && Instigator != None && WorldInfo.TimeSeconds - LastUDamageSoundTime > 0.25)
	{
		LastUDamageSoundTime = WorldInfo.TimeSeconds;
		Instigator.PlaySound(UDamageFireSound, false, true);
	}
}

/** called on a timer to play UDamage ending sound */
function PlayUDamageFadingSound()
{
	// reset timer if time got added
	if (TimeRemaining > 3.0)
	{
		SetTimer(TimeRemaining - 3.0, false, 'PlayUDamageFadingSound');
	}
	else
	{
		Instigator.PlaySound(UDamageFadingSound);
		SetTimer(0.75, false, 'PlayUDamageFadingSound');
	}
}

defaultproperties
{
   UDamageFireSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_UDamage_FireCue'
   UDamageFadingSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_UDamage_WarningCue'
   OverlayMaterialInstance=Material'PICKUPS.UDamage.M_UDamage_Overlay'
   VehicleWeaponEffect=(Mesh=StaticMesh'Envy_Effects.Mesh.S_VH_Powerups',Material=Material'Envy_Effects.Energy.Materials.M_VH_UDamage')
   DamageAmbientSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_UDamage_PowerLoopCue'
   PowerupOverSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_UDamage_EndCue'
   PowerupStatName="POWERUPTIME_UDAMAGE"
   IconCoords=(U=792.000000,V=41.000000,UL=43.000000,VL=58.000000)
   PP_Scene_HighLights=(X=-0.100000,Y=0.040000,Z=-0.200000)
   bRenderOverlays=True
   bReceiveOwnerEvents=True
   PickupMessage="AMPLIFICATORE DANNI!"
   PickupSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_UDamage_PickupCue'
   Begin Object Class=StaticMeshComponent Name=MeshComponentA ObjName=MeshComponentA Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.UDamage.Mesh.S_Pickups_UDamage'
      CullDistance=8000.000000
      CachedCullDistance=8000.000000
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      CollideActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=5.000000)
      Scale3D=(X=0.600000,Y=0.600000,Z=0.600000)
      Name="MeshComponentA"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   DroppedPickupMesh=MeshComponentA
   PickupFactoryMesh=MeshComponentA
   Begin Object Class=UTParticleSystemComponent Name=PickupParticles ObjName=PickupParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.UDamage.Effects.P_Pickups_UDamage_Idle'
      bAutoActivate=False
      Translation=(X=0.000000,Y=0.000000,Z=5.000000)
      Name="PickupParticles"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   DroppedPickupParticles=PickupParticles
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTTimedPowerup:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTTimedPowerup:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTUDamage"
   ObjectArchetype=UTTimedPowerup'UTGame.Default__UTTimedPowerup'
}
