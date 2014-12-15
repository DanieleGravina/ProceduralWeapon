//-----------------------------------------------------------
// * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//-----------------------------------------------------------
class DebugCameraInput extends PlayerInput;

defaultproperties
{
   Bindings(0)=(Name="MoveUp",Command="Axis aUp Speed=1.0")
   Bindings(1)=(Name="MoveDown",Command="Axis aUp Speed=-1.0")
   Bindings(2)=(Name="MoveForward",Command="Axis aBaseY Speed=1.0")
   Bindings(3)=(Name="MoveBackward",Command="Axis aBaseY Speed=-1.0")
   Bindings(4)=(Name="TurnLeft",Command="Axis aBaseX Speed=-200.0 AbsoluteAxis=100")
   Bindings(5)=(Name="TurnRight",Command="Axis aBaseX  Speed=+200.0 AbsoluteAxis=100")
   Bindings(6)=(Name="StrafeLeft",Command="Axis aStrafe Speed=-1.0")
   Bindings(7)=(Name="StrafeRight",Command="Axis aStrafe Speed=+1.0")
   Bindings(8)=(Name="Q",Command="MoveDown")
   Bindings(9)=(Name="E",Command="MoveUp")
   Bindings(10)=(Name="W",Command="MoveForward")
   Bindings(11)=(Name="S",Command="MoveBackward")
   Bindings(12)=(Name="A",Command="StrafeLeft")
   Bindings(13)=(Name="D",Command="StrafeRight")
   Bindings(14)=(Name="F",Command="FreezeRendering")
   Bindings(15)=(Name="MouseX",Command="Count bXAxis | Axis aMouseX")
   Bindings(16)=(Name="MouseY",Command="Count bYAxis | Axis aMouseY")
   Bindings(17)=(Name="Left",Command="TurnLeft")
   Bindings(18)=(Name="Right",Command="TurnRight")
   Bindings(19)=(Name="C",Command="ToggleDebugCamera",Alt=True)
   Bindings(20)=(Name="LeftShift",Command="MoreSpeed | OnRelease NormalSpeed")
   Bindings(21)=(Name="XboxTypeS_LeftThumbstick",Command="ToggleDebugCamera")
   Bindings(22)=(Name="XboxTypeS_LeftX",Command="Axis aStrafe Speed=1.0 DeadZone=0.3")
   Bindings(23)=(Name="XboxTypeS_LeftY",Command="Axis aBaseY Speed=1.0 DeadZone=0.3")
   Bindings(24)=(Name="XboxTypeS_RightX",Command="Axis aTurn Speed=1.0 DeadZone=0.2")
   Bindings(25)=(Name="XboxTypeS_RightY",Command="Axis aLookup Speed=0.8 DeadZone=0.2")
   Bindings(26)=(Name="XboxTypeS_LeftTrigger",Command="MoveDown")
   Bindings(27)=(Name="XboxTypeS_RightTrigger",Command="MoveUp")
   Bindings(28)=(Name="XboxTypeS_A",Command="SetFreezeRendering")
   Bindings(29)=(Name="XboxTypeS_B",Command="MoreSpeed | OnRelease NormalSpeed")
   Name="Default__DebugCameraInput"
   ObjectArchetype=PlayerInput'Engine.Default__PlayerInput'
}
