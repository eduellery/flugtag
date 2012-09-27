package com.boomstick.flugtag.props {
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;

	/**
	 * Nuvens, açúcar visual :)
	 * @author Oscar
	 */
	public class Baloes extends FlxGroup {
		
		[Embed(source = "balao1.png")] 
		private var balao1:Class;
		
		[Embed(source = "balao2.png")] 
		private var balao2:Class;
		
		public var velX:int;
		private var initVelX:int;
		
		private var baloesQnt:uint;
		
		public function Baloes(baloesQnt:uint = 10, MaxSize : uint = 0) {
			super(MaxSize);
			
			this.baloesQnt = baloesQnt;
			
			initVelX = 0;
			velX = 0;
			
			for (var i:uint = 0; i < baloesQnt; i++) {
				var nuvem:FlxSprite = new FlxSprite();
				
				var selNuvem:Number = Math.random();
				if (selNuvem > 0.50) {
					nuvem.loadGraphic(balao1);
				} else {
					nuvem.loadGraphic(balao2);
				}
				
				nuvem.y = Math.round((FlxG.height -116 - nuvem.height)*Math.random());
				nuvem.x = FlxG.width + Math.round(4000*Math.random());
				nuvem.velocity.x = initVelX;
				
				add(nuvem);
			}
		}
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < baloesQnt; i++) {
				FlxSprite(members[i]).velocity.x = initVelX + velX;
				if (FlxSprite(members[i]).x + FlxSprite(members[i]).width < 0) {
					FlxSprite(members[i]).x = FlxG.width + Math.round(4000*Math.random());
				}
			}
		}
		
	}
}
