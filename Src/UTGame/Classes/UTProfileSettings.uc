/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * List of profile settings for UT
 */
class UTProfileSettings extends OnlineProfileSettings
	native
	config(game)
	dependson(UTTypes);

// Generic Yes/No Enum
enum EGenericYesNo
{
	UTPID_VALUE_NO,
	UTPID_VALUE_YES
};

// Gore Level Enum
enum EGoreLevel
{
	GORE_NORMAL,
	GORE_LOW
};

// Announcer Setting Enum
enum EAnnouncerSetting
{
	ANNOUNCE_OFF,
	ANNOUNCE_MINIMAL,
	ANNOUNCE_FULL
};

// Network Type Enum
enum ENetworkType
{
	NETWORKTYPE_Unknown,
	NETWORKTYPE_Modem,
	NETWORKTYPE_ISDN,
	NETWORKTYPE_Cable,
	NETWORKTYPE_LAN
};

/** Post Processing Preset */
enum EPostProcessPreset
{
	PPP_Default,
	PPP_Muted,
	PPP_Vivid,
	PPP_Intense
};

/** Vehicle controls. */
enum EUTVehicleControls
{
	UTVC_Simple,
	UTVC_Normal,
	UTVC_Advanced
};

/** Text to speech mode. */
enum EUTTextToSpeechMode
{
	TTSM_None,
	TTSM_TeamOnly,
	TTSM_All
};

// Possible Digital Button Actions - This order matters, data is saved in the order of this array.
enum EDigitalButtonActions
{
	DBA_None,
	DBA_Fire,
	DBA_AltFire,
	DBA_Jump,
	DBA_Use,
	DBA_ToggleMelee,
	DBA_ShowScores,
	DBA_ShowMap,
	DBA_FeignDeath,
	DBA_ToggleSpeaking,
	DBA_ToggleMinimap,
	DBA_WeaponPicker,
	DBA_NextWeapon,
	DBA_BestWeapon,
	DBA_PrevWeapon,

	// The following actions aren't exposed on consoles and are used for PC keybinding.
	DBA_Duck,
	DBA_MoveForward,
	DBA_MoveBackward,
	DBA_StrafeLeft,
	DBA_StrafeRight,
	DBA_TurnLeft,
	DBA_TurnRight,
	DBA_SwitchWeapon1,
	DBA_SwitchWeapon2,
	DBA_SwitchWeapon3,
	DBA_SwitchWeapon4,
	DBA_SwitchWeapon5,
	DBA_SwitchWeapon6,
	DBA_SwitchWeapon7,
	DBA_SwitchWeapon8,
	DBA_SwitchWeapon9,
	DBA_SwitchWeapon10,
	DBA_ShrinkHUD,
	DBA_GrowHUD,
	DBA_Taunt,
	DBA_Taunt2,
	DBA_Talk,
	DBA_TeamTalk,
	DBA_ShowCommandMenu,
	DBA_ShowMenu,
	DBA_ToggleTranslocator,
	DBA_JumpPC,
	DBA_BestWeaponPC,
	DBA_Horn,

	DBA_TriggerHero,
};

/** Mapping of action enum to actually exec commands. */
var array<string> DigitalButtonActionsToCommandMapping;

// Possible Analog Stick Configurations
enum EAnalogStickActions
{
	ESA_Normal,
	ESA_SouthPaw,
	ESA_Legacy,
	ESA_LegacySouthPaw
};

/** Poassible crosshair types.*/
enum ECrosshairType
{
	CHT_Normal,
	CHT_Simple,
	CHT_None
};

/** Enum of bindable keys */
enum EUTBindableKeys
{
	UTBND_Unbound,	// Must be 0!
	UTBND_MouseX,
	UTBND_MouseY,
	UTBND_MouseScrollUp,
	UTBND_MouseScrollDown,
	UTBND_LeftMouseButton,
	UTBND_RightMouseButton,
	UTBND_MiddleMouseButton,
	UTBND_ThumbMouseButton,
	UTBND_ThumbMouseButton2,
	UTBND_BackSpace,
	UTBND_Tab,
	UTBND_Enter,
	UTBND_Pause,
	UTBND_CapsLock,
	UTBND_Escape,
	UTBND_SpaceBar,
	UTBND_PageUp,
	UTBND_PageDown,
	UTBND_End,
	UTBND_Home,
	UTBND_Left,
	UTBND_Up,
	UTBND_Right,
	UTBND_Down,
	UTBND_Insert,
	UTBND_Delete,
	UTBND_Zero,
	UTBND_One,
	UTBND_Two,
	UTBND_Three,
	UTBND_Four,
	UTBND_Five,
	UTBND_Six,
	UTBND_Seven,
	UTBND_Eight,
	UTBND_Nine,
	UTBND_A,
	UTBND_B,
	UTBND_C,
	UTBND_D,
	UTBND_E,
	UTBND_F,
	UTBND_G,
	UTBND_H,
	UTBND_I,
	UTBND_J,
	UTBND_K,
	UTBND_L,
	UTBND_M,
	UTBND_N,
	UTBND_O,
	UTBND_P,
	UTBND_Q,
	UTBND_R,
	UTBND_S,
	UTBND_T,
	UTBND_U,
	UTBND_V,
	UTBND_W,
	UTBND_X,
	UTBND_Y,
	UTBND_Z,
	UTBND_NumPadZero,
	UTBND_NumPadOne,
	UTBND_NumPadTwo,
	UTBND_NumPadThree,
	UTBND_NumPadFour,
	UTBND_NumPadFive,
	UTBND_NumPadSix,
	UTBND_NumPadSeven,
	UTBND_NumPadEight,
	UTBND_NumPadNine,
	UTBND_Multiply,
	UTBND_Add,
	UTBND_Subtract,
	UTBND_Decimal,
	UTBND_Divide,
	UTBND_F1,
	UTBND_F2,
	UTBND_F3,
	UTBND_F4,
	UTBND_F5,
	UTBND_F6,
	UTBND_F7,
	UTBND_F8,
	UTBND_F9,
	UTBND_F10,
	UTBND_F11,
	UTBND_F12,
	UTBND_NumLock,
	UTBND_ScrollLock,
	UTBND_LeftShift,
	UTBND_RightShift,
	UTBND_LeftControl,
	UTBND_RightControl,
	UTBND_LeftAlt,
	UTBND_RightAlt,
	UTBND_Semicolon,
	UTBND_Equals,
	UTBND_Comma,
	UTBND_Underscore,
	UTBND_Period,
	UTBND_Slash,
	UTBND_Tilde,
	UTBND_LeftBracket,
	UTBND_Backslash,
	UTBND_RightBracket,
	UTBND_Quote,

	// Gamepad keys
	UTBND_LeftStickX,
	UTBND_LeftStickY,
	UTBND_LeftStick_Click,
	UTBND_RightStick_X,
	UTBND_RightStick_Y,
	UTBND_RightStick_Click,
	UTBND_ButtonA,			// accept button
	UTBND_ButtonB,			// cancel button
	UTBND_ButtonX,			// option button 1
	UTBND_ButtonY,			// option button 2
	UTBND_LeftShoulder,
	UTBND_RightShoulder,
	UTBND_LeftTrigger,
	UTBND_RightTrigger,
	UTBND_Start,
	UTBND_Select,
	UTBND_DPad_Up,
	UTBND_DPad_Down,
	UTBND_DPad_Left,
	UTBND_DPad_Right,

	UTBND_SpecialX,
	UTBND_SpecialY,
	UTBND_SpecialZ,
	UTBND_SpecialW
};
var transient array<name>	KeyMappingArray;	/** Mapping of enums to keynames. */

// Profile settings ids definitions
const UTPID_CustomCharString = 301;
const UTPID_UnlockedCharacters = 302;

// Audio
const UTPID_SFXVolume = 360;
const UTPID_MusicVolume = 361;
const UTPID_VoiceVolume = 362;
const UTPID_AnnouncerVolume = 363;
const UTPID_AnnounceSetting = 364;
const UTPID_AutoTaunt = 365;
const UTPID_MessageBeep = 366;
const UTPID_TextToSpeechMode = 367;
const UTPID_AmbianceVolume = 368;

// Video
const UTPID_Gamma = 380;
const UTPID_PostProcessPreset = 381;
const UTPID_ScreenResolutionX = 382;
const UTPID_ScreenResolutionY = 383;
const UTPID_DefaultFOV = 384;
const UTPID_Subtitles = 385;

// Game
const UTPID_ViewBob = 400;
const UTPID_GoreLevel = 401;
const UTPID_DodgingEnabled = 402;
const UTPID_WeaponSwitchOnPickup = 403;


// Network
const UTPID_Alias = 404;
const UTPID_ClanTag = 405;
const UTPID_NetworkConnection = 406;
const UTPID_DynamicNetspeed = 407;
const UTPID_SpeechRecognition = 408;
const UTPID_ServerDescription = 409;
const UTPID_AllowCustomCharacters = 410;
const UTPID_FirstTimeMultiplayer = 411;
const UTPID_AlwaysLoadCustomCharacters = 412;

// Input
const UTPID_MouseSmoothing = 420;
const UTPID_ReduceMouseLag = 421;
const UTPID_EnableJoystick = 422;
const UTPID_MouseSensitivityGame = 423;
const UTPID_MouseSensitivityMenus = 424;
const UTPID_MouseSmoothingStrength = 425;
const UTPID_MouseAccelTreshold = 426;
const UTPID_DodgeDoubleClickTime = 427;
const UTPID_TurningAccelerationFactor = 428;

const UTPID_GamepadBinding_ButtonA = 429;
const UTPID_GamepadBinding_ButtonB = 430;
const UTPID_GamepadBinding_ButtonX = 431;
const UTPID_GamepadBinding_ButtonY = 432;
const UTPID_GamepadBinding_Back = 433;
const UTPID_GamepadBinding_RightBumper = 434;
const UTPID_GamepadBinding_LeftBumper = 435;
const UTPID_GamepadBinding_RightTrigger = 436;
const UTPID_GamepadBinding_LeftTrigger = 437;
const UTPID_GamepadBinding_RightThumbstickPressed = 438;
const UTPID_GamepadBinding_LeftThumbstickPressed = 439;
const UTPID_GamepadBinding_DPadUp = 440;
const UTPID_GamepadBinding_DPadDown = 441;
const UTPID_GamepadBinding_DPadLeft = 442;
const UTPID_GamepadBinding_DPadRight = 443;

const UTPID_GamepadBinding_AnalogStickPreset = 444;

const UTPID_ControllerSensitivityMultiplier = 450;
const UTPID_AutoCenterPitch = 451;
const UTPID_AutoCenterVehiclePitch = 452;
const UTPID_TiltSensing = 453;
const UTPID_VehicleControls = 454;
const UTPID_EnableHardwarePhysics = 455;

// Weapons
const UTPID_WeaponHand = 460;
const UTPID_SmallWeapons = 461;
const UTPID_DisplayWeaponBar = 462;
const UTPID_ShowOnlyAvailableWeapons = 463;

const UTPID_RocketLauncherPriority = 464;
const UTPID_BioRiflePriority = 465;
const UTPID_FlakCannonPriority = 466;
const UTPID_SniperRiflePriority = 467;
const UTPID_LinkGunPriority = 468;
const UTPID_EnforcerPriority = 469;
const UTPID_ShockRiflePriority = 470;
const UTPID_StingerPriority = 471;
const UTPID_AVRILPriority = 472;
const UTPID_RedeemerPriority = 473;

const UTPID_CrosshairType = 474;

// HUD
const UTPID_ShowMap = 480;
const UTPID_ShowClock = 481;
const UTPID_ShowDoll = 482;
const UTPID_ShowAmmo = 483;
const UTPID_ShowPowerups = 484;
const UTPID_ShowScoring = 485;
const UTPID_ShowLeaderboard = 486;
const UTPID_RotateMap = 487;
const UTPID_ShowVehicleArmorCount = 488;

// PC Keybindings
const UTPID_KeyAction_1 = 	501;
const UTPID_KeyAction_2 = 	502;
const UTPID_KeyAction_3 = 	503;
const UTPID_KeyAction_4 = 	504;
const UTPID_KeyAction_5 = 	505;
const UTPID_KeyAction_6 = 	506;
const UTPID_KeyAction_7 = 	507;
const UTPID_KeyAction_8 = 	508;
const UTPID_KeyAction_9 = 	509;
const UTPID_KeyAction_10 = 	510;
const UTPID_KeyAction_11 = 	511;
const UTPID_KeyAction_12 = 	512;
const UTPID_KeyAction_13 = 	513;
const UTPID_KeyAction_14 = 	514;
const UTPID_KeyAction_15 = 	515;
const UTPID_KeyAction_16 = 	516;
const UTPID_KeyAction_17 = 	517;
const UTPID_KeyAction_18 = 	518;
const UTPID_KeyAction_19 = 	519;
const UTPID_KeyAction_20 = 	520;
const UTPID_KeyAction_21 = 	521;
const UTPID_KeyAction_22 = 	522;
const UTPID_KeyAction_23 = 	523;
const UTPID_KeyAction_24 = 	524;
const UTPID_KeyAction_25 = 	525;
const UTPID_KeyAction_26 = 	526;
const UTPID_KeyAction_27 = 	527;
const UTPID_KeyAction_28 = 	528;
const UTPID_KeyAction_29 = 	529;
const UTPID_KeyAction_30 = 	530;
const UTPID_KeyAction_31 = 	531;
const UTPID_KeyAction_32 = 	532;
const UTPID_KeyAction_33 = 	533;
const UTPID_KeyAction_34 = 	534;
const UTPID_KeyAction_35 = 	535;
const UTPID_KeyAction_36 = 	536;
const UTPID_KeyAction_37 = 	537;
const UTPID_KeyAction_38 = 	538;
const UTPID_KeyAction_39 = 	539;
const UTPID_KeyAction_40 = 	540;
const UTPID_KeyAction_41 = 	541;
const UTPID_KeyAction_42 = 	542;
const UTPID_KeyAction_43 = 	543;
const UTPID_KeyAction_44 = 	544;
const UTPID_KeyAction_45 = 	545;
const UTPID_KeyAction_46 = 	546;
const UTPID_KeyAction_47 = 	547;
const UTPID_KeyAction_48 = 	548;
const UTPID_KeyAction_49 = 	549;



//UT Achievements
enum EUTUnlockType
{
	EUnlockType_Count,
	EUnlockType_Bitmask,
	EUnlockType_ByteCount
};

//Onslaught/Warfare
const UTPID_PopupMapOnDeath=700;


struct native AchievementData
{
	//What achievement is this
	var EUTGameAchievements Id;

	//How this unlock criteria is interpreted
	var EUTUnlockType UnlockType;

