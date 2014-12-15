/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTOnslaughtNodeTeleporter extends NavigationPoint
	native
	abstract
	placeable
	config(Game)
	hidecategories(Collision,Display,Attachment);

/** base ambient effects */
var ParticleSystem NeutralEffectTemplate;
var array<ParticleSystem> TeamEffectTemplates;

/** component that plays ambient effects for the node teleporter's current state */
var ParticleSystemComponent AmbientEffect;
/** component that plays the render-to-texture portal effect */
var ParticleSystemComponent PortalEffect;

/** teamcolored templates for portal effect */
var array<ParticleSystem> TeamPortalEffectTemplates;

/** current team owner */
var repnotify byte TeamNum;

var StaticMeshComponent FloorMesh;
var MaterialInstanceConstant FloorMaterialInstance;
var LinearColor NeutralFloorColor;
var array<LinearColor> TeamFloorColors;

var soundcue ConstructedSound, ActiveSound;

var AudioComponent AmbientSoundComponent;

/** materials for the portal effect */
var MaterialInterface PortalMaterial;
var MaterialInstanceConstant PortalMaterialInstance;
/** the component that captures the portal scene */
var SceneCapture2DComponent PortalCaptureComponent;

/** last destination this teleporter sent someone to. The portal is set to view through this actor. */
var repnotify Actor LastDestination;

/** Should we draw the tooltip for the teleporter */
var bool bDrawUseTeleporterMessage;

/** Distance check to draw the teleporter use tooltip  */
var float DrawTeleporterTooltipDistSq;

/** Coordinates for the tooltip textures */
var UIRoot.TextureCoordinates ToolTipIconCoords;

var bool bForceStaticCapture;

var globalconfig bool bRealtimeCapture;

replication
{
	if (bNetDirty)
		TeamNum, LastDestination;
}

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated event PostBeginPlay()
{
	local bool bStaticCapture;

	Super.PostBeginPlay();

	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		UpdateTeamEffects();

		// set up the portal effect
		if ( WorldInfo.IsConsoleBuild(CONSOLE_PS3) )
		{
			DetachComponent(PortalCaptureComponent);
		}
		else
		{
			// only get realtime capture in high detail mode
			bStaticCapture = !bRealtimeCapture;

			PortalMaterialInstance = new(self) class'MaterialInstanceConstant';
			PortalMaterialInstance.SetParent(PortalMaterial);
			PortalEffect.SetMaterialParameter('Portal', PortalMaterialInstance);
			if (LastDestination == None)
			{
				LastDestination = self;
			}
			PortalCaptureComponent.SetCaptureParameters( class'TextureRenderTarget2D'.static.Create( 256, 256,,
													MakeLinearColor(0.0, 0.0, 0.0, 1.0),
													bStaticCapture ) );
			PortalCaptureComponent.SetView(LastDestination.Location, LastDestination.Rotation);
			if (bStaticCapture)
			{
				PortalCaptureComponent.SetFrameRate(0);
			}
			PortalMaterialInstance.SetTextureParameterValue('RenderToTextureMap', PortalCaptureComponent.TextureTarget);
		}
	}
}

simulated function UpdateTeamEffects()
{
	local ParticleSystem NewTemplate;

	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		if ( FloorMaterialInstance == None )
		{
			FloorMaterialInstance = FloorMesh.CreateAndSetMaterialInstanceConstant(1);
		}
		FloorMaterialInstance.SetVectorParameterValue('Team_Color', (TeamNum < TeamFloorColors.length) ? TeamFloorColors[TeamNum] : NeutralFloorColor);

		NewTemplate = (TeamNum < TeamEffectTemplates.length) ? TeamEffectTemplates[TeamNum] : NeutralEffectTemplate;
		if (NewTemplate != AmbientEffect.Template)
		{
		    AmbientEffect.SetTemplate(NewTemplate);
		}
		AmbientEffect.SetActive(true);

		if (TeamNum < TeamPortalEffectTemplates.length)
		{
			if (PortalEffect.Template != TeamPortalEffectTemplates[TeamNum])
			{
				PortalEffect.SetTemplate(TeamPortalEffectTemplates[TeamNum]);
			}
		}

		if (TeamNum != 255)
		{
			PlaySound(ConstructedSound);
			SetAmbientSound(ActiveSound);
			PortalEffect.SetActive(true);
			PortalEffect.SetHidden(false);
			// only get realtime capture in high detail mode
			PortalCaptureComponent.SetFrameRate((!bRealtimeCapture || bForceStaticCapture) ? 0.0 : default.PortalCaptureComponent.FrameRate);
		}
		else
		{
			SetAmbientSound(None);
			PortalCaptureComponent.SetFrameRate(0);
			PortalEffect.SetActive(false);
			PortalEffect.SetHidden(true);
		}
	}
}

simulated function SetAmbientSound(SoundCue NewAmbientSound)
{
	// if the component is already playing this sound, don't restart it
	if (NewAmbientSound != AmbientSoundComponent.SoundCue)
	{
		AmbientSoundComponent.Stop();
		AmbientSoundComponent.SoundCue = NewAmbientSound;
		if (NewAmbientSound != None)
		{
			AmbientSoundComponent.Play();
		}
	}
}

