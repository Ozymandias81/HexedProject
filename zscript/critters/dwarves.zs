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

class HUW_Dwarf1 : Actor
{
	Default
	{
		//$Category HexedUW/Critters
		//$Title Mountainman, Red
		//$Color 4
		Health 350;
		PainChance 150;
		Speed 7;
		Radius 20;
		Height 56;
		Mass 400;
		Monster;
		Scale 0.65;
		+SEESDAGGERS
		+FLOORCLIP
		+NEVERRESPAWN
		Tag "Mountainman";
		SeeSound "m_dwarf/sight";
		PainSound "m_dwarf/pain";
		AttackSound "m_dwarf/attack";
		DeathSound "m_dwarf/death";
		ActiveSound "m_dwarf/active";
		Obituary "$OB_DWARF1";
	}

	States
	{
	Spawn:
		DWA1 F 8 A_Look2;
		Wait;
		DWA1 E 8;
		Loop;
		DWA1 G 8;
		Loop;
		DWA1 FFEEGG 12;
		Loop;
	See:
		DWA1 ABCD 6 Fast Slow A_Chase;
		Loop;
	Melee:
		DWA1 HIJ 6 A_FaceTarget; //this should be played only once --ozy81
		DWA1 KLM 6 A_FaceTarget;
		DWA1 "#" 0 A_Jump(255,"Melee.Bash", "Melee.Slash");
		Stop;
	Melee.Bash:
		DWA1 NOP 6 A_FaceTarget;
		DWA1 Q 8 A_CustomMeleeAttack(Random(4, 10), "m_dwarf/attack", "m_dwarf/attack");
		Goto See;
	Melee.Slash:
		DWA1 R 5 A_FaceTarget;
		DWA1 S 7 A_CustomMeleeAttack(Random(4, 10), "m_dwarf/attack", "m_dwarf/attack");
		DWA1 T 3 A_FaceTarget;
		Goto See;
	Pain:
		DWA1 K 8 Fast Slow A_Pain;
		Goto See;
	Death:
		DWA1 JM 7 A_Scream;
		DWA1 U 8;
		DWA1 V 9 A_NoBlocking;
		DWA1 W 10;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}
}

class HUW_Dwarf2 : HUW_Dwarf1
{	
	Default
	{
		//$Title Mountainman, Old
		Health 300;
		Obituary "$OB_DWARF2";
	}

	States
	{
	Spawn:
		DWA2 F 8 A_Look2;
		Wait;
		DWA2 E 8;
		Loop;
		DWA2 G 8;
		Loop;
		DWA2 FFEEGG 12;
		Loop;
	See:
		DWA2 ABCD 6 Fast Slow A_Chase;
		Loop;
	Melee:
		DWA2 HIJ 6 A_FaceTarget; //this should be played only once --ozy81
		DWA2 KLM 6 A_FaceTarget;
		DWA2 "#" 0 A_Jump(255,"Melee.Bash", "Melee.Slash");
		Stop;
	Melee.Bash:
		DWA2 NOP 6 A_FaceTarget;
		DWA2 Q 8 A_CustomMeleeAttack(Random(4, 10), "m_dwarf/attack", "m_dwarf/attack");
		Goto See;
	Melee.Slash:
		DWA2 R 5 A_FaceTarget;
		DWA2 S 7 A_CustomMeleeAttack(Random(4, 10), "m_dwarf/attack", "m_dwarf/attack");
		DWA2 T 3 A_FaceTarget;
		Goto See;
	Pain:
		DWA2 K 8 Fast Slow A_Pain;
		Goto See;
	Death:
		DWA2 JM 7 A_Scream;
		DWA2 U 8;
		DWA2 V 9 A_NoBlocking;
		DWA2 W 10;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}
}

class HUW_Dwarf3 : HUW_Dwarf1
{	
	Default
	{
		//$Title Mountainman, Blonde
		Health 375;
		Obituary "$OB_DWARF3";
	}

	States
	{
	Spawn:
		DWA3 F 8 A_Look2;
		Wait;
		DWA3 E 8;
		Loop;
		DWA3 G 8;
		Loop;
		DWA3 FFEEGG 12;
		Loop;
	See:
		DWA3 ABCD 6 Fast Slow A_Chase;
		Loop;
	Melee:
		DWA3 HIJ 6 A_FaceTarget; //this should be played only once --ozy81
		DWA3 KLM 6 A_FaceTarget;
		DWA3 "#" 0 A_Jump(255,"Melee.Bash", "Melee.Slash");
		Stop;
	Melee.Bash:
		DWA3 NOP 6 A_FaceTarget;
		DWA3 Q 8 A_CustomMeleeAttack(Random(4, 10), "m_dwarf/attack", "m_dwarf/attack");
		Goto See;
	Melee.Slash:
		DWA3 R 5 A_FaceTarget;
		DWA3 S 7 A_CustomMeleeAttack(Random(4, 10), "m_dwarf/attack", "m_dwarf/attack");
		DWA3 T 3 A_FaceTarget;
		Goto See;
	Pain:
		DWA3 K 8 Fast Slow A_Pain;
		Goto See;
	Death:
		DWA3 JM 7 A_Scream;
		DWA3 U 8;
		DWA3 V 9 A_NoBlocking;
		DWA3 W 10;
		UWDT G -1 A_SetScale(0.45);
		Stop;
	}
}