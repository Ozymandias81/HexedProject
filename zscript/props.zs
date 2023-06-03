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

class HUW_Sack1 : Actor
{
	Default
	{
		//$Category HexedUW/Pickups
		//$Title A Sack (Closed)
		Height 16;
		Radius 8;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWCK A -1;
		Stop;
	}
}

class HUW_Pack1 : Actor
{
	Default
	{
		//$Category HexedUW/Pickups
		//$Title A Pack
		Height 16;
		Radius 8;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWPC A -1;
		Stop;
	}
}

class HUW_Box1 : Actor
{
	Default
	{
		//$Category HexedUW/Pickups
		//$Title A Box (big)
		Height 16;
		Radius 8;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWBX A -1;
		Stop;
	}
}

class HUW_Plant1 : Actor
{
	Default
	{
		//$Category HexedUW/Decorations
		//$Title A Plant (not edible)
		Height 4;
		Radius 4;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWPT A -1;
		Stop;
	}
}

class HUW_Grass1 : Actor
{
	Default
	{
		//$Category HexedUW/Decorations
		//$Title Some Grass
		Height 4;
		Radius 4;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWNA A -1;
		Stop;
	}
}

class HUW_Skull1 : Actor
{
	Default
	{
		//$Category HexedUW/Decorations
		//$Title A Skull (1)
		Height 4;
		Radius 4;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWKL A -1;
		Stop;
	}
}

class HUW_Skull2 : HUW_Skull1
{
	Default
	{
		//$Title A Skull (2)
	}
	
	States
	{
	Spawn:
		UWKL B -1;
		Stop;
	}
}

class HUW_Bone1 : HUW_Skull1
{
	Default
	{
		//$Title A Bone (1)
	}
	
	States
	{
	Spawn:
		UWBN A -1;
		Stop;
	}
}

class HUW_Bone2 : HUW_Skull1
{
	Default
	{
		//$Title A Bone (2)
	}
	
	States
	{
	Spawn:
		UWBN B -1;
		Stop;
	}
}

class HUW_PileOfBones1 : HUW_Skull1
{
	Default
	{
		//$Title A Pile of Bones (1)
	}
	
	States
	{
	Spawn:
		UWBN C -1;
		Stop;
	}
}

class HUW_DebrisAxe : Actor
{
	Default
	{
		//$Category HexedUW/Decorations
		//$Title Broken Axe
		Height 4;
		Radius 4;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWAX D -1;
		Stop;
	}
}

class HUW_WoodStick1 : Actor
{
	Default
	{
		//$Category HexedUW/Decorations
		//$Title A Piece of Wood (1)
		Height 4;
		Radius 4;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWWS A -1;
		Stop;
	}
}

class HUW_WoodStick2 : HUW_WoodStick1
{
	Default
	{
		//$Title A Piece of Wood (2)
	}
	
	States
	{
	Spawn:
		UWWS B -1;
		Stop;
	}
}

class HUW_EdiblePlant1 : Actor
{
	Default
	{
		//$Category HexedUW/Pickups
		//$Title A Plant (Edible A)
		Height 4;
		Radius 4;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWPT B -1;
		Stop;
	}
}

class HUW_EdiblePlant2 : HUW_EdiblePlant1
{
	Default
	{
		//$Title A Plant (Edible B)
	}
	
	States
	{
	Spawn:
		UWPT C -1;
		Stop;
	}
}

class HUW_DebrisPile1 : Actor
{
	Default
	{
		//$Category HexedUW/Decorations
		//$Title A Pile of Debris (1)
		Height 4;
		Radius 4;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWDB A -1;
		Stop;
	}
}

class HUW_DebrisPile2 : HUW_DebrisPile1
{
	Default
	{
		//$Title A Pile of Debris (2)
	}
	
	States
	{
	Spawn:
		UWDB B -1;
		Stop;
	}
}

class HUW_DebrisPile6 : HUW_DebrisPile1
{
	Default
	{
		//$Title A Pile of Debris (6)
	}
	
	States
	{
	Spawn:
		UWDB E -1;
		Stop;
	}
}

class HUW_WoodenPole : Actor
{
	Default
	{
		//$Category HexedUW/Interactives
		//$Title A Wooden Pole
		Height 16;
		Radius 8;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWPE A -1;
		Stop;
	}
}

class HUW_BloodPool1 : Actor
{
	Default
	{
		//$Category HexedUW/Decorations
		//$Title A Blood Pool (1)
		Height 4;
		Radius 4;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWDT F -1;
		Stop;
	}
}

class HUW_BloodPool2 : HUW_BloodPool1
{
	Default
	{
		//$Title A Blood Pool (2)
	}
	
	States
	{
	Spawn:
		UWDT G -1;
		Stop;
	}
}

class HUW_Cauldron1 : Actor
{
	Default
	{
		//$Category HexedUW/Decorations
		//$Title A Cauldron
		Height 16;
		Radius 16;
		Scale 0.45;
		+NOGRAVITY;
	}
	
	States
	{
	Spawn:
		UWCA A -1;
		Stop;
	}
}