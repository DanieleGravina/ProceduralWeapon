/*********************************************************************************************
* Weapon class for firing a Damage Over Time (DoT) weapon in the form of poison
* Dave Voyles 11/2012
*********************************************************************************************/
class MyWeapon_PoisonDamage extends MyWeapon;


/***************************************************************************
* When a pawn is hit with our weapon, this function gets called.
* We need to use TutorialPawn instead of Pawn, as our PoisonedPlayer() is 
* only present in the TutorialPawn class.
***************************************************************************/
simulated function ProcessInstantHit(byte FiringMode, ImpactInfo Impact, optional int NumHits)
{
    local TutorialPawn TP;  
    
    if (Impact.HitActor != None && (Impact.HitActor).IsA('Pawn'))
    {
        TP = TutorialPawn(Impact.HitActor);                     // Defining the pawn
        TP.PoisonPlayer();                                      // Calls the poison function in the TutorialPawn class
        //`Log("***Pawn Health:" @TP.Health);                     // Log for debugging
    }   
}

defaultproperties
{
}