//=============================================================================
// PlayerInput
// Object within playercontroller that manages player input.
// only spawned on client
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================

class PlayerInput extends Input within PlayerController
	config(Input)
	transient
	native(UserInterface);

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

/** Player is giving input through a gamepad */
var	const bool	bUsingGamepad;
var const Name	LastAxisKeyName;

var globalconfig	bool		bInvertMouse;							/** if true, mouse y axis is inverted from normal FPS mode */
var globalconfig	bool		bInvertTurn;							/** if true, mouse x axis is inverted from normal FPS mode */

// Double click move flags
var					bool		bWasForward;
var					bool		bWasBack;
var					bool		bWasLeft;
var					bool		bWasRight;
var					bool		bEdgeForward;
var					bool		bEdgeBack;
var					bool		bEdgeLeft;
var					bool 		bEdgeRight;

var					float		DoubleClickTimer;						/** max double click interval for double click move */
var globalconfig	float		DoubleClickTime;						/** stores time of first click for potential double click */

var globalconfig	float		MouseSensitivity;

// Input axes.
var input			float		aBaseX;
var input			float		aBaseY;
var input			float		aBaseZ;
var input			float		aMouseX;
var input			float		aMouseY;
var input			float		aForward;
var input			float		aTurn;
var input			float		aStrafe;
var input			float		aUp;
var input			float		aLookUp;

// PS3 SIXAXIS axes
var input			float		aPS3AccelX;
var input			float		aPS3AccelY;
var input			float		aPS3AccelZ;
var input			float		aPS3Gyro;

//
// Joy Raw Input
//
/** Joypad left thumbstick, vertical axis. Range [-1,+1] */
var		transient	float	RawJoyUp;
/** Joypad left thumbstick, horizontal axis. Range [-1,+1] */
var		transient	float	RawJoyRight;
/** Joypad right thumbstick, horizontal axis. Range [-1,+1] */
var		transient	float	RawJoyLookRight;
/** Joypad right thumbstick, vertical axis. Range [-1,+1] */
var		transient	float	RawJoyLookUp;

/** move forward speed scaling */
var()	config		float	MoveForwardSpeed;
/** strafe speed scaling */
var()	config		float	MoveStrafeSpeed;
/** Yaw turn speed scaling */
var()	config		float	LookRightScale;
/** pitch turn speed scaling */
var()	config		float	LookUpScale;


// Input buttons.
var input			byte		bStrafe;
var input			byte		bXAxis;
var input			byte		bYAxis;

// Mouse smoothing control
var globalconfig bool		bEnableMouseSmoothing;			/** if true, mouse smoothing is enabled */

// Zoom Scaling
var bool bEnableFOVScaling;

// Mouse smoothing sample data
var float ZeroTime[2];							/** How long received mouse movement has been zero. */
var float SmoothedMouse[2];						/** Current average mouse movement/sample */
var int MouseSamples;							/** Number of mouse samples since mouse movement has been zero */
var float  MouseSamplingTotal;					/** DirectInput's mouse sampling total time */

//=============================================================================
// Input related functions.

exec function bool InvertMouse()
{
	bInvertMouse = !bInvertMouse;
	SaveConfig();
	return bInvertMouse;
}

exec function bool InvertTurn()
{
	bInvertTurn = !bInvertTurn;
	SaveConfig();
	return bInvertTurn;
}

exec function SetSensitivity(Float F)
{
	MouseSensitivity = F;
}

/** Hook called from HUD actor. Gives access to HUD and Canvas */
function DrawHUD( HUD H );

function PreProcessInput(float DeltaTime);
function PostProcessInput(float DeltaTime);

function AdjustMouseSensitivity(float FOVScale)
{
	// Apply mouse sensitivity.
	aMouseX			*= MouseSensitivity * FOVScale;
	aMouseY			*= MouseSensitivity * FOVScale;
}

