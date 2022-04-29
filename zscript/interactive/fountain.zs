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
*/

//===========================================================================
//
// Fountain of Rejuvenation
//
//===========================================================================

class HUW_Fountain : SwitchableDecoration
{
	Default
	{
		//$Category HexedUW/Interactives
		//$Title Fountain of Rejuvenation
		//$Color 3
		Radius 16;
		Height 56;
		Scale 0.45;
		+DONTSPLASH
		+DONTTHRUST
		+INVULNERABLE
		+LOOKALLAROUND //this is needed otherwise we can drink only while in front of it - ozy81
		+NOBLOOD
		+NOBLOODDECALS
		+NOTAUTOAIMED
		+SHOOTABLE
		+SOLID
		+USESPECIAL
		Activation THINGSPEC_Switch | THINGSPEC_ThingTargets;
		Tag "$UWTAGFOUN";
	}
	
	States
	{
	Active:
		UWFN A 0 A_JumpIfHealthLower(100, 1, AAPTR_TARGET);
		Goto Inactive;
		"####" A 0 A_GiveInventory("FountainCounter", 1);
		"####" A 0 A_RadiusGive("CrystalVial",128.0,RGF_PLAYERS|RGF_NOSIGHT,10);
		"####" A 0 A_JumpIfInventory("FountainCounter", 1, "Dry");
		Goto Inactive;
	Spawn:
		UWFN A 0 NODELAY A_StartSound("SFX/FlowLoop", CHAN_BODY, CHANF_LOOPING, 0.7, ATTN_STATIC);
	Inactive:
		UWFN BCDA 8;
		Loop;
	SpawnSet2:
		"####" E -1;
		Stop;
	Dry:
		//"####" A 0 A_RemoveChildren(TRUE, RMVF_MISC);
		"####" A 0 A_StopSound(CHAN_BODY);
		"####" A 0 {bUseSpecial = FALSE;}
		Goto SpawnSet2;
	}
}