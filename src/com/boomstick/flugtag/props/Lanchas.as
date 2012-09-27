package com.boomstick.flugtag.props {
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;

	/**
	 * Nuvens, açúcar visual :)
	 * @author Oscar
	 */
	public class Lanchas extends FlxGroup {
		
		[Embed(source = "motorboat.png")] 
		private var lancha1:Class;
		
		public var velX:int;
		private var initVelX:int;
		
		private var lanchasQnt:uint;
		
		public function Lanchas(lanchasQnt:uint = 10, MaxSize : uint = 0) {
			super(MaxSize);
			
			this.lanchasQnt = lanchasQnt;
			
			initVelX = 0;
			velX = 0;
			
			for (var i:uint = 0; i < lanchasQnt; i++) {
				var lancha:FlxSprite = new FlxSprite();
							
				lancha.loadGraphic(lancha1);
				
				lancha.y = FlxG.height - lancha.height - 70;
				lancha.x = FlxG.width + Math.round(2000*Math.random());
				lancha.velocity.x = initVelX;
				
				add(lancha);
			}
		}
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < lanchasQnt; i++) {
				FlxSprite(members[i]).velocity.x = initVelX + velX;
				if (FlxSprite(members[i]).x + FlxSprite(members[i]).width < 0) {
					FlxSprite(members[i]).x = FlxG.width + Math.round(2000*Math.random());
				}
			}
		}
		
	}
}
