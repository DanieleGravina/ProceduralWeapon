class ProceduralWeaponBot extends UTBot;

//Simulation uses only one type of bot
function Initialize(float InSkill, const out CharacterInfo BotInfo)
{
	local UTPlayerReplicationInfo PRI;
	local CustomCharData BotCharData;

	Skill = FClamp(InSkill, 0, 7);

	Aggressiveness = -0.95;
	BaseAggressiveness = Aggressiveness;
	Accuracy = -4.5;
	StrafingAbility = 1;
	CombatStyle = 0.5;
	Jumpiness = -1;
	Tactics = 0;
	ReactionTime = 0;

	// copy visual properties
	PRI = UTPlayerReplicationInfo(PlayerReplicationInfo);
	if (PRI != None)
	{
		// If we have no 'based on' char ref, just fill it in with this char. Thing like VoiceClass look at this.
		BotCharData = BotInfo.CharData;
		if(BotCharData.BasedOnCharID == "")
		{
			BotCharData.BasedOnCharID = BotInfo.CharID;
		}

		PRI.SetCharacterData(BotCharData);
	}

	ResetSkill();

	`log("[ProcWeapBot] Initialize bot with default pars, skill: "$string(Skill));
}

function Rotator GetAdjustedAimFor( Weapon InWeapon, vector projstart )
{
	local rotator FireRotation;
	local float TargetDist, ProjSpeed, TargetHeight;
	local actor HitActor;
	local vector FireSpot, FireDir, HitLocation, HitNormal;
	local bool bDefendMelee, bClean;
	local class<UTProjectile> ProjectileClass;
	local UTWeapon W;

	// make sure bot has a valid target
	if ( Focus == None )
		return Rotation;

	W = UTWeapon(InWeapon);
	if ( W == None )
		return Rotation;

	ProjectileClass = class<UTProjectile>(W.GetProjectileClass());
	if ( ProjectileClass != None )
		projspeed = ProceduralWeapon(InWeapon).Speed;

	FireSpot = FocalPoint;
	TargetDist = VSize(FocalPoint - Pawn.Location);

	// perfect aim at stationary objects
	if ( Focus.IsStationary() )
	{
		if ( (ProjectileClass == None) || (ProjectileClass.Default.Physics != PHYS_Falling) )
		{
			FireRotation = rotator(FocalPoint - projstart);
		}
		else
		{
			SuggestTossVelocity(FireDir, FocalPoint, ProjStart, projspeed, ProceduralWeapon(InWeapon).Gravity, 0.2,, PhysicsVolume.bWaterVolume ? PhysicsVolume.TerminalVelocity : ProjectileClass.Default.TerminalVelocity);
			FireRotation = rotator(FireDir);
		}
		// make sure bot shoots in the direction it's facing
		// our vehicles do their own aim clamping stuff so we don't need this
		if (Vehicle(Pawn) == None)
		{
			FireRotation.Yaw = Pawn.Rotation.Yaw;
		}
		SetRotation(FireRotation);
		return Rotation;
	}

	if ( (WorldInfo.TimeSeconds - LastActionMusicUpdate > 6.0) && (Enemy != None) && (Focus == Enemy) && (UTPlayerController(Enemy.Controller) != None) )
	{
		LastActionMusicUpdate = WorldInfo.TimeSeconds;
		UTPlayerController(Enemy.Controller).ClientMusicEvent(0);
	}

	bDefendMelee = ( (Focus == Enemy) && DefendMelee(TargetDist) );

	bClean = false; //so will fail first check unless shooting at feet

	if ( Pawn(Focus) != None )
		TargetHeight = Pawn(Focus).GetCollisionHeight();

	// adjust for toss distance
	if ( (ProjectileClass != None) && (ProjectileClass.Default.Physics == PHYS_Falling) )
	{
		if ( W.bRecommendSplashDamage && (Pawn(Focus) != None) && ((Skill >=4) || bDefendMelee)
			&& (((Focus.Physics == PHYS_Falling) && (Pawn.Location.Z + 80 >= FocalPoint.Z))
				|| ((Pawn.Location.Z + 19 >= FocalPoint.Z) && (bDefendMelee || (skill > 6.5 * FRand() - 0.5)))) )
		{
			FireSpot = FireSpot - vect(0,0,1) * TargetHeight;
		}
		// toss at target
		SuggestTossVelocity(FireDir, FireSpot, ProjStart, projspeed, ProceduralWeapon(InWeapon).Gravity, 0.2,, PhysicsVolume.bWaterVolume ? PhysicsVolume.TerminalVelocity : ProjectileClass.Default.TerminalVelocity);
	}
	else
	{
		if ( W.bRecommendSplashDamage && (Pawn(Focus) != None) )
		{
			if ( W.bLockedAimWhileFiring )
			{
				// it's a levi - fire at ground
	 			HitActor = Trace(HitLocation, HitNormal, FireSpot - vect(0,0,1000), FireSpot, false);
 				bClean = (HitActor == None);
				if ( !bClean )
				{
					FireSpot = HitLocation + vect(0,0,20);
					bClean = FastTrace(FireSpot, ProjStart);
				}
				else
				{
					bClean = FastTrace(FireSpot, ProjStart);
				}
			}
			else if ( ((Skill >=4) || bDefendMelee)
			&& (((Focus.Physics == PHYS_Falling) && (Pawn.Location.Z + 80 >= FocalPoint.Z))
				|| ((Pawn.Location.Z + 19 >= FocalPoint.Z) && (bDefendMelee || (skill > 6.5 * FRand() - 0.5)))) )
			{
		 		HitActor = Trace(HitLocation, HitNormal, FireSpot - vect(0,0,1) * (TargetHeight + 6), FireSpot, false);
 				bClean = (HitActor == None);
				if ( !bClean )
				{
					FireSpot = HitLocation + vect(0,0,3);
					bClean = FastTrace(FireSpot, ProjStart);
				}
				else
					bClean = ( (Focus.Physics == PHYS_Falling) && FastTrace(FireSpot, ProjStart) );
			}
		}
		if ( W.bSniping && Stopped() && (Skill > 5 + 6 * FRand()) )
		{
			// try head
 			FireSpot.Z = FocalPoint.Z + 0.9 * TargetHeight;
 			bClean = FastTrace(FireSpot, ProjStart);
		}

		if ( !bClean )
		{
			//try middle
			FireSpot.Z = FocalPoint.Z;
 			bClean = FastTrace(FireSpot, ProjStart);
		}
		if ( (ProjectileClass != None) && (ProjectileClass.Default.Physics == PHYS_Falling) && !bClean && bEnemyInfoValid )
		{
			FireSpot = LastSeenPos;
	 		HitActor = Trace(HitLocation, HitNormal, FireSpot, ProjStart, false);
			if ( HitActor != None )
			{
				bCanFire = false;
				FireSpot += 2 * TargetHeight * HitNormal;
			}
			bClean = true;
		}

		if( !bClean )
		{
			// try head
 			FireSpot.Z = FocalPoint.Z + 0.9 * TargetHeight;
 			bClean = FastTrace(FireSpot, ProjStart);
		}
		if (!bClean && (Focus == Enemy) && bEnemyInfoValid)
		{
			FireSpot = LastSeenPos;
			if ( Pawn.Location.Z >= LastSeenPos.Z )
				FireSpot.Z -= 0.4 * TargetHeight;
	 		HitActor = Trace(HitLocation, HitNormal, FireSpot, ProjStart, false);
			if ( HitActor != None )
			{
				FireSpot = LastSeenPos + 2 * TargetHeight * HitNormal;
				if ( Pawn.Weapon != None && Pawn.Weapon.GetDamageRadius() > 0 && (Skill >= 4) )
				{
			 		HitActor = Trace(HitLocation, HitNormal, FireSpot, ProjStart, false);
					if ( HitActor != None )
						FireSpot += 2 * TargetHeight * HitNormal;
				}
				if ( UTWeapon(Pawn.Weapon) != None && !UTWeapon(Pawn.Weapon).bFastRepeater )
				{
					bCanFire = false;
				}
			}
		}
		
		FireDir = FireSpot - ProjStart;
	}

	FireRotation = Rotator(FireDir);
	// make sure bot shoots in the direction it's facing
	// our vehicles do their own aim clamping stuff so we don't need this
	if (Vehicle(Pawn) == None)
	{
		FireRotation.Yaw = Pawn.Rotation.Yaw;
	}

	if (ProjectileClass == None)
	{
		InstantWarnTarget(Focus, Pawn.Weapon, vector(FireRotation));
	}
	ShotTarget = Pawn(Focus);

	SetRotation(FireRotation);
	return FireRotation;
}
