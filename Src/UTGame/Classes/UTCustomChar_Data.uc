/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 * This object is used as a store for all custom character part and profile information.
 */
class UTCustomChar_Data extends Object
	native
	config(CustomChar);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Enum defining different 'slots' for a custom character. */
enum ECharPart
{
	PART_Head,
	PART_Helmet,
	PART_Facemask,
	PART_Goggles,
	PART_Torso,
	PART_ShoPad,
	PART_Arms,
	PART_Thighs,
	PART_Boots
};

/** Structure defining a complete custom character, along with the faction and its name. */
struct native CustomCharData
{
	/** Used to find voice-pack etc, and as fallback character setup. */
	var string BasedOnCharID;

	/** This defines which 'set' of parts we are drawing from. */
	var string FamilyID;

	var string HeadID;
	var string HelmetID;
	var string FacemaskID;
	var string GogglesID;
	var string TorsoID;
	var string ShoPadID;
	var bool bHasLeftShoPad;
	var bool bHasRightShoPad;
	var string ArmsID;
	var string ThighsID;
	var string BootsID;
};

/** information about AI abilities/personality (generally map directly to UTBot properties) */
struct native CustomAIData
{
	var float Tactics, StrafingAbility, Accuracy, Aggressiveness, CombatStyle, Jumpiness, ReactionTime;
	/** full path to class of bot's favorite weapon */
	var string FavoriteWeapon;

	structdefaultproperties
	{
		Aggressiveness=0.4
		CombatStyle=0.2
	}
};

/** Structure defining a pre-made character in the game. */
struct native CharacterInfo
{
	/** Short unique string . */
	var string CharID;

	/** Friendly name for character. */
	var localized string CharName;

	/** Localized description of the character. */
	var localized string Description;

	/** Preview image markup for the character. */
	var string PreviewImageMarkup;

	/** Faction to which this character belongs (e.g. IronGuard). */
	var string Faction;
	/** What this character looks like. */
	var CustomCharData CharData;
	/** AI personality */
	var CustomAIData AIData;
	/** any extra properties of this character (for mod use) */
	var string ExtraInfo;
	/** whether this character shows up in menus by default */
	var bool bLocked;

	/** If true, this character will never be used for a random character in a single player game */
	var bool bRestrictInSinglePlayer;

	// @TODO: VOICE PACK
};

/** Structure defining information about a particular faction (eg. Ironguard) */
struct native FactionInfo
{
	var string Faction;

	/** Preview image markup for the faction. */
	var string PreviewImageMarkup;

	/** Localized version of the faction name to display in the UI. */
	var localized string FriendlyName;

	/** Description of the faction. */
	var localized string Description;
};

/** Structure defining one part of a custom character. */
struct native CustomCharPart
{
	/** Which 'slot' this part is for. */
	var ECharPart	Part;

	/** Name of actual SkeletalMesh object to find for this part. */
	var string		ObjectName;

	/** Short ID used within the CustomCharData. */
	var string		PartID;

	/** 'Set' to which this part belongs. All parts of a CustomCharData belong to the same family. */
	var string		FamilyID;

	/** If true, do not show goggles when this part is equipped. Only used on Helmets. */
	var bool		bNoGoggles;

	/** If true, do not show facemask when this part is equipped. Only used on Helmets. */
	var bool		bNoFacemask;

	/** If true, when using this helmet, use the neck stump mesh instead of real head. Only used on Helmets. */
	var bool		bUseNeckStumpForHead;
};

struct native CustomCharMergeState
{
	var bool				bMergeInProgress;
	/** Indicates that this character will not be valid (missing important part for example). */
	var bool				bInvalidChar;
	/** If true, this char changes LOD further away - set when using Self or Full texture detail. */
	var bool				bPushOutLODTransitions;
	var bool				bUseKrallRules;
	var bool				bUseNecrisMaleRules;
	var bool				bUseNecrisFemaleRules;

	var CustomCharData		CharData;
	var string				TeamString;

	/** If mesh is created and passed in - this is it - the one to place resulting merge mesh into. */
	var SkeletalMesh		UseMesh;

	// Diffuse, Normal, Specular, SpecPower, EmMask
	var Texture2DComposite	HeadTextures[5];
	var Texture2DComposite	BodyTextures[5];

	// Output MICs applied to head/body - Parent is FamilyInfo.BaseMICParent
	var MaterialInstanceConstant	DefaultHeadMIC;
	var MaterialInstanceConstant	DefaultBodyMIC;
};

/** Array of all parts, defined in UTCustomChar.ini file. */
var() config array<CustomCharPart>		Parts;

/** Aray of all complete character profiles, defined in UTCustomChar.ini file. */
var() config array<CharacterInfo>		Characters;

/** Array of top-level factions (eg Iron Guard). */
var() config array<FactionInfo>			Factions;

/** Array of info for each family (eg IRNM) */
var() array< class<UTFamilyInfo> >		Families;
/** full path to mod families. These will be added to the Families list on the first FindFamilyInfo() */
var() config array<string> ModFamilies;
var bool bAddedModFamilies;

var() config array<SourceTexture2DRegion>	HeadRegions; // head, eyes, teeth, stump, eyewear, facemask, helmet/hair
var() config array<SourceTexture2DRegion>	BodyRegions; // chest, thighs, shoulder pads, arms, boots

// Diffuse, Normal, Specular, SpecPower, EmMask
var() config int HeadMaxTexSize[5];
var() config int BodyMaxTexSize[5];

var() config int SelfHeadMaxTexSize[5];
var() config int SelfBodyMaxTexSize[5];

var() config float LOD1DisplayFactor;
var() config float LOD2DisplayFactor;
var() config float LOD3DisplayFactor;

var() config float CustomCharTextureStreamTimeout;

/** Structure defining setup for capturing character portrait bitmap. */
struct native CharPortraitSetup
{
	/** Name of bone to center view on. */
	var name	CenterOnBone;

	/** Translation of mesh (applied on top of CenterOnBone alignment. */
	var vector	MeshOffset;

	/** Rotation of mesh. */
	var rotator	MeshRot;

	/** FOV of camera. */
	var	float	CamFOV;

	/** Directional light rotation. */
	var rotator	DirLightRot;
	/** Directional light brightness. */
	var	float	DirLightBrightness;
	/** Directional light color. */
	var color	DirLightColor;

	/** Directional light rotation. */
	var rotator	DirLight2Rot;
	/** Directional light brightness. */
	var	float	DirLight2Brightness;
	/** Directional light color. */
	var color	DirLight2Color;

	/** Directional light rotation. */
	var rotator	DirLight3Rot;
	/** Directional light brightness. */
	var	float	DirLight3Brightness;
	/** Directional light color. */
	var color	DirLight3Color;

	/** Skylight brightness. */
	var float	SkyBrightness;

	/** Sky light color */
	var color	SkyColor;

	/** Sky lower brightness */
	var float	SkyLowerBrightness;

	/** Sky lower colour */
	var color	SkyLowerColor;

	/** Position of background mesh */
	var vector	PortraitBackgroundTranslation;

	/** Size of texture to render to */
	var int		TextureSize;
};

/** Enum for specifying resolution for texture created for custom chars. */
enum CustomCharTextureRes
{
	CCTR_Normal,
	CCTR_Full,
	CCTR_Self
};

/** Array used to map between bits stored in profile and unlocked chars. */
var array<String>	UnlockableChars;

// Default (fallback) first-person arm mesh - for when character does not have a custom char. */
var string	DefaultArmMeshPackageName;
var string	DefaultArmMeshName;
var	string	DefaultArmSkinPackageName;
var	string	DefaultRedArmSkinName;
var	string	DefaultBlueArmSkinName;

// Default portrait config to use
var() config CharPortraitSetup	PortraitSetup;

/** StaticMesh to use for background of portrait. */
var StaticMesh PortraitBackgroundMesh;

/** For Necris Male chars, 'chest skin' is instead 'pipes' using these textures. */
var string NecrisMalePipeTextures[5];

/** For Necris female chars, 'chest skin' is instead 'pipes' using these textures. */
var string NecrisFemalePipeTextures[5];

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Given a family, part and ID string, give the SkeletalMesh object name to use. */
static native final function string FindPartObjName(string InFamilyID, ECharPart InPart, string InPartID);

/** Given a family, part and ID string, find the SkeletalMesh object itself. */
static native final function SkeletalMesh FindPartSkelMesh(string InFamilyID, ECharPart InPart, string InPartID, bool bLeftShoPad, bool bUseHelmetHead, string InBasedOnCharID);

/** Given a faction and character ID, find the character that defines all its parts. */
static native final function CharacterInfo FindCharacter(string InFaction, string InCharID);