	//How many times must we do this to 'unlock' or a bitmask of unlock condition
	var int UnlockCriteria;
};

var array<AchievementData> AchievementsArray;

const UTAID_Achievement_Start = 800;
const UTAID_ACHIEVEMENT_CAMPAIGN_Chapter1 = 801;
const UTAID_ACHIEVEMENT_CAMPAIGN_SignTreaty = 802;
const UTAID_ACHIEVEMENT_CAMPAIGN_LiandriMainframe = 803;
const UTAID_ACHIEVEMENT_CAMPAIGN_ReachOmicron = 804;
const UTAID_ACHIEVEMENT_CAMPAIGN_DefeatAkasha = 805;
const UTAID_ACHIEVEMENT_CAMPAIGN_SignTreatyExpert = 806;
const UTAID_ACHIEVEMENT_CAMPAIGN_LiandriMainframeExpert = 807;
const UTAID_ACHIEVEMENT_CAMPAIGN_ReachOmicronExpert = 808;
const UTAID_ACHIEVEMENT_CAMPAIGN_DefeatAkashaExpert = 809;
const UTAID_ACHIEVEMENT_COOP_Complete1 = 810;
const UTAID_ACHIEVEMENT_COOP_Complete10 = 811;
const UTAID_ACHIEVEMENT_COOP_CompleteCampaign = 812;
const UTAID_ACHIEVEMENT_IA_EveryGameMode = 813;
const UTAID_ACHIEVEMENT_IA_Untouchable = 814;
const UTAID_ACHIEVEMENT_EXPLORE_AllPowerups = 815;
const UTAID_ACHIEVEMENT_EXPLORE_EveryMutator = 816;
const UTAID_ACHIEVEMENT_WEAPON_BrainSurgeon = 817;
const UTAID_ACHIEVEMENT_WEAPON_DontTaseMeBro = 818;
const UTAID_ACHIEVEMENT_WEAPON_GooGod = 819;
const UTAID_ACHIEVEMENT_WEAPON_Pistolero = 820;
const UTAID_ACHIEVEMENT_WEAPON_ShardOMatic = 821;
const UTAID_ACHIEVEMENT_WEAPON_Hammerhead = 822;
const UTAID_ACHIEVEMENT_WEAPON_StrongestLink = 823;
const UTAID_ACHIEVEMENT_WEAPON_HaveANiceDay = 824;
const UTAID_ACHIEVEMENT_WEAPON_BigGameHunter = 825;
const UTAID_ACHIEVEMENT_VEHICLE_Armadillo = 826;
const UTAID_ACHIEVEMENT_VEHICLE_JackOfAllTrades = 827;
const UTAID_ACHIEVEMENT_VEHICLE_Ace = 828;
const UTAID_ACHIEVEMENT_VEHICLE_Deathwish = 829;
const UTAID_ACHIEVEMENT_POWERUP_SeeingRed = 830;
const UTAID_ACHIEVEMENT_POWERUP_NeverSawItComing = 831;
const UTAID_ACHIEVEMENT_POWERUP_SurvivalFittest = 832;
const UTAID_ACHIEVEMENT_POWERUP_DeliveringTheHurt = 833;
const UTAID_ACHIEVEMENT_GAME_HatTrick = 834;
const UTAID_ACHIEVEMENT_GAME_BeingAHero = 835;
const UTAID_ACHIEVEMENT_GAME_FlagWaver = 836;
const UTAID_ACHIEVEMENT_GAME_30MinOrLess = 837;
const UTAID_ACHIEVEMENT_GAME_PaintTownRed = 838;
const UTAID_ACHIEVEMENT_GAME_ConnectTheDots = 839;
const UTAID_ACHIEVEMENT_HUMILIATION_SerialKiller = 840;
const UTAID_ACHIEVEMENT_HUMILIATION_SirSlaysALot = 841;
const UTAID_ACHIEVEMENT_HUMILIATION_KillJoy = 842;
const UTAID_ACHIEVEMENT_HUMILIATION_OffToAGoodStart = 843;
const UTAID_ACHIEVEMENT_VERSUS_GetItOn = 844;
const UTAID_ACHIEVEMENT_VERSUS_AroundTheWorld = 845;
const UTAID_ACHIEVEMENT_VERSUS_GetALife = 846;
const UTAID_ACHIEVEMENT_RANKED_BloodSweatTears = 847;
const UTAID_ACHIEVEMENT_UT3GOLD_CantBeTrusted = 848;
const UTAID_ACHIEVEMENT_UT3GOLD_Avenger = 849;
const UTAID_ACHIEVEMENT_UT3GOLD_BagOfBones = 850;
const UTAID_ACHIEVEMENT_UT3GOLD_SkullCollector = 851;
const UTAID_ACHIEVEMENT_UT3GOLD_Titanic = 852;
const UTAID_ACHIEVEMENT_UT3GOLD_Behemoth = 853;
const UTAID_ACHIEVEMENT_UT3GOLD_Unholy = 854;
const UTAID_ACHIEVEMENT_UT3GOLD_TheSlowLane = 855;
const UTAID_ACHIEVEMENT_UT3GOLD_Eradication = 856;
const UTAID_ACHIEVEMENT_UT3GOLD_Arachnophobia = 857;
const UTAID_Achievement_End = 861;


// ===================================================================
// Single Player Keys
// ===================================================================

/**
 * PersistentKeys are meant to be tied to in-game events and persist across
 * different missions.  The mission manager can use these keys to determine next
 * course of action and kismet can query for a key and act accordingly (TBD).
 * Current we have room for 20 persistent keys.
 *
 * To Add a persistent key, extend the enum below.
 */

enum ESinglePlayerPersistentKeys
{
	ESPKey_None,
	ESPKey_DarkWalkerUnlock,
	ESPKey_CanStealNecris,
	ESPKey_IronGuardUpgrade,
	ESPKey_LiandriUpgrade,
	ESPKey_MAX
};

const PSI_PersistentKeySlot0	= 200;
const PSI_PersistentKeySlot1	= 201;
const PSI_PersistentKeySlot2	= 202;
const PSI_PersistentKeySlot3	= 203;
const PSI_PersistentKeySlot4	= 204;
const PSI_PersistentKeySlot5	= 205;
const PSI_PersistentKeySlot6	= 206;
const PSI_PersistentKeySlot7	= 207;
const PSI_PersistentKeySlot8	= 208;
const PSI_PersistentKeySlot9	= 209;
const PSI_PersistentKeySlot10	= 210;
const PSI_PersistentKeySlot11	= 211;
const PSI_PersistentKeySlot12	= 212;
const PSI_PersistentKeySlot13	= 213;
const PSI_PersistentKeySlot14	= 214;
const PSI_PersistentKeySlot15	= 215;
const PSI_PersistentKeySlot16	= 216;
const PSI_PersistentKeySlot17	= 217;
const PSI_PersistentKeySlot18	= 218;
const PSI_PersistentKeySlot19	= 219;

const PSI_PersistentKeyMAX		= 220;	// When adding a persistent key slot, make sure you update the max
										// otherwise the new slot won't be processed

enum ESinglePlayerSkillLevels
{
	ESPSKILL_SkillLevel0,
	ESPSKILL_SkillLevel1,
	ESPSKILL_SkillLevel2,
	ESPSKILL_SkillLevel3,
	ESPSKILL_SkillLevelMAX
};

const PSI_SinglePlayerMapMaskA = 245;
const PSI_SinglePlayerMapMaskB = 246;

const PSI_SinglePlayerSkillLevel = 250;
const PSI_SinglePlayerCurrentMission=251;
const PSI_SinglePlayerCurrentMissionResult=252;

const PSI_ModifierCardDeck0	 = 270;
const PSI_ModifierCardDeck1  = 271;
const PSI_ModifierCardDeck2  = 272;
const PSI_ModifierCardDeck3  = 273;
const PSI_ModifierCardDeck4  = 274;
const PSI_ModifierCardDeck5  = 275;
const PSI_ModifierCardDeck6  = 276;
const PSI_ModifierCardDeck7  = 277;
const PSI_ModifierCardDeck8  = 278;
const PSI_ModifierCardDeck9  = 279;
const PSI_ModifierCardDeck10 = 280;
const PSI_ModifierCardDeck11 = 281;
const PSI_ModifierCardDeck12 = 282;
const PSI_ModifierCardDeck13 = 283;
const PSI_ModifierCardDeck14 = 284;
const PSI_ModifierCardDeck15 = 285;
const PSI_ModifierCardDeck16 = 286;
const PSI_ModifierCardDeck17 = 287;
const PSI_ModifierCardDeck18 = 288;
const PSI_ModifierCardDeck19 = 289;
const PSI_ModifierCardEnd	 = 290;

/** Holds which chapters have been unlocked */
const PSI_ChapterMask = 299;

var array<name> CampaignBoneNames;


/**
 * Checks to see if a bone has already been visited (ie: you have completed this mission
 *
 * @Param 	MaskA	The First part of the mask
 * @Param 	MaskA	The Second part of the mask
 */
function GetBoneMask(out int MaskA, out int MaskB)
{
	local int a,b;

	GetProfileSettingValueInt(PSI_SinglePlayerMapMaskA,A);
	GetProfileSettingValueInt(PSI_SinglePlayerMapMaskB,B);

	MaskA = A;
	MaskB = B;
}

/**
 * Flags a bone as having been visited
 *
 * @Param	BoneNAme		The Bone to flag
 */

function BoneHasBeenVisited(name BoneName)
{
	local int BoneIndex;
	local int SavedMask, BoneMask;
	local int SettingIndex;

	if (BoneName != '')
	{
		BoneIndex = CampaignBoneNames.Find(BoneName);

		if ( BoneIndex != INDEX_None )
		{
			SettingIndex = (BoneIndex > 31) ? PSI_SinglePlayerMapMaskB : PSI_SinglePlayerMapMaskA;

			GetProfileSettingValueInt(SettingIndex,SavedMask);
			BoneMask = (BoneIndex > 31) ? (1 << BoneIndex-32) : (1 << BoneIndex);

			SavedMask = SavedMask | BoneMask;
			SetProfileSettingValueInt(SettingIndex,SavedMask);
		}
	}
}

/**
 * Get's a list of bones that have been visited
 *
 * Param	MaskA			The first part of the bone mask
 * Param 	MaskB			The Second part of the bone mask
 * Param	OUT BoneList	returns the list of bones
 *
 */
static function GetListOfVisitedBones(int MaskA, int MaskB, out array<name> BoneList)
{
	local int i,j,cnt;
	local int SavedMask;
	local int BoneMask;

	for (j=0;j<2;j++)
	{
		SavedMask = (j>0) ? MaskB : MaskA;;
		for (i=0;i<32;i++)
		{
			BoneMask = 1 << i;
			if ( (SavedMask & BoneMask) > 0 )
			{
				Cnt++;
				BoneList.Length = Cnt;
				BoneList[Cnt-1] = Default.CampaignBoneNames[ (j * 32 + i) ];
			}
		}
	}
}

// ===================================================================
// Single Player Keys Accessors
// ===================================================================

/**
 * Check to see if a Persistent Key has been set.
 *
 * @Param	SearchKey		The Persistent Key to look for
 * @Param	PSI_Index		<Optional Out> returns the PSI Index for the slot holding the key
 *
 * @Returns true if the key exists, false if it doesn't
 */
function bool HasPersistentKey(ESinglePlayerPersistentKeys SearchKey, optional out int PSI_Index)
{
	local int Value;

	if (SearchKey != ESPKey_None)
	{
		for (PSI_Index = PSI_PersistentKeySlot0; PSI_Index < PSI_PersistentKeyMAX; PSI_Index++)
		{
			GetProfileSettingValueInt( PSI_Index, Value );
			if ( Value == SearchKey )
			{
				return true;
			}
		}
	}
	return false;
}

/**
 * Add a PersistentKey
 *
 * @Param	AddKey		The Persistent Key to add
 * @Returns true if successful.
 *
 */
function bool AddPersistentKey(ESinglePlayerPersistentKeys AddKey)
{
	local int PSI_Index, Value;

	// Make sure the key does not exist first

	if ( HasPersistentKey(AddKey) )
	{
//		`log("[SinglePlayer] Persistent Key"@AddKey@"already exists.");
		return false;
	}

	// Find the first available slot

	for (PSI_Index = PSI_PersistentKeySlot0; PSI_Index < PSI_PersistentKeyMAX; PSI_Index++)
	{
		GetProfileSettingValueInt( PSI_Index, Value );
		if ( Value == ESPKey_None )
		{
//			`log("[SinglePlayer] Adding Persistent Key"@AddKey);
			SetProfileSettingValueInt( PSI_Index, AddKey );
			return true;
		}
	}

//	`log("[SinglePlayer] Persistent Key Slots Filled");
	return false;
}


/**
 * Remove a PersistentKey
 *
 * @Param	RemoveKey		The Persistent Key to remove
 * @returns true if successful
 */
function bool RemovePersistentKey(ESinglePlayerPersistentKeys RemoveKey)
{
	local iNT PSI_Index;


	if ( HasPersistentKey(RemoveKey, PSI_Index) )
	{
//		`log("[SinglePlayer] Removing Persistent Key"@RemoveKey);
		SetProfileSettingValueInt( PSI_Index, ESPKey_None );
		return true;
	}

	return false;
}


/**
 * @Returns true if the player has any of these cards
 */
function bool HasModifierCard(name Card)
{
	local int TargetID,i,CardId;

	TargetID = class'UTGameModifierCard'.static.GetProfileIndexFor(Card);
	if ( TargetID != INDEX_None )
	{
		for (i = PSI_ModifierCardDeck0; i < PSI_ModifierCardEnd; i++)
		{
			GetProfileSettingValueInt( i, CardID);
			if (CardID == TargetID)
			{
				return true;
			}
		}
	}

	return false;
}

function int GetChapterMask()
{
	local int Value;
	GetProfileSettingValueInt( PSI_ChapterMask, value);
	return Value;
}

function SetChapterMask(int NewMask)
{
	SetProfileSettingValueInt( PSI_ChapterMask, NewMask );
}

function bool AreAnyChaptersUnlocked()
{
	local int Value;
	GetProfileSettingValueInt( PSI_ChapterMask, Value);
	return Value != 0;
}



function bool IsChapterUnlocked(int ChapterIndex)
{
	local int Mask,Value;

	Mask = 1 << ChapterIndex;
	GetProfileSettingValueInt( PSI_ChapterMask, Value );

	return ( (Value & Mask) != 0);
}

function UnlockChapter(int ChapterIndex)
{
	local int Mask,Value;

//	`log("[SinglePlayer] Unlocking Chapter"@ChapterIndex);

	Mask = 1 << (ChapterIndex-1);
	GetProfileSettingValueInt( PSI_ChapterMask, Value );
	Value = Value | Mask;


	SetProfileSettingValueInt( PSI_ChapterMAsk, Value );
}



