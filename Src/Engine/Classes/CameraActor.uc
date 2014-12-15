/*
	CameraActor
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class CameraActor extends Actor
	native
	placeable;

var()			bool			bConstrainAspectRatio;

var()	interp	float			AspectRatio;

var()	interp	float			FOVAngle;

var()			bool					bCamOverridePostProcess;
var()	interp	PostProcessSettings		CamOverridePostProcess;

var		DrawFrustumComponent	DrawFrustum;
var		StaticMeshComponent		MeshComp;

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

replication
{
	if (Role == ROLE_Authority)
		FOVAngle, AspectRatio;
}


/**
 * Returns camera's Point of View.
 * Called by Camera.uc class. Subclass and postprocess to add any effects.
 */
simulated function GetCameraView(float DeltaTime, out TPOV OutPOV)
{
	GetActorEyesViewPoint(OutPOV.Location, OutPOV.Rotation);
	OutPOV.FOV = FOVAngle;
}


/** 
 * list important CameraActor variables on canvas.  HUD will call DisplayDebug() on the current ViewTarget when
 * the ShowDebug exec is used
 *
 * @param	HUD		- HUD with canvas to draw on
 * @input	out_YL		- Height of the current font
 * @input	out_YPos	- Y position on Canvas. out_YPos += out_YL, gives position to draw text for next debug line.
 */
simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
	local float XL;
	local Canvas Canvas;

	Canvas = HUD.Canvas;

	super.DisplayDebug( HUD, out_YL, out_YPos);

	Canvas.StrLen("TEST", XL, out_YL);
	out_YPos += out_YL;
	Canvas.SetPos(4,out_YPos);
	Canvas.DrawText("FOV:" $ FOVAngle, false);
}

defaultproperties
{
   bConstrainAspectRatio=True
   AspectRatio=1.777778
   FOVAngle=90.000000
   CamOverridePostProcess=(bEnableBloom=True,bEnableSceneEffect=True,Bloom_Scale=1.000000,Bloom_InterpolationDuration=1.000000,DOF_FalloffExponent=4.000000,DOF_BlurKernelSize=16.000000,DOF_MaxNearBlurAmount=1.000000,DOF_MaxFarBlurAmount=1.000000,DOF_ModulateBlurColor=(B=255,G=255,R=255,A=255),DOF_FocusInnerRadius=2000.000000,DOF_InterpolationDuration=1.000000,MotionBlur_MaxVelocity=1.000000,MotionBlur_Amount=0.500000,MotionBlur_FullMotionBlur=True,MotionBlur_CameraRotationThreshold=45.000000,MotionBlur_CameraTranslationThreshold=10000.000000,MotionBlur_InterpolationDuration=1.000000,Scene_HighLights=(X=1.000000,Y=1.000000,Z=1.000000),Scene_MidTones=(X=1.000000,Y=1.000000,Z=1.000000),Scene_InterpolationDuration=1.000000)
   Begin Object Class=DrawFrustumComponent Name=DrawFrust0 ObjName=DrawFrust0 Archetype=DrawFrustumComponent'Engine.Default__DrawFrustumComponent'
      Name="DrawFrust0"
      ObjectArchetype=DrawFrustumComponent'Engine.Default__DrawFrustumComponent'
   End Object
   DrawFrustum=DrawFrust0
   Begin Object Class=StaticMeshComponent Name=CamMesh0 ObjName=CamMesh0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      HiddenGame=True
      CastShadow=False
      CollideActors=False
      BlockRigidBody=False
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="CamMesh0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   MeshComp=CamMesh0
   Components(0)=CamMesh0
   Components(1)=DrawFrust0
   Physics=PHYS_Interpolating
   bNoDelete=True
   NetUpdateFrequency=1.000000
   Name="Default__CameraActor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
