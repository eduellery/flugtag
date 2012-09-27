package com.boomstick.flugtag.props {
	import com.boomstick.flugtag.props.Oceano;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;

	public class FlxBackdrop extends FlxGroup
	{
		private var amountofSprites:uint;
		private var initVelX:int;
		public var velX:int;
		
		public var y:int;
		
		public function FlxBackdrop() {
			var tile:Oceano = new Oceano(0);
			amountofSprites = Math.ceil(FlxG.width / tile.width) + 2;
			this.initVelX = -10;
			this.velX = 0;
			this.y = tile.y;
			for (var i:uint = 0; i < amountofSprites; i++) {
				add(new Oceano(i));
			}
		}
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < amountofSprites; i++) {
				Oceano(members[i]).velocity.x = initVelX + velX;
				if (Oceano(members[i]).x + Oceano(members[i]).width < 0) {
					Oceano(members[i]).x = Oceano(members[(i+amountofSprites-1)%amountofSprites]).x + Oceano(members[i]).width;
				}
			}
		}
	}
}
