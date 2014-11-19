/*********************************************************************************************
* Weapon class for firing projectiles and homing weapons
* Dave Voyles 11/2012
*********************************************************************************************/
class MyWeapon extends UTWeap_ShockRifle;

/*********************************************************************************************
* Weapon lock on support
*********************************************************************************************/
/** Class of the rocket to use when seeking */
var class<UTProjectile> SeekingRocketClass;

/** The frequency with which we will check for a lock */
var(Locking) float      LockCheckTime;

/** How far out should we be considering actors for a lock */
var float       LockRange;

/** How long does the player need to target an actor to lock on to it*/
var(Locking) float      LockAcquireTime;

/** Once locked, how long can the player go without painting the object before they lose the lock */
var(Locking) float      LockTolerance;

/** When true, this weapon is locked on target */
var bool                bLockedOnTarget;

/** What "target" is this weapon locked on to */
var Actor               LockedTarget;

var PlayerReplicationInfo LockedTargetPRI;

/** What "target" is current pending to be locked on to */
var Actor               PendingLockedTarget;

/** How long since the Lock Target has been valid */
var float               LastLockedOnTime;

/** When did the pending Target become valid */
var float               PendingLockedTargetTime;

/** When was the last time we had a valid target */
var float               LastValidTargetTime;

/** angle for locking for lock targets */
var float               LockAim;

/** angle for locking for lock targets when on Console */
var float               ConsoleLockAim;

/** Sound Effects to play when Locking */
var SoundCue            LockAcquiredSound;
var SoundCue            LockLostSound;

/** If true, weapon will try to lock onto targets */
var bool bTargetLockingActive;

/** Last time target lock was checked */
var float LastTargetLockCheckTime;


/***************************************************************************
* Overriden to use GetPhysicalFireStartLoc() instead of 
* Instigator.GetWeaponStartTraceLocation()
* @returns position of trace start for instantfire()
***************************************************************************/
simulated function vector InstantFireStartTrace()
{
    return GetPhysicalFireStartLoc();
}


/***************************************************************************
* Location that projectiles will spawn from. Works for secondary fire on 
* third person mesh
***************************************************************************/
simulated function vector GetPhysicalFireStartLoc(optional vector AimDir)
{
    Local SkeletalMeshComponent AttachedMesh;
    local vector SocketLocation;
    Local TutorialPawn TutPawn;
    
    TutPawn = TutorialPawn(Owner);
    AttachedMesh = TutPawn.CurrentWeaponAttachment.Mesh;
    AttachedMesh.GetSocketWorldLocationAndRotation(MuzzleFlashSocket, SocketLocation);

    return SocketLocation;
}


/***************************************************************************
* Overridden from UTWeapon.uc
* @return the location + offset from which to spawn effects (primarily tracers) 
***************************************************************************/
simulated function vector GetEffectLocation()
{
    Local SkeletalMeshComponent AttachedMesh;
    local vector SocketLocation;
    Local TutorialPawn TutPawn;
    
    TutPawn = TutorialPawn(Owner);
    AttachedMesh = TutPawn.CurrentWeaponAttachment.Mesh;
    AttachedMesh.GetSocketWorldLocationAndRotation(MuzzleFlashSocket, SocketLocation);

    return SocketLocation;
}


/*********************************************************************************************
******************************** TARGET LOCKING CODE *****************************************
*********************************************************************************************/

/***************************************************************************
* Prints debug info for the weapon
***************************************************************************/
simulated function GetWeaponDebug( out Array<String> DebugInfo )
{
    Super.GetWeaponDebug(DebugInfo);

    DebugInfo[DebugInfo.Length] = "Locked: "@bLockedOnTarget@LockedTarget@LastLockedontime@(WorldInfo.TimeSeconds-LastLockedOnTime);
    DebugInfo[DebugInfo.Length] = "Pending:"@PendingLockedTarget@PendingLockedTargetTime@WorldInfo.TimeSeconds;
}


/***************************************************************************
* Used to adjust the LockTarget.
***************************************************************************/
function AdjustLockTarget(actor NewLockTarget)
{
    if ( LockedTarget == NewLockTarget )
    {
        return;                                                     // No need to update
    }
    if (NewLockTarget == None)
    {
        if (bLockedOnTarget)                                        // Clear the lock
        {
            LockedTarget = None;                                    // No target
            bLockedOnTarget = false;                                // Not locked onto a target

            if (LockLostSound != None && Instigator != None && Instigator.IsHumanControlled() )
            {
                // Play the LockLostSound if we lost track of the target
                PlayerController(Instigator.Controller).ClientPlaySound(LockLostSound);
            }
        }
    }
    else
    {
        // Set the lock
        bLockedOnTarget = true;
        LockedTarget = NewLockTarget;
        LockedTargetPRI = (Pawn(NewLockTarget) != None) ? Pawn(NewLockTarget).PlayerReplicationInfo : None;
        if ( LockAcquiredSound != None && Instigator != None  && Instigator.IsHumanControlled() )
        {
            PlayerController(Instigator.Controller).ClientPlaySound(LockAcquiredSound);
        }
    }
}


