//=============================================================================
// Emitter actor class.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class Emitter extends Actor
	native(Particle)
	placeable;

var()	editconst const	ParticleSystemComponent ParticleSystemComponent;
var						bool					bDestroyOnSystemFinish;

/** used to update status of toggleable level placed emitters on clients */
var repnotify bool bCurrentlyActive;

replication
{
	if (bNoDelete)
		bCurrentlyActive;
}

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

native noexport event SetTemplate(ParticleSystem NewTemplate, optional bool bDestroyOnFinish);

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	// Let them die quickly on a dedicated server
	if (WorldInfo.NetMode == NM_DedicatedServer)
	{
		LifeSpan = 0.2;
	}

	// Set Notification Delegate
	if (ParticleSystemComponent != None)
	{
		ParticleSystemComponent.OnSystemFinished = OnParticleSystemFinished;
		bCurrentlyActive = ParticleSystemComponent.bAutoActivate;
	}
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'bCurrentlyActive')
	{
		if (bCurrentlyActive)
		{
			ParticleSystemComponent.ActivateSystem();
		}
		else
		{
			ParticleSystemComponent.DeactivateSystem();
		}
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

function OnParticleSystemFinished(ParticleSystemComponent FinishedComponent)
{
	if (bDestroyOnSystemFinish)
	{
		Lifespan = 0.0001f;
	}
	bCurrentlyActive = false;
}

/**
 * Handling Toggle event from Kismet.
 */
simulated function OnToggle(SeqAct_Toggle action)
{
	// Turn ON
	if (action.InputLinks[0].bHasImpulse)
	{
		ParticleSystemComponent.ActivateSystem();
		bCurrentlyActive = TRUE;
	}
	// Turn OFF
	else if (action.InputLinks[1].bHasImpulse)
	{
		ParticleSystemComponent.DeactivateSystem();
		bCurrentlyActive = FALSE;
	}
	// Toggle
	else if (action.InputLinks[2].bHasImpulse)
	{
		// If spawning is suppressed or we aren't turned on at all, activate.
		if ((ParticleSystemComponent.bSuppressSpawning == TRUE) || (bCurrentlyActive == FALSE))
		{
			ParticleSystemComponent.ActivateSystem();
			bCurrentlyActive = TRUE;
		}
		else
		{
			ParticleSystemComponent.DeactivateSystem();
			bCurrentlyActive = FALSE;
		}
	}
	ParticleSystemComponent.LastRenderTime = WorldInfo.TimeSeconds;
	ForceNetRelevant();
}

simulated function SetFloatParameter(name ParameterName, float Param)
{
	if (ParticleSystemComponent != none)
		ParticleSystemComponent.SetFloatParameter(ParameterName, Param);
	else
		LogInternal("Warning: Attempting to set a parameter on "$self$" when the PSC does not exist");
}

simulated function SetVectorParameter(name ParameterName, vector Param)
{
	if (ParticleSystemComponent != none)
		ParticleSystemComponent.SetVectorParameter(ParameterName, Param);
	else
		LogInternal("Warning: Attempting to set a parameter on "$self$" when the PSC does not exist");
}

simulated function SetColorParameter(name ParameterName, color Param)
{
	if (ParticleSystemComponent != none)
		ParticleSystemComponent.SetColorParameter(ParameterName, Param);
	else
		LogInternal("Warning: Attempting to set a parameter on "$self$" when the PSC does not exist");
}

simulated function SetExtColorParameter(name ParameterName, byte Red, byte Green, byte Blue, byte Alpha)
{
	local color c;

	if (ParticleSystemComponent != none)
	{
		c.r = Red;
		c.g = Green;
		c.b = Blue;
		c.a = Alpha;
		ParticleSystemComponent.SetColorParameter(ParameterName, C);
	}
	else
		LogInternal("Warning: Attempting to set a parameter on "$self$" when the PSC does not exist");
}


simulated function SetActorParameter(name ParameterName, actor Param)
{
	if (ParticleSystemComponent != none)
		ParticleSystemComponent.SetActorParameter(ParameterName, Param);
	else
		LogInternal("Warning: Attempting to set a parameter on "$self$" when the PSC does not exist");
}

/**
 * Kismet handler for setting particle instance parameters.
 */
simulated function OnSetParticleSysParam(SeqAct_SetParticleSysParam Action)
{
	local int Idx, ParamIdx;
	if (ParticleSystemComponent != None &&
		Action.InstanceParameters.Length > 0)
	{
		for (Idx = 0; Idx < Action.InstanceParameters.Length; Idx++)
		{
			if (Action.InstanceParameters[Idx].ParamType != PSPT_None)
			{
				// look for an existing entry
				ParamIdx = ParticleSystemComponent.InstanceParameters.Find('Name',Action.InstanceParameters[Idx].Name);
				// create one if necessary
				if (ParamIdx == -1)
				{
					ParamIdx = ParticleSystemComponent.InstanceParameters.Length;
					ParticleSystemComponent.InstanceParameters.Length = ParamIdx + 1;
				}
				// update the instance parm
				ParticleSystemComponent.InstanceParameters[ParamIdx] = Action.InstanceParameters[Idx];
				if (Action.bOverrideScalar)
				{
					ParticleSystemComponent.InstanceParameters[ParamIdx].Scalar = Action.ScalarValue;
				}
			}
		}
	}
}

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      SecondsBeforeInactive=1.000000
      Name="ParticleSystemComponent0"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      Sprite=Texture2D'EngineResources.S_Emitter'
      bIsScreenSizeScaled=True
      ScreenSize=0.002500
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   Components(1)=ParticleSystemComponent0
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'Engine.Default__ArrowComponent'
      ArrowColor=(B=128,G=255,R=0,A=255)
      ArrowSize=1.500000
      Name="ArrowComponent0"
      ObjectArchetype=ArrowComponent'Engine.Default__ArrowComponent'
   End Object
   Components(2)=ArrowComponent0
   TickGroup=TG_DuringAsyncWork
   bNoDelete=True
   bHardAttach=True
   bGameRelevant=True
   bEdShouldSnap=True
   Name="Default__Emitter"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
