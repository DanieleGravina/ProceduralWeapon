/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class RB_StayUprightSetup extends RB_ConstraintSetup
    native(Physics);

defaultproperties
{
   LinearXSetup=(bLimited=0)
   LinearYSetup=(bLimited=0)
   LinearZSetup=(bLimited=0)
   bLinearLimitSoft=True
   bSwingLimited=True
   bSwingLimitSoft=True
   Name="Default__RB_StayUprightSetup"
   ObjectArchetype=RB_ConstraintSetup'Engine.Default__RB_ConstraintSetup'
}
