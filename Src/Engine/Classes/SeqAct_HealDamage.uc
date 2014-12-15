class SeqAct_HealDamage extends SequenceAction;

/** Type of healing to apply */
var() class<DamageType> DamageType;

/** Amount of healing to apply */
var() int HealAmount;

/** player that should take credit for the healing (Controller or Pawn) */
var Actor Instigator;

defaultproperties
{
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Amount",PropertyName="HealAmount",MinVars=1,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Instigator",PropertyName="Instigator",MinVars=1,MaxVars=255)
   ObjName="Heal Damage"
   ObjCategory="Actor"
   Name="Default__SeqAct_HealDamage"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