// Postprocess the player's input.
event PlayerInput( float DeltaTime )
{
	local float FOVScale, TimeScale;

	// Save Raw values
	RawJoyUp		= aBaseY;
	RawJoyRight		= aStrafe;
	RawJoyLookRight	= aTurn;
	RawJoyLookUp	= aLookUp;

	// PlayerInput shouldn't take timedilation into account
	DeltaTime /= WorldInfo.TimeDilation;
	if (Outer.bDemoOwner && WorldInfo.NetMode == NM_Client)
	{
		DeltaTime /= WorldInfo.DemoPlayTimeDilation;
	}

	PreProcessInput( DeltaTime );

	// Scale to game speed
	TimeScale = 100.f*DeltaTime;
	aBaseY		*= TimeScale * MoveForwardSpeed;
	aStrafe		*= TimeScale * MoveStrafeSpeed;
	aUp			*= TimeScale * MoveStrafeSpeed;
	aTurn		*= TimeScale * LookRightScale;
	aLookUp		*= TimeScale * LookUpScale;

	PostProcessInput( DeltaTime );

	ProcessInputMatching(DeltaTime);

	// Check for Double click movement.
	CatchDoubleClickInput();

	// Take FOV into account (lower FOV == less sensitivity).

	if ( bEnableFOVScaling )
	{
		FOVScale = GetFOVAngle() * 0.01111; // 0.01111 = 1 / 90.0
	}
	else
	{
		FOVScale = 1.0;
	}

	AdjustMouseSensitivity(FOVScale);

	// mouse smoothing
	if ( bEnableMouseSmoothing )
	{
		aMouseX = SmoothMouse(aMouseX, DeltaTime,bXAxis,0);
		aMouseY = SmoothMouse(aMouseY, DeltaTime,bYAxis,1);
	}

	aLookUp			*= FOVScale;
	aTurn			*= FOVScale;

	// Turning and strafing share the same axis.
	if( bStrafe > 0 )
		aStrafe		+= aBaseX + aMouseX;
	else
		aTurn		+= aBaseX + aMouseX;

	// Look up/down.
	aLookup += aMouseY;
	if (bInvertMouse)
	{
		aLookup *= -1.f;
	}

	if (bInvertTurn)
	{
		aTurn *= -1.f;
	}

	// Forward/ backward movement
	aForward		+= aBaseY;

	// Handle walking.
	HandleWalking();

	// ignore move input
	// Do not clear RawJoy flags, as we still want to be able to read input.
	if( IsMoveInputIgnored() )
	{
		aForward	= 0.f;
		aStrafe		= 0.f;
		aUp			= 0.f;
	}

	// ignore look input
	// Do not clear RawJoy flags, as we still want to be able to read input.
	if( IsLookInputIgnored() )
	{
		aTurn		= 0.f;
		aLookup		= 0.f;
	}
}

function CatchDoubleClickInput()
{
	if (!IsMoveInputIgnored())
	{
		bEdgeForward	= (bWasForward	^^ (aBaseY	> 0));
		bEdgeBack		= (bWasBack		^^ (aBaseY	< 0));
		bEdgeLeft		= (bWasLeft		^^ (aStrafe < 0));
		bEdgeRight		= (bWasRight	^^ (aStrafe > 0));
		bWasForward		= (aBaseY	> 0);
		bWasBack		= (aBaseY	< 0);
		bWasLeft		= (aStrafe	< 0);
		bWasRight		= (aStrafe	> 0);
	}
}

