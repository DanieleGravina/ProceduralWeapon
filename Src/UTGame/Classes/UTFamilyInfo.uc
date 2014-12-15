/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 * Structure defining information about a particular 'family' (eg. Ironguard Male)
 */

class UTFamilyInfo extends Object
	native
	abstract;

/** Matches the FamilyID in the CustomCharData */
var string FamilyID;

/** Faction that this family belongs to. */
var string Faction;

/** Mesh to use for first person weapon */
//var SkeletalMesh ArmMesh;

/** Package to load to find the arm mesh for this char. */
var string	ArmMeshPackageName;
/** Name of mesh within ArmMeshPackageName to use for arms. */
var string	ArmMeshName;
/** Package that contains team-skin materials for first-person arms. */
var		string				ArmSkinPackageName;
/** Name of red team material for first-person arms. */
var		string				RedArmSkinName;
/** Name of blue team material for first-person arms. */
var		string				BlueArmSkinName;
/** Name of 'neck stump' mesh to use if head is enclosed by helmet. */
var		string				NeckStumpName;
/** Extra offset to apply to mesh when rendering portrait for this family. */
var		vector				PortraitExtraOffset;

/** Physics Asset to use  */
var PhysicsAsset		PhysAsset;

/** Animation sets to use for a character in this 'family' */
var	array<AnimSet>		AnimSets;

/** Names for specific bones in the skeleton */
var name LeftFootBone;
var name RightFootBone;
var array<name> TakeHitPhysicsFixedBones;

var class<UTPawnSoundGroup> SoundGroupClass;

var class<UTVoice> VoiceClass;

var MaterialInstanceConstant	BaseMICParent;
var MaterialInstanceConstant	BioDeathMICParent;

/** This is the blood splatter effect to use on the walls when this pawn is shot @see LeaveABloodSplatterDecal **/
var MaterialInstance BloodSplatterDecalMaterial;

/** Contains all bones used by this family - used for animating character on creation screen. */
var	SkeletalMesh				MasterSkeleton;

/** Idle animation to use in character editor screen. */
var name						CharEditorIdleAnimName;

/** When not in a team game, this is the color to use for glowy bits. */
var	LinearColor					NonTeamEmissiveColor;

/** When not in a team game, this is the color to tint character at a distance. */
var LinearColor					NonTeamTintColor;

/** When creating this custom char, number of LODs to strip from the source parts. */
var int							MergeLODsToStrip;

/** Structure containing information about a specific emote */
struct native EmoteInfo
{
	/** Category to which this emote belongs. */
	var name		CategoryName;
	/** This is a unique tag used to look up this emote */
	var name		EmoteTag;
	/** Friendly name of this emote (eg for menu) */
	var localized string		EmoteName;
	/** Name of animation to play. Should be in AnimSets above. */
	var name		EmoteAnim;
	/** Indicates that this is a whole body 'victory' emote which should only be offered at the end of the game. */
	var bool		bVictoryEmote;
	/** Emote should only be played on top half of body. */
	var bool		bTopHalfEmote;
	/** The command that goes with this emote */
	var name  		Command;
	/** if true, the command requires a PRI */
	var bool		bRequiresPlayer;
};

/** Set of all emotes for this family. */
var array<EmoteInfo>	FamilyEmotes;

//// Gibs

/** information on what gibs to spawn and where */
struct native GibInfo
{
	/** the bone to spawn the gib at */
	var name BoneName;
	/** the gib class to spawn */
	var class<UTGib> GibClass;
	var bool bHighDetailOnly;
};
var array<GibInfo> Gibs;

/** Head gib */
var GibInfo HeadGib;


// NOTE:  this can probably be moved to the DamageType.  As the damage type is probably not going to have different types of mesh per race (???)
/** This is the skeleton skel mesh that will replace the character's mesh for various death effects **/
var SkeletalMesh DeathMeshSkelMesh;
var PhysicsAsset DeathMeshPhysAsset;

/** This is the number of materials on the DeathSkeleton **/
var int DeathMeshNumMaterialsToSetResident;

/** Which joints we can break when applying damage **/
var array<Name> DeathMeshBreakableJoints;

/** These are the materials that the skeleton for this race uses (i.e. some of them have more than one material **/
var array<MaterialInstanceTimeVarying> SkeletonBurnOutMaterials;


/** The visual effect to play when a headshot gibs a head. */
var ParticleSystem HeadShotEffect;

