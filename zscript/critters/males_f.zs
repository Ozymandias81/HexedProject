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

class HUW_MaleF1 : Actor
{
	Default
	{
		//$Category HexedUW/Critters
		//$Title Male Fighter, Default
		//$Color 4
		Health 350;
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
		Tag "Male Fighter";
		SeeSound "m_fighter/sight";
		PainSound "m_fighter/pain";
		AttackSound "m_fighter/attack";
		DeathSound "m_fighter/death";
		ActiveSound "m_fighter/active";
		Obituary "$OB_MALFI1";
	}

	States
	{
	Spawn:
		MAF1 A 5 A_Look2;
		Wait;
		MAF1 E 8;
		Loop;
		MAF1 G 8;
		Loop;
		MAF1 FFEEGG 8;
		Loop;
	See:
		MAF1 ABCD 6 Fast Slow A_Chase;
		Loop;
	Melee:
		MAF1 HIJ 6 A_FaceTarget;
		MAF1 "#" 0 A_Jump(255,"Melee.Bash", "Melee.Slash", "Melee.Stab");
		Stop;
	Melee.Bash:
		MAF1 K 5 A_FaceTarget;
		MAF1 L 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		Goto See;
	Melee.Slash:
		MAF1 M 5 A_FaceTarget;
		MAF1 N 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		MAF1 O 3 A_FaceTarget;
		Goto See;
	Melee.Stab:
		MAF1 K 5 A_FaceTarget;
		MAF1 P 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		Goto See;
	Pain:
		MAF1 J 8 Fast Slow A_Pain;
		Goto See;
	Death:
		MAF1 H 7 A_Scream;
		MAF1 J 8;
		MAF1 Q 9 A_NoBlocking;
		MAF1 R 10;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}
}

class HUW_MaleF2 : HUW_MaleF1
{
	Default
	{
		//$Title Male Fighter, Gray
		Obituary "$OB_MALFI2";
	}

	States
	{
	Spawn:
		MAF2 A 5 A_Look2;
		Wait;
		MAF2 E 8;
		Loop;
		MAF2 G 8;
		Loop;
		MAF2 FFEEGG 8;
		Loop;
	See:
		MAF2 ABCD 6 Fast Slow A_Chase;
		Loop;
	Melee:
		MAF2 HIJ 6 A_FaceTarget;
		MAF2 "#" 0 A_Jump(255,"Melee.Bash", "Melee.Slash", "Melee.Stab");
		Stop;
	Melee.Bash:
		MAF2 K 5 A_FaceTarget;
		MAF2 L 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		Goto See;
	Melee.Slash:
		MAF2 M 5 A_FaceTarget;
		MAF2 N 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		MAF2 O 3 A_FaceTarget;
		Goto See;
	Melee.Stab:
		MAF2 K 5 A_FaceTarget;
		MAF2 P 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		Goto See;
	Pain:
		MAF2 J 8 Fast Slow A_Pain;
		Goto See;
	Death:
		MAF2 H 7 A_Scream;
		MAF2 J 8;
		MAF2 Q 9 A_NoBlocking;
		MAF2 R 10;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}
}

class HUW_MaleF3 : HUW_MaleF1
{
	Default
	{
		//$Title Male Fighter, Green
		Obituary "$OB_MALFI3";
	}

	States
	{
	Spawn:
		MAF3 A 5 A_Look2;
		Wait;
		MAF3 E 8;
		Loop;
		MAF3 G 8;
		Loop;
		MAF3 FFEEGG 8;
		Loop;
	See:
		MAF3 ABCD 6 Fast Slow A_Chase;
		Loop;
	Melee:
		MAF3 HIJ 6 A_FaceTarget;
		MAF3 "#" 0 A_Jump(255,"Melee.Bash", "Melee.Slash", "Melee.Stab");
		Stop;
	Melee.Bash:
		MAF3 K 5 A_FaceTarget;
		MAF3 L 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		Goto See;
	Melee.Slash:
		MAF3 M 5 A_FaceTarget;
		MAF3 N 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		MAF3 O 3 A_FaceTarget;
		Goto See;
	Melee.Stab:
		MAF3 K 5 A_FaceTarget;
		MAF3 P 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		Goto See;
	Pain:
		MAF3 J 8 Fast Slow A_Pain;
		Goto See;
	Death:
		MAF3 H 7 A_Scream;
		MAF3 J 8;
		MAF3 Q 9 A_NoBlocking;
		MAF3 R 10;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}
}

class HUW_MaleF4 : HUW_MaleF1
{
	Default
	{
		//$Title Male Fighter, Black
		Obituary "$OB_MALFI4";
	}

	States
	{
	Spawn:
		MAF4 A 5 A_Look2;
		Wait;
		MAF4 E 8;
		Loop;
		MAF4 G 8;
		Loop;
		MAF4 FFEEGG 8;
		Loop;
	See:
		MAF4 ABCD 6 Fast Slow A_Chase;
		Loop;
	Melee:
		MAF4 HIJ 6 A_FaceTarget;
		MAF4 "#" 0 A_Jump(255,"Melee.Bash", "Melee.Slash", "Melee.Stab");
		Stop;
	Melee.Bash:
		MAF4 K 5 A_FaceTarget;
		MAF4 L 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		Goto See;
	Melee.Slash:
		MAF4 M 5 A_FaceTarget;
		MAF4 N 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		MAF4 O 3 A_FaceTarget;
		Goto See;
	Melee.Stab:
		MAF4 K 5 A_FaceTarget;
		MAF4 P 7 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		Goto See;
	Pain:
		MAF4 J 8 Fast Slow A_Pain;
		Goto See;
	Death:
		MAF4 H 7 A_Scream;
		MAF4 J 8;
		MAF4 Q 9 A_NoBlocking;
		MAF4 R 10;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}
}