/**
 * Add Modifier Card
 *
 * @Param	Card 	The Modifier Card to Add
 *
 */
function AddModifierCard(name Card)
{
	local int TargetID,i,CardId;
	local bool bUnique;
	local string work;

	LogInternal("Profile AddModifierCard"@Card);
	TargetID = class'UTGameModifierCard'.static.GetProfileIndexFor(Card);
	bUnique = class'UTGameModifierCard'.static.IsUnique(Card);

	if ( TargetID != INDEX_None )
	{
		// See if the card exists.  if we are unique, then exit

		for (i = PSI_ModifierCardDeck0; i < PSI_ModifierCardEnd; i++)
		{
			GetProfileSettingValueInt( i, CardID);
			if (CardID == TargetID && bUnique )
			{
				LogInternal("[SinglePlayer] The Modifier card"@CardID@" is unique and you already have it");
				return;
			}
		}

		// Add the card to the first unused slot

		for (i = PSI_ModifierCardDeck0; i < PSI_ModifierCardEnd; i++)
		{
			GetProfileSettingValueInt( i, CardID);
			if (CardID == INDEX_None)
			{
				LogInternal("[SinglePlayer] Adding Modifier card"@CardID);
				SetProfileSettingValueInt(i, TargetID);
				Work = "CardTitle"$Card;
				Work = Localize("CardDesc",Work,"UTGameUI");
				class'UTUIScene'.static.ShowOnlineToast(Work,,5);
				return;
			}
		}

		LogInternal("[SinglePlayer] Attempted to add Modifier card"@CardID@"failed!");

	}
	else
	{
		LogInternal("[SinglePlayer] Attempted to add Modifier card"@CardID@"failed because TargetID = NONE!");
	}

}

/**
 * Use Modifier Card
 *
 * @Param	Card 	The Modifier Card use
 */
function UseModifierCard(name Card)
{
	local int TargetID,i,CardId;

	TargetID = class'UTGameModifierCard'.static.GetProfileIndexFor(Card);
	if ( TargetID != INDEX_None )
	{
		// Find the Card

		for (i = PSI_ModifierCardDeck0; i < PSI_ModifierCardEnd; i++)
		{
			GetProfileSettingValueInt( i, CardID);
			if (CardID == TargetID)
			{
//				`log("[SinglePlayer] Modifier Card"@Card@"has been used!");
				SetProfileSettingValueInt(i,-1);
				return;
			}
		}
	}
}


/**
 * @Returns true if the player has any of these cards
 */
function ClearModifierCards()
{
	local int i;
//	`log("[SinglePlayer] Clearing all Modifier card.");
	for (i = PSI_ModifierCardDeck0; i < PSI_ModifierCardEnd; i++)
	{
		SetProfileSettingValueInt( i, -1);
	}
}


function GetDeck(out array<name> Deck, out array<int> CardCount)
{
	local int i,CardId,idx;
	local name Card;

	for (i = PSI_ModifierCardDeck0; i < PSI_ModifierCardEnd; i++)
	{
		GetProfileSettingValueInt(i,CardID);
		if (CardID != INDEX_None)
		{
			Card = class'UTGameModifierCard'.static.GetNameForProfileID(CardID);
			if (Card != '')
			{
				idx = Deck.Find(Card);
				if (idx == INDEX_None)
				{
					Deck.Insert(0,1);
					Deck[0] = Card;
					CardCount.Insert(0,1);
					CardCount[0] = 1;
				}
				else
				{
					CardCount[idx]++;
				}
			}
		}
	}
}

/**
 * Achievements stored in profile
 */

// Update an achievement int32 by by treating it as a bitmask
// for stats like "complete all campaign", etc
native function bool UpdateAchievementBitMask(int AchievementId, int BitMask);

// Increment the particular achievement by Count
// basically maintains a count of how many times this achievement was accomplished
native function bool UpdateAchievementCount(int AchievementId, optional int Count=1);

// Increment the particular achievement by Count
// basically maintains a count of how many times this achievement was accomplished
native function bool UpdateAchievementByteCount(int AchievementId, int Value);

// Returns the value stored with this particular achievement
native function bool GetAchievementValue(int AchievementId, out int Value);

// Set the value for this particular achievement
native function bool SetAchievementValue(int AchievementId, int Value);

// Get the unlock criteria for this achievement
native function bool GetAchievementUnlockCriteria(int AchievementId, out int UnlockCriteria);

// Get the unlock type for this achievement
native function bool GetAchievementUnlockType(int AchievementId, out int UnlockType);

// Returns the total number of bits within the value stored with this particular achievement
native function int CountBits64InAchivementValue(int AchievementId);

// Set the map that was just won for the 'Around the World' Achievement
native function bool UpdateAroundTheWorld(INT MapContextId);

// Set the map that was just won for the 'Like the Back of My Hand' Achievement
native function bool UpdateLikeTheBackOfMyHand(INT MapContextId);

// Returns true if the map has been completed for the 'Like the Back of My Hand' Achievement
native function bool CheckLikeTheBackOfMyHandMap(INT MapContextId);

// Returns true if the map has been completed for the 'Around The World' Achievement
native function bool CheckAroundTheWorldMap(INT MapContextId);

// Set the gametype just won for 'Mix It Up' Achievement
native function bool IncrementMixItUp(INT GameType, INT AchievementType);

// Returns true if the gametype has been played for the mix it up achievements
native function bool CheckMixItUp(INT GameType, INT AchievementType);

// Returns true if the vehicle has been used for the jack of all trades achievement
native function bool CheckJackOfAllTradesBitmask(int VehicleIndex);

// Returns true if the vehicle has been used for the jack of all trades achievement
native function bool CheckSpiceOfLifeBitmask(int MutatorIndex);

// Set the gametype just played for 'Get It On' Achievement
native function bool UpdateGetItOn(INT MapContextId);

native function bool IncrementGetALife();

/**
 * @Param MissionID		- Returns the Mission ID for the current mission
 * @Param MissionResult - Returns the results for the last mission.
 */
function GetCurrentMissionData(out int MissionID, out int MissionResult)
{
	GetProfileSettingValueInt(PSI_SinglePlayerCurrentMission,MissionID);
	GetProfileSettingValueInt(PSI_SinglePlayerCurrentMissionResult,MissionResult);
}

function SetCurrentMissionData(int NewMissionID, int bNewMissionResult)
{
	SetProfileSettingValueInt(PSI_SinglePlayerCurrentMission,NewMissionID);
	SetProfileSettingValueInt(PSI_SinglePlayerCurrentMissionResult,bNewMissionResult);
}

function int GetCampaignSkillLevel()
{
	local int CMIdx;
	GetProfileSettingValueInt(PSI_SinglePlayerSkillLevel, CMIdx);
	return CMIdx;
}

function SetCampaignSkillLevel(int NewSkillLevel)
{
	SetProfileSettingValueInt(PSI_SinglePlayerSkillLevel, NewSkillLevel);
}

/**
 * @Returns true if a game is in progress
 */

function bool bGameInProgress()
{
	local int IDX, R;
	GetCurrentMissionData(IDX,R);
	return (IDX >= 0);
}

/**
 * Resets the single player game profile settings for a new game
 */
function NewGame()
{
	local int i;

	for (i=PSI_PersistentKeySlot0;i< PSI_PersistentKeyMAX; i++)
	{
		SetProfileSettingValueInt(i,ESPKey_None);
	}

	// Reset the modifier cards
    ClearModifierCards();

	// Reset the Map Mask
	SetProfileSettingValueInt(PSI_SinglePlayerMapMaskA,0);
	SetProfileSettingValueInt(PSI_SinglePlayerMapMaskB,0);

	SetProfileSettingValueInt(PSI_SinglePlayerSkillLevel,1);
	SetCurrentMissionData(0,0);
}
/**
 * Returns the integer value of a profile setting given its name.
 *
 * @return Whether or not the value was retrieved
 */
native function bool GetProfileSettingValueIntByName(name SettingName, out int OutValue);

/**
 * Returns the float value of a profile setting given its name.
 *
 * @return Whether or not the value was retrieved
 */
native function bool GetProfileSettingValueFloatByName(name SettingName, out float OutValue);

/**
 * Returns the string value of a profile setting given its name.
 *
 * @return Whether or not the value was retrieved
 */
native function bool GetProfileSettingValueStringByName(name SettingName, out string OutValue);

/**
 * Returns the Id mapped value of a profile setting given its name.
 *
 * @return Whether or not the value was retrieved
 */
native function bool GetProfileSettingValueIdByName(name SettingName, out int OutValue);

/**
 * Sets the specified profile id back to its default value.
 *
 * @param ProfileId	Profile setting to reset to default.
 */
native function ResetToDefault(int ProfileId);


/**
 * Resets the current keybindings for the specified playerowner to the defaults specified in the INI.
 *
 * @param InPlayerOwner	Player to get the default keybindings for.
 */
native static function ResetKeysToDefault(optional LocalPlayer InPlayerOwner);

/**
 * Stores key settings in the profile using the player input object provided.
 *
 * @param PInput	Player input to get bindings from.
 */
function StoreKeysUsingPlayerInput(optional PlayerInput PInput=None)
{
	local int BindingIdx, CommandIdx, ToBindIdx;
	local int NumTotalBinds, NumCurrBinds;
	local name KeyBinds[2];
	local array<KeyBind> Bindings;

	if(PInput==None)
	{
		Bindings=class'PlayerInput'.default.Bindings;
	}
	else
	{
		Bindings=PInput.Bindings;
	}

	NumTotalBinds = 2;

	// Loop through all of the commands in the profile.
	for ( CommandIdx = 0; CommandIdx<DigitalButtonActionsToCommandMapping.length; CommandIdx++ )
	{
		// Init the local binding data.
		NumCurrBinds = 0;
		for ( ToBindIdx = 0; ToBindIdx < NumTotalBinds; ToBindIdx++ )
		{
			KeyBinds[ToBindIdx] = '';
		}

		// Loop through all of the binds and find the commands that match the one we are currently trying to set in the profile.
		for( BindingIdx = Bindings.length-1; BindingIdx >= 0; BindingIdx-- )
		{
			// Found one so mark the index in our local array.
			if (Bindings[BindingIdx].Command == DigitalButtonActionsToCommandMapping[CommandIdx])
			{
				KeyBinds[NumCurrBinds++] = Bindings[BindingIdx].Name;
			}

			// Make sure we only mark NumTotoalBinds worth of binds.
			if ( NumCurrBinds >= NumTotalBinds )
			{
				break;
			}
		}

		// Now set them in the profile.
		SetKeyBindingUsingCommand( DigitalButtonActionsToCommandMapping[CommandIdx], KeyBinds[0], KeyBinds[1] );
	}
}

/**
 * Sets all of the profile settings to their default values
 */
event ScriptSetToDefaults()
{
	local string DefaultStringValue;

	DefaultStringValue = "";

	// Resets keys to default values.
	ResetKeysToDefault();
	StoreKeysUsingPlayerInput();

	SetProfileSettingValueFloat(UTPID_RocketLauncherPriority, class'UTWeap_RocketLauncher'.default.Priority);
	SetProfileSettingValueFloat(UTPID_BioRiflePriority, class'UTWeap_BioRifle'.default.Priority);
	SetProfileSettingValueFloat(UTPID_StingerPriority, class'UTWeap_Stinger'.default.Priority);
	SetProfileSettingValueFloat(UTPID_ShockRiflePriority, class'UTWeap_ShockRifle'.default.Priority);
	SetProfileSettingValueFloat(UTPID_SniperRiflePriority, class'UTWeap_SniperRifle'.default.Priority);
	SetProfileSettingValueFloat(UTPID_FlakCannonPriority, class'UTWeap_FlakCannon'.default.Priority);
	SetProfileSettingValueFloat(UTPID_RedeemerPriority, class'UTWeap_Redeemer'.default.Priority);
	SetProfileSettingValueFloat(UTPID_AVRILPriority, class'UTWeap_Avril'.default.Priority);
	SetProfileSettingValueFloat(UTPID_LinkGunPriority, class'UTWeap_LinkGun'.default.Priority);
	SetProfileSettingValueFloat(UTPID_EnforcerPriority, class'UTWeap_Enforcer'.default.Priority);

	if ( !class'UIRoot'.static.IsConsole() )
	{
		SetProfileSettingValueId(UTPID_ShowVehicleArmorCount, UTPID_VALUE_YES);
	}



	SetProfileSettingValue(UTPID_ClanTag, DefaultStringValue);
	SetProfileSettingValue(UTPID_Alias, DefaultStringValue);
	SetProfileSettingValue(UTPID_ServerDescription, DefaultStringValue);

	SetProfileSettingValueId(UTPID_SmallWeapons, class'UTWeapon'.default.bSmallWeapons ? UTPID_VALUE_YES : UTPID_VALUE_NO);
}

/**
 * Looks up a keybinding name given an enum value
 *
 * @param KeyName	Key name to look up the enum for.
 *
 * @return Returns the name for the key if it exists, or '' otherwise.
 */
function name FindKeyName(EUTBindableKeys KeyEnum)
{
	local name Result;

	if(KeyEnum < KeyMappingArray.length)
	{
		Result = KeyMappingArray[KeyEnum];
	}
	else
	{
		Result = '';
	}

	return Result;
}

/**
 * Looks up a keybinding enum value given its name.
 *
 * @param KeyName	Key name to look up the enum for.
 *
 * @return Returns the enum value for the key or INDEX_NONE if none was found.
 */
function int FindKeyEnum(name KeyName)
{
	local int KeyIdx;
	local int Result;

	Result = INDEX_NONE;

	for(KeyIdx=0; KeyIdx<KeyMappingArray.length; KeyIdx++)
	{
		if(KeyMappingArray[KeyIdx]==KeyName)
		{
			Result = KeyIdx;
			break;
		}
	}

	return Result;
}

/**
 * Returns the profile ID for a digital button action.
 *
 * @param KeyAction		Action to return a profile ID for.
 *
 * @return	Returns the profile ID for the action.
 */
function int GetProfileIDForDBA(EDigitalButtonActions KeyAction)
{
	local int ProfileId;
	ProfileId = UTPID_KeyAction_1+KeyAction;
	Assert(ProfileId<=UTPID_KeyAction_49);
	return ProfileId;
}

/**
 * Attempts to find a digital button action enum using a string command
 *
 * @param Command	Command to find
 *
 * @return an EDigitalButtonAction enum value if one exists, INDEX_NONE otherwise.
 */
