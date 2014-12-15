/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTGameModifierCard extends Object;

struct EModiferCardData
{
	// The Tag by which you reference this card
	var name Tag;

	// The ProfileID that will be used to reference this card
	var int  ProfileID;

	// This card will add the following URL to the launch line
	var string URL;

	// Holds UI markup that points to the localized description for this card
	var string DescMarkup;

	// If true, this card must be used in the next round
	var bool bMustUse;

	// If true you can only have 1 of these cards in your deck at one time
	var bool bUnique;

	// An Index used to look up the card in a list of images
	var int ImageListIndex;

	// The UV coordinates of the card's image
	var TextureCoordinates UVs;

	var TextureCoordinates AltUVs;

	var ESinglePlayerPersistentKeys AltKey;

};

var array<EModiferCardData> Deck;


static function Name GetNameForProfileID(int ProfileID)
{
	local int i;
	for (i=0;i<Default.Deck.Length; i++)
	{
		if ( default.Deck[i].ProfileId == ProfileID )
		{
			return default.Deck[i].Tag;
		}
	}
	return '';
}


/** Get any additionals to the URL from this card */
static function string GetURL(name Tag)
{
	local int i;
	for (i=0;i<Default.Deck.Length; i++)
	{
		if ( default.Deck[i].Tag == Tag )
		{
			return default.Deck[i].URL;
		}
	}
	return "";
}

static function ESinglePlayerPersistentKeys GetAltKey(name Tag)
{
	local int i;
	for (i=0;i<Default.Deck.Length; i++)
	{
		if ( default.Deck[i].Tag == Tag )
		{
			return default.Deck[i].AltKey;
		}
	}
	return ESPKey_None;
}

static function int GetProfileIndexFor(name Tag)
{
	local int i;
	for (i=0;i<Default.Deck.Length; i++)
	{
		if ( default.Deck[i].Tag == Tag )
		{
			return default.Deck[i].ProfileID;
		}
	}
	return INDEX_None;
}

static function TextureCoordinates GetUVs(name Tag, UTProfileSettings Profile)
{
	local int i;
	local TextureCoordinates UV;
	for ( i=0;i<Default.Deck.Length; i++)
	{
		if ( default.Deck[i].Tag == Tag )
		{
			if ( Profile.HasPersistentKey(default.Deck[i].AltKey) )
			{
				return default.deck[i].ALtUVs;
			}
			else
			{
				return default.Deck[i].UVs;
			}
		}
	}
	return UV;
}

static function string GetDesc(name Tag)
{
	local int i;
	for ( i=0;i<Default.Deck.Length; i++)
	{
		if ( default.Deck[i].Tag == Tag )
		{
			return default.Deck[i].DescMarkup;
		}
	}
	return "";
}

static function bool IsUnique(name Tag)
{
	local int i;
	for ( i=0;i<Default.Deck.Length; i++)
	{
		if ( default.Deck[i].Tag == Tag )
		{
			return default.Deck[i].bUnique;
		}
	}
	return false;
}

static function bool IsMustUse(name Tag)
{
	local int i;
	for ( i=0;i<Default.Deck.Length; i++)
	{
		if ( default.Deck[i].Tag == Tag )
		{
			return default.Deck[i].bMustUse;
		}
	}
	return false;
}

defaultproperties
{
   Deck(0)=(Tag="TacticalDiversion",DescMarkup="<Strings:UTGameUI.CardDesc.Desc0>",UVs=(U=398.000000,V=1.000000,UL=198.000000,VL=252.000000))
   Deck(1)=(Tag="IronGuard",ProfileId=1,DescMarkup="<Strings:UTGameUI.CardDesc.Desc1>",UVs=(U=1.000000,V=1.000000,UL=198.000000,VL=252.000000),AltUVs=(U=200.000000,V=253.000000,UL=198.000000,VL=252.000000),AltKey=ESPKey_IronGuardUpgrade)
   Deck(2)=(Tag="Liandri",ProfileId=2,DescMarkup="<Strings:UTGameUI.CardDesc.Desc2>",UVs=(U=596.000000,V=1.000000,UL=198.000000,VL=252.000000),AltUVs=(U=398.000000,V=253.000000,UL=198.000000,VL=252.000000),AltKey=ESPKey_LiandriUpgrade)
   Deck(3)=(Tag="RespawnUpgrade",ProfileId=3,URL="?CoolSpawn=1",DescMarkup="<Strings:UTGameUI.CardDesc.Desc3>",UVs=(U=2.000000,V=253.000000,UL=198.000000,VL=252.000000))
   Deck(4)=(Tag="HeavyArmor",ProfileId=4,URL="?HeavyArmor=1",DescMarkup="<Strings:UTGameUI.CardDesc.Desc4>",UVs=(U=200.000000,V=1.000000,UL=198.000000,VL=252.000000))
   Deck(5)=(Tag="InstaGib",ProfileId=5,URL="?Mutator=UTGame.UTMutator_Instagib",DescMarkup="<Strings:UTGameUI.CardDesc.Desc5>",bMustUse=True,bUnique=True,UVs=(U=398.000000,V=1.000000,UL=198.000000,VL=252.000000))
   Name="Default__UTGameModifierCard"
   ObjectArchetype=Object'Core.Default__Object'
}
