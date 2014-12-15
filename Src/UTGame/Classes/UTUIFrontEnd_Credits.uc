/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Credits scene for UT3.
 */
class UTUIFrontEnd_Credits extends UTUIFrontEnd
	native(UIFrontEnd);

struct native CreditsImageSetData
{
	var transient Surface  TexImage;
	var string			   TexImageName;
	var TextureCoordinates TexCoords;
	var string			   LabelMarkup;
};

struct native CreditsImageSet
{
	var array<CreditsImageSetData> ImageData;
};

/** How long to show the scene for. */
var() float	SceneTimeInSec;

/** How much of a delay to have before starting to show gears photos. */
var() float DelayBeforePictures;

/** How much of a delay to have after pictures end. */
var() float DelayAfterPictures;

/** Whether or not the credits have finished player. */
var bool bFinishedPlaying;

/** Record when we started displaying. */
var transient float StartTime;

/** A set of images and labels to cycle between. */
var	transient array<CreditsImageSet>	ImageSets;

/** Which object set to use for fading. */
var transient int CurrentObjectOffset;

/** Which image set we are currently on. */
var transient int CurrentImageSet;

/** Labels that hold quotes for each person. */
var transient UILabel QuoteLabels[6];

/** Photos of each person. */
var transient UIImage PhotoImage[6];

/** Labels to hold the scrolling credits text. */
var transient UILabel TextLabels[3];

/** Which text set we are currently on. */
var transient int CurrentTextSet;

/** Scrolling offset to start from. */
var transient float StartOffset[3];

/** Sets of text used for the scrolling credits. */
var transient array<string>	 TextSets;

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

/** Sets up the credits scene and retrieves references to widgets. */
native function SetupScene();

/** Make sure we use the frontend skin for credits. */
event Initialized()
{
	local UISkin Skin;

	if ( IsGame() )
	{
		// make sure we're using the right skin
		Skin = UISkin(DynamicLoadObject("UI_Skin_Derived.UTDerivedSkin",class'UISkin'));
		if ( Skin != none )
		{
			SceneClient.ChangeActiveSkin(Skin);
		}
	}

	Super.Initialized();
}


/** PostInitialize event - Sets delegates for the scene. */
event PostInitialize( )
{
	local int ImageIdx, DataIdx;

	Super.PostInitialize();

	// Retrieve references to all of the portrait images.
	for(ImageIdx=0; ImageIdx<ImageSets.length; ImageIdx++)
	{
		for (DataIdx=0; DataIdx<ImageSets[ImageIdx].ImageData.length; DataIdx++)
		{
			ImageSets[ImageIdx].ImageData[DataIdx].TexImage = Surface(DynamicLoadObject(ImageSets[ImageIdx].ImageData[DataIdx].TexImageName, class'Surface'));

			if(ImageSets[ImageIdx].ImageData[DataIdx].TexImage == None)
			{
				LogInternal("UTUIFrontEnd_Credits - Couldn't find image "$ImageSets[ImageIdx].ImageData[DataIdx].TexImageName);
			}
			else
			{
				LogInternal("UTUIFrontEnd_Credits - DLO Image: "$ImageSets[ImageIdx].ImageData[DataIdx].TexImageName);
			}
		}
	}

	SetupScene();
}

/** Sets up the scene's button bar. */
function SetupButtonBar()
{
	ButtonBar.Clear();
	ButtonBar.AppendButton("<Strings:UTGameUI.ButtonCallouts.Back>", OnButtonBar_Back);
}


/** Finishes the credits, either by closing the scene or going back to the main menu. */
function OnFinishCredits()
{
	local UTPlayerController PC;

	PC = GetUTPlayerOwner();

	if(PC.GetURLMap()!="UTFrontEnd")
	{
		PC.QuitToMainMenu();
	}
	else
	{
		CloseScene(self);
	}
}

/** Callback for when the credits have finished displaying. */
event OnCreditsFinished()
{
	if(bFinishedPlaying==false)
	{
		OnFinishCredits();
		bFinishedPlaying=true;
	}
}

/** Callback for when the user wants to back out of this screen. */
function OnBack()
{
	OnFinishCredits();
}

/** Buttonbar Callbacks. */
function bool OnButtonBar_Back(UIScreenObject InButton, int InPlayerIndex)
{
	OnBack();

	return true;
}

/**
 * Provides a hook for unrealscript to respond to input using actual input key names (i.e. Left, Tab, etc.)
 *
 * Called when an input key event is received which this widget responds to and is in the correct state to process.  The
 * keys and states widgets receive input for is managed through the UI editor's key binding dialog (F8).
 *
 * This delegate is called BEFORE kismet is given a chance to process the input.
 *
 * @param	EventParms	information about the input event.
 *
 * @return	TRUE to indicate that this input key was processed; no further processing will occur on this input key event.
 */
function bool HandleInputKey( const out InputEventParameters EventParms )
{
	local bool bResult;

	bResult=false;

	if(EventParms.EventType==IE_Released)
	{
		if(EventParms.InputKeyName=='XboxTypeS_B' || EventParms.InputKeyName=='Escape')
		{
			OnBack();
			bResult=true;
		}
	}

	return bResult;
}

defaultproperties
{
   SceneTimeInSec=240.000000
   DelayBeforePictures=10.000000
   DelayAfterPictures=20.000000
   Begin Object Class=UIComp_Event Name=SceneEventComponent ObjName=SceneEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIFrontEnd:SceneEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIFrontEnd:SceneEventComponent'
   End Object
   EventProvider=SceneEventComponent
   Name="Default__UTUIFrontEnd_Credits"
   ObjectArchetype=UTUIFrontEnd'UTGame.Default__UTUIFrontEnd'
}