simulated event byte ScriptGetTeamNum()
{
	return TeamNum;
}

function SetTeamNum(byte NewTeamNum)
{
	local UTOnslaughtGame Game;
	local UTTeamPlayerStart Start;

	TeamNum = NewTeamNum;
	// make sure we're turned on
	SetHidden(false);
	SetCollision(true);
	// update effects
	bForceNetUpdate = TRUE;
	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		UpdateTeamEffects();
	}

	// set a default destination when the teleporter changes hands
	Game = UTOnslaughtGame(WorldInfo.Game);
	if (Game != None && TeamNum < ArrayCount(Game.PowerCore) && Game.PowerCore[TeamNum].PlayerStarts.length > 0)
	{
		SetLastDestination(Game.PowerCore[TeamNum].PlayerStarts[0]);
	}
	else
	{
		foreach WorldInfo.AllNavigationPoints(class'UTTeamPlayerStart', Start)
		{
			if (Start.TeamNumber == TeamNum)
			{
				SetLastDestination(Start);
				break;
			}
		}
	}
}

/** called when this node teleporter is associated with a disabled node */
function TurnOff()
{
	SetHidden(true);
	SetCollision(false);
	AmbientEffect.DeactivateSystem();
	bForceNetUpdate = TRUE;
}

simulated function SetLastDestination(Actor NewLastDestination)
{
	LastDestination = NewLastDestination;

	if (WorldInfo.NetMode != NM_DedicatedServer && PortalCaptureComponent != None && LastDestination != None)
	{
		PortalCaptureComponent.SetView(LastDestination.Location + vect(0,0,100), LastDestination.Rotation);
	}
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'TeamNum')
	{
		UpdateTeamEffects();
	}
	else if (VarName == 'LastDestination')
	{
		SetLastDestination(LastDestination);
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated event Attach(Actor Other)
{
	local UTPawn P;

	P = UTPawn(Other);
	if ( (P != None) && P.IsHumanControlled() && P.IsLocallyControlled() )
	{
		SendUseMessage();
	}
}

/**
Script function called by NativePostRenderFor().
*/
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, vector CameraPosition, vector CameraDir)
{
	local UTHUD myHUD;
	local float DistToTeleporterSq;
	Super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);
	if (bDrawUseTeleporterMessage)
	{
		DistToTeleporterSq = VSizeSq(Location - CameraPosition);
		if (DistToTeleporterSq < DrawTeleporterTooltipDistSq)
		{

			myHUD = UTHud(PC.myHUD);
			myHUD.DrawToolTip(Canvas, PC, "GBA_Use", Canvas.ClipX * 0.5, Canvas.ClipY * 0.6, ToolTipIconCoords.U, ToolTipIconCoords.V, ToolTipIconCoords.UL, ToolTipIconCoords.VL, Canvas.ClipY / 768, myHUD.AltHudTexture);
		}
	}
}

/** sends 'Press use to node teleport' message to all local players standing on us */
simulated function SendUseMessage()
{
	local PlayerController PC;
	local bool bShouldRetrigger;
	local UTPlayerReplicationInfo PRI;

	bDrawUseTeleporterMessage = false;
	foreach LocalPlayerControllers(class'PlayerController', PC)
	{
		if (LocalPlayer(PC.Player) != None && PC.Pawn != None && PC.Pawn.Base == self && WorldInfo.GRI.OnSameTeam(PC, self))
		{
			bShouldRetrigger = true;
			PRI = UTPlayerReplicationInfo(PC.PlayerReplicationInfo);
			if ( (PRI != None) && PRI.bHasFlag )
			{
				PC.ReceiveLocalizedMessage(MessageClass, 44);
			}
			else
			{
				bDrawUseTeleporterMessage = true;
				break;
			}
		}
	}

	if ( bShouldRetrigger )
	{
		SetTimer(2.0, false, 'SendUseMessage');
	}
}

function bool UsedBy(Pawn User)
{
	local UTPlayerController PC;

	PC = UTPlayerController(User.Controller);
	if (PC != None && WorldInfo.GRI.OnSameTeam(PC, self))
	{
		PC.ShowHudMap();
		return true;
	}
	else
	{
		return false;
	}
}

defaultproperties
{
   NeutralFloorColor=(R=0.000000,G=0.000000,B=0.000000,A=1.000000)
   DrawTeleporterTooltipDistSq=21025.000000
   ToolTipIconCoords=(U=889.000000,V=115.000000,UL=62.000000,VL=43.000000)
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite2'
      ObjectArchetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__NavigationPoint:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__NavigationPoint:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__NavigationPoint:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__NavigationPoint:PathRenderer'
   End Object
   Components(4)=PathRenderer
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTOnslaughtNodeTeleporter"
   ObjectArchetype=NavigationPoint'Engine.Default__NavigationPoint'
}