/** Find the info class for a particular family */
static native final function class<UTFamilyInfo> FindFamilyInfo(string InFamilyID);

/**
 *	This loads all assets associated with a custom character family (based on ini file) and create a
 *	UTCharFamilyAssetStore which is used to keep refs to all the required assets.
 *	@param bBlocking	If true, game will block until all assets are loaded.
 *	@param bArms		Load package containing arm mesh for this family
 */
static native final function UTCharFamilyAssetStore LoadFamilyAssets(string InFamilyID, bool bBlocking, bool bArms);

/**
 *	Given a complete character profile, combine all the individual parts into a new SkeletalMesh.
 *	New SkeletalMesh, Texture2Ds and MaterialInterface are created in the transient package.
 *	TeamString and SkinString are strings used to replace V01 and SK1 in the diffuse and spec texture names. This allows
 *	for team- and skin-specific versions of the material to be created.
 *	This function starts all the relevant textures streaming in.
 *	@param	UseMesh	If supplied, this mesh will be used for the result. If not, a new mesh in the transient package will be created.
 */
static native final function CustomCharMergeState StartCustomCharMerge(CustomCharData InCharData, string TeamString, SkeletalMesh UseMesh, CustomCharTextureRes TextureRes);

/**
 *	Must call StartCustomCharMerge before this function.
 *	If all necessary textures are streamed in, parts will be combined and a new SkeletalMesh will be returned, and the part textures allowed to stream out again.
 *	If textures are not streamed in yet, NULL will be returned.
 */
static native final function SkeletalMesh FinishCustomCharMerge(out CustomCharMergeState MergeState);

/** Call to abandon merging of parts - textures are set to unstream and MergeState is reset to defaults. */
static native final function ResetCustomCharMerge(out CustomCharMergeState MergeState);

/**
 *	Util for creating a portrait texture for the supplied skeletal mesh.
 */
static native final function texture MakeCharPortraitTexture(SkeletalMesh CharMesh, CharPortraitSetup Setup, StaticMesh BackgroundMesh);

/** Utility for creating a random player character. */
static native final function CustomCharData MakeRandomCharData();

/** Utility for converting custom char data into one string */
static native final function string CharDataToString(CustomCharData InCharData);

/** Utility for converting a string into a custom char data. */
static native final function CustomCharData CharDataFromString(string InString);

