/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTCTFGame_Content extends UTCTFGame;

defaultproperties
{
   AnnouncerMessageClass=Class'UTGameContent.UTCTFMessage'
   TeamScoreMessageClass=Class'UTGameContent.UTTeamScoreMessage'
   TranslocatorClass=Class'UTGameContent.UTWeap_Translocator_Content'
   HUDType=Class'UTGame.UTCTFHUD'
   Name="Default__UTCTFGame_Content"
   ObjectArchetype=UTCTFGame'UTGame.Default__UTCTFGame'
}