// check for double click move
function Actor.EDoubleClickDir CheckForDoubleClickMove(float DeltaTime)
{
	local Actor.EDoubleClickDir DoubleClickMove, OldDoubleClick;

	if ( DoubleClickDir == DCLICK_Active )
		DoubleClickMove = DCLICK_Active;
	else
		DoubleClickMove = DCLICK_None;
	if (DoubleClickTime > 0.0)
	{
		if ( DoubleClickDir == DCLICK_Active )
		{
			if ( (Pawn != None) && (Pawn.Physics == PHYS_Walking) )
			{
				DoubleClickTimer = 0;
				DoubleClickDir = DCLICK_Done;
			}
		}
		else if ( DoubleClickDir != DCLICK_Done )
		{
			OldDoubleClick = DoubleClickDir;
			DoubleClickDir = DCLICK_None;

			if (bEdgeForward && bWasForward)
				DoubleClickDir = DCLICK_Forward;
			else if (bEdgeBack && bWasBack)
				DoubleClickDir = DCLICK_Back;
			else if (bEdgeLeft && bWasLeft)
				DoubleClickDir = DCLICK_Left;
			else if (bEdgeRight && bWasRight)
				DoubleClickDir = DCLICK_Right;

			if ( DoubleClickDir == DCLICK_None)
				DoubleClickDir = OldDoubleClick;
			else if ( DoubleClickDir != OldDoubleClick )
				DoubleClickTimer = DoubleClickTime + 0.5 * DeltaTime;
			else
				DoubleClickMove = DoubleClickDir;
		}

		if (DoubleClickDir == DCLICK_Done)
		{
			DoubleClickTimer = FMin(DoubleClickTimer-DeltaTime,0);
			if (DoubleClickTimer < -0.35)
			{
				DoubleClickDir = DCLICK_None;
				DoubleClickTimer = DoubleClickTime;
			}
		}
		else if ((DoubleClickDir != DCLICK_None) && (DoubleClickDir != DCLICK_Active))
		{
			DoubleClickTimer -= DeltaTime;
			if (DoubleClickTimer < 0)
			{
				DoubleClickDir = DCLICK_None;
				DoubleClickTimer = DoubleClickTime;
			}
		}
	}
	return DoubleClickMove;
}

/**
 * Iterates through all InputRequests on the PlayerController and
 * checks to see if a new input has been matched, or if the entire
 * match sequence should be reset.
 *
 * @param	DeltaTime - time since last tick
 */
final function ProcessInputMatching(float DeltaTime)
{
	local float Value;
	local int i,MatchIdx;
	local bool bMatch;
	// iterate through each request,
	for (i = 0; i < InputRequests.Length; i++)
	{
		// if we have a valid match idx
		if (InputRequests[i].MatchActor != None &&
			InputRequests[i].MatchIdx >= 0 &&
			InputRequests[i].MatchIdx < InputRequests[i].Inputs.Length)
		{
			MatchIdx = InputRequests[i].MatchIdx;
			// if we've exceeded the delta,
			// ignore the delta for the first match
			if (MatchIdx != 0 &&
				WorldInfo.TimeSeconds - InputRequests[i].LastMatchTime >= InputRequests[i].Inputs[MatchIdx].TimeDelta)
			{
				// reset this match
				InputRequests[i].LastMatchTime = 0.f;
				InputRequests[i].MatchIdx = 0;

				// fire off the cancel event
				if (InputRequests[i].FailedFuncName != 'None')
				{
					InputRequests[i].MatchActor.SetTimer(0.01f, false, InputRequests[i].FailedFuncName );
				}
			}
			else
			{
				// grab the current input value of the matching type
				Value = 0.f;
				switch (InputRequests[i].Inputs[MatchIdx].Type)
				{
				case IT_XAxis:
					Value = aStrafe;
					break;
				case IT_YAxis:
					Value = aBaseY;
					break;
				}
				// check to see if this matches
				switch (InputRequests[i].Inputs[MatchIdx].Action)
				{
				case IMA_GreaterThan:
					bMatch = Value >= InputRequests[i].Inputs[MatchIdx].Value;
					break;
				case IMA_LessThan:
					bMatch = Value <= InputRequests[i].Inputs[MatchIdx].Value;
					break;
				}
				if (bMatch)
				{
					// mark it as matched
					InputRequests[i].LastMatchTime = WorldInfo.TimeSeconds;
					InputRequests[i].MatchIdx++;
					// check to see if we've matched all inputs
					if (InputRequests[i].MatchIdx >= InputRequests[i].Inputs.Length)
					{
						// fire off the event
						if (InputRequests[i].MatchFuncName != 'None')
						{
							InputRequests[i].MatchActor.SetTimer(0.01f,false,InputRequests[i].MatchFuncName);
						}
						// reset this match
						InputRequests[i].LastMatchTime = 0.f;
						InputRequests[i].MatchIdx = 0;
						// as well as all others
					}
				}
			}
		}
	}
}

//*************************************************************************************
// Normal gameplay execs
// Type the name of the exec function at the console to execute it

exec function Jump()
{
	if ( WorldInfo.Pauser == PlayerReplicationInfo )
		SetPause( False );
	else
		bPressedJump = true;
}

