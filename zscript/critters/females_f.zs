/*
 * Copyright (c) 2022 Ozymandias81
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
**/

class HUW_FemaleF1 : Actor
{
	Default
	{
		//$Category HexedUW/Critters
		//$Title Female Fighter, Default
		//$Color 4
		Health 250;
		PainChance 150;
		Speed 7;
		Radius 24;
		Height 64;
		Mass 400;
		Monster;
		Scale 0.65;
		+SEESDAGGERS
		+FLOORCLIP
		+NEVERRESPAWN
		Tag "Female Fighter";
		SeeSound "f_fighter/sight";
		PainSound "f_fighter/pain";
		AttackSound "f_fighter/attack";
		DeathSound "f_fighter/death";
		ActiveSound "f_fighter/active";
		Obituary "$OB_FEMFI1";
	}

	States
	{
	Spawn:
		FEF1 A 5 A_Look2;
		Wait;
		FEF1 E 8;
		Loop;
		FEF1 G 8;
		Loop;
		FEF1 FFEEGG 8;
		Loop;
	See:
		FEF1 ABCD 6 Fast Slow A_Chase;
		Loop;
	Melee:
		FEF1 HIJ 6 A_FaceTarget;
		FEF1 "#" 0 A_Jump(255,"Melee.Bash", "Melee.Slash", "Melee.Stab");
		Stop;
	Melee.Bash:
		FEF1 K 5 A_FaceTarget;
		FEF1 L 7 A_CustomMeleeAttack(Random(4, 10), "f_fighter/attack", "f_fighter/attack");
		Goto See;
	Melee.Slash:
		FEF1 M 5 A_FaceTarget;
		FEF1 N 7 A_CustomMeleeAttack(Random(4, 10), "f_fighter/attack", "f_fighter/attack");
		FEF1 O 3 A_FaceTarget;
		Goto See;
	Melee.Stab:
		FEF1 K 5 A_FaceTarget;
		FEF1 P 7 A_CustomMeleeAttack(Random(4, 10), "f_fighter/attack", "f_fighter/attack");
		Goto See;
	Pain:
		FEF1 J 8 Fast Slow A_Pain;
		Goto See;
	Death:
		FEF1 H 7 A_Scream;
		FEF1 J 8;
		FEF1 Q 9 A_NoBlocking;
		FEF1 R 10;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}
}

class HUW_FemaleF2 : HUW_FemaleF1
{
	Default
	{
		//$Title Female Fighter, Black
		Obituary "$OB_FEMFI2";
	}

	States
	{
	Spawn:
		FEF2 A 5 A_Look2;
		Wait;
		FEF2 E 8;
		Loop;
		FEF2 G 8;
		Loop;
		FEF2 FFEEGG 8;
		Loop;
	See:
		FEF2 ABCD 6 Fast Slow A_Chase;
		Loop;
	Melee:
		FEF2 HIJ 6 A_FaceTarget;
		FEF2 "#" 0 A_Jump(255,"Melee.Bash", "Melee.Slash", "Melee.Stab");
		Stop;
	Melee.Bash:
		FEF2 K 5 A_FaceTarget;
		FEF2 L 7 A_CustomMeleeAttack(Random(4, 10), "f_fighter/attack", "f_fighter/attack");
		Goto See;
	Melee.Slash:
		FEF2 M 5 A_FaceTarget;
		FEF2 N 7 A_CustomMeleeAttack(Random(4, 10), "f_fighter/attack", "f_fighter/attack");
		FEF2 O 3 A_FaceTarget;
		Goto See;
	Melee.Stab:
		FEF2 K 5 A_FaceTarget;
		FEF2 P 7 A_CustomMeleeAttack(Random(4, 10), "f_fighter/attack", "f_fighter/attack");
		Goto See;
	Pain:
		FEF2 J 8 Fast Slow A_Pain;
		Goto See;
	Death:
		FEF2 H 7 A_Scream;
		FEF2 J 8;
		FEF2 Q 9 A_NoBlocking;
		FEF2 R 10;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}
}

class HUW_FemaleF3 : HUW_FemaleF1
{
	Default
	{
		//$Title Female Fighter, Blonde
		Obituary "$OB_FEMFI3";
	}

	States
	{
	Spawn:
		FEF3 A 5 A_Look2;
		Wait;
		FEF3 E 8;
		Loop;
		FEF3 G 8;
		Loop;
		FEF3 FFEEGG 8;
		Loop;
	See:
		FEF3 ABCD 6 Fast Slow A_Chase;
		Loop;
	Melee:
		FEF3 HIJ 6 A_FaceTarget;
		FEF3 "#" 0 A_Jump(255,"Melee.Bash", "Melee.Slash", "Melee.Stab");
		Stop;
	Melee.Bash:
		FEF3 K 5 A_FaceTarget;
		FEF3 L 7 A_CustomMeleeAttack(Random(4, 10), "f_fighter/attack", "f_fighter/attack");
		Goto See;
	Melee.Slash:
		FEF3 M 5 A_FaceTarget;
		FEF3 N 7 A_CustomMeleeAttack(Random(4, 10), "f_fighter/attack", "f_fighter/attack");
		FEF3 O 3 A_FaceTarget;
		Goto See;
	Melee.Stab:
		FEF3 K 5 A_FaceTarget;
		FEF3 P 7 A_CustomMeleeAttack(Random(4, 10), "f_fighter/attack", "f_fighter/attack");
		Goto See;
	Pain:
		FEF3 J 8 Fast Slow A_Pain;
		Goto See;
	Death:
		FEF3 H 7 A_Scream;
		FEF3 J 8;
		FEF3 Q 9 A_NoBlocking;
		FEF3 R 10;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}
}