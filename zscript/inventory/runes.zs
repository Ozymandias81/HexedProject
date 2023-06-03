/*
 * Copyright (c) 2023 Ozymandias81
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

class HUW_RuneBase : Actor
{	
	Default
	{
		//$Category HexedUW/Runes
		Height 8;
		Radius 8;
		Scale 0.45;
		+NOGRAVITY;
	}

	//To be programmed

}

class HUW_RuneJux : HUW_RuneBase
{
	Default
	{
		//$Title Rune - Jux
	}
	
	States
	{
	Spawn:
		UWRU J -1;
		Stop;
	}
}

class HUW_RuneOrt : HUW_RuneBase
{
	Default
	{
		//$Title Rune - Ort
	}
	
	States
	{
	Spawn:
		UWRU O -1;
		Stop;
	}
}