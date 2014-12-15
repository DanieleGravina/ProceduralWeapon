/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTArmorPickupFactory extends UTItemPickupFactory
	abstract
	native;

var int		ShieldAmount;
var UTParticleSystemComponent ParticleEffects;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated static function UpdateHUD(UTHUD H)
{
	Super.UpdateHUD(H);
	H.LastArmorPickupTime = H.LastPickupTime;
}

simulated function SetPickupVisible()
{
	if(ParticleEffects != none)
	{
		ParticleEffects.SetActive(true);
	}
	super.SetPickupVisible();
}
simulated function SetPickupHidden()
{
	if(ParticleEffects != none)
		ParticleEffects.DeactivateSystem();
	super.SetPickupHidden();
}

simulated function PostBeginPlay()
{
	if(!bPickupHidden)
	{
		SetPickupVisible();
	}
	Super.PostBeginPlay();
}

function SpawnCopyFor( Pawn Recipient )
{
	if ( UTPawn(Recipient) == None )
		return;

	if ( UTPlayerReplicationInfo(Recipient.PlayerReplicationInfo) != None )
	{
		UTPlayerReplicationInfo(Recipient.PlayerReplicationInfo).IncrementPickupStat(GetPickupStatName());
	}

	// Give armor to recipient
	Recipient.MakeNoise(0.2);
	AddShieldStrength(UTPawn(Recipient));
	super.SpawnCopyFor(Recipient);
}

/** CanUseShield()
returns how many shield units P could use
*/
function int CanUseShield(UTPawn P)
{
	return 0;
}

/** AddShieldStrength()
add shield to appropriate P armor type.
*/
function AddShieldStrength(UTPawn P);

//=============================================================================
// Pickup state: this inventory item is sitting on the ground.

auto state Pickup
{
	/* DetourWeight()
	value of this path to take a quick detour (usually 0, used when on route to distant objective, but want to grab inventory for example)
	*/
	function float DetourWeight(Pawn P,float PathWeight)
	{
		local float Need;
		local UTPawn Other;

		Other = UTPawn(P);
		if ( Other == None )
			return 0;
		Need = CanUseShield(Other);
		if ( AIController(Other.Controller).PriorityObjective() && (Need < 0.4 * ShieldAmount) )
			return (0.005 * MaxDesireability * Need)/PathWeight;
		if ( Need <= 0 )
		{
			if ( !WorldInfo.Game.bTeamGame )
				Need = 0.5;
			else
				return 0;
		}
		else if ( !WorldInfo.Game.bTeamGame )
			Need = FMax(Need,0.6);
		return (0.013 * MaxDesireability * Need)/PathWeight;
	}

	/* ValidTouch()
	 Validate touch (if valid return true to let other pick me up and trigger event).
	*/
	function bool ValidTouch( Pawn Other )
	{
		if ( !Super.ValidTouch(Other) )
		{
			return false;
		}

		// does Other need armor?
		return ( (CanUseShield(UTPawn(Other)) > 0) || !WorldInfo.Game.bTeamGame );
	}
}

function float BotDesireability(Pawn Bot, Controller C)
{
	local float Desire;

	if ( UTPawn(Bot) == None )
		return 0;

	Desire = (0.013 * MaxDesireability * CanUseShield(UTPawn(Bot)));
	if (!WorldInfo.Game.bTeamGame && UTBot(C) != None && UTBot(C).Skill >= 4.0)
	{
		// high skill bots keep considering powerups that they don't need if they can still pick them up
		// to deny the enemy any chance of getting them
		Desire = FMax(Desire, 0.001);
	}
	return Desire;
}

defaultproperties
{
   ShieldAmount=20
   Begin Object Class=UTParticleSystemComponent Name=ArmorParticles ObjName=ArmorParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Base_Armor.Effects.P_Pickups_Base_Armor_Glow'
      SecondsBeforeInactive=2.000000
      Translation=(X=0.000000,Y=0.000000,Z=-25.000000)
      Name="ArmorParticles"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   ParticleEffects=ArmorParticles
   PickupMessage="Armatura"
   bRotatingPickup=True
   bTrackPickup=True
   YawRotationRate=24000.000000
   BaseBrightEmissive=(R=25.000000,G=25.000000,B=1.000000,A=1.000000)
   BaseDimEmissive=(R=1.000000,G=1.000000,B=0.010000,A=1.000000)
   RespawnSound=SoundCue'A_Pickups.Armor.Cue.A_Pickups_Armor_Respawn_Cue'
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTItemPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTItemPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   PickupStatName="PICKUPS_ARMOR"
   bPredictRespawns=True
   MaxDesireability=1.500000
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTItemPickupFactory:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTItemPickupFactory:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTItemPickupFactory:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTItemPickupFactory:PathRenderer'
   End Object
   Components(1)=PathRenderer
   Components(2)=PickupLightEnvironment
   Begin Object Class=StaticMeshComponent Name=BaseMeshComp ObjName=BaseMeshComp Archetype=StaticMeshComponent'UTGame.Default__UTItemPickupFactory:BaseMeshComp'
      StaticMesh=StaticMesh'PICKUPS.Base_Armor.Mesh.S_Pickups_Base_Armor'
      Translation=(X=0.000000,Y=0.000000,Z=-44.000000)
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTItemPickupFactory:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   Components(4)=ArmorParticles
   Begin Object Class=StaticMeshComponent Name=ArmorPickUpComp ObjName=ArmorPickUpComp Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGame.Default__UTArmorPickupFactory:PickupLightEnvironment'
      CullDistance=8000.000000
      CachedCullDistance=8000.000000
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      CollideActors=False
      Name="ArmorPickUpComp"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Components(5)=ArmorPickUpComp
   CollisionComponent=CollisionCylinder
   Name="Default__UTArmorPickupFactory"
   ObjectArchetype=UTItemPickupFactory'UTGame.Default__UTItemPickupFactory'
}
