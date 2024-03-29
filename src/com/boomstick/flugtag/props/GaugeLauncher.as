package com.boomstick.flugtag.props {
	import com.boomstick.flugtag.utils.VisualAssets;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	/**
	 * Medidor de lançamento
	 * @author Oscar
	 */
	public class GaugeLauncher extends FlxSprite {
		
		public var redCan:FlxSprite;
		
		private var border:uint;
				
		private var MAX_SPEED:uint = 300;
		
		public function GaugeLauncher() {
			this.border = 16;
			
			this.loadGraphic(VisualAssets.BARRA);
			this.x = FlxG.width/2 - this.width/2;
			this.y = FlxG.height - ( 64 + border); 
			
			redCan = new FlxSprite();
			redCan.loadGraphic(VisualAssets.LATA);
			redCan.width = 128;
			redCan.height = 128;
			redCan.x = this.x + border;
			redCan.y = y  - redCan.height/2 + height/2;
			redCan.velocity.x = 1000;
		}
		
		override public function update():void {	
			if (redCan.x + redCan.width > this.x + this.width - border ||
				redCan.x < this.x + border) {
				redCan.velocity.x *= -1;
			}
		}
		
		public function getSpeed():int {
			
			var s:int = this.x + this.width/2;
			var delta:int = Math.abs( (redCan.x + redCan.width/2) - s );
			var speed:int = Math.round(MAX_SPEED * (1 - delta/s) + MAX_SPEED*0.1);
			
			return speed;
		}
		
	}
}
