/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTBeamWeaponAttachment extends UTWeaponAttachment;


/** The Particle System Template for the Beam */

var particleSystem BeamTemplate[2];

/** Holds the Emitter for the Beam */

var ParticleSystemComponent BeamEmitter[2];

/** Where to attach the Beam */

var name BeamSockets[2];

/** Quick access to the pawn owner */

var UTPawn PawnOwner;

/** The name of the EndPoint parameter */

var name EndPointParamName;


simulated function AddBeamEmitter()
{
	local int i;

	for (i=0;i<2;i++)
	{
		if ( BeamTemplate[i] != none )
		{
			BeamEmitter[i] = new(self) class'UTParticleSystemComponent';
			BeamEmitter[i].SetTemplate(BeamTemplate[i]);
			BeamEmitter[i].SetHidden(true);
			BeamEmitter[i].SetTickGroup(TG_PostAsyncWork);
			BeamEmitter[i].bUpdateComponentInTick = true;
			BeamEmitter[i].SetOwnerNoSee(true);
			Mesh.AttachComponentToSocket(BeamEmitter[i], BeamSockets[i]);
		}
	}
}

simulated function HideEmitter(int Index, bool bHide)
{
	if (BeamEmitter[Index] != None)
	{
		BeamEmitter[Index].SetHidden(bHide);
	}
}

simulated function UpdateBeam(byte FireModeNum)
{
	// Make sure the Emitter is visible
	if (BeamEmitter[FireModeNum] != None)
	{
		BeamEmitter[FireModeNum].SetVectorParameter(EndPointParamName , PawnOwner.FlashLocation);
	}

	HideEmitter(FireModeNum, false);
	HideEmitter(Abs(FireModeNum - 1), true);
}

state CurrentlyAttached
{
	simulated function BeginState(Name PreviousStateName)
	{
		PawnOwner = UTPawn(Owner);
		if (PawnOwner==none)
		{
			LogInternal("ERROR:"@self@"found without a valid UTPawn Owner");
			return;
		}

		AddBeamEmitter();

	}

	simulated function Tick(float DeltaTime)
	{
		//If we aren't firing or the owner and its not splitscreen, hide the emitter
		if  ( (PawnOwner == None) || (PawnOwner.IsFirstPerson() && !class'Engine'.static.IsSplitScreen()) || PawnOwner.FlashLocation==vect(0,0,0) )
		{
			HideEmitter(0,true);
			HideEmitter(1,true);
			return;
		}

		UpdateBeam(PawnOwner.FiringMode);
	}
}

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      Animations=UTAnimNodeSequence'UTGame.Default__UTBeamWeaponAttachment:SkeletalMeshComponent0.MeshSequenceA'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   Name="Default__UTBeamWeaponAttachment"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