exec function SmartJump()
{
	Jump();
}

//*************************************************************************************
// Mouse smoothing

exec function ClearSmoothing()
{
	local int i;

	for ( i=0; i<2; i++ )
	{
		//`Log(i$" zerotime "$zerotime[i]$" smoothedmouse "$SmoothedMouse[i]);
		ZeroTime[i] = 0;
		SmoothedMouse[i] = 0;
	}
	//`Log("MouseSamplingTotal "$MouseSamplingTotal$" MouseSamples "$MouseSamples);
    	MouseSamplingTotal = Default.MouseSamplingTotal;
	MouseSamples = Default.MouseSamples;
}

/** SmoothMouse()
Smooth mouse movement, because mouse sampling doesn't match up with tick time.
 * @note: if we got sample event for zero mouse samples (so we
			didn't have to guess whether a 0 was caused by no sample occuring during the tick (at high frame rates) or because the mouse actually stopped)
 * @param: aMouse is the mouse axis movement received from DirectInput
 * @param: DeltaTime is the tick time
 * @param: SampleCount is the number of mouse samples received from DirectInput
 * @param: Index is 0 for X axis, 1 for Y axis
 * @return the smoothed mouse axis movement
 */
function float SmoothMouse(float aMouse, float DeltaTime, out byte SampleCount, int Index)
{
	local float MouseSamplingTime;

	if (DeltaTime < 0.25)
	{
		MouseSamplingTime = MouseSamplingTotal/MouseSamples;

		if ( aMouse == 0 )
		{
			// no mouse movement received
			ZeroTime[Index] += DeltaTime;
			if ( ZeroTime[Index] < MouseSamplingTime )
			{
				// zero mouse movement is possibly because less than the mouse sampling interval has passed
				aMouse = SmoothedMouse[Index] * DeltaTime/MouseSamplingTime;
			}
			else
			{
				SmoothedMouse[Index] = 0;
			}
		}
		else
		{
			ZeroTime[Index] = 0;
			if ( SmoothedMouse[Index] != 0 )
			{
				// this isn't the first tick with non-zero mouse movement
				if ( DeltaTime < MouseSamplingTime * (SampleCount + 1) )
				{
					// smooth mouse movement so samples/tick is constant
					aMouse = aMouse * DeltaTime/(MouseSamplingTime * SampleCount);
				}
				else
				{
					// fewer samples, so going slow
					// use number of samples we should have had for sample count
					SampleCount = DeltaTime/MouseSamplingTime;
				}
			}
			SmoothedMouse[Index] = aMouse/SampleCount;
		}
	}
	else
	{
		// if we had an abnormally long frame, clear everything so it doesn't distort the results
		ClearSmoothing();
	}
	SampleCount = 0;
	return aMouse;
}

