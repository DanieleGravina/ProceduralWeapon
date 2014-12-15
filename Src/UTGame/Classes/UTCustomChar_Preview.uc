/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 * Actor placed in level and used to preview different custom character combinations.
 * Does not use skeletal mesh merging, so changing parts is quick.
 */

class UTCustomChar_Preview extends Actor
	dependson(UTCustomChar_Data)
	placeable
	native;

var()	SkeletalMeshComponent	AnimComp;
var()	SkeletalMeshComponent	HeadComp;
var()	SkeletalMeshComponent	HelmetComp;
var()	SkeletalMeshComponent	FacemaskComp;
var()	SkeletalMeshComponent	GogglesComp;
var()	SkeletalMeshComponent	TorsoComp;
var()	SkeletalMeshComponent	LShoPadComp;
var()	SkeletalMeshComponent	RShoPadComp;
var()	SkeletalMeshComponent	ArmsComp;
var()	SkeletalMeshComponent	ThighsComp;
var()	SkeletalMeshComponent	BootsComp;

/** Info about character currently being used. */
var()	UTCustomChar_Data.CharacterInfo	Character;

var()	UTCustomChar_Data.CustomCharMergeState MergeState;

/**  */
var()	SkeletalMeshActor		TestMergeActor;
var()	MaterialInstanceConstant		TestMIC;
var()	MaterialInstanceConstant		TestMIC2;
var()	MaterialInstanceConstant		TestMIC3;

var		UTCharFamilyAssetStore	FamilyAssets;

/** In the char editor, used to find the right UTCustomChar_Preview for each faction. */
var()	string					UseForFaction;

/** Used for easily setting */
var()	LightingChannelContainer	CharLightingChannels;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Set a particular part of the preview character, based on its short ID. */
native function SetPart(UTCustomChar_Data.ECharPart InPart, string InPartID);

/** Set the entire preview character to a specified profile. */
native function SetCharacter(string InFaction, string InCharID);

/** Sets the preview character's data to the specified char data struct. */
native function SetCharacterData(UTCustomChar_Data.CustomCharData InCharData);

/** Notification when the character data has changed so the preview actor can update the data in-game. */
native function NotifyCharacterDataChanged();

event PostBeginPlay()
{
	Super.PostBeginPlay();

	if(TestMergeActor != None)
	{
		//FamilyAssets = class'UTCustomChar_Data'.static.LoadFamilyAssets("TWIF", FALSE);
		FamilyAssets = class'UTCustomChar_Data'.static.LoadFamilyAssets("IRNM", FALSE, FALSE);
		//SetCharacter(class'UTCustomChar_Data'.default.Characters[4].Faction, class'UTCustomChar_Data'.default.Characters[4].CharID);
		SetCharacter(class'UTCustomChar_Data'.default.Characters[0].Faction, class'UTCustomChar_Data'.default.Characters[0].CharID);
	}
}

/** Handler for 'SetCustomCharPart' kismet action **/
event OnSetCustomCharPart(UTSeqAct_SetCustomCharPart Action)
{
	//`log("SET PART:"@Action.Part@Action.PartID);
	SetPart(Action.Part, Action.PartID);
}

/** Handler for 'SetCustomCharCharacter' kismet action **/
event OnSetCustomCharProfile(UTSeqAct_SetCustomCharProfile Action)
{
	//`log("SET PROFILE:"@Action.Faction@Action.CharName);
	SetCharacter(Action.Faction, Action.CharID);
}

/** For testing merging - when toggled - create new merged skeletal mesh and assign to place SkeletalMeshActor.*/
event OnToggle(SeqAct_Toggle Action)
{
	//local CustomCharData CharData;

	if(TestMergeActor != None && FamilyAssets != None && !MergeState.bMergeInProgress)
	{
		// See if all assets required are loaded.
		if(FamilyAssets.NumPendingPackages == 0)
		{
			//CharData = class'UTCustomChar_Data'.static.MakeRandomCharData();
			MergeState = class'UTCustomChar_Data'.static.StartCustomCharMerge(Character.CharData, "VRed", None, CCTR_Normal);
		}
		else
		{
			LogInternal("Cannot merge yet - "$FamilyAssets.NumPendingPackages$" packages pending.");
		}
	}
}

