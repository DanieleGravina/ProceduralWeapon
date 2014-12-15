/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTPowerNodePanel extends UTPowerCorePanel_Content;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=GibMesh ObjName=GibMesh Archetype=StaticMeshComponent'UTGameContent.Default__UTPowerCorePanel_Content:GibMesh'
      Scale=0.400000
      ObjectArchetype=StaticMeshComponent'UTGameContent.Default__UTPowerCorePanel_Content:GibMesh'
   End Object
   Mesh=GibMesh
   Begin Object Class=DynamicLightEnvironmentComponent Name=PanelLightEnvironmentComp ObjName=PanelLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTPowerCorePanel_Content:PanelLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTPowerCorePanel_Content:PanelLightEnvironmentComp'
   End Object
   Components(0)=PanelLightEnvironmentComp
   Components(1)=GibMesh
   CollisionComponent=GibMesh
   Name="Default__UTPowerNodePanel"
   ObjectArchetype=UTPowerCorePanel_Content'UTGameContent.Default__UTPowerCorePanel_Content'
}
