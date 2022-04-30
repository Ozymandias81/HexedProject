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

class HUW_Skeleton : Actor
{
	Default
	{
		//$Category HexedUW/Critters
		//$Title Skeleton
		//$Color 4
		Health 300;
		PainChance 64;
		Speed 5;
		Radius 24;
		Height 64;
		Mass 400;
		Monster;
		Scale 0.65;
		+FLOORCLIP
		+NOBLOOD
		+NOBLOODDECALS
		Tag "Skeleton";
		SeeSound "m_fighter/sight";
		PainSound "m_fighter/pain";
		AttackSound "m_fighter/attack";
		DeathSound "m_fighter/death";
		ActiveSound "m_fighter/active";
		Obituary "$OB_SKELET";
	}

	States
	{
	Spawn:
		UWSK A 5 A_Look2;
		Wait;
		UWSK E 8;
		Loop;
		UWSK G 8;
		Loop;
		UWSK FFEEGG 8;
		Loop;
	See:
		UWSK ABCD 6 A_Chase;
		Loop;
	Melee:
		UWSK HIJ 6 A_FaceTarget;
		UWSK "#" 0 A_Jump(255,"Melee.Bash", "Melee.Slash", "Melee.Stab");
		Stop;
	Melee.Bash:
		UWSK K 7 A_FaceTarget;
		UWSK O 8 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		Goto See;
	Melee.Slash:
		UWSK MN 7 A_FaceTarget;
		UWSK O 8 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		UWSK PQ 5 A_FaceTarget;
		Goto See;
	Melee.Stab:
		UWSK QM 7 A_FaceTarget;
		UWSK L 8 A_CustomMeleeAttack(Random(4, 10), "m_fighter/attack", "m_fighter/attack");
		Goto See;
	Pain:
		UWSK I 8;
		UWSK H 8 A_Pain;
		Goto See;
	Death:
		UWSK H 7 A_Scream;
		UWSK J 8;
		UWSK Q 9 A_NoBlocking;
		UWSK RS 7;
		UWSK T -1;
		Stop;
	}
}
