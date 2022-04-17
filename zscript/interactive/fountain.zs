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
		+DONTTHRUST
		+NOBLOOD
		+NOBLOODDECALS
		+NOTAUTOAIMED
		+SHOOTABLE
		+SOLID
		+USESPECIAL
		Activation THINGSPEC_Switch|THINGSPEC_Activate;
		Tag "$UWTAGFOUN";
	}
	
	States
	{
	Active:
		UWFN A 0 A_RadiusGive("CrystalVial",128.0,RGF_PLAYERS|RGF_NOSIGHT,10);
		"####" A 1 A_StartSound("SFX/FlowLoop", CHAN_BODY, CHANF_LOOPING, 0.7, ATTN_STATIC);
	Spawn:
		UWFN BCDA 8;
		Loop;
	Inactive:
		UWFN E 1 A_StopSound(CHAN_BODY);
		"####" E -1;
		Stop;
	}
}