/***************************************************************************
* Given an potential target TA determine if we can lock on to it.  By 
* default, we can only lock on to pawns.
***************************************************************************/
simulated function bool CanLockOnTo(Actor TA)
{
    if ( (TA == None) || !TA.bProjTarget || TA.bDeleteMe || (Pawn(TA) == None) || (TA == Instigator) || (Pawn(TA).Health <= 0) )
    {
        return false;
    }
    return ( (WorldInfo.Game == None) || !WorldInfo.Game.bTeamGame || (WorldInfo.GRI == None) || !WorldInfo.GRI.OnSameTeam(Instigator,TA) );
}


/***************************************************************************
* Check target locking with each update 
***************************************************************************/
event Tick( FLOAT DeltaTime )
{
    if ( bTargetLockingActive && ( WorldInfo.TimeSeconds > LastTargetLockCheckTime + LockCheckTime ) )
    {
        LastTargetLockCheckTime = WorldInfo.TimeSeconds;    // Time, in seconds, since level began play 
        CheckTargetLock();                                  // Checks to see if we are locked on a target
    }
}


/***************************************************************************
* Have we locked onto our target?
***************************************************************************/
function CheckTargetLock()
{
    local Actor BestTarget, HitActor, TA;
    local UDKBot BotController;
    local vector StartTrace, EndTrace, Aim, HitLocation, HitNormal;
    local rotator AimRot;
    local float BestAim, BestDist;

    if ( (Instigator == None) || (Instigator.Controller == None) || (self != Instigator.Weapon) )
    {
        return;
    }
    if ( Instigator.bNoWeaponFiring)                    // TRUE indicates that weapon firing is disabled for this pawn          
    {
        AdjustLockTarget(None);                         // Used to adjust the LockTarget.
        PendingLockedTarget = None;                     // "target" is current pending to be locked on to
        return;
    }
    BestTarget = None;                                  // We don't have a target
    BotController = UDKBot(Instigator.Controller);      
    if ( BotController != None )                        // If there isn't a BotController...
    {
        // only try locking onto bot's target
        if ( (BotController.Focus != None) && CanLockOnTo(BotController.Focus) )
        {
            // make sure bot can hit it
            BotController.GetPlayerViewPoint( StartTrace, AimRot );
            Aim = vector(AimRot);

            if ( (Aim dot Normal(BotController.Focus.Location - StartTrace)) > LockAim )
            {
                HitActor = Trace(HitLocation, HitNormal, BotController.Focus.Location, StartTrace, true,,, TRACEFLAG_Bullet);
                if ( (HitActor == None) || (HitActor == BotController.Focus) )
                {
                    BestTarget = BotController.Focus;           // Actor being looked at
                }
            }
        }
    }
    else
    {
        // Trace the shot to see if it hits anyone
        Instigator.Controller.GetPlayerViewPoint( StartTrace, AimRot );
        Aim = vector(AimRot);
        EndTrace = StartTrace + Aim * LockRange;                // Where our trace stops
        HitActor = Trace(HitLocation, HitNormal, EndTrace, StartTrace, true,,, TRACEFLAG_Bullet);

        if ( (HitActor == None) || !CanLockOnTo(HitActor) )     // Check for a hit
        {
            // We didn't hit a valid target?  Controller attempts to pick a good target
            BestAim = ((UDKPlayerController(Instigator.Controller) != None) && UDKPlayerController(Instigator.Controller).bConsolePlayer) ? ConsoleLockAim : LockAim;
            BestDist = 0.0;
            TA = Instigator.Controller.PickTarget(class'Pawn', BestAim, BestDist, Aim, StartTrace, LockRange);
            if ( TA != None && CanLockOnTo(TA) )
            {
                BestTarget = TA;                                // Best target is the target we've locked onto
            }
        }
        else                                                    // We hit a valid target
        {
            BestTarget = HitActor;                              // Best Target is the one we've done a trace on
        }
    }

    // If we have a "possible" target, note its time mark
    if ( BestTarget != None )
    {
        LastValidTargetTime = WorldInfo.TimeSeconds;

        if ( BestTarget == LockedTarget )                       // If we're locked onto our best target...
        {
            LastLockedOnTime = WorldInfo.TimeSeconds;           // Set the LLOT to the time in seconds since level began play
        }
        else
        {
            if ( LockedTarget != None && ((WorldInfo.TimeSeconds - LastLockedOnTime > LockTolerance) || !CanLockOnTo(LockedTarget)) )
            {
                // Invalidate the current locked Target
                AdjustLockTarget(None);
            }

            // We have our best target, see if they should become our current target.
            if (PendingLockedTarget != BestTarget)              // Check for a new Pending Lock
            {
                PendingLockedTarget = BestTarget;
                PendingLockedTargetTime = ((Vehicle(PendingLockedTarget) != None) && (UDKPlayerController(Instigator.Controller) != None) && UDKPlayerController(Instigator.Controller).bConsolePlayer)
                                        ? WorldInfo.TimeSeconds + 0.5*LockAcquireTime
                                        : WorldInfo.TimeSeconds + LockAcquireTime;
            }

            // Otherwise check to see if we have been tracking the pending lock long enough
            else if (PendingLockedTarget == BestTarget && WorldInfo.TimeSeconds >= PendingLockedTargetTime )
            {
                AdjustLockTarget(PendingLockedTarget);
                LastLockedOnTime = WorldInfo.TimeSeconds;
                PendingLockedTarget = None;
                PendingLockedTargetTime = 0.0;
            }
        }
    }
    else 
    {
        if ( LockedTarget != None && ((WorldInfo.TimeSeconds - LastLockedOnTime > LockTolerance) || !CanLockOnTo(LockedTarget)) )
        {
            AdjustLockTarget(None);                             // Invalidate the current locked Target
        }

        // Next attempt to invalidate the Pending Target
        if ( PendingLockedTarget != None && ((WorldInfo.TimeSeconds - LastValidTargetTime > LockTolerance) || !CanLockOnTo(PendingLockedTarget)) )
        {
            PendingLockedTarget = None;                         // We are not pending another target to lock onto       
        }
    }
}


