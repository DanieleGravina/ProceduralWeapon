/** this class is used for status announcements related to UTOnslaughtCountdownNodes */
class UTCountdownNodeMessage extends UTObjectiveSpecificMessage
	dependson(UTPlayerController);

static function ObjectiveAnnouncementInfo GetObjectiveAnnouncement(byte MessageIndex, Object Objective, PlayerController PC)
{
	local UTOnslaughtCountdownNode Node;
	local array<ObjectiveAnnouncementInfo> AnnouncementList;
	local ObjectiveAnnouncementInfo EmptyAnnouncement;
	local int TeamIndex;

	Node = UTOnslaughtCountdownNode(Objective);
	if (Node != None)
	{
		TeamIndex = MessageIndex % 10;
		MessageIndex /= 10;
		switch (MessageIndex)
		{
			case 0:
				AnnouncementList = Node.BuiltAnnouncements;
				break;
			case 1:
				AnnouncementList = Node.HalfTimeAnnouncements;
				break;
			case 2:
				AnnouncementList = Node.TenSecondsLeftAnnouncements;
				break;
			case 3:
				AnnouncementList = Node.SuccessAnnouncements;
				break;
			case 4:
				AnnouncementList = Node.DestroyedAnnouncements;
				break;
			default:
				WarnInternal("Invalid MessageIndex" @ MessageIndex);
				break;
		}

		if (AnnouncementList.length == 1)
		{
			return AnnouncementList[0];
		}
		else if (TeamIndex < AnnouncementList.length)
		{
			return AnnouncementList[TeamIndex];
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
   Lifetime=2.500000
   DrawColor=(B=255,G=160,R=0,A=255)
   FontSize=1
   Name="Default__UTCountdownNodeMessage"
   ObjectArchetype=UTObjectiveSpecificMessage'UTGame.Default__UTObjectiveSpecificMessage'
}