function int GetDBAFromCommand(string Command)
{
	local int Result;
	local int CommandIdx;

	Result = INDEX_NONE;

	for(CommandIdx=0; CommandIdx<DigitalButtonActionsToCommandMapping.length; CommandIdx++)
	{
		if(DigitalButtonActionsToCommandMapping[CommandIdx]==Command)
		{
			Result = CommandIdx;
			break;
		}
	}

	return Result;
}

/**
 * Sets a binding for a specified command.
 *
 * @param KeyAction		DBA to bind
 * @param KeyBinding1	Key to bind #1
 * @param KeyBinding2	Key to bind #2
 * @param KeyBinding3	Key to bind #3
 * @param KeyBinding4	Key to bind #4
 */
function SetKeyBindingUsingCommand(string KeyCommand, name KeyBinding, optional name KeyBinding2='', optional name KeyBinding3='', optional name KeyBinding4='')
{
	local int KeyAction;

	KeyAction = GetDBAFromCommand(KeyCommand);

	if(KeyAction != INDEX_NONE)
	{
		SetKeyBinding(EDigitalButtonActions(KeyAction), KeyBinding, KeyBinding2, KeyBinding3, KeyBinding4);
	}
}

/**
 * Sets a binding for a specified key action.
 *
 * @param KeyAction		DBA to bind
 * @param KeyBinding1	Key to bind #1
 * @param KeyBinding2	Key to bind #2
 * @param KeyBinding3	Key to bind #3
 * @param KeyBinding4	Key to bind #4
 */
function SetKeyBinding(EDigitalButtonActions KeyAction, name KeyBinding, optional name KeyBinding2='', optional name KeyBinding3='', optional name KeyBinding4='')
{
	local int KeyBindingValue[4];
	local int FinalProfileValue;
	local int KeyEnumValue;
	local int BindingIdx;

	KeyBindingValue[0]=0;
	KeyBindingValue[1]=0;
	KeyBindingValue[2]=0;
	KeyBindingValue[3]=0;

	// Key binding 1
	if(KeyBinding != '')
	{
		KeyEnumValue = FindKeyEnum(KeyBinding);

		if(KeyEnumValue != INDEX_NONE)
		{
			KeyBindingValue[3]=KeyEnumValue;
		}
	}

	// Key binding 2
	if(KeyBinding2 != '')
	{
		KeyEnumValue = FindKeyEnum(KeyBinding2);

		if(KeyEnumValue != INDEX_NONE)
		{
			KeyBindingValue[2]=KeyEnumValue;
		}
	}

	// Key binding 3
	if(KeyBinding3 != '')
	{
		KeyEnumValue = FindKeyEnum(KeyBinding3);

		if(KeyEnumValue != INDEX_NONE)
		{
			KeyBindingValue[1]=KeyEnumValue;
		}
	}

	// Key binding 4
	if(KeyBinding4 != '')
	{
		KeyEnumValue = FindKeyEnum(KeyBinding4);

		if(KeyEnumValue != INDEX_NONE)
		{
			KeyBindingValue[0]=KeyEnumValue;
		}
	}

	// Save the value to the profile
	FinalProfileValue=0;
	for(BindingIdx=0;BindingIdx<4;BindingIdx++)
	{
		FinalProfileValue = FinalProfileValue | (KeyBindingValue[BindingIdx]<<(BindingIdx*8));
	}
	SetProfileSettingValueInt(GetProfileIDForDBA(KeyAction), FinalProfileValue);
}

/**
 * Unbinds the specified key.
 *
 * @param PInput	Player input to operate on
 * @param BindName	Key to unbind
 */
function UnbindKey(PlayerInput PInput, name BindName)
{
	local int BindingIdx;

	for(BindingIdx = 0;BindingIdx < PInput.Bindings.Length;BindingIdx++)
	{
		if(PInput.Bindings[BindingIdx].Name == BindName)
		{
			PInput.Bindings.Remove(BindingIdx, 1);
			PInput.SaveConfig();
			break;
		}
	}
}

/**
 * Applies all possible bindings to the specified player input.
 *
 * @param InPlayerInput		PlayerInput to bind keys on
 */
function ApplyAllKeyBindings(PlayerInput PInput)
{
	local int BindingIdx;

	if ( !class'UIRoot'.static.IsConsole() )
	{
		RemoveDBABindings( PInput );

		for(BindingIdx=0; BindingIdx<DBA_MAX; BindingIdx++)
		{
			ApplyKeyBinding(PInput, EDigitalButtonActions(BindingIdx));
		}
	}

	PatchDefaultKeyBindings(PInput);
}

function PatchDefaultKeyBindings(PlayerInput PInput)
{
	local int KeyBindBitmask;

	// For existing profiles that are upgrading to UT3G, make sure Titan transformation is bound
	if ( GetProfileSettingValueInt(GetProfileIDForDBA(DBA_TriggerHero), KeyBindBitmask) )
	{
		if ( KeyBindBitmask == 0 )
		{
			if ( PInput.GetBind('R') == "" )
			{
				SetKeyBinding(DBA_TriggerHero, 'R', 'XboxTypeS_DPad_Up');
			}
			else if ( PInput.GetBind('P') == "" )
			{
				SetKeyBinding(DBA_TriggerHero, 'P', 'XboxTypeS_DPad_Up');
			}
			else if ( PInput.GetBind('O') == "" )
			{
				SetKeyBinding(DBA_TriggerHero, 'O', 'XboxTypeS_DPad_Up');
			}
			ApplyKeyBinding(PInput, DBA_TriggerHero);
		}	
	}

	// Bind gamepad defaults
	if ( PInput.GetBind('XboxTypeS_LeftThumbstick') == "" )
	{
		PInput.SetBind('XboxTypeS_LeftThumbstick', "GBA_Duck");
	}
	if ( PInput.GetBind('XboxTypeS_Start') == "" )
	{
		PInput.SetBind('XboxTypeS_Start', "GBA_ShowMenu");
	}
	if ( PInput.GetBind('XboxTypeS_RightShoulder') == "" )
	{
		PInput.SetBind('XboxTypeS_RightShoulder', "GBA_NextWeapon");
	}
	if ( PInput.GetBind('XboxTypeS_RightTrigger') == "" )
	{
		PInput.SetBind('XboxTypeS_RightTrigger', "GBA_Fire");
	}
	if ( PInput.GetBind('XboxTypeS_LeftShoulder') == "" )
	{
		PInput.SetBind('XboxTypeS_LeftShoulder', "GBA_WeaponPicker");
	}
	if ( PInput.GetBind('XboxTypeS_LeftTrigger') == "" )
	{
		PInput.SetBind('XboxTypeS_LeftTrigger', "GBA_AltFire");
	}
	if ( PInput.GetBind('XboxTypeS_RightThumbstick') == "" )
	{
		PInput.SetBind('XboxTypeS_RightThumbstick', "GBA_SwitchToBestWeapon_Gamepad");
	}
	if ( PInput.GetBind('XboxTypeS_A') == "" )
	{
		PInput.SetBind('XboxTypeS_A', "GBA_Jump_Gamepad");
	}
	if ( PInput.GetBind('XboxTypeS_B') == "" )
	{
		PInput.SetBind('XboxTypeS_B', "GBA_ToggleMelee");
	}
	if ( PInput.GetBind('XboxTypeS_Y') == "" )
	{
		PInput.SetBind('XboxTypeS_Y', "GBA_ShowMap");
	}
	if ( PInput.GetBind('XboxTypeS_X') == "" )
	{
		PInput.SetBind('XboxTypeS_X', "GBA_Use_Gamepad");
	}
	if ( PInput.GetBind('XboxTypeS_Back') == "" )
	{
		PInput.SetBind('XboxTypeS_Back', "GBA_ShowScores");
	}
	if ( PInput.GetBind('XboxTypeS_DPad_Down') == "" )
	{
		PInput.SetBind('XboxTypeS_DPad_Down', "GBA_FeignDeath");
	}
	if ( PInput.GetBind('XboxTypeS_DPad_Left') == "" )
	{
		PInput.SetBind('XboxTypeS_DPad_Left', "GBA_ShowCommandMenu");
	}
	if ( PInput.GetBind('XboxTypeS_DPad_Right') == "" )
	{
		PInput.SetBind('XboxTypeS_DPad_Right', "GBA_ToggleSpeaking");
	}

	UTPlayerController(PInput.Outer).SaveProfile();
}


/**
 * Applies a key binding to the given player input, rebinds keys that are already bound, doesn't unbind keys already assigned to the action.
 *
 * @param InPlayerInput		PlayerInput to bind keys on
 * @param KeyBinding		Action to bind keys for.
 */
function ApplyKeyBinding(PlayerInput PInput, EDigitalButtonActions KeyBinding)
{
	local int KeyBindingValue;
	local int CurrentProfileValue;
	local name KeyName;
	local string KeyCommand;
	local int BindingIdx;

	if(GetProfileSettingValueInt(GetProfileIDForDBA(KeyBinding), CurrentProfileValue))
	{
		// Unpack value
		for(BindingIdx=0;BindingIdx<4;BindingIdx++)
		{
			KeyBindingValue = 0xFF & (CurrentProfileValue>>(BindingIdx*8));
			KeyName = FindKeyName(EUTBindableKeys(KeyBindingValue));
			KeyCommand = DigitalButtonActionsToCommandMapping[KeyBinding];

			// Unbind the current value first
			if(KeyBindingValue != 0 && KeyName != '' && Len(KeyCommand)>0)
			{
				//`Log("### - Applying keybinding Key:"@KeyName@"Command:"@KeyCommand);
				PInput.SetBind(KeyName, KeyCommand);
			}
		}
	}
}

/** Removes any binds the profile manages. */
function RemoveDBABindings( PlayerInput PInput )
{
	local int BindingIdx, DBAIdx;

	for ( BindingIdx = 0; BindingIdx < PInput.Bindings.length; BindingIdx++ )
	{
		for ( DBAIdx = 0; DBAIdx < DigitalButtonActionsToCommandMapping.length; DBAIdx++ )
		{
			if ( PInput.Bindings[BindingIdx].Command == DigitalButtonActionsToCommandMapping[DBAIdx] )
			{
				PInput.Bindings.Remove(BindingIdx, 1);
				BindingIdx--;
				break;
			}
		}
	}
}

/** Whether an action has been bound or not. */
function bool ActionIsBound(EDigitalButtonActions ActionIdx)
{
	local int Idx, Value;

	for ( Idx = UTPID_GamepadBinding_ButtonA; Idx <= UTPID_GamepadBinding_DPadRight; Idx++ )
	{
		if ( GetProfileSettingValueId(Idx, Value) )
		{
			if ( Value == ActionIdx )
			{
				return true;
			}
		}
	}

	return false;
}