/***************************************************************************
* Default state. Go back to prev state, and don't use our current 
* tick
***************************************************************************/
auto simulated state Inactive
{
    ignores Tick;                                       

    simulated function BeginState(name PreviousStateName)   
    {
        Super.BeginState(PreviousStateName);
            bTargetLockingActive = false;           // not looking to lock onto a target
            AdjustLockTarget(None);                 // Don't adjust our target lock
    }


/***************************************************************************
 * Finish current state, & prepare for the next one
***************************************************************************/
    simulated function EndState(Name NextStateName)         
    {
        Super.EndState(NextStateName);
        bTargetLockingActive = true;                    // If true, weapon will try to lock onto targets
    }
}


/**************************************************************************
 * If the weapon is destroyed, cancel any target lock
**************************************************************************/
simulated event Destroyed()
{
    AdjustLockTarget(none);                             // Used to adjust the LockTarget.
    super.Destroyed();
}


/************************************************************************
* If locked on, we need to set the Seeking projectile's
* LockedTarget.
 ************************************************************************/
simulated function Projectile ProjectileFire()
{
    local Projectile SpawnedProjectile;

    SpawnedProjectile = super.ProjectileFire();
    if (bLockedOnTarget && UTProj_SeekingRocket(SpawnedProjectile) != None)
    {
        // Go after the target we are currently locked onto
        UTProj_SeekingRocket(SpawnedProjectile).SeekTarget = LockedTarget;
    }
    return SpawnedProjectile;
}


/************************************************************************
* We override GetProjectileClass to swap in a Seeking Rocket if we are 
* locked on.
 ***********************************************************************/
function class<Projectile> GetProjectileClass()
{
     if (bLockedOnTarget)                   // if we're locked on...
    {
        return SeekingRocketClass;          // use our homing rocket    
    }
    else                                    // Otherwise...
    {
        return WeaponProjectiles[CurrentFireMode];  // Use our default projectile
    }
}


/***************************************************************************
* Everything looks good, so fire our ammo!
***************************************************************************/
simulated function FireAmmunition()
{
    Super.FireAmmunition();
        AdjustLockTarget(None);             
        LastValidTargetTime = 0;                
        PendingLockedTarget = None;
        LastLockedOnTime = 0;
        PendingLockedTargetTime = 0;
}



defaultproperties
{
    // Forces the secondary fire projectile to fire from the weapon attachment
    MuzzleFlashSocket=MuzzleFlashSocket 
}