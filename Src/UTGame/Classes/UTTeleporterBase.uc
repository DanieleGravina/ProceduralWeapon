/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTTeleporterBase extends Teleporter
	native
	abstract
	config(Game);

/** the component that captures the portal scene */
var(SceneCapture) editconst SceneCaptureComponent PortalCaptureComponent;
/** the texture that the component renders to */
var TextureRenderTarget2D TextureTarget;
/** resolution parameters */
var(SceneCapture) int TextureResolutionX, TextureResolutionY;
/** actor that the portal view is based on (used for updating Controllers' VisiblePortals array) */
var Actor PortalViewTarget;
/** materials for the portal effect */
var MaterialInterface PortalMaterial;
var MaterialInstanceConstant PortalMaterialInstance;
/** material parameter that we assign the rendered texture to */
var name PortalTextureParameter;
/** Sound to be played when someone teleports in*/
var SoundCue TeleportingSound;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated event PostBeginPlay()
{
	local Teleporter Dest;

	Super.PostBeginPlay();

	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		// try to find a teleporter to view
		foreach WorldInfo.AllNavigationPoints(class'Teleporter', Dest)
		{
			if (string(Dest.Tag) ~= URL && Dest != Self)
			{
				break;
			}
		}
		if (WorldInfo.IsConsoleBuild(CONSOLE_PS3))
		{
			SetHidden(Dest == None);
		}
		else
		{
			InitializePortalEffect(Dest);
		}
	}
}

simulated function InitializePortalEffect(Actor Dest)
{
	local bool bStaticCapture;

	if (PortalCaptureComponent != None)
	{
		if (Dest != None)
		{
			// only get realtime capture in high detail mode
			bStaticCapture = (WorldInfo.GetDetailMode() < DM_High);
			if ( !class'UTOnslaughtNodeTeleporter'.default.bRealtimeCapture )
			{
				PortalCaptureComponent.MaxUpdateDist = 500;
				PortalCaptureComponent.MaxStreamingUpdateDist = 500;
			}
			PortalViewTarget = Dest;
			// set up the portal effect
			PortalMaterialInstance = new(self) class'MaterialInstanceConstant';
			PortalMaterialInstance.SetParent(PortalMaterial);

			TextureTarget = class'TextureRenderTarget2D'.static.Create( TextureResolutionX, TextureResolutionY,,
									MakeLinearColor(0.0, 0.0, 0.0, 1.0), bStaticCapture );

			if (bStaticCapture)
			{
				PortalCaptureComponent.SetFrameRate(0);
			}
			PortalMaterialInstance.SetTextureParameterValue(PortalTextureParameter, TextureTarget);

			AttachComponent(PortalCaptureComponent);
		}
		else
		{
			SetHidden(true);
		}
	}
}

simulated event bool Accept( actor Incoming, Actor Source )
{
	local UTPlayerReplicationInfo PRI;

	PRI = (Pawn(Incoming) != None) ? UTPlayerReplicationInfo(Pawn(Incoming).PlayerReplicationInfo) : None;
	if ( (PRI != None) && (UTOnslaughtFlag(PRI.GetFlag()) != None) )
	{
		PRI.GetFlag().Drop();
	}

	if (Super.Accept(Incoming,Source))
	{
		PlaySound(TeleportingSound);
		return true;
	}
	else
	{
		return false;
	}
}

defaultproperties
{
   TextureResolutionX=256
   TextureResolutionY=256
   PortalTextureParameter="RenderToTextureMap"
   TeleportingSound=SoundCue'A_Gameplay.Portal.Portal_WalkThrough01Cue'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__Teleporter:CollisionCylinder'
      CollisionHeight=30.000000
      CollisionRadius=50.000000
      ObjectArchetype=CylinderComponent'Engine.Default__Teleporter:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Teleporter:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Teleporter:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'Engine.Default__Teleporter:Sprite2'
      ObjectArchetype=SpriteComponent'Engine.Default__Teleporter:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__Teleporter:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__Teleporter:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__Teleporter:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__Teleporter:PathRenderer'
   End Object
   Components(4)=PathRenderer
   Begin Object Class=AudioComponent Name=AmbientSound ObjName=AmbientSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.Portal.Portal_Loop01Cue'
      bAutoPlay=True
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="AmbientSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   Components(5)=AmbientSound
   bStatic=False
   bMovable=False
   CollisionComponent=CollisionCylinder
   Name="Default__UTTeleporterBase"
   ObjectArchetype=Teleporter'Engine.Default__Teleporter'
}
