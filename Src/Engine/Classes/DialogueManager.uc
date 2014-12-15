/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DialogueManager extends Actor;

function bool TriggerDialogueEvent( class<SequenceEvent> InEventClass, Actor InInstigator, Actor InOriginator );

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   TickGroup=TG_DuringAsyncWork
   CollisionType=COLLIDE_CustomDefault
   Name="Default__DialogueManager"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
