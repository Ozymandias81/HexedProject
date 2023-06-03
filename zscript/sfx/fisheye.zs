/*
 * Copyright (c) 2023 Nash Muhandes
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

/*class FishEyePostProcessHandler : StaticEventHandler
{
	override void RenderOverlay(RenderEvent e)
	{
		FishEye(e);
	}

	ui void FishEye(RenderEvent e)
	{
		PPShader.SetEnabled("fisheyeshader", true);
	}
}*/

class FishEyeEffectGiver : EffectGiver //just a copypaste for now
{
	Default
	{
		//$Title FishEye Effect Giver
		StencilColor "Green";
		EffectGiver.Control "FishEyeControl";
	}
}

class FishEyeControl : ShaderControl
{
	int holdTarget;

	Default
	{
		ShaderControl.Shader "fisheyeshader";
		Inventory.MaxAmount 350;
	}

	override void DoEffect()
	{
		if (amount > 1) { holdTarget = level.time + amount; } // Set hold time based on amount in inventory

		if (holdTarget && level.time > holdTarget) // If we've hit the hold time, remove the effect
		{
			amount = 1;
			holdTarget = 0;
		}
		else if (holdTarget)
		{
			amount = max(amount - 8, 1);
		}
	}
}
