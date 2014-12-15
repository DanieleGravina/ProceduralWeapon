/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicleSimHellbender extends UTVehicleSimCar;

defaultproperties
{
   TorqueVSpeedCurve=(Points=((InVal=-500.000000),(InVal=-300.000000,OutVal=60.000000),(OutVal=120.000000),(InVal=400.000000,OutVal=120.000000),(InVal=800.000000,OutVal=150.000000),(InVal=920.000000)))
   EngineRPMCurve=(Points=((InVal=-500.000000,OutVal=2500.000000),(OutVal=500.000000),(InVal=599.000000,OutVal=5000.000000),(InVal=600.000000,OutVal=3000.000000),(InVal=849.000000,OutVal=5000.000000),(InVal=850.000000,OutVal=3000.000000),(InVal=1050.000000,OutVal=5000.000000)))
   LSDFactor=0.200000
   SteeringReductionFactor=0.250000
   NumWheelsForFullSteering=4
   SteeringReductionSpeed=800.000000
   SteeringReductionMinSpeed=500.000000
   HardTurnMotorTorque=1.000000
   FrontalCollisionGripFactor=0.180000
   SpeedBasedTurnDamping=5.000000
   AirControlTurnTorque=60.000000
   InAirUprightTorqueFactor=-25.000000
   InAirUprightMaxTorque=12.000000
   ChassisTorqueScale=0.500000
   MaxSteerAngleCurve=(Points=((OutVal=45.000000),(InVal=300.000000,OutVal=31.000000),(InVal=900.000000,OutVal=22.000000)))
   SteerSpeed=140.000000
   EngineBrakeFactor=0.025000
   MaxBrakeTorque=10.000000
   StopThreshold=200.000000
   WheelSuspensionStiffness=90.000000
   WheelSuspensionDamping=1.000000
   WheelLatExtremumValue=0.950000
   WheelLatAsymptoteValue=0.850000
   WheelInertia=0.400000
   bClampedFrictionModel=True
   Name="Default__UTVehicleSimHellbender"
   ObjectArchetype=UTVehicleSimCar'UTGame.Default__UTVehicleSimCar'
}
