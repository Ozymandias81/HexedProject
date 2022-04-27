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

Class PaganU8 : Ettin
{
	Default
	{
		//$Category HexedUW/EasterEggs
		//$Title "Avatar from Ultima 8"
		Tag "Avatar";
		Speed 4;
		Height 52;
		Radius 16;
		Scale 1.3;
		MaxStepHeight 16;
		MaxDropoffHeight 32;
		+FLOORCLIP
		+FRIENDLY
		+PUSHABLE
		+INVULNERABLE
	}
	
	States
	{
	Spawn:
		AVTR A 1 A_Look2;
		Loop;
	See:
		AVTR BCDEFGHI 4 A_Wander;
		Loop;
	}
}