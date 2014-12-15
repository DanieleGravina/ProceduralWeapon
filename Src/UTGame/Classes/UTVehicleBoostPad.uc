/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicleBoostPad extends Actor
	placeable;

var()	bool						bInitiallyOn;
var() 	float						BoostPower, BoostDamping;
var()	array<class<UTVehicle> >	AffectedVehicles;

var		bool 						bCurrentlyActive;
var		array<UTVehicle>			VehicleList;

simulated event PostBeginPlay()
{
	bCurrentlyActive = bInitiallyOn;

	// ttp 113322: Make sure the box is always hidden
	CollisionComponent.SetHidden(true);

	Disable('Tick');
}

function Trigger( Actor Other, Pawn EventInstigator )
{
	bCurrentlyActive = !bCurrentlyActive;
}

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
	local bool bFound;
	local UTVehicle UTV;

	UTV = UTVehicle(Other);

	if (UTV != None && bCurrentlyActive)
	{
		if (AffectedVehicles.Length > 0)
			bFound = (AffectedVehicles.Find(UTV.Class) != -1);
		else
			bFound = TRUE;
	}

	if (bFound)
	{
		VehicleList[VehicleList.Length] = UTV;
		Enable('Tick');

		// If we have a sound to play, and not dedicated server, play it
		if(WorldInfo.NetMode != NM_DedicatedServer && UTV.BoostPadSound != None)
		{
			PlaySound(UTV.BoostPadSound, TRUE, , , UTV.Location);
		}
	}
}

event UnTouch(Actor Other)
{
	local int Idx;
	local UTVehicle UTV;

	UTV = UTVehicle(Other);

	if (UTV != None)
	{
		Idx = VehicleList.Find(UTV);

		if (Idx >= 0)
			VehicleList.Remove(Idx, 1);
	}
}

simulated function vector CalculateForce(vector CarLocation, vector CarVelocity)
{
	local vector X,Y,Z;
	local vector BoostForce, BoostNormal;

	GetAxes(rotation, X, Y, Z);

	BoostForce = X * BoostPower;
	BoostNormal = Normal(BoostForce);

	BoostForce -= BoostNormal * (CarVelocity dot BoostNormal) * BoostDamping;

	return BoostForce;
}

function Tick(float DT)
{
	local vector CalculatedForce;
	local int i;

	if (VehicleList.Length == 0)
		Disable('Tick');

	if (bCurrentlyActive)
	{
		for (i = 0; i < VehicleList.Length; i++)
		{
			CalculatedForce = CalculateForce(VehicleList[i].Location, VehicleList[i].Velocity);
			VehicleList[i].Mesh.AddForce(CalculatedForce);
		}
	}
}

defaultproperties
{
   bInitiallyOn=True
   BoostPower=1500.000000
   BoostDamping=0.010000
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'Engine.Default__ArrowComponent'
      ArrowColor=(B=128,G=255,R=0,A=255)
      ArrowSize=5.500000
      Name="ArrowComponent0"
      ObjectArchetype=ArrowComponent'Engine.Default__ArrowComponent'
   End Object
   Components(0)=ArrowComponent0
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
      Materials(0)=Material'Envy_Effects.Energy.Materials.M_EFX_Energy_Loop_Scroll_01'
      HiddenGame=True
      bUseAsOccluder=False
      CastShadow=False
      bAcceptsLights=False
      BlockActors=False
      BlockZeroExtent=False
      BlockRigidBody=False
      Scale3D=(X=2.000000,Y=1.000000,Z=0.400000)
      Name="StaticMeshComponent0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Components(1)=StaticMeshComponent0
   bAlwaysRelevant=True
   bCollideActors=True
   CollisionComponent=StaticMeshComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTVehicleBoostPad"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
