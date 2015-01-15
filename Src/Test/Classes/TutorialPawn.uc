Class TutorialPawn extends UTPawn
HideCategories(Movement, AI, Camera, Debug, Attachment, Physics, Advanced, Object);

/** Used to decrease the poision length each tick */
var int                                          PoisonCountdown;

/** Stores our flashlight */
var WeaponFlashlight                 Flashlight;

/** Used for flashing damage as pawn's HP drops */
var float                                        DamageOverlayTime;
var LinearColor                          DamageBodyMatColor;



///***************************************************************************
//* Tells the pawn to draw all postrender functions
//* http://forums.epicgames.com/archive/index.php/t-901388.html
//***************************************************************************/
//simulated function PostRenderFor(PlayerController PC, Canvas Canvas, vector CameraPosition,
                                  //vector CameraDir)
//{
    //local vector ScreenPos;
    //
    //Super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);   
    //
    //ScreenPos = Canvas.Project(self.Location);    
    ////canvas.setPos(200,200);
    //canvas.SetPos(ScreenPos.X,ScreenPos.Y +100);
    //canvas.DrawText("TEST POST RENDER!");
    //canvas.TextSize(Canvas.TextSize);
//
//}


/***************************************************************************
* Lets us know that the class is being called, for debugging purposes
***************************************************************************/
simulated event PostBeginPlay()
{
    Super.PostBeginPlay();
    `Log("================");
    `Log("Tutorial Pawn up");
    
    /** Flashlight */ 
    Flashlight = Spawn(class'WeaponFlashlight', self);          // Spawns the light on the player, setting self as owner
    
    Flashlight.SetBase(self);                                   // Sets the lights base on at the player    
    Flashlight.LightComponent.SetEnabled(false);                // Light is off by default 
    Flashlight.LightComponent.SetLightProperties(0.75);         // Starts at 75% brightness
    FlashDmg();
    
    /** called from UTPawn, spawns the default controller */
    SpawnDefaultController();
    
    
}


/***************************************************************************
* Called by MyWeapon_PoisonDamge when the pawn is shot
***************************************************************************/
function PoisonPlayer()
{
    PoisonCountdown = 0;                                        // Reset Poison Counter
    SetTimer(0.5, true, 'PoisonDmg');                           // Every .5 seconds PoisonDmg() will be called
}


/***************************************************************************
* NES style flashing damage timer to indicate how hurt a pawn is
***************************************************************************/
function FlashDmgTimer()
{

    if (Health < HealthMax /2)
    {
        `log("HP is less than 50%");
        SetTimer(2.2, true, 'FlashDmg');
    }
    
    if (Health < HealthMax /4)
    {
        `log("HP is less than 25%");
        SetTimer(1.5, true, 'FlashDmg');
    }   
    
    if (Health < HealthMax /10)
    {
        `log("HP is less than 10%");
        SetTimer(0.7, true, 'FlashDmg');
    }   
}

/***************************************************************************
* Sets the flashing overlay on the pawn to indicate damage taken
***************************************************************************/
simulated function FlashDmg()
{   
    SetBodyMatColor(DamageBodyMatColor, DamageOverlayTime);     
}


/***************************************************************************
* Called when a pawn is hit
***************************************************************************/
function PlayHit(float Damage, Controller InstigatedBy, vector HitLocation, 
                    class<DamageType> damageType, vector Momentum, TraceHitInfo HitInfo)
{
        Super.PlayHit(Damage, InstigatedBy, HitLocation, DamageType, Momentum, HitInfo);                    
        FlashDmgTimer();        
}


/***************************************************************************
* Actually does the damage to the pawn
***************************************************************************/
function PoisonDmg()
{
    Local Pawn P;
    
    P = self;                                       // Set the pawn to yourself

    /** Does 5 damage to the pawn of type UTDmgType_Burning */
    TakeDamage( 5, None, Location, vect(0,0,0) , class'UTDmgType_Burning');
    PoisonCountdown = PoisonCountdown++;              // Increment timer
    `Log("***Pawn Health:" @P.Health);              // Log for debugging
       
    /** clear the infinitely looping 0.5 second timer after 10 counts of damage */
    if(PoisonCountdown >= 10)
    {
        ClearTimer('PoisonDmg');
    }
}


/***************************************************************************
* Turns the light on and off
***************************************************************************/
exec function ToggleFlashlight()
{
    if(!Flashlight.LightComponent.bEnabled)         // If the light is off...   
    {
        Flashlight.LightComponent.SetEnabled(true); // Then turn it on
        `log("TOGGLE FLASHLIGHT ON");
    }
    else                                            // If it's already on
    {
        Flashlight.LightComponent.SetEnabled(false);// Turn it off
                `log("TOGGLE FLASHLIGHT OFF");
    }
}


/***************************************************************************
* Forces the flashlight to use our pawn's rotation
***************************************************************************/
event UpdateEyeHeight( float DeltaTime )
{
    Super.UpdateEyeHeight(DeltaTime);
    Flashlight.SetRotation(Controller.Rotation);    // Flasligh will use our controller's rotation      
        
    /**  Offset the light slightly, so that it looks as though it is coming from our pawn's eyes/helmet */
    Flashlight.SetRelativeLocation(Controller.RelativeLocation + vect(20, 0, 25));
}


///***********************************************************************************
//**USED FOR TOP DOWN Camera**
//* Forces the weapon to use the pawn's direction for aiming, and not the camera's
//* shots will be fired in the direction the gun is pointed. Used by PlayerController
//* Comment this out if you are not using any camera system other than top down. 
//* @return POVRot.
//***********************************************************************************/
//simulated singular event Rotator GetBaseAimRotation()
//{
    //local rotator POVRot, tempRot;
//
    //tempRot = Rotation;
    //SetRotation(tempRot);
    //POVRot = Rotation;
    //
    //// Stops the player from being able to adjust the pitch of the shot, forcing the camera to always point
    //// down towards the pawn. We can still rotate left and right, however. 
////    POVRot.Pitch = 0;
//
    //return POVRot;
//}


/***************************************************************************
* Returns base Aim Rotation without any adjustment.  We simply use our rotation
* Only use this if you want your weapon trace to follow where your gun is 
* pointed. Projectiles will now follow your trace.  Comment out if you want
*  to fire in middle of screen.
* @return   POVRot
***************************************************************************/
simulated singular event Rotator GetBaseAimRotation()
{
    local rotator   POVRot;

    // We simply use our rotation
    POVRot = Rotation;

    // If our Pitch is 0, then use RemoveViewPitch
    if( POVRot.Pitch == 0 )
    {
        POVRot.Pitch = RemoteViewPitch << 8;
    }

    return POVRot;
}


   

defaultproperties
{
    /** AI and navigation */
    bAvoidLedges=true               // don't get too close to ledges
    bStopAtLedges=true              // if bAvoidLedges and bStopAtLedges, Pawn doesn't try to walk along the edge at all
    bUpdateEyeHeight=true           // Updates eye height so that the flashlight can become dynamic
    
    /** Used for flashing damage as pawn's HP drops */
    DamageOverlayTime=.1            // The flash lasts this long (float)
    DamageBodyMatColor=(R=10)       // Sets the pawn to flash red (hence the R=10)
      
    /** PostRender functions */
    bPostRenderIfNotVisible = true  // IF true, may call PostRenderFor() even when this actor is not visible 
    bPostRenderOtherTeam=true       // If true, call postrenderfor() even if on different team
}