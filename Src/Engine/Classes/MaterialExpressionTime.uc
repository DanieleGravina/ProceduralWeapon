/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class MaterialExpressionTime extends MaterialExpression
	native(Material)
	collapsecategories
	hidecategories(Object);

/** This time continues advancing regardless of whether the game is paused. */
var() bool bIgnorePause;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Name="Default__MaterialExpressionTime"
   ObjectArchetype=MaterialExpression'Engine.Default__MaterialExpression'
}