event Tick(float DeltaTime)
{
	local SkeletalMesh NewMesh;
	local Texture HeadTex, BodyTex;
	local Texture PortraitTex;

	if(MergeState.bMergeInProgress)
	{
		HeadTex = MergeState.HeadTextures[0];
		BodyTex = MergeState.BodyTextures[0];
		NewMesh = class'UTCustomChar_Data'.static.FinishCustomCharMerge(MergeState);
		if(NewMesh != None)
		{
			PortraitTex = class'UTCustomChar_Data'.static.MakeCharPortraitTexture(NewMesh, class'UTCustomChar_Data'.default.PortraitSetup, class'UTCustomChar_Data'.default.PortraitBackgroundMesh);

			TestMergeActor.SkeletalMeshComponent.SetSkeletalMesh(NewMesh);

			if(TestMIC != None)
			{
				TestMIC.SetTextureParameterValue('TestTex', HeadTex);
			}

			if(TestMIC2 != None)
			{
				TestMIC2.SetTextureParameterValue('TestTex', BodyTex);
			}

			if(TestMIC3 != None)
			{
				TestMIC3.SetTextureParameterValue('TestTex', PortraitTex);
			}
		}
	}
}

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=MyAnimComp ObjName=MyAnimComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'CH_IronGuard_Male.Mesh.SK_CH_IronGuard_MaleA'
      Begin Object Class=AnimNodeSequence Name=AnimNodeSeq0 ObjName=AnimNodeSeq0 Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         AnimSeqName="idle_ready_rif"
         bPlaying=True
         bLooping=True
         Name="AnimNodeSeq0"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGame.Default__UTCustomChar_Preview:AnimNodeSeq0'
      AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
      bHasPhysicsAssetInstance=True
      bEnableFullAnimWeightBodies=True
      HiddenGame=True
      BlockRigidBody=True
      RBChannel=RBCC_Untitled4
      RBCollideWithChannels=(Untitled4=True)
      Name="MyAnimComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   AnimComp=MyAnimComp
   Begin Object Class=SkeletalMeshComponent Name=MyHeadComp ObjName=MyHeadComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      ParentAnimComponent=SkeletalMeshComponent'UTGame.Default__UTCustomChar_Preview:MyAnimComp'
      Name="MyHeadComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   HeadComp=MyHeadComp
   Begin Object Class=SkeletalMeshComponent Name=MyHelmetComp ObjName=MyHelmetComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      ParentAnimComponent=SkeletalMeshComponent'UTGame.Default__UTCustomChar_Preview:MyAnimComp'
      Name="MyHelmetComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   HelmetComp=MyHelmetComp
   Begin Object Class=SkeletalMeshComponent Name=MyFacemaskComp ObjName=MyFacemaskComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      ParentAnimComponent=SkeletalMeshComponent'UTGame.Default__UTCustomChar_Preview:MyAnimComp'
      Name="MyFacemaskComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   FacemaskComp=MyFacemaskComp
   Begin Object Class=SkeletalMeshComponent Name=MyGogglesComp ObjName=MyGogglesComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      ParentAnimComponent=SkeletalMeshComponent'UTGame.Default__UTCustomChar_Preview:MyAnimComp'
      Name="MyGogglesComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   GogglesComp=MyGogglesComp
   Begin Object Class=SkeletalMeshComponent Name=MyTorsoComp ObjName=MyTorsoComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      ParentAnimComponent=SkeletalMeshComponent'UTGame.Default__UTCustomChar_Preview:MyAnimComp'
      Name="MyTorsoComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   TorsoComp=MyTorsoComp
   Begin Object Class=SkeletalMeshComponent Name=MyLShoPadComp ObjName=MyLShoPadComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      ParentAnimComponent=SkeletalMeshComponent'UTGame.Default__UTCustomChar_Preview:MyAnimComp'
      Name="MyLShoPadComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   LShoPadComp=MyLShoPadComp
   Begin Object Class=SkeletalMeshComponent Name=MyRShoPadComp ObjName=MyRShoPadComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      ParentAnimComponent=SkeletalMeshComponent'UTGame.Default__UTCustomChar_Preview:MyAnimComp'
      Name="MyRShoPadComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   RShoPadComp=MyRShoPadComp
   Begin Object Class=SkeletalMeshComponent Name=MyArmsComp ObjName=MyArmsComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      ParentAnimComponent=SkeletalMeshComponent'UTGame.Default__UTCustomChar_Preview:MyAnimComp'
      Name="MyArmsComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   ArmsComp=MyArmsComp
   Begin Object Class=SkeletalMeshComponent Name=MyThighsComp ObjName=MyThighsComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      ParentAnimComponent=SkeletalMeshComponent'UTGame.Default__UTCustomChar_Preview:MyAnimComp'
      Name="MyThighsComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   ThighsComp=MyThighsComp
   Begin Object Class=SkeletalMeshComponent Name=MyBootsComp ObjName=MyBootsComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      ParentAnimComponent=SkeletalMeshComponent'UTGame.Default__UTCustomChar_Preview:MyAnimComp'
      Name="MyBootsComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   BootsComp=MyBootsComp
   Character=(AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Components(0)=MyAnimComp
   Components(1)=MyTorsoComp
   Components(2)=MyHeadComp
   Components(3)=MyHelmetComp
   Components(4)=MyFacemaskComp
   Components(5)=MyGogglesComp
   Components(6)=MyLShoPadComp
   Components(7)=MyRShoPadComp
   Components(8)=MyArmsComp
   Components(9)=MyThighsComp
   Components(10)=MyBootsComp
   Name="Default__UTCustomChar_Preview"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
