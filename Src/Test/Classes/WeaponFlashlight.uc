/*********************************************************************************************
* Flashlight that mounts to a weapon
* Dave Voyles 11/2012
*********************************************************************************************/
class WeaponFlashlight extends SpotLightMovable
    notplaceable;

DefaultProperties
{
    Begin Object Name=SpotLightComponent0
        LightColor=(R=200,G=200,B=200)          // Sets the light color
        InnerConeAngle=10.0
        OuterConeAngle=20.0
    End Object

    bNoDelete=false                             // Cannot be deleted during play.
}