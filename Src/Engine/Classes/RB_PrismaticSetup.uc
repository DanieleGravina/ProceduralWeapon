/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class RB_PrismaticSetup extends RB_ConstraintSetup
	native(Physics);

defaultproperties
{
   LinearXSetup=(bLimited=0)
   bSwingLimited=True
   bTwistLimited=True
   Name="Default__RB_PrismaticSetup"
   ObjectArchetype=RB_ConstraintSetup'Engine.Default__RB_ConstraintSetup'
}
