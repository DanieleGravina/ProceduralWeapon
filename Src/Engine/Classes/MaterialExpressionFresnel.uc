/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * Allows the artists to quickly set up a Fresnel term. Returns:
 *
 *		pow(1 - max(Normal dot Camera,0),Exponent)
 */
class MaterialExpressionFresnel extends MaterialExpression
	native(Material)
	collapsecategories
	hidecategories(Object);

/** The exponent to pass into the pow() function */
var() float Exponent;

/** The normal to dot with the camera vector */
var ExpressionInput	Normal;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Exponent=3.000000
   Name="Default__MaterialExpressionFresnel"
   ObjectArchetype=MaterialExpression'Engine.Default__MaterialExpression'
}
