/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTOnslaughtRedCoreMessage extends UTOnslaughtBlueCoreMessage;

defaultproperties
{
   PowerCoreAttackedString="Nucleo Rosso sotto Attacco!"
   PowerCoreDestroyedString="Nucleo Rosso Distrutto"
   PowerCoreCriticalString="Nucleo Rosso in Situazione Critica!"
   PowerCoreVulnerableString="Nucleo Rosso Vulnerabile!"
   PowerCoreDamagedString="Nucleo Rosso Gravemente Danneggiato!"
   PowerCoreSecureString="Il Nucleo rosso è sicuro.."
   MessageAnnouncements(0)=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_RedCoreIsUnderAttack'
   MessageAnnouncements(1)=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_RedCoreDestroyed'
   MessageAnnouncements(2)=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_RedCoreIsCritical'
   MessageAnnouncements(3)=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_RedCoreIsVulnerable'
   MessageAnnouncements(4)=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_RedCoreIsHeavilyDamaged'
   MessageAnnouncements(6)=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_RedCoreIsSecure'
   DrawColor=(B=48,G=64,R=255,A=255)
   Name="Default__UTOnslaughtRedCoreMessage"
   ObjectArchetype=UTOnslaughtBlueCoreMessage'UTGameContent.Default__UTOnslaughtBlueCoreMessage'
}
