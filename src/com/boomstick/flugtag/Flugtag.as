package com.boomstick.flugtag {
	import com.boomstick.flugtag.states.GameState;
	import org.flixel.FlxGame;

	[SWF(height="1280", width="768", frameRate="60",
	backgroundColor="#FFFFFF")]   
	
	//[SWF(width="1024", height="600", frameRate="60",
	//backgroundColor="#FFFFFF")]   
	
	dynamic public class Flugtag extends FlxGame {
		public function Flugtag() {
			//super(1024, 600, GameState, 1, 60, 60, true);
			super(1280, 768, GameState, 1, 60, 60, true);
		}
	}
}
