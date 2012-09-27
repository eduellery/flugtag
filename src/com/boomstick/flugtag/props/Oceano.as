package com.boomstick.flugtag.props {
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	/**
	 * Sprite do oceano, se atualiza e loopa automaticamente
	 * @author Oscar
	 */
	public class Oceano extends FlxSprite {
				
		[Embed(source = "wave.jpg")] 
		private var wavetJPG:Class;
		
		public function Oceano(mult:int) {
			super();
			this.width = 128;
			this.height = 116;
			this.x = 0 + this.width*mult;
			this.y = FlxG.height - this.height;
			this.loadGraphic(wavetJPG);
		}
	}
}