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
		Speed 4;
		Height 52;
		Radius 16;
		Scale 1.1;
		MaxStepHeight 16;
		MaxDropoffHeight 32;
		+FLOORCLIP
		+FRIENDLY
		+PUSHABLE
		+INVULNERABLE
		BloodColor "Red";
		Translation 0;
		//ConversationID 1;
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

Class Test1 : Actor
{
	Default
	{
		//$Category HexedUW/Deco
		Radius 4;
		Height 4;
	}
	
	States
	{
	Spawn:
		BATZ A -1;
		Stop;
	}
}

Class Test2 : Test1
{
	States
	{
	Spawn:
		DEMN A -1;
		Stop;
	}
}

Class Test3 : Test1
{
	States
	{
	Spawn:
		DWRF A -1;
		Stop;
	}
}

Class Test4 : Test1
{
	States
	{
	Spawn:
		DWRF B -1;
		Stop;
	}
}

Class Test5 : Test1
{
	States
	{
	Spawn:
		DWRF C -1;
		Stop;
	}
}

Class Test6 : Test1
{
	States
	{
	Spawn:
		ELEZ A -1;
		Stop;
	}
}

Class Test7 : Test1
{
	States
	{
	Spawn:
		ELEZ B -1;
		Stop;
	}
}

Class Test8 : Test1
{
	States
	{
	Spawn:
		FEFA A -1;
		Stop;
	}
}

Class Test9 : Test1
{
	States
	{
	Spawn:
		FEFA B -1;
		Stop;
	}
}

Class Test10 : Test1
{
	States
	{
	Spawn:
		FEFA C -1;
		Stop;
	}
}

Class Test11 : Test1
{
	States
	{
	Spawn:
		FEWZ A -1;
		Stop;
	}
}

Class Test12 : Test1
{
	States
	{
	Spawn:
		FEWZ B -1;
		Stop;
	}
}

Class Test13 : Test1
{
	States
	{
	Spawn:
		FEWZ C -1;
		Stop;
	}
}

Class Test14 : Test1
{
	States
	{
	Spawn:
		FEWZ D -1;
		Stop;
	}
}

Class Test15 : Test1
{
	States
	{
	Spawn:
		GAZR A -1;
		Stop;
	}
}

Class Test16 : Test1
{
	States
	{
	Spawn:
		GHLZ A -1;
		Stop;
	}
}

Class Test17 : Test1
{
	States
	{
	Spawn:
		GHLZ B -1;
		Stop;
	}
}

Class Test18 : Test1
{
	States
	{
	Spawn:
		GHLZ C -1;
		Stop;
	}
}

Class Test19 : Test1
{
	States
	{
	Spawn:
		GLEM A -1;
		Stop;
	}
}

Class Test20 : Test1
{
	States
	{
	Spawn:
		GLEM B -1;
		Stop;
	}
}

Class Test21 : Test1
{
	States
	{
	Spawn:
		GLEM C -1;
		Stop;
	}
}

Class Test22 : Test1
{
	States
	{
	Spawn:
		GRGO A -1;
		Stop;
	}
}

Class Test23 : Test1
{
	States
	{
	Spawn:
		GRGO B -1;
		Stop;
	}
}

Class Test24 : Test1
{
	States
	{
	Spawn:
		GRGO C -1;
		Stop;
	}
}

Class Test25 : Test1
{
	States
	{
	Spawn:
		GSTZ A -1;
		Stop;
	}
}

Class Test26 : Test1
{
	States
	{
	Spawn:
		GSTZ B -1;
		Stop;
	}
}

Class Test27 : Test1
{
	States
	{
	Spawn:
		GSTZ C -1;
		Stop;
	}
}

Class Test28 : Test1
{
	States
	{
	Spawn:
		GSTZ D -1;
		Stop;
	}
}

Class Test29 : Test1
{
	States
	{
	Spawn:
		GYGO A -1;
		Stop;
	}
}

Class Test30 : Test1
{
	States
	{
	Spawn:
		GYGO B -1;
		Stop;
	}
}

Class Test31 : Test1
{
	States
	{
	Spawn:
		GYGO C -1;
		Stop;
	}
}

Class Test32 : Test1
{
	States
	{
	Spawn:
		HLSS A -1;
		Stop;
	}
}