// Returns the string of an action name.
function string GetActionName(EDigitalButtonActions ActionIdx)
{
	local string ActionName;
	local int ProfileSettingIDIndex, Idx;

	ActionName = "";

	for ( ProfileSettingIDIndex = 0; ProfileSettingIDIndex < ProfileMappings.length; ProfileSettingIDIndex++ )
	{
		if ( ProfileMappings[ProfileSettingIDIndex].Id == UTPID_GamepadBinding_ButtonA )
		{
			for ( Idx = 0; Idx < ProfileMappings[ProfileSettingIDIndex].ValueMappings.Length; Idx++ )
			{
				if (ProfileMappings[ProfileSettingIDIndex].ValueMappings[Idx].Id == int(ActionIdx))
				{
					ActionName = string(ProfileMappings[ProfileSettingIDIndex].ValueMappings[Idx].Name);
					break;
				}
			}
		}
	}

	return ActionName;
}

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   DigitalButtonActionsToCommandMapping(0)=
   DigitalButtonActionsToCommandMapping(1)="GBA_Fire"
   DigitalButtonActionsToCommandMapping(2)="GBA_AltFire"
   DigitalButtonActionsToCommandMapping(3)="GBA_Jump_Gamepad"
   DigitalButtonActionsToCommandMapping(4)="GBA_Use"
   DigitalButtonActionsToCommandMapping(5)="GBA_ToggleMelee"
   DigitalButtonActionsToCommandMapping(6)="GBA_ShowScores"
   DigitalButtonActionsToCommandMapping(7)="GBA_ShowMap"
   DigitalButtonActionsToCommandMapping(8)="GBA_FeignDeath"
   DigitalButtonActionsToCommandMapping(9)="GBA_ToggleSpeaking"
   DigitalButtonActionsToCommandMapping(10)="GBA_ToggleMinimap"
   DigitalButtonActionsToCommandMapping(11)="GBA_WeaponPicker"
   DigitalButtonActionsToCommandMapping(12)="GBA_NextWeapon"
   DigitalButtonActionsToCommandMapping(13)="GBA_SwitchToBestWeapon_Gamepad"
   DigitalButtonActionsToCommandMapping(14)="GBA_PrevWeapon"
   DigitalButtonActionsToCommandMapping(15)="GBA_Duck"
   DigitalButtonActionsToCommandMapping(16)="GBA_MoveForward"
   DigitalButtonActionsToCommandMapping(17)="GBA_Backward"
   DigitalButtonActionsToCommandMapping(18)="GBA_StrafeLeft"
   DigitalButtonActionsToCommandMapping(19)="GBA_StrafeRight"
   DigitalButtonActionsToCommandMapping(20)="GBA_TurnLeft"
   DigitalButtonActionsToCommandMapping(21)="GBA_TurnRight"
   DigitalButtonActionsToCommandMapping(22)="GBA_SwitchWeapon1"
   DigitalButtonActionsToCommandMapping(23)="GBA_SwitchWeapon2"
   DigitalButtonActionsToCommandMapping(24)="GBA_SwitchWeapon3"
   DigitalButtonActionsToCommandMapping(25)="GBA_SwitchWeapon4"
   DigitalButtonActionsToCommandMapping(26)="GBA_SwitchWeapon5"
   DigitalButtonActionsToCommandMapping(27)="GBA_SwitchWeapon6"
   DigitalButtonActionsToCommandMapping(28)="GBA_SwitchWeapon7"
   DigitalButtonActionsToCommandMapping(29)="GBA_SwitchWeapon8"
   DigitalButtonActionsToCommandMapping(30)="GBA_SwitchWeapon9"
   DigitalButtonActionsToCommandMapping(31)="GBA_SwitchWeapon10"
   DigitalButtonActionsToCommandMapping(32)="GBA_GrowHud"
   DigitalButtonActionsToCommandMapping(33)="GBA_ShrinkHud"
   DigitalButtonActionsToCommandMapping(34)="GBA_Taunt1"
   DigitalButtonActionsToCommandMapping(35)="GBA_Taunt2"
   DigitalButtonActionsToCommandMapping(36)="GBA_Talk"
   DigitalButtonActionsToCommandMapping(37)="GBA_TeamTalk"
   DigitalButtonActionsToCommandMapping(38)="GBA_ShowCommandMenu"
   DigitalButtonActionsToCommandMapping(39)="GBA_ShowMenu"
   DigitalButtonActionsToCommandMapping(40)="GBA_ToggleTranslocator"
   DigitalButtonActionsToCommandMapping(41)="GBA_Jump"
   DigitalButtonActionsToCommandMapping(42)="GBA_SwitchToBestWeapon"
   DigitalButtonActionsToCommandMapping(43)="GBA_Horn"
   DigitalButtonActionsToCommandMapping(44)="GBA_TriggerHero"
   AchievementsArray(0)=(Id=EUTA_CAMPAIGN_SignTreaty,UnlockCriteria=1)
   AchievementsArray(1)=(Id=EUTA_CAMPAIGN_LiandriMainframe,UnlockCriteria=1)
   AchievementsArray(2)=(Id=EUTA_CAMPAIGN_ReachOmicron,UnlockCriteria=1)
   AchievementsArray(3)=(Id=EUTA_CAMPAIGN_SignTreatyExpert,UnlockCriteria=1)
   AchievementsArray(4)=(Id=EUTA_CAMPAIGN_LiandriMainframeExpert,UnlockCriteria=1)
   AchievementsArray(5)=(Id=EUTA_CAMPAIGN_ReachOmicronExpert,UnlockCriteria=1)
   AchievementsArray(6)=(Id=EUTA_COOP_Complete1,UnlockCriteria=1)
   AchievementsArray(7)=(Id=EUTA_COOP_Complete10,UnlockCriteria=10)
   AchievementsArray(8)=(Id=EUTA_COOP_CompleteCampaign,UnlockCriteria=1)
   AchievementsArray(9)=(Id=EUTA_IA_EveryGameMode,UnlockType=EUnlockType_Bitmask,UnlockCriteria=255)
   AchievementsArray(10)=(Id=EUTA_IA_Untouchable,UnlockCriteria=1)
   AchievementsArray(11)=(Id=EUTA_EXPLORE_AllPowerups,UnlockType=EUnlockType_Bitmask,UnlockCriteria=-1)
   AchievementsArray(12)=(Id=EUTA_EXPLORE_EveryMutator,UnlockType=EUnlockType_Bitmask,UnlockCriteria=65535)
   AchievementsArray(13)=(Id=EUTA_WEAPON_BrainSurgeon,UnlockCriteria=10)
   AchievementsArray(14)=(Id=EUTA_WEAPON_DontTaseMeBro,UnlockCriteria=10)
   AchievementsArray(15)=(Id=EUTA_WEAPON_GooGod,UnlockCriteria=10)
   AchievementsArray(16)=(Id=EUTA_WEAPON_Pistolero,UnlockCriteria=10)
   AchievementsArray(17)=(Id=EUTA_WEAPON_Hammerhead,UnlockCriteria=10)
   AchievementsArray(18)=(Id=EUTA_WEAPON_StrongestLink,UnlockCriteria=10)
   AchievementsArray(19)=(Id=EUTA_WEAPON_HaveANiceDay,UnlockType=EUnlockType_ByteCount,UnlockCriteria=2570)
   AchievementsArray(20)=(Id=EUTA_WEAPON_BigGameHunter,UnlockCriteria=10)
   AchievementsArray(21)=(Id=EUTA_VEHICLE_Armadillo,UnlockCriteria=10)
   AchievementsArray(22)=(Id=EUTA_VEHICLE_JackOfAllTrades,UnlockType=EUnlockType_Bitmask,UnlockCriteria=65535)
   AchievementsArray(23)=(Id=EUTA_VEHICLE_Ace,UnlockCriteria=20)
   AchievementsArray(24)=(Id=EUTA_VEHICLE_Deathwish,UnlockCriteria=20)
   AchievementsArray(25)=(Id=EUTA_HUMILIATION_SerialKiller,UnlockCriteria=20)
   AchievementsArray(26)=(Id=EUTA_HUMILIATION_SirSlaysALot,UnlockCriteria=20)
   AchievementsArray(27)=(Id=EUTA_HUMILIATION_KillJoy,UnlockCriteria=20)
   AchievementsArray(28)=(Id=EUTA_VERSUS_GetItOn,UnlockType=EUnlockType_Bitmask,UnlockCriteria=255)
   AchievementsArray(29)=(Id=EUTA_VERSUS_AroundTheWorld,UnlockType=EUnlockType_Bitmask,UnlockCriteria=-1)
   AchievementsArray(30)=(Id=EUTA_VERSUS_GetALife,UnlockType=EUnlockType_ByteCount,UnlockCriteria=51250)
   AchievementsArray(31)=(Id=EUTA_GAME_HatTrick,UnlockCriteria=10)
   AchievementsArray(32)=(Id=EUTA_RANKED_BloodSweatTears,UnlockCriteria=500)
   AchievementsArray(33)=(Id=EUTA_CAMPAIGN_DefeatAkashaExpert,UnlockCriteria=1)
   AchievementsArray(34)=(Id=EUTA_CAMPAIGN_DefeatAkasha,UnlockCriteria=1)
   AchievementsArray(35)=(Id=EUTA_HUMILIATION_OffToAGoodStart,UnlockCriteria=40)
   AchievementsArray(36)=(Id=EUTA_CAMPAIGN_Chapter1,UnlockCriteria=1)
   AchievementsArray(37)=(Id=EUTA_WEAPON_ShardOMatic,UnlockCriteria=10)
   AchievementsArray(38)=(Id=EUTA_POWERUP_SeeingRed,UnlockCriteria=1200)
   AchievementsArray(39)=(Id=EUTA_POWERUP_NeverSawItComing,UnlockCriteria=1200)
   AchievementsArray(40)=(Id=EUTA_POWERUP_SurvivalFittest,UnlockCriteria=600)
   AchievementsArray(41)=(Id=EUTA_POWERUP_DeliveringTheHurt,UnlockCriteria=1200)
   AchievementsArray(42)=(Id=EUTA_GAME_BeingAHero,UnlockCriteria=100)
   AchievementsArray(43)=(Id=EUTA_GAME_FlagWaver,UnlockCriteria=100)
   AchievementsArray(44)=(Id=EUTA_GAME_30MinOrLess,UnlockCriteria=100)
   AchievementsArray(45)=(Id=EUTA_GAME_PaintTownRed,UnlockCriteria=100)
   AchievementsArray(46)=(Id=EUTA_GAME_ConnectTheDots,UnlockCriteria=100)
   AchievementsArray(47)=(Id=EUTA_UT3GOLD_CantBeTrusted,UnlockCriteria=200)
   AchievementsArray(48)=(Id=EUTA_UT3GOLD_Avenger,UnlockCriteria=20)
   AchievementsArray(49)=(Id=EUTA_UT3GOLD_BagOfBones,UnlockCriteria=1)
   AchievementsArray(50)=(Id=EUTA_UT3GOLD_SkullCollector,UnlockCriteria=500)
   AchievementsArray(51)=(Id=EUTA_UT3GOLD_Titanic,UnlockCriteria=20)
   AchievementsArray(52)=(Id=EUTA_UT3GOLD_Behemoth,UnlockCriteria=10)
   AchievementsArray(53)=(Id=EUTA_UT3GOLD_Unholy,UnlockCriteria=1)
   AchievementsArray(54)=(Id=EUTA_UT3GOLD_TheSlowLane,UnlockCriteria=600)
   AchievementsArray(55)=(Id=EUTA_UT3GOLD_Eradication,UnlockCriteria=100)
   AchievementsArray(56)=(Id=EUTA_UT3GOLD_Arachnophobia,UnlockCriteria=10)
   CampaignBoneNames(0)="B_CTFStrident"
   CampaignBoneNames(1)="B_DMCarbonfire"
   CampaignBoneNames(2)="B_CTFCoret"
   CampaignBoneNames(3)="B_DMHeatray"
   CampaignBoneNames(4)="B_CTFDeny"
   CampaignBoneNames(5)="B_DMGateway"
   CampaignBoneNames(6)="B_DMArsenal"
   CampaignBoneNames(7)="B_ONSPowerSurge"
   CampaignBoneNames(8)="B_ONSDusk"
   CampaignBoneNames(9)="B_ONSIslander"
   CampaignBoneNames(10)="B_DMRisingsun"
   CampaignBoneNames(11)="B_DMShangrila"
   CampaignBoneNames(12)="B_CTFCorruption"
   CampaignBoneNames(13)="B_ONSMarketdistrict"
   CampaignBoneNames(14)="B_ONSDownUnder"
   CampaignBoneNames(15)="B_ONSDmz"
   CampaignBoneNames(16)="B_CTFReflection"
   CampaignBoneNames(17)="B_ONSTorlan"
   CampaignBoneNames(18)="B_ONSSerenity"
   CampaignBoneNames(19)="B_ONSJumpgate"
   CampaignBoneNames(20)="B_ONSOnyxcoast"
   CampaignBoneNames(21)="B_DMHardcore"
   CampaignBoneNames(22)="B_ONSColdHarbor"
   CampaignBoneNames(23)="B_CTFKargo"
   CampaignBoneNames(24)="B_CTFHydrosis"
   CampaignBoneNames(25)="B_CTFSuspense"
   CampaignBoneNames(26)="B_DMDeck"
   CampaignBoneNames(27)="B_DMDiesel"
   CampaignBoneNames(28)="B_ONSDowntown"
   CampaignBoneNames(29)="B_DMDefiance"
   CampaignBoneNames(30)="B_CTFSandstorm"
   CampaignBoneNames(31)="B_DMSentinel"
   CampaignBoneNames(32)="B_ONSSublevels"
   CampaignBoneNames(33)="B_CTFNecropolis"
   CampaignBoneNames(34)="B_CTFVertibrae"
   CampaignBoneNames(35)="B_DMRevenant"
   CampaignBoneNames(36)="B_DMBabel"
   CampaignBoneNames(37)="B_CTFSteamlight"
   VersionNumber=59
   ProfileSettingIds(0)=1
   ProfileSettingIds(1)=2
   ProfileSettingIds(2)=5
   ProfileSettingIds(3)=450
   ProfileSettingIds(4)=16
   ProfileSettingIds(5)=301
   ProfileSettingIds(6)=302
   ProfileSettingIds(7)=360
   ProfileSettingIds(8)=361
   ProfileSettingIds(9)=362
   ProfileSettingIds(10)=363
   ProfileSettingIds(11)=364
   ProfileSettingIds(12)=365
   ProfileSettingIds(13)=366
   ProfileSettingIds(14)=367
   ProfileSettingIds(15)=368
   ProfileSettingIds(16)=380
   ProfileSettingIds(17)=381
   ProfileSettingIds(18)=382
   ProfileSettingIds(19)=383
   ProfileSettingIds(20)=384
   ProfileSettingIds(21)=385
   ProfileSettingIds(22)=400
   ProfileSettingIds(23)=401
   ProfileSettingIds(24)=402
   ProfileSettingIds(25)=403
   ProfileSettingIds(26)=404
   ProfileSettingIds(27)=405
   ProfileSettingIds(28)=406
   ProfileSettingIds(29)=407
   ProfileSettingIds(30)=408
   ProfileSettingIds(31)=409
   ProfileSettingIds(32)=410
   ProfileSettingIds(33)=411
   ProfileSettingIds(34)=412
   ProfileSettingIds(35)=420
   ProfileSettingIds(36)=421
   ProfileSettingIds(37)=422
   ProfileSettingIds(38)=423
   ProfileSettingIds(39)=424
   ProfileSettingIds(40)=425
   ProfileSettingIds(41)=426
   ProfileSettingIds(42)=427
   ProfileSettingIds(43)=428
   ProfileSettingIds(44)=429
   ProfileSettingIds(45)=430
   ProfileSettingIds(46)=431
   ProfileSettingIds(47)=432
   ProfileSettingIds(48)=433
   ProfileSettingIds(49)=434
   ProfileSettingIds(50)=435
   ProfileSettingIds(51)=436
   ProfileSettingIds(52)=437
   ProfileSettingIds(53)=438
   ProfileSettingIds(54)=439
   ProfileSettingIds(55)=440
   ProfileSettingIds(56)=441
   ProfileSettingIds(57)=442
   ProfileSettingIds(58)=443
   ProfileSettingIds(59)=444
   ProfileSettingIds(60)=451
   ProfileSettingIds(61)=452
   ProfileSettingIds(62)=453
   ProfileSettingIds(63)=455
   ProfileSettingIds(64)=454
   ProfileSettingIds(65)=460
   ProfileSettingIds(66)=461
   ProfileSettingIds(67)=462
   ProfileSettingIds(68)=463
   ProfileSettingIds(69)=464
   ProfileSettingIds(70)=465
   ProfileSettingIds(71)=466
   ProfileSettingIds(72)=467
   ProfileSettingIds(73)=468
   ProfileSettingIds(74)=469
   ProfileSettingIds(75)=470
   ProfileSettingIds(76)=471
   ProfileSettingIds(77)=472
   ProfileSettingIds(78)=473
   ProfileSettingIds(79)=474
   ProfileSettingIds(80)=480
   ProfileSettingIds(81)=481
   ProfileSettingIds(82)=482
   ProfileSettingIds(83)=483
   ProfileSettingIds(84)=484
   ProfileSettingIds(85)=485
   ProfileSettingIds(86)=486
   ProfileSettingIds(87)=487
   ProfileSettingIds(88)=488
   ProfileSettingIds(89)=700
   ProfileSettingIds(90)=245
   ProfileSettingIds(91)=246
   ProfileSettingIds(92)=200
   ProfileSettingIds(93)=201
   ProfileSettingIds(94)=202
   ProfileSettingIds(95)=203
   ProfileSettingIds(96)=204
   ProfileSettingIds(97)=205
   ProfileSettingIds(98)=206
   ProfileSettingIds(99)=207
   ProfileSettingIds(100)=208
   ProfileSettingIds(101)=209
   ProfileSettingIds(102)=210
   ProfileSettingIds(103)=211
   ProfileSettingIds(104)=212
   ProfileSettingIds(105)=213
   ProfileSettingIds(106)=214
   ProfileSettingIds(107)=215
   ProfileSettingIds(108)=216
   ProfileSettingIds(109)=217
   ProfileSettingIds(110)=218
   ProfileSettingIds(111)=219
   ProfileSettingIds(112)=299
   ProfileSettingIds(113)=250
   ProfileSettingIds(114)=251
   ProfileSettingIds(115)=252
   ProfileSettingIds(116)=270
   ProfileSettingIds(117)=271
   ProfileSettingIds(118)=272
   ProfileSettingIds(119)=273
   ProfileSettingIds(120)=274
   ProfileSettingIds(121)=275
   ProfileSettingIds(122)=276
   ProfileSettingIds(123)=277
   ProfileSettingIds(124)=278
   ProfileSettingIds(125)=279
   ProfileSettingIds(126)=280
   ProfileSettingIds(127)=281
   ProfileSettingIds(128)=282
   ProfileSettingIds(129)=283
   ProfileSettingIds(130)=284
   ProfileSettingIds(131)=285
   ProfileSettingIds(132)=286
   ProfileSettingIds(133)=287
   ProfileSettingIds(134)=288
   ProfileSettingIds(135)=289
   ProfileSettingIds(136)=501
   ProfileSettingIds(137)=502
   ProfileSettingIds(138)=503
   ProfileSettingIds(139)=504
   ProfileSettingIds(140)=505
   ProfileSettingIds(141)=506
   ProfileSettingIds(142)=507
   ProfileSettingIds(143)=508
   ProfileSettingIds(144)=509
   ProfileSettingIds(145)=510
   ProfileSettingIds(146)=511
   ProfileSettingIds(147)=512
   ProfileSettingIds(148)=513
   ProfileSettingIds(149)=514
   ProfileSettingIds(150)=515
   ProfileSettingIds(151)=516
   ProfileSettingIds(152)=517
   ProfileSettingIds(153)=518
   ProfileSettingIds(154)=519
   ProfileSettingIds(155)=520
   ProfileSettingIds(156)=521
   ProfileSettingIds(157)=522
   ProfileSettingIds(158)=523
   ProfileSettingIds(159)=524
   ProfileSettingIds(160)=525
   ProfileSettingIds(161)=526
   ProfileSettingIds(162)=527
   ProfileSettingIds(163)=528
   ProfileSettingIds(164)=529
   ProfileSettingIds(165)=530
   ProfileSettingIds(166)=531
   ProfileSettingIds(167)=532
   ProfileSettingIds(168)=533
   ProfileSettingIds(169)=534
   ProfileSettingIds(170)=535
   ProfileSettingIds(171)=536
   ProfileSettingIds(172)=537
   ProfileSettingIds(173)=538
   ProfileSettingIds(174)=539
   ProfileSettingIds(175)=540
   ProfileSettingIds(176)=541
   ProfileSettingIds(177)=542
   ProfileSettingIds(178)=543
   ProfileSettingIds(179)=544
   ProfileSettingIds(180)=545
   ProfileSettingIds(181)=546
   ProfileSettingIds(182)=547
   ProfileSettingIds(183)=548
   ProfileSettingIds(184)=549
   ProfileSettingIds(185)=802
   ProfileSettingIds(186)=803
   ProfileSettingIds(187)=804
   ProfileSettingIds(188)=806
   ProfileSettingIds(189)=807
   ProfileSettingIds(190)=808
   ProfileSettingIds(191)=810
   ProfileSettingIds(192)=811
   ProfileSettingIds(193)=812
   ProfileSettingIds(194)=813
   ProfileSettingIds(195)=814
   ProfileSettingIds(196)=815
   ProfileSettingIds(197)=816
   ProfileSettingIds(198)=817
   ProfileSettingIds(199)=818
   ProfileSettingIds(200)=819
   ProfileSettingIds(201)=820
   ProfileSettingIds(202)=822
   ProfileSettingIds(203)=823
   ProfileSettingIds(204)=824
   ProfileSettingIds(205)=825
   ProfileSettingIds(206)=826
   ProfileSettingIds(207)=827
   ProfileSettingIds(208)=828
   ProfileSettingIds(209)=829
   ProfileSettingIds(210)=840
   ProfileSettingIds(211)=841
   ProfileSettingIds(212)=842
   ProfileSettingIds(213)=844
   ProfileSettingIds(214)=845
   ProfileSettingIds(215)=846
   ProfileSettingIds(216)=834
   ProfileSettingIds(217)=847
   ProfileSettingIds(218)=809
   ProfileSettingIds(219)=805
   ProfileSettingIds(220)=843
   ProfileSettingIds(221)=801
   ProfileSettingIds(222)=821
   ProfileSettingIds(223)=830
   ProfileSettingIds(224)=831
   ProfileSettingIds(225)=832
   ProfileSettingIds(226)=833
   ProfileSettingIds(227)=835
   ProfileSettingIds(228)=836
   ProfileSettingIds(229)=837
   ProfileSettingIds(230)=838
   ProfileSettingIds(231)=839
   ProfileSettingIds(232)=848
   ProfileSettingIds(233)=849
   ProfileSettingIds(234)=850
   ProfileSettingIds(235)=851
   ProfileSettingIds(236)=852
   ProfileSettingIds(237)=853
   ProfileSettingIds(238)=854
   ProfileSettingIds(239)=855
   ProfileSettingIds(240)=856
   ProfileSettingIds(241)=857
   ProfileSettingIds(242)=800
   DefaultSettings(0)=(Owner=OPPO_OnlineService,ProfileSetting=(PropertyId=1,Data=(Type=SDT_Int32,Value1=3)))
   DefaultSettings(1)=(Owner=OPPO_OnlineService,ProfileSetting=(PropertyId=2,Data=(Type=SDT_Int32)))
   DefaultSettings(2)=(Owner=OPPO_OnlineService,ProfileSetting=(PropertyId=5,Data=(Type=SDT_Int32)))
   DefaultSettings(3)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=450,Data=(Type=SDT_Int32,Value1=10)))
   DefaultSettings(4)=(Owner=OPPO_OnlineService,ProfileSetting=(PropertyId=16,Data=(Type=SDT_Int32)))
   DefaultSettings(5)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=301,Data=(Type=SDT_String)))
   DefaultSettings(6)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=302,Data=(Type=SDT_Int32)))
   DefaultSettings(7)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=411,Data=(Type=SDT_Int32)))
   DefaultSettings(8)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=360,Data=(Type=SDT_Int32,Value1=5)))
   DefaultSettings(9)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=361,Data=(Type=SDT_Int32,Value1=5)))
   DefaultSettings(10)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=362,Data=(Type=SDT_Int32,Value1=6)))
   DefaultSettings(11)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=368,Data=(Type=SDT_Int32,Value1=5)))
   DefaultSettings(12)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=363,Data=(Type=SDT_Int32,Value1=5)))
   DefaultSettings(13)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=364,Data=(Type=SDT_Int32,Value1=2)))
   DefaultSettings(14)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=365,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(15)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=366,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(16)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=367,Data=(Type=SDT_Int32)))
   DefaultSettings(17)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=380,Data=(Type=SDT_Int32,Value1=6)))
   DefaultSettings(18)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=381,Data=(Type=SDT_Int32)))
   DefaultSettings(19)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=382,Data=(Type=SDT_Int32,Value1=1024)))
   DefaultSettings(20)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=383,Data=(Type=SDT_Int32,Value1=768)))
   DefaultSettings(21)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=384,Data=(Type=SDT_Int32,Value1=90)))
   DefaultSettings(22)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=385,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(23)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=400,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(24)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=401,Data=(Type=SDT_Int32)))
   DefaultSettings(25)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=402,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(26)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=403,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(27)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=406,Data=(Type=SDT_Int32,Value1=3)))
   DefaultSettings(28)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=407,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(29)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=408,Data=(Type=SDT_Int32)))
   DefaultSettings(30)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=404,Data=(Type=SDT_String)))
   DefaultSettings(31)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=405,Data=(Type=SDT_String)))
   DefaultSettings(32)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=409,Data=(Type=SDT_String)))
   DefaultSettings(33)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=410,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(34)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=412,Data=(Type=SDT_Int32)))
   DefaultSettings(35)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=420,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(36)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=421,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(37)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=422,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(38)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=423,Data=(Type=SDT_Int32,Value1=2500)))
   DefaultSettings(39)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=424,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(40)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=425,Data=(Type=SDT_Int32,Value1=10)))
   DefaultSettings(41)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=426,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(42)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=427,Data=(Type=SDT_Int32,Value1=25)))
   DefaultSettings(43)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=428,Data=(Type=SDT_Int32,Value1=4)))
   DefaultSettings(44)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=429,Data=(Type=SDT_Int32,Value1=3)))
   DefaultSettings(45)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=430,Data=(Type=SDT_Int32,Value1=5)))
   DefaultSettings(46)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=431,Data=(Type=SDT_Int32,Value1=4)))
   DefaultSettings(47)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=432,Data=(Type=SDT_Int32,Value1=7)))
   DefaultSettings(48)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=433,Data=(Type=SDT_Int32,Value1=6)))
   DefaultSettings(49)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=434,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(50)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=435,Data=(Type=SDT_Int32,Value1=2)))
   DefaultSettings(51)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=436,Data=(Type=SDT_Int32,Value1=12)))
   DefaultSettings(52)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=437,Data=(Type=SDT_Int32,Value1=11)))
   DefaultSettings(53)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=438,Data=(Type=SDT_Int32,Value1=13)))
   DefaultSettings(54)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=439,Data=(Type=SDT_Int32,Value1=3)))
   DefaultSettings(55)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=440,Data=(Type=SDT_Int32,Value1=44)))
   DefaultSettings(56)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=441,Data=(Type=SDT_Int32,Value1=8)))
   DefaultSettings(57)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=442,Data=(Type=SDT_Int32,Value1=38)))
   DefaultSettings(58)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=443,Data=(Type=SDT_Int32,Value1=9)))
   DefaultSettings(59)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=444,Data=(Type=SDT_Int32)))
   DefaultSettings(60)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=451,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(61)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=452,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(62)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=453,Data=(Type=SDT_Int32)))
   DefaultSettings(63)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=455,Data=(Type=SDT_Int32)))
   DefaultSettings(64)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=454,Data=(Type=SDT_Int32)))
   DefaultSettings(65)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=460,Data=(Type=SDT_Int32)))
   DefaultSettings(66)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=461,Data=(Type=SDT_Int32)))
   DefaultSettings(67)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=462,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(68)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=463,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(69)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=464,Data=(Type=SDT_Float)))
   DefaultSettings(70)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=465,Data=(Type=SDT_Float)))
   DefaultSettings(71)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=466,Data=(Type=SDT_Float)))
   DefaultSettings(72)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=467,Data=(Type=SDT_Float)))
   DefaultSettings(73)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=468,Data=(Type=SDT_Float)))
   DefaultSettings(74)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=469,Data=(Type=SDT_Float)))
   DefaultSettings(75)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=470,Data=(Type=SDT_Float)))
   DefaultSettings(76)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=471,Data=(Type=SDT_Float)))
   DefaultSettings(77)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=472,Data=(Type=SDT_Float)))
   DefaultSettings(78)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=473,Data=(Type=SDT_Float)))
   DefaultSettings(79)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=474,Data=(Type=SDT_Int32)))
   DefaultSettings(80)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=480,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(81)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=481,Data=(Type=SDT_Int32)))
   DefaultSettings(82)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=482,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(83)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=483,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(84)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=484,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(85)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=485,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(86)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=486,Data=(Type=SDT_Int32)))
   DefaultSettings(87)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=487,Data=(Type=SDT_Int32)))
   DefaultSettings(88)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=488,Data=(Type=SDT_Int32)))
   DefaultSettings(89)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=700,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(90)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=501,Data=(Type=SDT_Int32)))
   DefaultSettings(91)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=502,Data=(Type=SDT_Int32)))
   DefaultSettings(92)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=503,Data=(Type=SDT_Int32)))
   DefaultSettings(93)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=504,Data=(Type=SDT_Int32)))
   DefaultSettings(94)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=505,Data=(Type=SDT_Int32)))
   DefaultSettings(95)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=506,Data=(Type=SDT_Int32)))
   DefaultSettings(96)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=507,Data=(Type=SDT_Int32)))
   DefaultSettings(97)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=508,Data=(Type=SDT_Int32)))
   DefaultSettings(98)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=509,Data=(Type=SDT_Int32)))
   DefaultSettings(99)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=510,Data=(Type=SDT_Int32)))
   DefaultSettings(100)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=511,Data=(Type=SDT_Int32)))
   DefaultSettings(101)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=512,Data=(Type=SDT_Int32)))
   DefaultSettings(102)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=513,Data=(Type=SDT_Int32)))
   DefaultSettings(103)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=514,Data=(Type=SDT_Int32)))
   DefaultSettings(104)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=515,Data=(Type=SDT_Int32)))
   DefaultSettings(105)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=516,Data=(Type=SDT_Int32)))
   DefaultSettings(106)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=517,Data=(Type=SDT_Int32)))
   DefaultSettings(107)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=518,Data=(Type=SDT_Int32)))
   DefaultSettings(108)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=519,Data=(Type=SDT_Int32)))
   DefaultSettings(109)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=520,Data=(Type=SDT_Int32)))
   DefaultSettings(110)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=521,Data=(Type=SDT_Int32)))
   DefaultSettings(111)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=522,Data=(Type=SDT_Int32)))
   DefaultSettings(112)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=523,Data=(Type=SDT_Int32)))
   DefaultSettings(113)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=524,Data=(Type=SDT_Int32)))
   DefaultSettings(114)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=525,Data=(Type=SDT_Int32)))
   DefaultSettings(115)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=526,Data=(Type=SDT_Int32)))
   DefaultSettings(116)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=527,Data=(Type=SDT_Int32)))
   DefaultSettings(117)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=528,Data=(Type=SDT_Int32)))
   DefaultSettings(118)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=529,Data=(Type=SDT_Int32)))
   DefaultSettings(119)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=530,Data=(Type=SDT_Int32)))
   DefaultSettings(120)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=531,Data=(Type=SDT_Int32)))
   DefaultSettings(121)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=532,Data=(Type=SDT_Int32)))
   DefaultSettings(122)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=533,Data=(Type=SDT_Int32)))
   DefaultSettings(123)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=534,Data=(Type=SDT_Int32)))
   DefaultSettings(124)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=535,Data=(Type=SDT_Int32)))
   DefaultSettings(125)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=536,Data=(Type=SDT_Int32)))
   DefaultSettings(126)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=537,Data=(Type=SDT_Int32)))
   DefaultSettings(127)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=538,Data=(Type=SDT_Int32)))
   DefaultSettings(128)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=539,Data=(Type=SDT_Int32)))
   DefaultSettings(129)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=540,Data=(Type=SDT_Int32)))
   DefaultSettings(130)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=541,Data=(Type=SDT_Int32)))
   DefaultSettings(131)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=542,Data=(Type=SDT_Int32)))
   DefaultSettings(132)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=543,Data=(Type=SDT_Int32)))
   DefaultSettings(133)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=544,Data=(Type=SDT_Int32)))
   DefaultSettings(134)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=545,Data=(Type=SDT_Int32)))
   DefaultSettings(135)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=546,Data=(Type=SDT_Int32)))
   DefaultSettings(136)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=547,Data=(Type=SDT_Int32)))
   DefaultSettings(137)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=548,Data=(Type=SDT_Int32)))
   DefaultSettings(138)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=549,Data=(Type=SDT_Int32)))
   DefaultSettings(139)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=245,Data=(Type=SDT_Int32)))
   DefaultSettings(140)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=246,Data=(Type=SDT_Int32)))
   DefaultSettings(141)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=200,Data=(Type=SDT_Int32)))
   DefaultSettings(142)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=201,Data=(Type=SDT_Int32)))
   DefaultSettings(143)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=202,Data=(Type=SDT_Int32)))
   DefaultSettings(144)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=203,Data=(Type=SDT_Int32)))
   DefaultSettings(145)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=204,Data=(Type=SDT_Int32)))
   DefaultSettings(146)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=205,Data=(Type=SDT_Int32)))
   DefaultSettings(147)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=206,Data=(Type=SDT_Int32)))
   DefaultSettings(148)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=207,Data=(Type=SDT_Int32)))
   DefaultSettings(149)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=208,Data=(Type=SDT_Int32)))
   DefaultSettings(150)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=209,Data=(Type=SDT_Int32)))
   DefaultSettings(151)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=210,Data=(Type=SDT_Int32)))
   DefaultSettings(152)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=211,Data=(Type=SDT_Int32)))
   DefaultSettings(153)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=212,Data=(Type=SDT_Int32)))
   DefaultSettings(154)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=213,Data=(Type=SDT_Int32)))
   DefaultSettings(155)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=214,Data=(Type=SDT_Int32)))
   DefaultSettings(156)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=215,Data=(Type=SDT_Int32)))
   DefaultSettings(157)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=216,Data=(Type=SDT_Int32)))
   DefaultSettings(158)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=217,Data=(Type=SDT_Int32)))
   DefaultSettings(159)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=218,Data=(Type=SDT_Int32)))
   DefaultSettings(160)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=219,Data=(Type=SDT_Int32)))
   DefaultSettings(161)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=250,Data=(Type=SDT_Int32,Value1=1)))
   DefaultSettings(162)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=251,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(163)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=252,Data=(Type=SDT_Int32)))
   DefaultSettings(164)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=270,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(165)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=271,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(166)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=272,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(167)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=273,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(168)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=274,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(169)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=275,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(170)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=276,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(171)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=277,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(172)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=278,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(173)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=279,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(174)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=280,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(175)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=281,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(176)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=282,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(177)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=283,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(178)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=284,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(179)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=285,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(180)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=286,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(181)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=287,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(182)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=288,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(183)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=289,Data=(Type=SDT_Int32,Value1=-1)))
   DefaultSettings(184)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=299,Data=(Type=SDT_Int32)))
   DefaultSettings(185)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=802,Data=(Type=SDT_Int32)))
   DefaultSettings(186)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=803,Data=(Type=SDT_Int32)))
   DefaultSettings(187)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=804,Data=(Type=SDT_Int32)))
   DefaultSettings(188)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=806,Data=(Type=SDT_Int32)))
   DefaultSettings(189)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=807,Data=(Type=SDT_Int32)))
   DefaultSettings(190)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=808,Data=(Type=SDT_Int32)))
   DefaultSettings(191)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=810,Data=(Type=SDT_Int32)))
   DefaultSettings(192)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=811,Data=(Type=SDT_Int32)))
   DefaultSettings(193)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=812,Data=(Type=SDT_Int32)))
   DefaultSettings(194)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=813,Data=(Type=SDT_Int32)))
   DefaultSettings(195)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=814,Data=(Type=SDT_Int32)))
   DefaultSettings(196)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=815,Data=(Type=SDT_Int64)))
   DefaultSettings(197)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=816,Data=(Type=SDT_Int32)))
   DefaultSettings(198)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=817,Data=(Type=SDT_Int32)))
   DefaultSettings(199)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=818,Data=(Type=SDT_Int32)))
   DefaultSettings(200)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=819,Data=(Type=SDT_Int32)))
   DefaultSettings(201)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=820,Data=(Type=SDT_Int32)))
   DefaultSettings(202)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=822,Data=(Type=SDT_Int32)))
   DefaultSettings(203)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=823,Data=(Type=SDT_Int32)))
   DefaultSettings(204)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=824,Data=(Type=SDT_Int32)))
   DefaultSettings(205)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=825,Data=(Type=SDT_Int32)))
   DefaultSettings(206)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=826,Data=(Type=SDT_Int32)))
   DefaultSettings(207)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=827,Data=(Type=SDT_Int32)))
   DefaultSettings(208)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=828,Data=(Type=SDT_Int32)))
   DefaultSettings(209)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=829,Data=(Type=SDT_Int32)))
   DefaultSettings(210)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=840,Data=(Type=SDT_Int32)))
   DefaultSettings(211)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=841,Data=(Type=SDT_Int32)))
   DefaultSettings(212)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=842,Data=(Type=SDT_Int32)))
   DefaultSettings(213)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=844,Data=(Type=SDT_Int32)))
   DefaultSettings(214)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=845,Data=(Type=SDT_Int64)))
   DefaultSettings(215)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=846,Data=(Type=SDT_Int32)))
   DefaultSettings(216)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=834,Data=(Type=SDT_Int32)))
   DefaultSettings(217)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=847,Data=(Type=SDT_Int32)))
   DefaultSettings(218)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=809,Data=(Type=SDT_Int32)))
   DefaultSettings(219)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=805,Data=(Type=SDT_Int32)))
   DefaultSettings(220)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=843,Data=(Type=SDT_Int32)))
   DefaultSettings(221)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=801,Data=(Type=SDT_Int32)))
   DefaultSettings(222)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=821,Data=(Type=SDT_Int32)))
   DefaultSettings(223)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=830,Data=(Type=SDT_Int32)))
   DefaultSettings(224)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=831,Data=(Type=SDT_Int32)))
   DefaultSettings(225)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=832,Data=(Type=SDT_Int32)))
   DefaultSettings(226)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=833,Data=(Type=SDT_Int32)))
   DefaultSettings(227)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=835,Data=(Type=SDT_Int32)))
   DefaultSettings(228)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=836,Data=(Type=SDT_Int32)))
   DefaultSettings(229)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=837,Data=(Type=SDT_Int32)))
   DefaultSettings(230)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=838,Data=(Type=SDT_Int32)))
   DefaultSettings(231)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=839,Data=(Type=SDT_Int32)))
   DefaultSettings(232)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=848,Data=(Type=SDT_Int32)))
   DefaultSettings(233)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=849,Data=(Type=SDT_Int32)))
   DefaultSettings(234)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=850,Data=(Type=SDT_Int32)))
   DefaultSettings(235)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=851,Data=(Type=SDT_Int32)))
   DefaultSettings(236)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=852,Data=(Type=SDT_Int32)))
   DefaultSettings(237)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=853,Data=(Type=SDT_Int32)))
   DefaultSettings(238)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=854,Data=(Type=SDT_Int32)))
   DefaultSettings(239)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=855,Data=(Type=SDT_Int32)))
   DefaultSettings(240)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=856,Data=(Type=SDT_Int32)))
   DefaultSettings(241)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=857,Data=(Type=SDT_Int32)))
   DefaultSettings(242)=(Owner=OPPO_Game,ProfileSetting=(PropertyId=800,Data=(Type=SDT_Int64)))
   ProfileMappings(0)=(Name="ControllerVibration",ValueMappings=((Name="Spento"),(Name="Acceso")))
   ProfileMappings(1)=(Name="InvertY",ValueMappings=((Name="Spento"),(Name="Acceso")))
   ProfileMappings(2)=(Name="MuteVoice",ValueMappings=((Name="Spento"),(Name="Acceso")))
   ProfileMappings(3)=(Id=450,Name="ControllerSensitivityMultiplier",MappingType=PVMT_RawValue,ValueMappings=)
   ProfileMappings(4)=(Id=16,Name="AutoAim",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(5)=(Id=301,Name="CustomCharData",MappingType=PVMT_RawValue,ValueMappings=)
   ProfileMappings(6)=(Id=360,Name="SFXVolume",MappingType=PVMT_RawValue,ValueMappings=)
   ProfileMappings(7)=(Id=361,Name="MusicVolume",MappingType=PVMT_RawValue,ValueMappings=)
   ProfileMappings(8)=(Id=362,Name="VoiceVolume",MappingType=PVMT_RawValue,ValueMappings=)
   ProfileMappings(9)=(Id=363,Name="AnnouncerVolume",MappingType=PVMT_RawValue,ValueMappings=)
   ProfileMappings(10)=(Id=364,Name="AnnounceSetting",ValueMappings=((Name="Spento"),(Name="Minimale"),(Id=2,Name="Intero")))
   ProfileMappings(11)=(Id=365,Name="AutoTaunt",ValueMappings=((Name="Spento"),(Name="Acceso")))
   ProfileMappings(12)=(Id=366,Name="MessageBeep",ValueMappings=((Name="Spento"),(Name="Acceso")))
   ProfileMappings(13)=(Id=367,Name="TextToSpeechMode",ValueMappings=((Name="Nessuno"),(Name="Solo squadra"),(Name="Tutti")))
   ProfileMappings(14)=(Id=368,Name="AmbianceVolume",MappingType=PVMT_RawValue,ValueMappings=)
   ProfileMappings(15)=(Id=380,Name="Gamma",MappingType=PVMT_RawValue,ValueMappings=)
   ProfileMappings(16)=(Id=381,Name="PostProcessPreset",MappingType=PVMT_IdMapped,ValueMappings=((Id=1,Name="Muto"),(Name="Predefiniti"),(Id=2,Name="Vivido"),(Id=3,Name="Intenso")))
   ProfileMappings(17)=(Id=382,Name="ScreenResolutionX")
   ProfileMappings(18)=(Id=383,Name="ScreenResolutionY")
   ProfileMappings(19)=(Id=384,Name="DefaultFOV")
   ProfileMappings(20)=(Id=400,Name="ViewBob",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(21)=(Id=401,Name="GoreLevel",MappingType=PVMT_IdMapped,ValueMappings=((Name="Normale"),(Id=1,Name="Basso")))
   ProfileMappings(22)=(Id=402,Name="DodgingEnabled",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(23)=(Id=403,Name="WeaponSwitchOnPickup",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(24)=(Id=406,Name="NetworkConnection",MappingType=PVMT_IdMapped,ValueMappings=((Name="Sconosciuto"),(Id=1,Name="Modem"),(Id=2,Name="ISDN"),(Id=3,Name="Cable Modem"),(Id=4,Name="LAN")))
   ProfileMappings(25)=(Id=407,Name="DynamicNetspeed",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(26)=(Id=408,Name="SpeechRecognition",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(27)=(Id=420,Name="MouseSmoothing",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(28)=(Id=421,Name="ReduceMouseLag",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(29)=(Id=422,Name="EnableJoystick",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(30)=(Id=423,Name="MouseSensitivityGame")
   ProfileMappings(31)=(Id=424,Name="MouseSensitivityMenus")
   ProfileMappings(32)=(Id=425,Name="MouseSmoothingStrength")
   ProfileMappings(33)=(Id=426,Name="MouseAccelTreshold")
   ProfileMappings(34)=(Id=427,Name="DodgeDoubleClickTime")
   ProfileMappings(35)=(Id=428,Name="TurningAccelerationFactor")
   ProfileMappings(36)=(Id=420)
   ProfileMappings(37)=(Id=421)
   ProfileMappings(38)=(Id=422)
   ProfileMappings(39)=(Id=423)
   ProfileMappings(40)=(Id=424)
   ProfileMappings(41)=(Id=425)
   ProfileMappings(42)=(Id=426)
   ProfileMappings(43)=(Id=427)
   ProfileMappings(44)=(Id=428)
   ProfileMappings(45)=(Id=429,Name="GamepadBinding_ButtonA",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(46)=(Id=430,Name="GamepadBinding_ButtonB",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(47)=(Id=431,Name="GamepadBinding_ButtonX",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(48)=(Id=432,Name="GamepadBinding_ButtonY",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(49)=(Id=433,Name="GamepadBinding_Back",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(50)=(Id=434,Name="GamepadBinding_RightBumper",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(51)=(Id=435,Name="GamepadBinding_LeftBumper",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(52)=(Id=436,Name="GamepadBinding_RightTrigger",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(53)=(Id=437,Name="GamepadBinding_LeftTrigger",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(54)=(Id=438,Name="GamepadBinding_RightThumbstickPressed",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(55)=(Id=439,Name="GamepadBinding_LeftThumbstickPressed",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(56)=(Id=440,Name="GamepadBinding_DPadUp",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(57)=(Id=441,Name="GamepadBinding_DPadDown",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(58)=(Id=442,Name="GamepadBinding_DPadLeft",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(59)=(Id=443,Name="GamepadBinding_DPadRight",MappingType=PVMT_IdMapped,ValueMappings=((Name="Vuoto"),(Id=1,Name="Fuoco"),(Id=2,Name="Fuoco alternativo"),(Id=3,Name="Salta"),(Id=4,Name="Usa / Hoverboard"),(Id=5,Name="Scegli Melee"),(Id=6,Name="Mostra Punteggi"),(Id=7,Name="Mostra Mappa"),(Id=8,Name="Fingi Morte"),(Id=9,Name="Scegli Parlare"),(Id=38,Name="Menu voce"),(Id=10,Name="Scegli Minimappa"),(Id=11,Name="Selezionatore Arma"),(Id=12,Name="Prossima Arma"),(Id=13,Name="Arma Migliore"),(Id=14,Name="Arma Precedente")))
   ProfileMappings(60)=(Id=444,Name="GamepadBinding_AnalogStickPreset",MappingType=PVMT_IdMapped,ValueMappings=((Name="Predefiniti"),(Id=1,Name="Mancino"),(Id=2,Name="Legacy"),(Id=3,Name="Legacy Mancini")))
   ProfileMappings(61)=(Id=451,Name="AutoCenterPitch",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(62)=(Id=452,Name="AutoCenterVehiclePitch",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(63)=(Id=453,Name="TiltSensing",MappingType=PVMT_IdMapped,ValueMappings=((Name="Disabilitato"),(Id=1,Name="Attivato")))
   ProfileMappings(64)=(Id=460,Name="WeaponHand",MappingType=PVMT_IdMapped,ValueMappings=((Name="Destra"),(Id=1,Name="Sinistra"),(Id=3,Name="Nascosto")))
   ProfileMappings(65)=(Id=461,Name="SmallWeapons",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(66)=(Id=462,Name="DisplayWeaponBar",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(67)=(Id=463,Name="ShowOnlyAvailableWeapons",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(68)=(Id=464,Name="UTGame.UTWeap_RocketLauncher_Priority")
   ProfileMappings(69)=(Id=465,Name="UTGame.UTWeap_BioRifle_Priority")
   ProfileMappings(70)=(Id=466,Name="UTGame.UTWeap_FlakCannon_Priority")
   ProfileMappings(71)=(Id=467,Name="UTGame.UTWeap_SniperRifle_Priority")
   ProfileMappings(72)=(Id=468,Name="UTGame.UTWeap_LinkGun_Priority")
   ProfileMappings(73)=(Id=469,Name="UTGame.UTWeap_Enforcer_Priority")
   ProfileMappings(74)=(Id=470,Name="UTGame.UTWeap_ShockRifle_Priority")
   ProfileMappings(75)=(Id=471,Name="UTGame.UTWeap_Stinger_Priority")
   ProfileMappings(76)=(Id=472,Name="UTGameContent.UTWeap_Avril_Content")
   ProfileMappings(77)=(Id=473,Name="UTGameContent.UTWeap_Redeemer_Content")
   ProfileMappings(78)=(Id=480,Name="ShowMap",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(79)=(Id=481,Name="ShowClock",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(80)=(Id=482,Name="ShowDoll",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(81)=(Id=483,Name="ShowAmmo",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(82)=(Id=484,Name="ShowPowerups",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(83)=(Id=485,Name="ShowScoring",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(84)=(Id=486,Name="ShowLeaderboard",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(85)=(Id=487,Name="RotateMap",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(86)=(Id=488,Name="ShowVehicleArmorCount",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(87)=(Id=455,Name="EnableHardwarePhysics",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(88)=(Id=454,Name="VehicleControls",MappingType=PVMT_IdMapped,ValueMappings=((Name="Relativo"),(Id=1,Name="Mischiato"),(Id=2,Name="Diretto")))
   ProfileMappings(89)=(Id=410,Name="AllowCustomCharacters",MappingType=PVMT_IdMapped,ValueMappings=((Name="No"),(Id=1,Name="Sì")))
   ProfileMappings(90)=(Id=474,Name="CrosshairType",MappingType=PVMT_IdMapped,ValueMappings=((Name="Normale"),(Id=1,Name="Semplice"),(Id=2,Name="Nessuno")))
   ProfileMappings(91)=(Id=385,Name="Subtitles",MappingType=PVMT_IdMapped,ValueMappings=((Name="Disabilitato"),(Id=1,Name="Attivato")))
   ProfileMappings(92)=(Id=250,Name="SkillLevel",ValueMappings=((Name="Facile"),(Name="Normale"),(Name="Difficile"),(Name="Pazzo")))
   ProfileMappings(93)=(Id=700,Name="PopupMapOnDeath",MappingType=PVMT_IdMapped,ValueMappings=((Name="Spento"),(Id=1,Name="Acceso")))
   ProfileMappings(94)=(Id=412,Name="AlwaysLoadCustomCharacters",MappingType=PVMT_IdMapped,ValueMappings=((Name="No"),(Id=1,Name="Sì")))
   ProfileMappings(95)=(Id=299,Name="ChapterMask")
   ProfileMappings(96)=(Id=245,Name="MapMaskA")
   ProfileMappings(97)=(Id=246,Name="MapMaskB")
   ProfileMappings(98)=(Id=200,Name="PKey0")
   ProfileMappings(99)=(Id=201,Name="PKey1")
   ProfileMappings(100)=(Id=202,Name="PKey2")
   ProfileMappings(101)=(Id=203,Name="PKey3")
   ProfileMappings(102)=(Id=204,Name="PKey4")
   ProfileMappings(103)=(Id=205,Name="PKey5")
   ProfileMappings(104)=(Id=206,Name="PKey6")
   ProfileMappings(105)=(Id=207,Name="PKey7")
   ProfileMappings(106)=(Id=208,Name="PKey8")
   ProfileMappings(107)=(Id=209,Name="PKey9")
   ProfileMappings(108)=(Id=210,Name="PKey10")
   ProfileMappings(109)=(Id=211,Name="PKey11")
   ProfileMappings(110)=(Id=212,Name="PKey12")
   ProfileMappings(111)=(Id=213,Name="PKey13")
   ProfileMappings(112)=(Id=214,Name="PKey14")
   ProfileMappings(113)=(Id=215,Name="PKey15")
   ProfileMappings(114)=(Id=216,Name="PKey16")
   ProfileMappings(115)=(Id=217,Name="PKey17")
   ProfileMappings(116)=(Id=218,Name="PKey18")
   ProfileMappings(117)=(Id=219,Name="PKey19")
   ProfileMappings(118)=(Id=251,Name="CurrentMission")
   ProfileMappings(119)=(Id=252,Name="CurrentMissionResult")
   ProfileMappings(120)=(Id=302,Name="UnlockedCharacters")
   ProfileMappings(121)=(Id=404,Name="Alias")
   ProfileMappings(122)=(Id=405,Name="ClanTag")
   ProfileMappings(123)=(Id=409,Name="ServerDescription")
   ProfileMappings(124)=(Id=411,Name="FirstTimeMultiplayer")
   ProfileMappings(125)=(Id=501,Name="KeyAction_1")
   ProfileMappings(126)=(Id=502,Name="KeyAction_2")
   ProfileMappings(127)=(Id=503,Name="KeyAction_3")
   ProfileMappings(128)=(Id=504,Name="KeyAction_4")
   ProfileMappings(129)=(Id=505,Name="KeyAction_5")
   ProfileMappings(130)=(Id=506,Name="KeyAction_6")
   ProfileMappings(131)=(Id=507,Name="KeyAction_7")
   ProfileMappings(132)=(Id=508,Name="KeyAction_8")
   ProfileMappings(133)=(Id=509,Name="KeyAction_9")
   ProfileMappings(134)=(Id=510,Name="KeyAction_10")
   ProfileMappings(135)=(Id=511,Name="KeyAction_11")
   ProfileMappings(136)=(Id=512,Name="KeyAction_12")
   ProfileMappings(137)=(Id=513,Name="KeyAction_13")
   ProfileMappings(138)=(Id=514,Name="KeyAction_14")
   ProfileMappings(139)=(Id=515,Name="KeyAction_15")
   ProfileMappings(140)=(Id=516,Name="KeyAction_16")
   ProfileMappings(141)=(Id=517,Name="KeyAction_17")
   ProfileMappings(142)=(Id=518,Name="KeyAction_18")
   ProfileMappings(143)=(Id=519,Name="KeyAction_19")
   ProfileMappings(144)=(Id=520,Name="KeyAction_20")
   ProfileMappings(145)=(Id=521,Name="KeyAction_21")
   ProfileMappings(146)=(Id=522,Name="KeyAction_22")
   ProfileMappings(147)=(Id=523,Name="KeyAction_23")
   ProfileMappings(148)=(Id=524,Name="KeyAction_24")
   ProfileMappings(149)=(Id=525,Name="KeyAction_25")
   ProfileMappings(150)=(Id=526,Name="KeyAction_26")
   ProfileMappings(151)=(Id=527,Name="KeyAction_27")
   ProfileMappings(152)=(Id=528,Name="KeyAction_28")
   ProfileMappings(153)=(Id=529,Name="KeyAction_29")
   ProfileMappings(154)=(Id=530,Name="KeyAction_30")
   ProfileMappings(155)=(Id=531,Name="KeyAction_31")
   ProfileMappings(156)=(Id=532,Name="KeyAction_32")
   ProfileMappings(157)=(Id=533,Name="KeyAction_33")
   ProfileMappings(158)=(Id=534,Name="KeyAction_34")
   ProfileMappings(159)=(Id=535,Name="KeyAction_35")
   ProfileMappings(160)=(Id=536,Name="KeyAction_36")
   ProfileMappings(161)=(Id=537,Name="KeyAction_37")
   ProfileMappings(162)=(Id=538,Name="KeyAction_38")
   ProfileMappings(163)=(Id=539,Name="KeyAction_39")
   ProfileMappings(164)=(Id=540,Name="KeyAction_40")
   ProfileMappings(165)=(Id=541,Name="KeyAction_41")
   ProfileMappings(166)=(Id=542,Name="KeyAction_42")
   ProfileMappings(167)=(Id=543,Name="KeyAction_43")
   ProfileMappings(168)=(Id=544,Name="KeyAction_44")
   ProfileMappings(169)=(Id=545,Name="KeyAction_45")
   ProfileMappings(170)=(Id=546,Name="KeyAction_46")
   ProfileMappings(171)=(Id=547,Name="KeyAction_47")
   ProfileMappings(172)=(Id=548,Name="KeyAction_48")
   ProfileMappings(173)=(Id=549,Name="KeyAction_49")
   ProfileMappings(174)=(Id=270,Name="ModifierCardDeck0")
   ProfileMappings(175)=(Id=271,Name="ModifierCardDeck0")
   ProfileMappings(176)=(Id=272,Name="ModifierCardDeck0")
   ProfileMappings(177)=(Id=273,Name="ModifierCardDeck0")
   ProfileMappings(178)=(Id=274,Name="ModifierCardDeck0")
   ProfileMappings(179)=(Id=275,Name="ModifierCardDeck0")
   ProfileMappings(180)=(Id=276,Name="ModifierCardDeck0")
   ProfileMappings(181)=(Id=277,Name="ModifierCardDeck0")
   ProfileMappings(182)=(Id=278,Name="ModifierCardDeck0")
   ProfileMappings(183)=(Id=279,Name="ModifierCardDeck0")
   ProfileMappings(184)=(Id=280,Name="ModifierCardDeck0")
   ProfileMappings(185)=(Id=281,Name="ModifierCardDeck0")
   ProfileMappings(186)=(Id=282,Name="ModifierCardDeck0")
   ProfileMappings(187)=(Id=283,Name="ModifierCardDeck0")
   ProfileMappings(188)=(Id=284,Name="ModifierCardDeck0")
   ProfileMappings(189)=(Id=285,Name="ModifierCardDeck0")
   ProfileMappings(190)=(Id=286,Name="ModifierCardDeck0")
   ProfileMappings(191)=(Id=287,Name="ModifierCardDeck0")
   ProfileMappings(192)=(Id=288,Name="ModifierCardDeck0")
   ProfileMappings(193)=(Id=289,Name="ModifierCardDeck0")
   ProfileMappings(194)=(Id=802,Name="SignTreaty")
   ProfileMappings(195)=(Id=803,Name="LiandriMainframe")
   ProfileMappings(196)=(Id=804,Name="ReachOmicron")
   ProfileMappings(197)=(Id=806,Name="SignTreaty")
   ProfileMappings(198)=(Id=807,Name="LiandriMainframeExpert")
   ProfileMappings(199)=(Id=808,Name="ReachOmicronExpert")
   ProfileMappings(200)=(Id=810,Name="Complete1")
   ProfileMappings(201)=(Id=811,Name="Complete10")
   ProfileMappings(202)=(Id=812,Name="CompleteCampaign")
   ProfileMappings(203)=(Id=813,Name="EveryGameMod")
   ProfileMappings(204)=(Id=814,Name="Untouchable")
   ProfileMappings(205)=(Id=815,Name="AllPowerups")
   ProfileMappings(206)=(Id=816,Name="EveryMutator")
   ProfileMappings(207)=(Id=817,Name="BrainSurgeon")
   ProfileMappings(208)=(Id=818,Name="DontTaseMeBro")
   ProfileMappings(209)=(Id=819,Name="GooGod")
   ProfileMappings(210)=(Id=820,Name="Pistolero")
   ProfileMappings(211)=(Id=822,Name="Hammerhead")
   ProfileMappings(212)=(Id=823,Name="StrongestLink")
   ProfileMappings(213)=(Id=824,Name="HaveANiceDay")
   ProfileMappings(214)=(Id=825,Name="BigGameHunter")
   ProfileMappings(215)=(Id=826,Name="Armadillo")
   ProfileMappings(216)=(Id=827,Name="JackOfAllTrades")
   ProfileMappings(217)=(Id=828,Name="Ace")
   ProfileMappings(218)=(Id=829,Name="Deathwish")
   ProfileMappings(219)=(Id=840,Name="SerialKiller")
   ProfileMappings(220)=(Id=841,Name="SirSlaysALot")
   ProfileMappings(221)=(Id=842,Name="KillJoy")
   ProfileMappings(222)=(Id=844,Name="GetItOn")
   ProfileMappings(223)=(Id=845,Name="AroundTheWorld")
   ProfileMappings(224)=(Id=846,Name="GetALife")
   ProfileMappings(225)=(Id=834,Name="HatTrick")
   ProfileMappings(226)=(Id=847,Name="BloodSweatTears")
   ProfileMappings(227)=(Id=809,Name="DefeatAkashaExpert")
   ProfileMappings(228)=(Id=805,Name="DefeatAkasha")
   ProfileMappings(229)=(Id=843,Name="OffToAGoodStart")
   ProfileMappings(230)=(Id=801,Name="Chapter1")
   ProfileMappings(231)=(Id=821,Name="ShardOMatic")
   ProfileMappings(232)=(Id=830,Name="SeeingRed")
   ProfileMappings(233)=(Id=831,Name="NeverSawItComing")
   ProfileMappings(234)=(Id=832,Name="SurvivalFittest")
   ProfileMappings(235)=(Id=833,Name="DeliveringTheHurt")
   ProfileMappings(236)=(Id=835,Name="BeingAHero")
   ProfileMappings(237)=(Id=836,Name="FlagWaver")
   ProfileMappings(238)=(Id=837,Name="30MinOrLess")
   ProfileMappings(239)=(Id=838,Name="PaintTownRed")
   ProfileMappings(240)=(Id=839,Name="ConnectTheDots")
   ProfileMappings(241)=(Id=848,Name="CantBeTrusted")
   ProfileMappings(242)=(Id=849,Name="Avenger")
   ProfileMappings(243)=(Id=850,Name="BagOfBones")
   ProfileMappings(244)=(Id=851,Name="SkullCollector")
   ProfileMappings(245)=(Id=852,Name="Titanic")
   ProfileMappings(246)=(Id=853,Name="Behemoth")
   ProfileMappings(247)=(Id=854,Name="Unholy")
   ProfileMappings(248)=(Id=855,Name="TheSlowLane")
   ProfileMappings(249)=(Id=856,Name="Eradication")
   ProfileMappings(250)=(Id=857,Name="Arachnophobia")
   ProfileMappings(251)=(Id=800,Name="BitMask")
   Name="Default__UTProfileSettings"
   ObjectArchetype=OnlineProfileSettings'Engine.Default__OnlineProfileSettings'
}