defaultproperties
{
   bEnableMouseSmoothing=True
   DoubleClickTime=0.250000
   MouseSensitivity=30.000000
   MoveForwardSpeed=1200.000000
   MoveStrafeSpeed=1200.000000
   LookRightScale=300.000000
   LookUpScale=-250.000000
   MouseSamples=1
   MouseSamplingTotal=0.008300
   Bindings(0)=(Name="F8",Command="set D3DRenderDevice bUsePostProcessEffects True")
   Bindings(1)=(Name="F9",Command="shot")
   Bindings(2)=(Name="P",Command="TogglePhysicsMode")
   Bindings(3)=(Name="Delete",Command="Camera Default")
   Bindings(4)=(Name="End",Command="Camera FirstPerson")
   Bindings(5)=(Name="MouseX",Command="Count bXAxis | Axis aMouseX")
   Bindings(6)=(Name="LeftShift",Command="Walking")
   Bindings(7)=(Name="F7",Command="set D3DRenderDevice bUsePostProcessEffects False")
   Bindings(8)=(Name="MouseY",Command="Count bYAxis | Axis aMouseY")
   Bindings(9)=(Name="Duck",Command="Button bDuck | Axis aUp Speed=-1.0  AbsoluteAxis=100")
   Bindings(10)=(Name="Look",Command="Button bLook")
   Bindings(11)=(Name="Pause",Command="Pause")
   Bindings(12)=(Name="LookToggle",Command="Toggle bLook")
   Bindings(13)=(Name="LookUp",Command="Axis aLookUp Speed=+25.0 AbsoluteAxis=100")
   Bindings(14)=(Name="LookDown",Command="Axis aLookUp Speed=-25.0 AbsoluteAxis=100")
   Bindings(15)=(Name="CenterView",Command="Button bSnapLevel")
   Bindings(16)=(Name="Walking",Command="Button bRun")
   Bindings(17)=(Name="Strafe",Command="Button bStrafe")
   Bindings(18)=(Name="NextWeapon",Command="NextWeapon")
   Bindings(19)=(Name="ViewTeam",Command="ViewClass Pawn")
   Bindings(20)=(Name="TurnToNearest",Command="Button bTurnToNearest")
   Bindings(21)=(Name="Turn180",Command="Button bTurn180")
   Bindings(22)=(Name="GBA_MoveForward",Command="Axis aBaseY Speed=1.0")
   Bindings(23)=(Name="GBA_Backward",Command="Axis aBaseY Speed=-1.0")
   Bindings(24)=(Name="GBA_StrafeLeft",Command="Axis aStrafe Speed=-1.0")
   Bindings(25)=(Name="GBA_StrafeRight",Command="Axis aStrafe Speed=+1.0")
   Bindings(26)=(Name="GBA_TurnLeft",Command="Axis aBaseX Speed=-200.0 AbsoluteAxis=100")
   Bindings(27)=(Name="GBA_TurnRight",Command="Axis aBaseX  Speed=+200.0 AbsoluteAxis=100")
   Bindings(28)=(Name="GBA_Jump",Command="Jump | Axis aUp Speed=+1.0 AbsoluteAxis=100")
   Bindings(29)=(Name="GBA_Duck",Command="Duck | onrelease UnDuck | Axis aUp Speed=-1.0  AbsoluteAxis=100")
   Bindings(30)=(Name="GBA_Fire",Command="StartFire | OnRelease StopFire")
   Bindings(31)=(Name="GBA_AltFire",Command="StartAltFire | OnRelease StopAltFire")
   Bindings(32)=(Name="GBA_Use",Command="use")
   Bindings(33)=(Name="GBA_FeignDeath",Command="FeignDeath")
   Bindings(34)=(Name="GBA_SwitchToBestWeapon",Command="SwitchToBestWeapon")
   Bindings(35)=(Name="GBA_PrevWeapon",Command="PrevWeapon")
   Bindings(36)=(Name="GBA_NextWeapon",Command="NextWeapon")
   Bindings(37)=(Name="GBA_SwitchWeapon1",Command="switchweapon 1")
   Bindings(38)=(Name="GBA_SwitchWeapon2",Command="switchweapon 2")
   Bindings(39)=(Name="GBA_SwitchWeapon3",Command="switchweapon 3")
   Bindings(40)=(Name="GBA_SwitchWeapon4",Command="switchweapon 4")
   Bindings(41)=(Name="GBA_SwitchWeapon5",Command="switchweapon 5")
   Bindings(42)=(Name="GBA_SwitchWeapon6",Command="switchweapon 6")
   Bindings(43)=(Name="GBA_SwitchWeapon7",Command="switchweapon 7")
   Bindings(44)=(Name="GBA_SwitchWeapon8",Command="switchweapon 8")
   Bindings(45)=(Name="GBA_SwitchWeapon9",Command="switchweapon 9")
   Bindings(46)=(Name="GBA_SwitchWeapon10",Command="switchweapon 10")
   Bindings(47)=(Name="GBA_ToggleTranslocator",Command="ToggleTranslocator")
   Bindings(48)=(Name="GBA_ToggleSpeaking",Command="ToggleSpeaking true | OnRelease ToggleSpeaking false")
   Bindings(49)=(Name="GBA_Talk",Command="talk")
   Bindings(50)=(Name="GBA_TeamTalk",Command="teamtalk")
   Bindings(51)=(Name="GBA_Taunt1",Command="taunt 1")
   Bindings(52)=(Name="GBA_Taunt2",Command="taunt 2")
   Bindings(53)=(Name="GBA_Horn",Command="PlayVehicleHorn")
   Bindings(54)=(Name="GBA_ShowMenu",Command="CloseEditorViewport | onrelease ShowMenu")
   Bindings(55)=(Name="GBA_ShowCommandMenu",Command="ShowCommandMenu")
   Bindings(56)=(Name="GBA_ShowScores",Command="SetShowScores true | Onrelease SetShowScores false")
   Bindings(57)=(Name="GBA_ShowMap",Command="ShowMap")
   Bindings(58)=(Name="GBA_ToggleMinimap",Command="ToggleMinimap")
   Bindings(59)=(Name="GBA_TriggerHero",Command="TriggerHero")
   Bindings(60)=(Name="GBA_GrowHud",Command="GrowHud")
   Bindings(61)=(Name="GBA_ShrinkHud",Command="ShrinkHud")
   Bindings(62)=(Name="GBA_ToggleMelee",Command="ToggleMelee | Axis aUp Speed=-1.0 AbsoluteAxis=100")
   Bindings(63)=(Name="GBA_WeaponPicker",Command="ShowQuickPick | OnRelease HideQuickPick")
   Bindings(64)=(Name="GBA_Jump_Gamepad",Command="SmartJump | Axis aUp Speed=1.0 AbsoluteAxis=100")
   Bindings(65)=(Name="GBA_StrafeLeft_Gamepad",Command="Axis aStrafe Speed=1.0 DeadZone=0.2")
   Bindings(66)=(Name="GBA_MoveForward_Gamepad",Command="Axis aBaseY Speed=1.0 DeadZone=0.2")
   Bindings(67)=(Name="GBA_TurnLeft_Gamepad",Command="Axis aTurn Speed=1.0 DeadZone=0.2")
   Bindings(68)=(Name="GBA_Look_Gamepad",Command="Axis aLookup Speed=0.65 DeadZone=0.2")
   Bindings(69)=(Name="GBA_SwitchToBestWeapon_Gamepad",Command="SwitchToBestWeapon | Axis aUp Speed=-1.0 AbsoluteAxis=100")
   Bindings(70)=(Name="GBA_Use_Gamepad",Command="use")
   Bindings(71)=(Name="XboxTypeS_Start",Command="GBA_ShowMenu")
   Bindings(72)=(Name="XboxTypeS_LeftX",Command="GBA_StrafeLeft_Gamepad")
   Bindings(73)=(Name="XboxTypeS_LeftY",Command="GBA_MoveForward_Gamepad")
   Bindings(74)=(Name="XboxTypeS_RightX",Command="GBA_TurnLeft_Gamepad")
   Bindings(75)=(Name="XboxTypeS_RightY",Command="GBA_Look_Gamepad")
   Bindings(76)=(Name="XboxTypeS_RightShoulder",Command="GBA_NextWeapon")
   Bindings(77)=(Name="XboxTypeS_RightTrigger",Command="GBA_Fire")
   Bindings(78)=(Name="XboxTypeS_LeftShoulder",Command="GBA_WeaponPicker")
   Bindings(79)=(Name="XboxTypeS_LeftTrigger",Command="GBA_AltFire")
   Bindings(80)=(Name="XboxTypeS_RightThumbstick",Command="GBA_SwitchToBestWeapon_Gamepad")
   Bindings(81)=(Name="XboxTypeS_LeftThumbstick",Command="GBA_Duck")
   Bindings(82)=(Name="XboxTypeS_A",Command="GBA_Jump_Gamepad")
   Bindings(83)=(Name="XboxTypeS_B",Command="GBA_ToggleMelee")
   Bindings(84)=(Name="XboxTypeS_Y",Command="GBA_ShowMap")
   Bindings(85)=(Name="XboxTypeS_X",Command="GBA_Use_Gamepad")
   Bindings(86)=(Name="XboxTypeS_Back",Command="GBA_ShowScores")
   Bindings(87)=(Name="XboxTypeS_DPad_Up",Command="GBA_TriggerHero")
   Bindings(88)=(Name="XboxTypeS_DPad_Down",Command="GBA_FeignDeath")
   Bindings(89)=(Name="XboxTypeS_DPad_Left",Command="GBA_ShowCommandMenu")
   Bindings(90)=(Name="XboxTypeS_DPad_Right",Command="GBA_ToggleSpeaking")
   Bindings(91)=(Name="SIXAXIS_AccelX",Command="GBA_TurnLeft_Gamepad")
   Bindings(92)=(Name="SIXAXIS_AccelZ",Command="GBA_Look_Gamepad")
   Bindings(93)=(Name="Up",Command="GBA_MoveForward")
   Bindings(94)=(Name="Down",Command="GBA_Backward")
   Bindings(95)=(Name="Left",Command="GBA_TurnLeft")
   Bindings(96)=(Name="Right",Command="GBA_TurnRight")
   Bindings(97)=(Name="LeftControl",Command="GBA_Jump")
   Bindings(98)=(Name="Enter",Command="GBA_Use")
   Bindings(99)=(Name="SpaceBar",Command="GBA_Jump")
   Bindings(100)=(Name="W",Command="GBA_MoveForward")
   Bindings(101)=(Name="S",Command="GBA_Backward")
   Bindings(102)=(Name="A",Command="GBA_StrafeLeft")
   Bindings(103)=(Name="D",Command="GBA_StrafeRight")
   Bindings(104)=(Name="E",Command="GBA_Use")
   Bindings(105)=(Name="LeftMouseButton",Command="GBA_Fire")
   Bindings(106)=(Name="RightMouseButton",Command="GBA_AltFire")
   Bindings(107)=(Name="C",Command="GBA_Duck")
   Bindings(108)=(Name="Escape",Command="GBA_ShowMenu")
   Bindings(109)=(Name="MouseScrollUp",Command="GBA_PrevWeapon")
   Bindings(110)=(Name="MouseScrollDown",Command="GBA_NextWeapon")
   Bindings(111)=(Name="one",Command="GBA_SwitchWeapon1")
   Bindings(112)=(Name="two",Command="GBA_SwitchWeapon2")
   Bindings(113)=(Name="three",Command="GBA_SwitchWeapon3")
   Bindings(114)=(Name="four",Command="GBA_SwitchWeapon4")
   Bindings(115)=(Name="five",Command="GBA_SwitchWeapon5")
   Bindings(116)=(Name="six",Command="GBA_SwitchWeapon6")
   Bindings(117)=(Name="seven",Command="GBA_SwitchWeapon7")
   Bindings(118)=(Name="eight",Command="GBA_SwitchWeapon8")
   Bindings(119)=(Name="nine",Command="GBA_SwitchWeapon9")
   Bindings(120)=(Name="zero",Command="GBA_SwitchWeapon10")
   Bindings(121)=(Name="Q",Command="GBA_ToggleTranslocator")
   Bindings(122)=(Name="T",Command="GBA_Talk")
   Bindings(123)=(Name="Y",Command="GBA_TeamTalk")
   Bindings(124)=(Name="J",Command="GBA_Taunt1")
   Bindings(125)=(Name="K",Command="GBA_Taunt2")
   Bindings(126)=(Name="L",Command="GBA_Horn")
   Bindings(127)=(Name="F1",Command="GBA_ShowScores")
   Bindings(128)=(Name="F2",Command="GBA_ShowMap")
   Bindings(129)=(Name="F3",Command="GBA_ToggleMinimap")
   Bindings(130)=(Name="F6",Command="stat net")
   Bindings(131)=(Name="G",Command="GBA_SwitchToBestWeapon")
   Bindings(132)=(Name="F",Command="GBA_FeignDeath")
   Bindings(133)=(Name="Equals",Command="GBA_GrowHud")
   Bindings(134)=(Name="Minus",Command="GBA_ShrinkHud")
   Bindings(135)=(Name="V",Command="GBA_ShowCommandMenu")
   Bindings(136)=(Name="B",Command="GBA_ToggleSpeaking")
   Bindings(137)=(Name="R",Command="GBA_TriggerHero")
   Bindings(138)=(Name="M",Command="BasePath 0")
   Bindings(139)=(Name="N",Command="BasePath 1")
   Name="Default__PlayerInput"
   ObjectArchetype=Input'Engine.Default__Input'
}
