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

Class HUW_Ankh : Actor
{
	Default
	{
		//$Category HexedUW/Interactives
		//$Title Ankh
		Radius 16;
		Height 48;
		+NOBLOOD
		+NOBLOODDECALS
		+NOTAUTOAIMED
		+SHOOTABLE
		+SOLID
	}
	
	States
	{
	Spawn:
		MDLS A -1;
		Stop;
	}
}

Class HUW_Rock1 : Actor
{
	Default
	{
		//$Category HexedUW/Destroyable
		//$Title Large Boulder (Grey)
		Radius 48;
		Height 48;
		+NOBLOOD
		+NOBLOODDECALS
		+NOTAUTOAIMED
		+MOVEWITHSECTOR
		+SHOOTABLE
		+SOLID
	}
	
	States
	{
	Spawn:
		MDLS A -1;
		Stop;
	}
}

Class HUW_Table1 : Actor
{
	Default
	{
		//$Category HexedUW/Props
		//$Title Wooden Table
		Radius 28;
		Height 36;
		+CANPASS
		+NOBLOOD
		+NOBLOODDECALS
		+NOTAUTOAIMED
		+SHOOTABLE
		+SOLID
	}
	
	States
	{
	Spawn:
		MDLS A -1;
		Stop;
	}
}