/** Name of the HeadShotGoreSocket **/
var name HeadShotGoreSocketName;

/** 
 * This is attached to the HeadShotGoreSocket on the pawn if there exists one.  Some pawns do no need to have this as their mesh already
 * has gore pieces.  But some do not.
 **/
var StaticMesh HeadShotNeckGoreAttachment;


var class<UTEmit_HitEffect> BloodEmitterClass;
/** Hit impact effects.  Sprays when you get shot **/
var array<DistanceBasedParticleTemplate> BloodEffects;

/** When you are gibbed this is the particle effect to play **/
var ParticleSystem GibExplosionTemplate;

/** scale for meshes in this family when driving a vehicle */
var float DrivingDrawScale;

/** Whether these are female characters */
var bool bIsFemale;

/** Mesh scaling */
var float DefaultMeshScale;
var float BaseTranslationOffset;

/** death camera blood effect */
var class<UTEmitCameraEffect> DeathCameraEffect;

/** Camera offsets for Hero */
var float ExtraCameraZOffset;
var float CameraXOffset, CameraYOffset;
var float MinCameraDistSq;

/** Projectile offsets for Hero */
var vector HeroFireOffset;
var vector SuperHeroFireOffset;

/** AnimSet for this family's Hero Melee attack */
var AnimSet HeroMeleeAnimSet;

/** How likely bot associated with this family is to betray teammates */
var float TrustWorthiness;

/**
 * Returns the # of emotes in a given group
 */
function static int GetEmoteGroupCnt(name Category)
{
	local int i,cnt;
	for (i=0;i<default.FamilyEmotes.length;i++)
	{
		if (default.FamilyEmotes[i].CategoryName == Category )
		{
			cnt++;
		}
	}

	return cnt;
}

static function class<UTVoice> GetVoiceClass(CustomCharData CharacterData)
{
	return Default.VoiceClass;
}

/**
 * returns all the Emotes in a group
 */
function static GetEmotes(name Category, out array<string> Captions, out array<name> EmoteTags)
{
	local int i;
	local int cnt;
	for (i=0;i<default.FamilyEmotes.length;i++)
	{
		if (default.FamilyEmotes[i].CategoryName == Category )
		{
			Captions[cnt] = default.FamilyEmotes[i].EmoteName;
			EmoteTags[cnt] = default.FamilyEmotes[i].EmoteTag;
			cnt++;
		}
	}
}

/**
 * Finds the index of the emote given a tag
 */

function static int GetEmoteIndex(name EmoteTag)
{
	local int i;
	for (i=0;i<default.FamilyEmotes.length;i++)
	{
		if ( default.FamilyEmotes[i].EmoteTag == EmoteTag )
		{
			return i;
		}
	}
	return -1;
}

