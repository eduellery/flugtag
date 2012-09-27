package com.boomstick.flugtag.props {
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;

	/**
	 * Nuvens, açúcar visual :)
	 * @author Oscar
	 */
	public class Clouds extends FlxGroup {
		
		[Embed(source = "cloud1.png")] 
		private var cloud1:Class;
		
		[Embed(source = "cloud2.png")] 
		private var cloud2:Class;
		
		[Embed(source = "cloud3.png")] 
		private var cloud3:Class;
		
		public var velX:int;
		private var initVelX:int;
		
		private var cloudsQnt:uint;
		
		public function Clouds(cloudsQnt:uint = 10, MaxSize : uint = 0) {
			super(MaxSize);
			
			this.cloudsQnt = cloudsQnt;
			
			initVelX = -20;
			velX = 0;
			
			for (var i:uint = 0; i < cloudsQnt; i++) {
				var nuvem:FlxSprite = new FlxSprite();
				
				var selNuvem:Number = Math.random();
				if (selNuvem > 0.33) {
					nuvem.loadGraphic(cloud1);
				} else if (selNuvem > 0.66) {
					nuvem.loadGraphic(cloud2);
				} else {
					nuvem.loadGraphic(cloud3);
				}
				
				nuvem.y = Math.round((FlxG.height -116 - nuvem.height)*Math.random());
				nuvem.x = Math.round(2000*Math.random());
				nuvem.velocity.x = initVelX;
				
				add(nuvem);
			}
		}
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < cloudsQnt; i++) {
				FlxSprite(members[i]).velocity.x = initVelX + velX;
				if (FlxSprite(members[i]).x + FlxSprite(members[i]).width < 0) {
					FlxSprite(members[i]).x = FlxG.width + Math.round(2000*Math.random());
				}
			}
		}
		
	}
}