Class Test33 : Test1
{
	States
	{
	Spawn:
		IMPZ A -1;
		Stop;
	}
}

Class Test34 : Test1
{
	States
	{
	Spawn:
		IMPZ B -1;
		Stop;
	}
}

Class Test35 : Test1
{
	States
	{
	Spawn:
		LIZM A -1;
		Stop;
	}
}

Class Test36 : Test1
{
	States
	{
	Spawn:
		LIZM B -1;
		Stop;
	}
}

Class Test37 : Test1
{
	States
	{
	Spawn:
		LIZM C -1;
		Stop;
	}
}

Class Test38 : Test1
{
	States
	{
	Spawn:
		LURK A -1;
		Stop;
	}
}

Class Test39 : Test1
{
	States
	{
	Spawn:
		LURK B -1;
		Stop;
	}
}

Class Test40 : Test1
{
	States
	{
	Spawn:
		MAFA A -1;
		Stop;
	}
}

Class Test41 : Test1
{
	States
	{
	Spawn:
		MAFA B -1;
		Stop;
	}
}

Class Test42 : Test1
{
	States
	{
	Spawn:
		MAFA C -1;
		Stop;
	}
}

Class Test43 : Test1
{
	States
	{
	Spawn:
		MAFA D -1;
		Stop;
	}
}

Class Test44 : Test1
{
	States
	{
	Spawn:
		RATZ A -1;
		Stop;
	}
}

Class Test45 : Test1
{
	States
	{
	Spawn:
		RATZ B -1;
		Stop;
	}
}

Class Test46 : Test1
{
	States
	{
	Spawn:
		REPR A -1;
		Stop;
	}
}

Class Test47 : Test1
{
	States
	{
	Spawn:
		ROTW A -1;
		Stop;
	}
}

Class Test48 : Test1
{
	States
	{
	Spawn:
		ROTW B -1;
		Stop;
	}
}

Class Test49 : Test1
{
	States
	{
	Spawn:
		SHAW A -1;
		Stop;
	}
}

Class Test50 : Test1
{
	States
	{
	Spawn:
		SHAW B -1;
		Stop;
	}
}

Class Test51 : Test1
{
	States
	{
	Spawn:
		SKLN A -1;
		Stop;
	}
}

Class Test52 : Test1
{
	States
	{
	Spawn:
		SLUG A -1;
		Stop;
	}
}

Class Test53 : Test1
{
	States
	{
	Spawn:
		SLUG B -1;
		Stop;
	}
}

Class Test54 : Test1
{
	States
	{
	Spawn:
		SPDZ A -1;
		Stop;
	}
}

Class Test55 : Test1
{
	States
	{
	Spawn:
		SPDZ B -1;
		Stop;
	}
}

Class Test56 : Test1
{
	States
	{
	Spawn:
		SPDZ C -1;
		Stop;
	}
}

Class Test57 : Test1
{
	States
	{
	Spawn:
		TROZ A -1;
		Stop;
	}
}

Class Test58 : Test1
{
	States
	{
	Spawn:
		TROZ B -1;
		Stop;
	}
}

Class Test59 : Test1
{
	States
	{
	Spawn:
		TROZ C -1;
		Stop;
	}
}

Class Test60 : Test1
{
	States
	{
	Spawn:
		WISP A -1;
		Stop;
	}
}

Class Test61 : Test1
{
	States
	{
	Spawn:
		WIZZ A -1;
		Stop;
	}
}

Class Test62 : Test1
{
	States
	{
	Spawn:
		WIZZ B -1;
		Stop;
	}
}

Class Test63 : Test1
{
	States
	{
	Spawn:
		WIZZ C -1;
		Stop;
	}
}

Class Test64 : Test1
{
	States
	{
	Spawn:
		WIZZ D -1;
		Stop;
	}
}

Class Test65 : Test1
{
	States
	{
	Spawn:
		WIZZ E -1;
		Stop;
	}
}

Class Test66 : Test1
{
	States
	{
	Spawn:
		WIZZ F -1;
		Stop;
	}
}

Class Test67 : Test1
{
	States
	{
	Spawn:
		WIZZ G -1;
		Stop;
	}
}

Class Test68 : Test1
{
	States
	{
	Spawn:
		WIZZ H -1;
		Stop;
	}
}