defaultproperties
{
   Parts(0)=(ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Head01",PartID="A",FamilyID="IRNM")
   Parts(1)=(ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Head02",PartID="B",FamilyID="IRNM")
   Parts(2)=(ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Head03",PartID="C",FamilyID="IRNM")
   Parts(3)=(ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Head04",PartID="D",FamilyID="IRNM")
   Parts(4)=(ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Head01",PartID="A",FamilyID="IRNF")
   Parts(5)=(ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Head02",PartID="B",FamilyID="IRNF")
   Parts(6)=(ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Head03",PartID="C",FamilyID="IRNF")
   Parts(7)=(ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Head01",PartID="A",FamilyID="TWIM")
   Parts(8)=(ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Head02",PartID="B",FamilyID="TWIM")
   Parts(9)=(ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Head03-noGog",PartID="C",FamilyID="TWIM")
   Parts(10)=(ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Head04",PartID="D",FamilyID="TWIM")
   Parts(11)=(ObjectName="CH_RTeam_Female.Mesh.SK_CH_RTeam_Female_Head03",PartID="A",FamilyID="TWIF")
   Parts(12)=(ObjectName="CH_RTeam_Female.Mesh.SK_CH_RTeam_Female_Head02",PartID="B",FamilyID="TWIF")
   Parts(13)=(ObjectName="CH_RTeam_Female2.Mesh.SK_CH_RTeam_Female_Head04x",PartID="C",FamilyID="TWIF")
   Parts(14)=(ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Head01",PartID="A",FamilyID="KRAM")
   Parts(15)=(ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Head02",PartID="B",FamilyID="KRAM")
   Parts(16)=(ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Head03",PartID="C",FamilyID="KRAM")
   Parts(17)=(ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_Head01",PartID="A",FamilyID="NECF")
   Parts(18)=(ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_Head02",PartID="B",FamilyID="NECF")
   Parts(19)=(ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Head01",PartID="A",FamilyID="NECM")
   Parts(20)=(ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Head02",PartID="B",FamilyID="NECM")
   Parts(21)=(ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Head03",PartID="C",FamilyID="NECM")
   Parts(22)=(ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Head01",PartID="A",FamilyID="LIAM")
   Parts(23)=(ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Head02",PartID="B",FamilyID="LIAM")
   Parts(24)=(ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Head03",PartID="C",FamilyID="LIAM")
   Parts(25)=(ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Head04",PartID="D",FamilyID="LIAM")
   Parts(26)=(ObjectName="CH_Corrupt_Male2.Mesh.SK_CH_Corrupt_Male_Head03x",PartID="E",FamilyID="LIAM")
   Parts(27)=(Part=PART_Helmet,PartID="NONE",FamilyID="IRNM")
   Parts(28)=(Part=PART_Helmet,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_HalfHelmet01",PartID="A",FamilyID="IRNM",bNoGoggles=True)
   Parts(29)=(Part=PART_Helmet,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_HalfHelmet02",PartID="B",FamilyID="IRNM",bNoGoggles=True)
   Parts(30)=(Part=PART_Helmet,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Helmet01",PartID="C",FamilyID="IRNM",bNoGoggles=True,bNoFacemask=True,bUseNeckStumpForHead=True)
   Parts(31)=(Part=PART_Helmet,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Helmet02",PartID="D",FamilyID="IRNM",bNoGoggles=True,bNoFacemask=True,bUseNeckStumpForHead=True)
   Parts(32)=(Part=PART_Helmet,PartID="NONE",FamilyID="IRNF")
   Parts(33)=(Part=PART_Helmet,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Helmet01",PartID="A",FamilyID="IRNF",bNoGoggles=True,bNoFacemask=True)
   Parts(34)=(Part=PART_Helmet,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Helmet02",PartID="B",FamilyID="IRNF",bNoGoggles=True,bNoFacemask=True,bUseNeckStumpForHead=True)
   Parts(35)=(Part=PART_Helmet,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Helmet03",PartID="C",FamilyID="IRNF",bNoGoggles=True,bNoFacemask=True)
   Parts(36)=(Part=PART_Helmet,PartID="NONE",FamilyID="TWIM")
   Parts(37)=(Part=PART_Helmet,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Helmet01",PartID="A",FamilyID="TWIM",bNoGoggles=True,bNoFacemask=True,bUseNeckStumpForHead=True)
   Parts(38)=(Part=PART_Helmet,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Helmet02",PartID="B",FamilyID="TWIM",bNoGoggles=True,bNoFacemask=True,bUseNeckStumpForHead=True)
   Parts(39)=(Part=PART_Helmet,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Helmet03",PartID="C",FamilyID="TWIM",bNoGoggles=True,bNoFacemask=True,bUseNeckStumpForHead=True)
   Parts(40)=(Part=PART_Helmet,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Helmet04",PartID="D",FamilyID="TWIM",bNoGoggles=True,bNoFacemask=True,bUseNeckStumpForHead=True)
   Parts(41)=(Part=PART_Helmet,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_HalfHelmet01",PartID="E",FamilyID="TWIM",bNoGoggles=True)
   Parts(42)=(Part=PART_Helmet,PartID="NONE",FamilyID="TWIF")
   Parts(43)=(Part=PART_Helmet,ObjectName="CH_RTeam_Female.Mesh.SK_CH_Twinsouls_FHelmet01",PartID="A",FamilyID="TWIF")
   Parts(44)=(Part=PART_Helmet,ObjectName="CH_RTeam_Female.Mesh.SK_CH_Twinsouls_FHelmet02",PartID="B",FamilyID="TWIF")
   Parts(45)=(Part=PART_Helmet,ObjectName="CH_RTeam_Female2.Mesh.SK_CH_RTeam_Female_Helmet04x",PartID="C",FamilyID="TWIF",bNoGoggles=True,bNoFacemask=True,bUseNeckStumpForHead=True)
   Parts(46)=(Part=PART_Helmet,PartID="NONE",FamilyID="KRAM")
   Parts(47)=(Part=PART_Helmet,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Helmet01",PartID="A",FamilyID="KRAM",bNoGoggles=True,bNoFacemask=True)
   Parts(48)=(Part=PART_Helmet,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Helmet02",PartID="B",FamilyID="KRAM",bNoGoggles=True,bNoFacemask=True)
   Parts(49)=(Part=PART_Helmet,PartID="NONE",FamilyID="NECM")
   Parts(50)=(Part=PART_Helmet,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_HalfHelmet01",PartID="A",FamilyID="NECM",bNoGoggles=True)
   Parts(51)=(Part=PART_Helmet,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Helmet01",PartID="B",FamilyID="NECM",bNoGoggles=True,bNoFacemask=True)
   Parts(52)=(Part=PART_Helmet,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Helmet02",PartID="C",FamilyID="NECM",bNoGoggles=True,bNoFacemask=True)
   Parts(53)=(Part=PART_Helmet,PartID="NONE",FamilyID="NECF")
   Parts(54)=(Part=PART_Helmet,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_FHelmet01",PartID="A",FamilyID="NECF",bNoGoggles=True,bNoFacemask=True)
   Parts(55)=(Part=PART_Helmet,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_FHelmet02",PartID="B",FamilyID="NECF",bNoGoggles=True,bNoFacemask=True)
   Parts(56)=(Part=PART_Facemask,PartID="NONE",FamilyID="IRNM")
   Parts(57)=(Part=PART_Facemask,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_FaceMask01",PartID="A",FamilyID="IRNM")
   Parts(58)=(Part=PART_Facemask,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_FaceMask02",PartID="B",FamilyID="IRNM")
   Parts(59)=(Part=PART_Facemask,PartID="NONE",FamilyID="TWIM")
   Parts(60)=(Part=PART_Facemask,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_FaceMask01",PartID="A",FamilyID="TWIM")
   Parts(61)=(Part=PART_Facemask,PartID="NONE",FamilyID="TWIF")
   Parts(62)=(Part=PART_Facemask,ObjectName="CH_RTeam_Female2.Mesh.SK_CH_RTeam_Female_Facemask04x",PartID="A",FamilyID="TWIF")
   Parts(63)=(Part=PART_Facemask,PartID="NONE",FamilyID="LIAM")
   Parts(64)=(Part=PART_Facemask,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Headunit01",PartID="A",FamilyID="LIAM")
   Parts(65)=(Part=PART_Facemask,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Headunit02",PartID="B",FamilyID="LIAM")
   Parts(66)=(Part=PART_Facemask,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Headunit03",PartID="C",FamilyID="LIAM")
   Parts(67)=(Part=PART_Facemask,PartID="NONE",FamilyID="NECM")
   Parts(68)=(Part=PART_Facemask,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_FaceMask01",PartID="A",FamilyID="NECM")
   Parts(69)=(Part=PART_Facemask,PartID="NONE",FamilyID="NECF")
   Parts(70)=(Part=PART_Facemask,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_FaceMask01",PartID="A",FamilyID="NECF")
   Parts(71)=(Part=PART_Goggles,PartID="NONE",FamilyID="IRNM")
   Parts(72)=(Part=PART_Goggles,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Goggle01",PartID="A",FamilyID="IRNM")
   Parts(73)=(Part=PART_Goggles,PartID="NONE",FamilyID="TWIM")
   Parts(74)=(Part=PART_Goggles,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Goggle01",PartID="A",FamilyID="TWIM")
   Parts(75)=(Part=PART_Goggles,PartID="NONE",FamilyID="TWIF")
   Parts(76)=(Part=PART_Goggles,ObjectName="CH_RTeam_Female2.Mesh.SK_CH_RTeam_Female_Goggles04x",PartID="A",FamilyID="TWIF")
   Parts(77)=(Part=PART_Goggles,PartID="NONE",FamilyID="NECM")
   Parts(78)=(Part=PART_Goggles,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Goggle01",PartID="A",FamilyID="NECM")
   Parts(79)=(Part=PART_Torso,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Torso01",PartID="A",FamilyID="IRNM")
   Parts(80)=(Part=PART_Torso,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Torso02",PartID="B",FamilyID="IRNM")
   Parts(81)=(Part=PART_Torso,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Torso03",PartID="C",FamilyID="IRNM")
   Parts(82)=(Part=PART_Torso,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Torso01",PartID="A",FamilyID="IRNF")
   Parts(83)=(Part=PART_Torso,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Torso02",PartID="B",FamilyID="IRNF")
   Parts(84)=(Part=PART_Torso,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Torso01",PartID="A",FamilyID="TWIM")
   Parts(85)=(Part=PART_Torso,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Torso02",PartID="B",FamilyID="TWIM")
   Parts(86)=(Part=PART_Torso,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Torso03",PartID="C",FamilyID="TWIM")
   Parts(87)=(Part=PART_Torso,ObjectName="CH_RTeam_Female.Mesh.SK_CH_RTeam_Female_Torso01",PartID="A",FamilyID="TWIF")
   Parts(88)=(Part=PART_Torso,ObjectName="CH_RTeam_Female.Mesh.SK_CH_RTeam_Female_Torso02",PartID="B",FamilyID="TWIF")
   Parts(89)=(Part=PART_Torso,ObjectName="CH_RTeam_Female2.Mesh.SK_CH_RTeam_Female_Torso04x",PartID="C",FamilyID="TWIF")
   Parts(90)=(Part=PART_Torso,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Torso01",PartID="A",FamilyID="KRAM")
   Parts(91)=(Part=PART_Torso,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Torso02",PartID="B",FamilyID="KRAM")
   Parts(92)=(Part=PART_Torso,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Torso03",PartID="C",FamilyID="KRAM")
   Parts(93)=(Part=PART_Torso,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_Torso01",PartID="A",FamilyID="NECF")
   Parts(94)=(Part=PART_Torso,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_Torso02",PartID="B",FamilyID="NECF")
   Parts(95)=(Part=PART_Torso,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Torso01",PartID="A",FamilyID="NECM")
   Parts(96)=(Part=PART_Torso,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Torso02",PartID="B",FamilyID="NECM")
   Parts(97)=(Part=PART_Torso,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Torso01",PartID="A",FamilyID="LIAM")
   Parts(98)=(Part=PART_Torso,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Torso02",PartID="B",FamilyID="LIAM")
   Parts(99)=(Part=PART_Torso,ObjectName="CH_Corrupt_Male2.Mesh.SK_CH_Corrupt_Male_Torso03x",PartID="C",FamilyID="LIAM")
   Parts(100)=(Part=PART_ShoPad,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_XShoPad01",PartID="A",FamilyID="IRNM")
   Parts(101)=(Part=PART_ShoPad,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_XShoPad02",PartID="B",FamilyID="IRNM")
   Parts(102)=(Part=PART_ShoPad,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_XShoPad03",PartID="C",FamilyID="IRNM")
   Parts(103)=(Part=PART_ShoPad,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_XShoPad01",PartID="A",FamilyID="IRNF")
   Parts(104)=(Part=PART_ShoPad,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_XShoPad02",PartID="B",FamilyID="IRNF")
   Parts(105)=(Part=PART_ShoPad,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_XShoPad03",PartID="C",FamilyID="IRNF")
   Parts(106)=(Part=PART_ShoPad,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_XShoPad04",PartID="D",FamilyID="IRNF")
   Parts(107)=(Part=PART_ShoPad,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_XShoPad05",PartID="E",FamilyID="IRNF")
   Parts(108)=(Part=PART_ShoPad,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_XShoPad01",PartID="A",FamilyID="TWIM")
   Parts(109)=(Part=PART_ShoPad,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_XShoPad02",PartID="B",FamilyID="TWIM")
   Parts(110)=(Part=PART_ShoPad,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_XShoPad03",PartID="C",FamilyID="TWIM")
   Parts(111)=(Part=PART_ShoPad,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_XShoPad04",PartID="D",FamilyID="TWIM")
   Parts(112)=(Part=PART_ShoPad,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_XShoPad05",PartID="E",FamilyID="TWIM")
   Parts(113)=(Part=PART_ShoPad,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_XShoPad06",PartID="F",FamilyID="TWIM")
   Parts(114)=(Part=PART_ShoPad,ObjectName="CH_RTeam_Female.Mesh.SK_CH_RTeam_Female_XShoPad01",PartID="A",FamilyID="TWIF")
   Parts(115)=(Part=PART_ShoPad,ObjectName="CH_RTeam_Female.Mesh.SK_CH_RTeam_Female_XShoPad02",PartID="B",FamilyID="TWIF")
   Parts(116)=(Part=PART_ShoPad,ObjectName="CH_RTeam_Female2.Mesh.SK_CH_RTeam_Female_XShoPad04x",PartID="C",FamilyID="TWIF")
   Parts(117)=(Part=PART_ShoPad,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_XShoPad01",PartID="A",FamilyID="KRAM")
   Parts(118)=(Part=PART_ShoPad,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_XShoPad02",PartID="B",FamilyID="KRAM")
   Parts(119)=(Part=PART_ShoPad,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_XShoPad01",PartID="A",FamilyID="NECF")
   Parts(120)=(Part=PART_ShoPad,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_XShoPad02",PartID="B",FamilyID="NECF")
   Parts(121)=(Part=PART_ShoPad,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_XShoPad01",PartID="A",FamilyID="NECM")
   Parts(122)=(Part=PART_ShoPad,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_XShoPad02",PartID="B",FamilyID="NECM")
   Parts(123)=(Part=PART_ShoPad,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_XShoPad01",PartID="A",FamilyID="LIAM")
   Parts(124)=(Part=PART_ShoPad,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_XShoPad02",PartID="B",FamilyID="LIAM")
   Parts(125)=(Part=PART_ShoPad,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_XShoPad04",PartID="C",FamilyID="LIAM")
   Parts(126)=(Part=PART_ShoPad,ObjectName="CH_Corrupt_Male2.Mesh.SK_CH_Corrupt_Male_XShoPad03x",PartID="D",FamilyID="LIAM")
   Parts(127)=(Part=PART_Arms,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Arms01",PartID="A",FamilyID="IRNM")
   Parts(128)=(Part=PART_Arms,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Arms02",PartID="B",FamilyID="IRNM")
   Parts(129)=(Part=PART_Arms,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Arms03",PartID="C",FamilyID="IRNM")
   Parts(130)=(Part=PART_Arms,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Arms",PartID="A",FamilyID="IRNF")
   Parts(131)=(Part=PART_Arms,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Arms02",PartID="B",FamilyID="IRNF")
   Parts(132)=(Part=PART_Arms,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Arms01",PartID="A",FamilyID="TWIM")
   Parts(133)=(Part=PART_Arms,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Arms02",PartID="B",FamilyID="TWIM")
   Parts(134)=(Part=PART_Arms,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Arms03",PartID="C",FamilyID="TWIM")
   Parts(135)=(Part=PART_Arms,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Arms04",PartID="D",FamilyID="TWIM")
   Parts(136)=(Part=PART_Arms,ObjectName="CH_RTeam_Female.Mesh.SK_CH_RTeam_Female_Arms01",PartID="A",FamilyID="TWIF")
   Parts(137)=(Part=PART_Arms,ObjectName="CH_RTeam_Female.Mesh.SK_CH_RTeam_Female_Arms02",PartID="B",FamilyID="TWIF")
   Parts(138)=(Part=PART_Arms,ObjectName="CH_RTeam_Female2.Mesh.SK_CH_RTeam_Female_Arms04x",PartID="C",FamilyID="TWIF")
   Parts(139)=(Part=PART_Arms,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Arms01",PartID="A",FamilyID="KRAM")
   Parts(140)=(Part=PART_Arms,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Arms02",PartID="B",FamilyID="KRAM")
   Parts(141)=(Part=PART_Arms,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Arms03",PartID="C",FamilyID="KRAM")
   Parts(142)=(Part=PART_Arms,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Arms04",PartID="D",FamilyID="KRAM")
   Parts(143)=(Part=PART_Arms,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Arms05",PartID="E",FamilyID="KRAM")
   Parts(144)=(Part=PART_Arms,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_Arms01",PartID="A",FamilyID="NECF")
   Parts(145)=(Part=PART_Arms,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_Arms02",PartID="B",FamilyID="NECF")
   Parts(146)=(Part=PART_Arms,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Arms01",PartID="A",FamilyID="NECM")
   Parts(147)=(Part=PART_Arms,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Arms02",PartID="B",FamilyID="NECM")
   Parts(148)=(Part=PART_Arms,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Arms03",PartID="C",FamilyID="NECM")
   Parts(149)=(Part=PART_Arms,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Arms04",PartID="D",FamilyID="NECM")
   Parts(150)=(Part=PART_Arms,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Arms01",PartID="A",FamilyID="LIAM")
   Parts(151)=(Part=PART_Arms,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Arms02",PartID="B",FamilyID="LIAM")
   Parts(152)=(Part=PART_Arms,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Arms03",PartID="C",FamilyID="LIAM")
   Parts(153)=(Part=PART_Arms,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Arms04",PartID="D",FamilyID="LIAM")
   Parts(154)=(Part=PART_Arms,ObjectName="CH_Corrupt_Male2.Mesh.SK_CH_Corrupt_Male_Arms03x",PartID="E",FamilyID="LIAM")
   Parts(155)=(Part=PART_Thighs,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Thighs01",PartID="A",FamilyID="IRNM")
   Parts(156)=(Part=PART_Thighs,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Thighs02",PartID="B",FamilyID="IRNM")
   Parts(157)=(Part=PART_Thighs,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Thighs03",PartID="C",FamilyID="IRNM")
   Parts(158)=(Part=PART_Thighs,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Thighs01",PartID="A",FamilyID="IRNF")
   Parts(159)=(Part=PART_Thighs,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Thighs02",PartID="B",FamilyID="IRNF")
   Parts(160)=(Part=PART_Thighs,ObjectName="CH_RTeam_Male2.Mesh.SK_CH_RTeam_Male2_Thighs01",PartID="A",FamilyID="TWIM")
   Parts(161)=(Part=PART_Thighs,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Thighs02",PartID="B",FamilyID="TWIM")
   Parts(162)=(Part=PART_Thighs,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Thighs03",PartID="C",FamilyID="TWIM")
   Parts(163)=(Part=PART_Thighs,ObjectName="CH_RTeam_Female.Mesh.SK_CH_RTeam_Female_Thighs01",PartID="A",FamilyID="TWIF")
   Parts(164)=(Part=PART_Thighs,ObjectName="CH_RTeam_Female2.Mesh.SK_CH_RTeam_Female2_Thighs02",PartID="B",FamilyID="TWIF")
   Parts(165)=(Part=PART_Thighs,ObjectName="CH_RTeam_Female2.Mesh.SK_CH_RTeam_Female_Thighs04x",PartID="C",FamilyID="TWIF")
   Parts(166)=(Part=PART_Thighs,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Thighs01",PartID="A",FamilyID="KRAM")
   Parts(167)=(Part=PART_Thighs,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Thighs02",PartID="B",FamilyID="KRAM")
   Parts(168)=(Part=PART_Thighs,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Thighs03",PartID="C",FamilyID="KRAM")
   Parts(169)=(Part=PART_Thighs,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Thighs04",PartID="D",FamilyID="KRAM")
   Parts(170)=(Part=PART_Thighs,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_Thighs05",PartID="E",FamilyID="KRAM")
   Parts(171)=(Part=PART_Thighs,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_Thighs01",PartID="A",FamilyID="NECF")
   Parts(172)=(Part=PART_Thighs,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_Thighs02",PartID="B",FamilyID="NECF")
   Parts(173)=(Part=PART_Thighs,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Thighs01",PartID="A",FamilyID="NECM")
   Parts(174)=(Part=PART_Thighs,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Thighs02",PartID="B",FamilyID="NECM")
   Parts(175)=(Part=PART_Thighs,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Thighs01",PartID="A",FamilyID="LIAM")
   Parts(176)=(Part=PART_Thighs,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Thighs02",PartID="B",FamilyID="LIAM")
   Parts(177)=(Part=PART_Thighs,ObjectName="CH_Corrupt_Male2.Mesh.SK_CH_Corrupt_Male_Thighs03x",PartID="C",FamilyID="LIAM")
   Parts(178)=(Part=PART_Boots,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Boots01",PartID="A",FamilyID="IRNM")
   Parts(179)=(Part=PART_Boots,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Boots02",PartID="B",FamilyID="IRNM")
   Parts(180)=(Part=PART_Boots,ObjectName="CH_IronGuard_Male.Mesh.SK_CH_IronG_Male_Boots03",PartID="C",FamilyID="IRNM")
   Parts(181)=(Part=PART_Boots,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Boots01",PartID="A",FamilyID="IRNF")
   Parts(182)=(Part=PART_Boots,ObjectName="CH_IronGuard_Female.Mesh.SK_CH_IronG_Female_Boots02",PartID="B",FamilyID="IRNF")
   Parts(183)=(Part=PART_Boots,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Boots01",PartID="A",FamilyID="TWIM")
   Parts(184)=(Part=PART_Boots,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Boots02",PartID="B",FamilyID="TWIM")
   Parts(185)=(Part=PART_Boots,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Boots03",PartID="C",FamilyID="TWIM")
   Parts(186)=(Part=PART_Boots,ObjectName="CH_RTeam_Male.Mesh.SK_CH_RTeam_Male_Boots04",PartID="D",FamilyID="TWIM")
   Parts(187)=(Part=PART_Boots,ObjectName="CH_RTeam_Female.Mesh.SK_CH_RTeam_Female_Boots01",PartID="A",FamilyID="TWIF")
   Parts(188)=(Part=PART_Boots,ObjectName="CH_RTeam_Female.Mesh.SK_CH_RTeam_Female_Boots02",PartID="B",FamilyID="TWIF")
   Parts(189)=(Part=PART_Boots,ObjectName="CH_RTeam_Female2.Mesh.SK_CH_RTeam_Female_Boots04x",PartID="C",FamilyID="TWIF")
   Parts(190)=(Part=PART_Boots,PartID="NONE",FamilyID="KRAM")
   Parts(191)=(Part=PART_Boots,ObjectName="CH_Krall_Male.Mesh.SK_CH_Krall_Male_KneePad01",PartID="A",FamilyID="KRAM")
   Parts(192)=(Part=PART_Boots,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_Boots01",PartID="A",FamilyID="NECF")
   Parts(193)=(Part=PART_Boots,ObjectName="CH_Necris_Female.Mesh.SK_CH_Necris_Female_Boots02",PartID="B",FamilyID="NECF")
   Parts(194)=(Part=PART_Boots,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Boots01",PartID="A",FamilyID="NECM")
   Parts(195)=(Part=PART_Boots,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Boots02",PartID="B",FamilyID="NECM")
   Parts(196)=(Part=PART_Boots,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Boots03",PartID="C",FamilyID="NECM")
   Parts(197)=(Part=PART_Boots,ObjectName="CH_Necris_Male1.Mesh.SK_CH_Necris_Male_Boots04",PartID="D",FamilyID="NECM")
   Parts(198)=(Part=PART_Boots,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Boots01",PartID="A",FamilyID="LIAM")
   Parts(199)=(Part=PART_Boots,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Boots02",PartID="B",FamilyID="LIAM")
   Parts(200)=(Part=PART_Boots,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Boots03",PartID="C",FamilyID="LIAM")
   Parts(201)=(Part=PART_Boots,ObjectName="CH_Corrupt_Male.Mesh.SK_CH_Corrupt_Male_Boots04",PartID="D",FamilyID="LIAM")
   Parts(202)=(Part=PART_Boots,ObjectName="CH_Corrupt_Male2.Mesh.SK_CH_Corrupt_Male_Boots03x",PartID="E",FamilyID="LIAM")
   Characters(0)=(CharID="A",CharName="Lauren",Description="<Strings:UTGameUI.CharLocData.Lauren_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Female_Head01>",Faction="Ironguard",CharData=(FamilyID="IRNF",HeadID="A",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Tactics=1.000000,StrafingAbility=1.000000,Accuracy=0.500000,Aggressiveness=0.400000,CombatStyle=0.200000,FavoriteWeapon="UTGame.UTWeap_ShockRifle"),bLocked=True)
   Characters(1)=(CharID="C",CharName="Barktooth",Description="<Strings:UTGameUI.CharLocData.Barktooth_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Male_Head02>",Faction="Ironguard",CharData=(FamilyID="IRNM",HeadID="B",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="A",BootsID="C"),AIData=(Aggressiveness=0.500000,CombatStyle=0.200000,FavoriteWeapon="UTGame.UTWeap_FlakCannon"))
   Characters(2)=(CharID="B",CharName="Harlin",Description="<Strings:UTGameUI.CharLocData.Harlin_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Male_Head01>",Faction="Ironguard",CharData=(FamilyID="IRNM",HeadID="A",TorsoID="B",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Characters(3)=(CharID="D",CharName="Slain",Description="<Strings:UTGameUI.CharLocData.Slain_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Male_Head03>",Faction="Ironguard",CharData=(FamilyID="IRNM",HeadID="C",TorsoID="C",ShoPadID="C",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="C",ThighsID="C",BootsID="C"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Characters(4)=(CharID="E",CharName="Cain",Description="<Strings:UTGameUI.CharLocData.Cain_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Male_Head01>",Faction="Ironguard",CharData=(FamilyID="IRNM",HeadID="C",FacemaskID="A",TorsoID="C",ShoPadID="A",ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(5)=(CharID="F",CharName="Johnson",Description="<Strings:UTGameUI.CharLocData.Johnson_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Male_Head02>",Faction="Ironguard",CharData=(FamilyID="IRNM",HeadID="D",TorsoID="A",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="C",BootsID="C"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(6)=(CharID="G",CharName="Karag",Description="<Strings:UTGameUI.CharLocData.Karag_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Male_Head03>",Faction="Ironguard",CharData=(FamilyID="IRNM",HeadID="c",GogglesID="A",TorsoID="A",ShoPadID="A",bHasRightShoPad=True,ArmsID="C",ThighsID="B",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(7)=(CharID="H",CharName="Wraith",Description="<Strings:UTGameUI.CharLocData.Wraith_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Male_Head02>",Faction="Ironguard",CharData=(FamilyID="IRNM",HeadID="c",HelmetID="C",GogglesID="A",TorsoID="A",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="B",BootsID="C"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(8)=(CharID="K",CharName="Blain",Description="<Strings:UTGameUI.CharLocData.Blaine_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Male_Head02>",Faction="Ironguard",CharData=(FamilyID="IRNM",HeadID="B",HelmetID="A",GogglesID="A",TorsoID="C",ShoPadID="C",bHasRightShoPad=True,ArmsID="C",ThighsID="A",BootsID="C"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(9)=(CharID="L",CharName="Drake",Description="<Strings:UTGameUI.CharLocData.Drake_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Male_Head03>",Faction="Ironguard",CharData=(FamilyID="IRNM",HeadID="C",HelmetID="D",TorsoID="C",ShoPadID="C",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="C",ThighsID="C",BootsID="C"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(10)=(CharID="J",CharName="Kregore",Description="<Strings:UTGameUI.CharLocData.Kregore_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Male_Head01>",Faction="Ironguard",CharData=(FamilyID="IRNM",HeadID="A",HelmetID="B",TorsoID="A",ShoPadID="A",ArmsID="C",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(11)=(CharID="I",CharName="Talan",Description="<Strings:UTGameUI.CharLocData.Talan_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Male_Head01>",Faction="Ironguard",CharData=(FamilyID="IRNM",HeadID="D",HelmetID="A",GogglesID="A",TorsoID="A",ShoPadID="A",ArmsID="A",ThighsID="A",BootsID="C"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(12)=(CharID="P",CharName="Ariel",Description="<Strings:UTGameUI.CharLocData.Ariel_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Female_Head02>",Faction="Ironguard",CharData=(FamilyID="IRNF",HeadID="B",TorsoID="B",ShoPadID="E",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="B",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(13)=(CharID="O",CharName="Avalon",Description="<Strings:UTGameUI.CharLocData.Avalon_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Female_Head02>",Faction="Ironguard",CharData=(FamilyID="IRNF",HeadID="B",HelmetID="C",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(14)=(CharID="N",CharName="Blackjack",Description="<Strings:UTGameUI.CharLocData.Blackjack_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Female_Head03>",Faction="Ironguard",CharData=(FamilyID="IRNF",HeadID="C",TorsoID="B",ShoPadID="E",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="B",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Characters(15)=(CharID="M",CharName="Desiree",Description="<Strings:UTGameUI.CharLocData.Desiree_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Ironguard_Female_Head01>",Faction="Ironguard",CharData=(FamilyID="IRNF",HeadID="A",HelmetID="A",TorsoID="A",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(16)=(CharID="A",CharName="Reaper",Description="<Strings:UTGameUI.CharLocData.Reaper_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Male_Head03>",Faction="TwinSouls",CharData=(FamilyID="TWIM",HeadID="C",TorsoID="C",ShoPadID="C",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="C",ThighsID="C",BootsID="C"),AIData=(StrafingAbility=1.000000,Accuracy=0.500000,Aggressiveness=0.400000,CombatStyle=0.500000,FavoriteWeapon="UTGame.UTWeap_RocketLauncher"))
   Characters(17)=(CharID="B",CharName="Bishop",Description="<Strings:UTGameUI.CharLocData.Bishop_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Male_Head04>",Faction="TwinSouls",CharData=(FamilyID="TWIM",HeadID="D",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000,FavoriteWeapon="UTGame.UTWeap_SniperRifle"))
   Characters(18)=(CharID="C",CharName="Othello",Description="<Strings:UTGameUI.CharLocData.Othello_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Male_Head02>",Faction="TwinSouls",CharData=(FamilyID="TWIM",HeadID="B",TorsoID="B",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="B",BootsID="B"),AIData=(Tactics=0.300000,Aggressiveness=0.600000,CombatStyle=0.300000,FavoriteWeapon="UTGame.UTWeap_Stinger"))
   Characters(19)=(CharID="D",CharName="Jester",Description="<Strings:UTGameUI.CharLocData.Jester_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Female_Head01>",Faction="TwinSouls",CharData=(FamilyID="TWIF",HeadID="A",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(StrafingAbility=-0.200000,Aggressiveness=0.400000,CombatStyle=0.500000,Jumpiness=-0.400000,FavoriteWeapon="UTGame.UTWeap_RocketLauncher"))
   Characters(20)=(CharID="P",CharName="Kana",Description="<Strings:UTGameUI.CharLocData.Kana_Description>",PreviewImageMarkup="<Images:UI_Portrait1.Character.UI_Portrait1_Character_TwinSouls_Female_Head04>",Faction="TwinSouls",CharData=(FamilyID="TWIF",HeadID="C",TorsoID="C",ShoPadID="C",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="C",ThighsID="C",BootsID="C"),AIData=(StrafingAbility=-0.200000,Aggressiveness=0.400000,CombatStyle=0.500000,Jumpiness=-0.400000,FavoriteWeapon="UTGame.UTWeap_RocketLauncher"))
   Characters(21)=(CharID="G",CharName="Arashi",Description="<Strings:UTGameUI.CharLocData.Arashi_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Male_Head02>",Faction="TwinSouls",CharData=(FamilyID="TWIM",HeadID="B",HelmetID="E",FacemaskID="A",TorsoID="B",ShoPadID="F",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="C",ThighsID="B",BootsID="C"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(22)=(CharID="F",CharName="Kensai",Description="<Strings:UTGameUI.CharLocData.Kensai_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Male_Head04>",Faction="TwinSouls",CharData=(FamilyID="TWIM",HeadID="A",TorsoID="C",ShoPadID="E",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="C",BootsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(23)=(CharID="H",CharName="Rook",Description="<Strings:UTGameUI.CharLocData.Rock_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Male_Head02>",Faction="TwinSouls",CharData=(FamilyID="TWIM",HeadID="B",HelmetID="C",TorsoID="B",ShoPadID="D",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(24)=(CharID="E",CharName="Ushido",Description="<Strings:UTGameUI.CharLocData.Ushido_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Male_Head03>",Faction="TwinSouls",CharData=(FamilyID="TWIM",HeadID="B",HelmetID="D",TorsoID="C",ShoPadID="A",ArmsID="D",ThighsID="A",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(25)=(CharID="J",CharName="Connor",Description="<Strings:UTGameUI.CharLocData.Connor_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Male_Head04>",Faction="TwinSouls",CharData=(FamilyID="TWIM",HeadID="A",HelmetID="D",TorsoID="A",ShoPadID="D",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="D",ThighsID="A",BootsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(26)=(CharID="K",CharName="Harkin",Description="<Strings:UTGameUI.CharLocData.Harkin_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Male_Head02>",Faction="TwinSouls",CharData=(FamilyID="TWIM",HeadID="B",HelmetID="B",TorsoID="B",ShoPadID="A",bHasRightShoPad=True,ArmsID="A",ThighsID="B",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(27)=(CharID="I",CharName="Hunter",Description="<Strings:UTGameUI.CharLocData.Hunter_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Male_Head03>",Faction="TwinSouls",CharData=(FamilyID="TWIM",HeadID="C",HelmetID="E",TorsoID="C",ShoPadID="E",bHasLeftShoPad=True,ArmsID="C",ThighsID="C",BootsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(28)=(CharID="M",CharName="Cassidy",Description="<Strings:UTGameUI.CharLocData.Cassidy_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Female_Head01>",Faction="TwinSouls",CharData=(FamilyID="TWIF",HeadID="B",HelmetID="B",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(29)=(CharID="O",CharName="Kira",Description="<Strings:UTGameUI.CharLocData.Kira_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Female_Head01>",Faction="TwinSouls",CharData=(FamilyID="TWIF",HeadID="B",HelmetID="A",TorsoID="B",ShoPadID="B",bHasLeftShoPad=True,ArmsID="A",ThighsID="B",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(30)=(CharID="N",CharName="Kai",Description="<Strings:UTGameUI.CharLocData.Kai_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Female_Head02>",Faction="TwinSouls",CharData=(FamilyID="TWIF",HeadID="B",TorsoID="B",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="B",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Characters(31)=(CharID="L",CharName="Metridia",Description="<Strings:UTGameUI.CharLocData.Metridia_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_TwinSouls_Female_Head01>",Faction="TwinSouls",CharData=(FamilyID="TWIF",HeadID="A",HelmetID="B",TorsoID="B",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="A",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(32)=(CharID="A",CharName="Scythe",Description="<Strings:UTGameUI.CharLocData.Scythe_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head02>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="B",HelmetID="A",TorsoID="B",ShoPadID="B",bHasLeftShoPad=True,ArmsID="D",ThighsID="D",BootsID="A"),AIData=(Tactics=0.500000,StrafingAbility=0.500000,Accuracy=0.400000,Aggressiveness=0.400000,CombatStyle=-0.200000,Jumpiness=0.500000,FavoriteWeapon="UTGame.UTWeap_LinkGun"),bLocked=True)
   Characters(33)=(CharID="C",CharName="Cerberus",Description="<Strings:UTGameUI.CharLocData.Cerberus_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head03>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="C",TorsoID="C",ShoPadID="B",bHasRightShoPad=True,ArmsID="C",ThighsID="C"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Characters(34)=(CharID="B",CharName="Gnasher",Description="<Strings:UTGameUI.CharLocData.Gnasher_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head01>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="A",HelmetID="A",TorsoID="A",ShoPadID="A",ArmsID="E",ThighsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Characters(35)=(CharID="D",CharName="Scorn",Description="<Strings:UTGameUI.CharLocData.Scorn_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head04>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="A",HelmetID="B",TorsoID="C",ShoPadID="B",bHasRightShoPad=True,ArmsID="D",ThighsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Characters(36)=(CharID="H",CharName="Lockjaw",Description="<Strings:UTGameUI.CharLocData.Lockjaw_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head04>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="A",HelmetID="B",TorsoID="C",ShoPadID="B",bHasRightShoPad=True,ArmsID="E",ThighsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(37)=(CharID="E",CharName="Scar",Description="<Strings:UTGameUI.CharLocData.Scar_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head01>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="A",TorsoID="A",ShoPadID="A",ArmsID="E",ThighsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(38)=(CharID="F",CharName="Sharptooth",Description="<Strings:UTGameUI.CharLocData.Sharptooth_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head02>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="B",HelmetID="B",TorsoID="B",ShoPadID="B",bHasRightShoPad=True,ArmsID="B",ThighsID="B"),AIData=(Tactics=0.500000,StrafingAbility=0.500000,Accuracy=0.250000,Aggressiveness=0.400000,CombatStyle=-0.200000,Jumpiness=0.500000,FavoriteWeapon="UTGame.UTWeap_RocketLauncher"),bLocked=True)
   Characters(39)=(CharID="G",CharName="Worg",Description="<Strings:UTGameUI.CharLocData.Worg_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head03>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="C",TorsoID="C",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="C",ThighsID="C",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(40)=(CharID="J",CharName="Claw",Description="<Strings:UTGameUI.CharLocData.Claw_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head02>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="B",TorsoID="A",ShoPadID="B",bHasRightShoPad=True,ArmsID="D",ThighsID="E"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(41)=(CharID="K",CharName="Bargest",Description="<Strings:UTGameUI.CharLocData.Bargest_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head03>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="C",TorsoID="C",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="C",ThighsID="C"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(42)=(CharID="L",CharName="Blackfang",Description="<Strings:UTGameUI.CharLocData.BlackFang_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head04>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="A",TorsoID="A",ShoPadID="B",bHasRightShoPad=True,ArmsID="D",ThighsID="D",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(43)=(CharID="I",CharName="Hellhound",Description="<Strings:UTGameUI.CharLocData.Hellhound_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Krall_Male_Head01>",Faction="Krall",CharData=(FamilyID="KRAM",HeadID="A",TorsoID="B",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="E",ThighsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(44)=(CharID="A",CharName="Akasha",Description="<Strings:UTGameUI.CharLocData.Akasha_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Female_Head01>",Faction="Necris",CharData=(FamilyID="NECF",HeadID="A",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Tactics=1.000000,StrafingAbility=1.000000,Accuracy=1.000000,Aggressiveness=0.400000,CombatStyle=0.200000,Jumpiness=0.250000,FavoriteWeapon="UTGame.UTWeap_ShockRifle"),bLocked=True)
   Characters(45)=(CharID="B",CharName="Loque",Description="<Strings:UTGameUI.CharLocData.Loque_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Male_Head02>",Faction="Necris",CharData=(FamilyID="NECM",HeadID="B",TorsoID="B",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="B",BootsID="B"),AIData=(Tactics=1.000000,StrafingAbility=0.500000,Accuracy=1.000000,Aggressiveness=0.400000,CombatStyle=0.200000,Jumpiness=-0.250000,FavoriteWeapon="UTGame.UTWeap_SniperRifle"),bLocked=True)
   Characters(46)=(CharID="C",CharName="Damian",Description="<Strings:UTGameUI.CharLocData.Damian_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Male_Head01>",Faction="Necris",CharData=(FamilyID="NECM",HeadID="A",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(47)=(CharID="D",CharName="Kragoth",Description="<Strings:UTGameUI.CharLocData.Kragoth_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Male_Head03>",Faction="Necris",CharData=(FamilyID="NECM",HeadID="C",TorsoID="A",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="A",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(48)=(CharID="E",CharName="Malakai",Description="<Strings:UTGameUI.CharLocData.Malakai_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Male_Head04>",Faction="Necris",CharData=(FamilyID="NECM",HeadID="C",FacemaskID="A",GogglesID="A",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="B",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(49)=(CharID="H",CharName="Grail",Description="<Strings:UTGameUI.CharLocData.Grail_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Male_Head03>",Faction="Necris",CharData=(FamilyID="NECM",HeadID="C",FacemaskID="A",TorsoID="B",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="B",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(50)=(CharID="G",CharName="Judas",Description="<Strings:UTGameUI.CharLocData.Judas_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Male_Head01>",Faction="Necris",CharData=(FamilyID="NECM",HeadID="A",TorsoID="B",ShoPadID="A",ArmsID="C",ThighsID="B",BootsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(51)=(CharID="F",CharName="Nocturne",Description="<Strings:UTGameUI.CharLocData.Nocture_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Male_Head02>",Faction="Necris",CharData=(FamilyID="NECM",HeadID="B",HelmetID="A",TorsoID="A",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="C",ThighsID="B",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(52)=(CharID="I",CharName="Samael",Description="<Strings:UTGameUI.CharLocData.Samael_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Male_Head03>",Faction="Necris",CharData=(FamilyID="NECM",HeadID="C",HelmetID="C",TorsoID="A",ShoPadID="B",ArmsID="A",ThighsID="A",BootsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(53)=(CharID="J",CharName="Harbinger",Description="<Strings:UTGameUI.CharLocData.Harbinger_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Male_Head02>",Faction="Necris",CharData=(FamilyID="NECM",HeadID="B",HelmetID="B",TorsoID="B",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="C",ThighsID="B",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(54)=(CharID="K",CharName="Pagan",Description="<Strings:UTGameUI.CharLocData.Pagan_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Male_Head01>",Faction="Necris",CharData=(FamilyID="NECM",HeadID="A",GogglesID="A",TorsoID="A",ShoPadID="A",bHasRightShoPad=True,ArmsID="B",ThighsID="B",BootsID="C"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(55)=(CharID="L",CharName="Thannis",Description="<Strings:UTGameUI.CharLocData.Thannis_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Male_Head03>",Faction="Necris",CharData=(FamilyID="NECM",HeadID="C",HelmetID="C",TorsoID="B",ShoPadID="A",bHasLeftShoPad=True,ArmsID="B",ThighsID="B",BootsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(56)=(CharID="N",CharName="Alanna",Description="<Strings:UTGameUI.CharLocData.Alanna_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Female_Head02>",Faction="Necris",CharData=(FamilyID="NECF",HeadID="B",TorsoID="B",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="B",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(57)=(CharID="S",CharName="Arachne",Description="<Strings:UTGameUI.CharLocData.Archane_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Female_Head01>",Faction="Necris",CharData=(FamilyID="NECF",HeadID="B",HelmetID="A",TorsoID="B",ShoPadID="A",bHasLeftShoPad=True,ArmsID="A",ThighsID="A",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(58)=(CharID="O",CharName="Freylis",Description="<Strings:UTGameUI.CharLocData.Freylis_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Female_Head01>",Faction="Necris",CharData=(FamilyID="NECF",HeadID="A",FacemaskID="A",TorsoID="A",ShoPadID="A",ArmsID="B",ThighsID="B",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(59)=(CharID="P",CharName="Malise",Description="<Strings:UTGameUI.CharLocData.Malise_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Female_Head01>",Faction="Necris",CharData=(FamilyID="NECF",HeadID="B",HelmetID="B",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(60)=(CharID="R",CharName="Raven",Description="<Strings:UTGameUI.CharLocData.Raven_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Female_Head01>",Faction="Necris",CharData=(FamilyID="NECF",HeadID="B",FacemaskID="A",TorsoID="A",ShoPadID="A",ArmsID="A",ThighsID="B",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(61)=(CharID="Q",CharName="Visse",Description="<Strings:UTGameUI.CharLocData.Visse_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Necris_Female_Head01>",Faction="Necris",CharData=(FamilyID="NECF",HeadID="A",TorsoID="A",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="B",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(62)=(CharID="A",CharName="Matrix",Description="<Strings:UTGameUI.CharLocData.Matrix_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head04>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="D",FacemaskID="C",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,ArmsID="D",ThighsID="A",BootsID="D"),AIData=(Tactics=1.000000,StrafingAbility=1.000000,Accuracy=0.400000,Aggressiveness=0.400000,CombatStyle=0.200000,Jumpiness=0.250000,FavoriteWeapon="UTGame.UTWeap_Stinger"),bLocked=True)
   Characters(63)=(CharID="C",CharName="Aspect",Description="<Strings:UTGameUI.CharLocData.Aspect_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head02>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="B",TorsoID="B",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="B",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Characters(64)=(CharID="B",CharName="Cathode",Description="<Strings:UTGameUI.CharLocData.Cathode_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head01>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="A",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Characters(65)=(CharID="D",CharName="Enigma",Description="<Strings:UTGameUI.CharLocData.Enigma_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head03>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="C",TorsoID="B",ShoPadID="C",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="C",ThighsID="B",BootsID="C"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Characters(66)=(CharID="Z",CharName="Nova",Description="<Strings:UTGameUI.CharLocData.Nova_Description>",PreviewImageMarkup="<Images:UI_Portrait1.Character.UI_Portrait1_Character_Liandri_Male_Head06>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="E",TorsoID="C",ShoPadID="D",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="E",ThighsID="C",BootsID="E"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000))
   Characters(67)=(CharID="F",CharName="Collossus",Description="<Strings:UTGameUI.CharLocData.Collossus_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head02>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="B",FacemaskID="B",TorsoID="B",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="D",ThighsID="B",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(68)=(CharID="I",CharName="Entropy",Description="<Strings:UTGameUI.CharLocData.Entropy_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head01>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="A",FacemaskID="C",TorsoID="A",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="B",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.500000,CombatStyle=0.200000,FavoriteWeapon="UTGame.UTWeap_FlakCannon"),bLocked=True)
   Characters(69)=(CharID="H",CharName="Monarch",Description="<Strings:UTGameUI.CharLocData.Monarch_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head04>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="D",FacemaskID="A",TorsoID="A",ShoPadID="C",bHasLeftShoPad=True,ArmsID="A",ThighsID="A",BootsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(70)=(CharID="K",CharName="OSC",Description="<Strings:UTGameUI.CharLocData.OSC_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head03>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="C",TorsoID="A",ShoPadID="A",bHasLeftShoPad=True,ArmsID="D",ThighsID="A",BootsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(71)=(CharID="J",CharName="Evolution",Description="<Strings:UTGameUI.CharLocData.Evolution_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head02>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="B",FacemaskID="B",TorsoID="B",ShoPadID="A",ArmsID="A",ThighsID="B",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(72)=(CharID="G",CharName="Mihr",Description="<Strings:UTGameUI.CharLocData.Mihr_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head03>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="C",TorsoID="B",ShoPadID="B",ArmsID="C",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(73)=(CharID="E",CharName="Raptor",Description="<Strings:UTGameUI.CharLocData.Raptor_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head01>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="C",FacemaskID="C",TorsoID="B",ShoPadID="B",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="A"),AIData=(Aggressiveness=0.700000,CombatStyle=0.200000,FavoriteWeapon="UTGame.UTWeap_Shockrifle"),bLocked=True)
   Characters(74)=(CharID="L",CharName="Syntax",Description="<Strings:UTGameUI.CharLocData.Syntax_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head04>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="D",TorsoID="A",ShoPadID="C",bHasLeftShoPad=True,ArmsID="A",ThighsID="A",BootsID="D"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Characters(75)=(CharID="M",CharName="Torque",Description="<Strings:UTGameUI.CharLocData.Torque_Description>",PreviewImageMarkup="<Images:UI_Portrait.Character.UI_Portrait_Character_Liandri_Male_Head04>",Faction="Liandri",CharData=(FamilyID="LIAM",HeadID="D",TorsoID="A",ShoPadID="C",bHasLeftShoPad=True,bHasRightShoPad=True,ArmsID="A",ThighsID="A",BootsID="B"),AIData=(Aggressiveness=0.400000,CombatStyle=0.200000),bLocked=True)
   Factions(0)=(Faction="Ironguard",PreviewImageMarkup="<Images:UI_Portrait.Faction.UI_CH_Ironguard_Team>",FriendlyName="<Strings:UTGameUI.FactionData.IronGuard_FriendlyName>",Description="<Strings:UTGameUI.FactionData.IronGuard_Description>")
   Factions(1)=(Faction="TwinSouls",PreviewImageMarkup="<Images:UI_Portrait.Faction.UI_CH_TwinSouls_Team>",FriendlyName="<Strings:UTGameUI.FactionData.Ronin_FriendlyName>",Description="<Strings:UTGameUI.FactionData.Ronin_Description>")
   Factions(2)=(Faction="Krall",PreviewImageMarkup="<Images:UI_Portrait.Faction.UI_CH_Krall_Team>",FriendlyName="<Strings:UTGameUI.FactionData.Krall_FriendlyName>",Description="<Strings:UTGameUI.FactionData.Krall_Description>")
   Factions(3)=(Faction="Necris",PreviewImageMarkup="<Images:UI_Portrait.Faction.UI_CH_Necris_Team>",FriendlyName="<Strings:UTGameUI.FactionData.Necris_FriendlyName>",Description="<Strings:UTGameUI.FactionData.Necris_Description>")
   Factions(4)=(Faction="Liandri",PreviewImageMarkup="<Images:UI_Portrait.Faction.UI_CH_Liandri_Team>",FriendlyName="<Strings:UTGameUI.FactionData.Liandri_FriendlyName>",Description="<Strings:UTGameUI.FactionData.Liandri_Description>")
   Families(0)=Class'UTGame.UTFamilyInfo_Ironguard_Female'
   Families(1)=Class'UTGame.UTFamilyInfo_Ironguard_Male'
   Families(2)=Class'UTGame.UTFamilyInfo_Krall_Male'
   Families(3)=Class'UTGame.UTFamilyInfo_Liandri_Male'
   Families(4)=Class'UTGame.UTFamilyInfo_Necris_Female'
   Families(5)=Class'UTGame.UTFamilyInfo_Necris_Male'
   Families(6)=Class'UTGame.UTFamilyInfo_TwinSouls_Female'
   Families(7)=Class'UTGame.UTFamilyInfo_TwinSouls_Male'
   HeadRegions(0)=(SizeX=2048,SizeY=1024)
   HeadRegions(1)=(OffsetY=1024,SizeX=512,SizeY=512)
   HeadRegions(2)=(OffsetX=256,OffsetY=1024,SizeX=256,SizeY=256)
   HeadRegions(3)=(OffsetY=1280,SizeX=256,SizeY=256)
   HeadRegions(4)=(OffsetX=1024,OffsetY=1024,SizeX=1024,SizeY=1024)
   HeadRegions(5)=(OffsetX=512,OffsetY=1024,SizeX=512,SizeY=512)
   HeadRegions(6)=(OffsetY=1536,SizeX=512,SizeY=256)
   HeadRegions(7)=(OffsetX=512,OffsetY=1536,SizeX=512,SizeY=512)
   HeadRegions(8)=(OffsetY=1792,SizeX=512,SizeY=256)
   BodyRegions(0)=(SizeX=1152,SizeY=1024)
   BodyRegions(1)=(OffsetY=1024,SizeX=1152,SizeY=1024)
   BodyRegions(2)=(OffsetX=1152,SizeX=896,SizeY=384)
   BodyRegions(3)=(OffsetX=1152,OffsetY=384,SizeX=896,SizeY=896)
   BodyRegions(4)=(OffsetX=1152,OffsetY=1280,SizeX=896,SizeY=768)
   HeadMaxTexSize(0)=512
   HeadMaxTexSize(1)=512
   HeadMaxTexSize(2)=256
   HeadMaxTexSize(3)=256
   HeadMaxTexSize(4)=256
   BodyMaxTexSize(0)=1024
   BodyMaxTexSize(1)=1024
   BodyMaxTexSize(2)=256
   BodyMaxTexSize(3)=256
   BodyMaxTexSize(4)=512
   SelfHeadMaxTexSize(0)=512
   SelfHeadMaxTexSize(1)=512
   SelfHeadMaxTexSize(2)=256
   SelfHeadMaxTexSize(3)=256
   SelfHeadMaxTexSize(4)=256
   SelfBodyMaxTexSize(0)=1024
   SelfBodyMaxTexSize(1)=1024
   SelfBodyMaxTexSize(2)=256
   SelfBodyMaxTexSize(3)=256
   SelfBodyMaxTexSize(4)=512
   LOD1DisplayFactor=0.400000
   LOD2DisplayFactor=0.200000
   LOD3DisplayFactor=0.075000
   CustomCharTextureStreamTimeout=10.000000
   UnlockableChars(0)="Lauren"
   UnlockableChars(1)="Ariel"
   UnlockableChars(2)="Scythe"
   UnlockableChars(3)="Akasha"
   UnlockableChars(4)="Alanna"
   UnlockableChars(5)="Loque"
   UnlockableChars(6)="Damian"
   UnlockableChars(7)="Kragoth"
   UnlockableChars(8)="Malakai"
   UnlockableChars(9)="Matrix"
   DefaultArmMeshPackageName="CH_IronGuard_Arms"
   DefaultArmMeshName="CH_IronGuard_Arms.Mesh.SK_CH_IronGuard_Arms_MaleB_1P"
   DefaultArmSkinPackageName="CH_IronGuard_Arms"
   DefaultRedArmSkinName="CH_IronGuard_Arms.Materials.M_CH_IronG_Arms_FirstPersonArm_VRed"
   DefaultBlueArmSkinName="CH_IronGuard_Arms.Materials.M_CH_IronG_Arms_FirstPersonArm_VBlue"
   PortraitSetup=(CenterOnBone="b_Head",MeshOffset=(X=50.000000,Y=0.000000,Z=-2.000000),MeshRot=(Pitch=0,Yaw=-36408,Roll=0),CamFOV=20.000000,DirLightRot=(Pitch=57344,Yaw=9102,Roll=0),DirLightBrightness=2.000000,DirLightColor=(B=255,G=255,R=255,A=0),DirLight2Rot=(Pitch=57344,Yaw=40049,Roll=0),DirLight2Brightness=20.000000,DirLight2Color=(B=240,G=180,R=150,A=0),DirLight3Rot=(Pitch=57344,Yaw=57344,Roll=0),DirLight3Brightness=1.000000,DirLight3Color=(B=255,G=230,R=255,A=0),SkyBrightness=0.400000,SkyColor=(B=255,G=222,R=200,A=0),SkyLowerBrightness=0.200000,SkyLowerColor=(B=200,G=230,R=255,A=0),PortraitBackgroundTranslation=(X=3000.000000,Y=0.000000,Z=0.000000),TextureSize=256)
   PortraitBackgroundMesh=StaticMesh'UI_CharPortraits.Mesh.S_UI_CharPortraits_Cube'
   NecrisMalePipeTextures(0)="CH_Necris_Male1.Materials.T_CH_Necris_MHead01_D01_V01_SK2"
   NecrisMalePipeTextures(1)="CH_Necris_Male1.Materials.T_CH_Necris_MHead01_N01_V01_SK2"
   NecrisMalePipeTextures(2)="CH_Necris_Male1.Materials.T_CH_Necris_MHead01_S01_V01_SK2"
   NecrisMalePipeTextures(3)="CH_Necris_Male1.Materials.T_CH_Necris_MHead01_SP01_V01_SK2"
   NecrisMalePipeTextures(4)="CH_Necris_Male1.Materials.T_CH_Necris_MHead01_E01_V01_SK2"
   NecrisFemalePipeTextures(0)="CH_Necris_Female.Materials.T_CH_Necris_FHead01_D01_V01_SK1"
   NecrisFemalePipeTextures(1)="CH_Necris_Female.Materials.T_CH_Necris_FHead01_N01_V01_SK1"
   NecrisFemalePipeTextures(2)="CH_Necris_Female.Materials.T_CH_Necris_FHead01_S01_V01_SK1"
   NecrisFemalePipeTextures(3)="CH_Necris_Female.Materials.T_CH_Necris_FHead01_SP01_V01_SK1"
   NecrisFemalePipeTextures(4)="CH_Necris_Female.Materials.T_CH_Necris_FHead01_E01_V01_SK1"
   Name="Default__UTCustomChar_Data"
   ObjectArchetype=Object'Core.Default__Object'
}
