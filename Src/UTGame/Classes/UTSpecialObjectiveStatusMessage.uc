/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** this class is used for status announcements related to UTOnslaughtSpecialObjectives */
class UTSpecialObjectiveStatusMessage extends UTObjectiveSpecificMessage
	dependson(UTPlayerController);

static function ObjectiveAnnouncementInfo GetObjectiveAnnouncement(byte MessageIndex, Object Objective, PlayerController PC)
{
	local UTOnslaughtSpecialObjective SpecialObjective;
	local ObjectiveAnnouncementInfo EmptyAnnouncement;

	SpecialObjective = UTOnslaughtSpecialObjective(Objective);
	if (SpecialObjective != None)
	{
		switch (MessageIndex)
		{
			case 0:
				return SpecialObjective.UnderAttackAnnouncement;
			case 1:
				return SpecialObjective.DisabledAnnouncement;
			default:
				WarnInternal("Invalid MessageIndex" @ MessageIndex);
				break;
		}
	}

	return EmptyAnnouncement;
}

static function byte AnnouncementLevel(byte MessageIndex)
{
	return 2;
}

defaultproperties
{
   bIsConsoleMessage=True
   Lifetime=2.500000
   DrawColor=(B=255,G=160,R=0,A=255)
   FontSize=2
   Name="Default__UTSpecialObjectiveStatusMessage"
   ObjectArchetype=UTObjectiveSpecificMessage'UTGame.Default__UTObjectiveSpecificMessage'
}
