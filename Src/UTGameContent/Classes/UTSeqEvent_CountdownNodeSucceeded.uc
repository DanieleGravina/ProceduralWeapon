class UTSeqEvent_CountdownNodeSucceeded extends SequenceEvent;

var() UTOnslaughtPowerCore ControllingCore;

event Activated()
{
	local UTOnslaughtCountdownNode CountdownNode;

	CountdownNode = UTOnslaughtCountdownNode(Originator);
	if (CountdownNode != None)
	{
		ControllingCore = UTOnslaughtGame(CountdownNode.WorldInfo.Game).PowerCore[CountdownNode.GetTeamNum()];
	}
	else
	{
		ScriptLog("CountdownNodeSucceeded not connected to CountdownNode!");
	}
}

defaultproperties
{
   MaxTriggerCount=0
   bPlayerOnly=False
   VariableLinks(0)=(LinkDesc="Node Team's PowerCore",PropertyName="ControllingCore")
   ObjName="Countdown Node Succeeded"
   ObjCategory="Objective"
   Name="Default__UTSeqEvent_CountdownNodeSucceeded"
   ObjectArchetype=SequenceEvent'Engine.Default__SequenceEvent'
}
