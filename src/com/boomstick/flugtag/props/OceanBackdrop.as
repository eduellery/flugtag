package com.boomstick.flugtag.props {
	import flash.display.Bitmap;
	import com.boomstick.flugtag.utils.VisualAssets;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;

	public class OceanBackdrop extends FlxGroup
	{
		private var amountofSprites:uint;
		private var initVelX:int;
		public var velX:int;
		
		public var y:int;
		
		public function OceanBackdrop() {
			
			var ocean:Bitmap = new VisualAssets.OCEAN();
			this.y = FlxG.height - ocean.height;
			
			amountofSprites = Math.ceil(FlxG.width / ocean.width) + 2;
			this.initVelX = -10;
			this.velX = 0;
			for (var i:uint = 0; i < amountofSprites; i++) {
				
				var oceanTile:FlxSprite = new FlxSprite();
				oceanTile.loadGraphic(VisualAssets.OCEAN);
				oceanTile.x = oceanTile.width*i;
				oceanTile.y = FlxG.height - oceanTile.height;
				
				add(oceanTile);
			}
		}
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < amountofSprites; i++) {
				FlxSprite(members[i]).velocity.x = initVelX + velX;
				if (FlxSprite(members[i]).x + FlxSprite(members[i]).width < 0) {
					FlxSprite(members[i]).x = FlxSprite(members[(i+amountofSprites-1)%amountofSprites]).x + FlxSprite(members[i]).width;
				}
			}
		}
	}
}
