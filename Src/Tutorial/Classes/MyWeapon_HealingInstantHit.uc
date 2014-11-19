class MyWeapon_HealingInstantHit extends MyWeapon;

simulated function ProcessInstantHit(byte FiringMode, ImpactInfo Impact, optional int NumHits)
{
    local Pawn P;  
    
    if (Impact.HitActor != None && (Impact.HitActor).IsA('Pawn'))
    {
        P = Pawn(Impact.HitActor);                     // Defining the pawn
        P.HealDamage(10, Instigator.Controller, InstantHitDamageTypes[1]);
        
        // `Log("***Pawn Health:" @P.Health); 
    }   
}

defaultproperties
{
	InstantHitDamageTypes(1) = None;
}