defaultproperties
{
   LeftFootBone="b_LeftAnkle"
   RightFootBone="b_RightAnkle"
   TakeHitPhysicsFixedBones(0)="b_LeftAnkle"
   TakeHitPhysicsFixedBones(1)="b_RightAnkle"
   SoundGroupClass=Class'UTGame.UTPawnSoundGroup'
   VoiceClass=Class'UTGame.UTVoice_DefaultMale'
   BloodSplatterDecalMaterial=MaterialInstanceTimeVarying'T_FX.DecalMaterials.MITV_FX_BloodDecal_Small01'
   NonTeamEmissiveColor=(R=10.000000,G=0.200000,B=0.200000,A=1.000000)
   NonTeamTintColor=(R=4.000000,G=2.000000,B=0.500000,A=1.000000)
   MergeLODsToStrip=1
   FamilyEmotes(0)=(CategoryName="Taunt",EmoteTag="TauntA",EmoteName="Fatti sotto",EmoteAnim="Taunt_FB_BringItOn")
   FamilyEmotes(1)=(CategoryName="Taunt",EmoteTag="TauntB",EmoteName="Hula hoop",EmoteAnim="Taunt_FB_Hoolahoop")
   FamilyEmotes(2)=(CategoryName="Taunt",EmoteTag="TauntC",EmoteName="Ancheggiare ",EmoteAnim="Taunt_FB_Pelvic_Thrust_A")
   FamilyEmotes(3)=(CategoryName="Taunt",EmoteTag="TauntD",EmoteName="Colpo alla testa",EmoteAnim="Taunt_UB_BulletToTheHead",bTopHalfEmote=True)
   FamilyEmotes(4)=(CategoryName="Taunt",EmoteTag="TauntE",EmoteName="Vieni qui",EmoteAnim="Taunt_UB_ComeHere",bTopHalfEmote=True)
   FamilyEmotes(5)=(CategoryName="Taunt",EmoteTag="TauntF",EmoteName="Taglio alla gola",EmoteAnim="Taunt_UB_Slit_Throat",bTopHalfEmote=True)
   FamilyEmotes(6)=(CategoryName="Order",EmoteTag="OrderA",EmoteName="Attacca la base",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True,Command="ATTACK",bRequiresPlayer=True)
   FamilyEmotes(7)=(CategoryName="Order",EmoteTag="OrderB",EmoteName="Difendi la base",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True,Command="Defend",bRequiresPlayer=True)
   FamilyEmotes(8)=(CategoryName="Order",EmoteTag="OrderC",EmoteName="Aspetta in questa posizione",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True,Command="Hold",bRequiresPlayer=True)
   FamilyEmotes(9)=(CategoryName="Order",EmoteTag="OrderD",EmoteName="Coprimi",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True,Command="Follow",bRequiresPlayer=True)
   FamilyEmotes(10)=(CategoryName="Order",EmoteTag="OrderE",EmoteName="Da solo",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True,Command="Freelance",bRequiresPlayer=True)
   FamilyEmotes(11)=(CategoryName="Order",EmoteTag="OrderF",EmoteName="Goccia di bandiera",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True,Command="DropFlag")
   FamilyEmotes(12)=(CategoryName="UnusedOrder",EmoteTag="OrderG",EmoteName="Lasciare l'orbe",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True,Command="DropOrb")
   FamilyEmotes(13)=(CategoryName="SpecialMove",EmoteTag="MeleeA",EmoteAnim="GroundPound_A")
   FamilyEmotes(14)=(CategoryName="Status",EmoteTag="ENCOURAGEMENT",EmoteName="Incoraggiamento",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True)
   FamilyEmotes(15)=(CategoryName="Status",EmoteTag="ACK",EmoteName="Ricevuto",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True)
   FamilyEmotes(16)=(CategoryName="Status",EmoteTag="InPosition",EmoteName="In posizione",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True)
   FamilyEmotes(17)=(CategoryName="Status",EmoteTag="UnderAttack",EmoteName="Sotto attacco",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True)
   FamilyEmotes(18)=(CategoryName="Status",EmoteTag="AreaSecure",EmoteName="Area sicura",EmoteAnim="Taunt_UB_Flag_Pickup",bTopHalfEmote=True)
   HeadShotEffect=ParticleSystem'T_FX.Effects.P_FX_HeadShot'
   HeadShotGoreSocketName="HeadShotGoreSocket"
   HeadShotNeckGoreAttachment=StaticMesh'CH_Gore.S_CH_Headshot_Gore'
   BloodEmitterClass=Class'UTGame.UTEmit_BloodSpray'
   BloodEffects(0)=(Template=ParticleSystem'T_FX.Effects.P_FX_Bloodhit_01_Far',MinDistance=750.000000)
   BloodEffects(1)=(Template=ParticleSystem'T_FX.Effects.P_FX_Bloodhit_01_Mid',MinDistance=350.000000)
   BloodEffects(2)=(Template=ParticleSystem'T_FX.Effects.P_FX_Bloodhit_01_Near')
   GibExplosionTemplate=ParticleSystem'T_FX.Effects.P_FX_GibExplode'
   DrivingDrawScale=1.000000
   DefaultMeshScale=1.075000
   BaseTranslationOffset=7.000000
   DeathCameraEffect=Class'UTGame.UTEmitCameraEffect_BloodSplatter'
   ExtraCameraZOffset=-10.000000
   CameraXOffset=0.200000
   CameraYOffset=-1.000000
   MinCameraDistSq=1.000000
   HeroFireOffset=(X=180.000000,Y=-10.000000,Z=-20.000000)
   SuperHeroFireOffset=(X=380.000000,Y=-10.000000,Z=-30.000000)
   HeroMeleeAnimSet=AnimSet'CH_AnimHuman_Hero.Anims.K_AnimHuman_Hero'
   Name="Default__UTFamilyInfo"
   ObjectArchetype=Object'Core.Default__Object'
}
