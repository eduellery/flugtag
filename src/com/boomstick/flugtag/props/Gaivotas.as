package com.boomstick.flugtag.props {
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;

	/**
	 * Nuvens, açúcar visual :)
	 * @author Oscar
	 */
	public class Gaivotas extends FlxGroup {
		
		[Embed(source = "gaivota.png")] 
		private var gaivota1:Class;
		
		public var velX:int;
		private var initVelX:int;
		
		private var gaivotasQnt:uint;
		
		public function Gaivotas(gaivotasQnt:uint = 10, MaxSize : uint = 0) {
			super(MaxSize);
			
			this.gaivotasQnt = gaivotasQnt;
			
			initVelX = 0;
			velX = 0;
			
			for (var i:uint = 0; i < gaivotasQnt; i++) {
				var gaivota : FlxSprite = new FlxSprite();

				gaivota.loadGraphic(gaivota1);

				gaivota.y = Math.round((FlxG.height - 116 - gaivota.height) * Math.random());
				gaivota.x = FlxG.width + Math.round(2000 * Math.random());
				gaivota.velocity.x = initVelX;

				add(gaivota);
			}
		}
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < gaivotasQnt; i++) {
				FlxSprite(members[i]).velocity.x = initVelX + velX;
				if (FlxSprite(members[i]).x + FlxSprite(members[i]).width < 0) {
					FlxSprite(members[i]).x = FlxG.width + Math.round(2000*Math.random());
				}
			}
		}
		
	}
}
