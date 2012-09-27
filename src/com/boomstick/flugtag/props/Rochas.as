package com.boomstick.flugtag.props {
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;

	/**
	 * Nuvens, açúcar visual :)
	 * @author Oscar
	 */
	public class Rochas extends FlxGroup {
		
		[Embed(source = "rock.png")] 
		private var rocha1:Class;
		
		public var velX:int;
		private var initVelX:int;
		
		private var rochasQnt:uint;
		
		public function Rochas(rochasQnt:uint = 10, MaxSize : uint = 0) {
			super(MaxSize);
			
			this.rochasQnt = rochasQnt;
			
			initVelX = 0;
			velX = 0;
			
			for (var i : uint = 0; i < rochasQnt; i++) {
				var rocha : FlxSprite = new FlxSprite();

				rocha.loadGraphic(rocha1);

				rocha.y = FlxG.height - rocha.height - 70;
				rocha.x = FlxG.width + Math.round(2000 * Math.random());
				rocha.velocity.x = initVelX;

				add(rocha);
			}
		}
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < rochasQnt; i++) {
				FlxSprite(members[i]).velocity.x = initVelX + velX;
				if (FlxSprite(members[i]).x + FlxSprite(members[i]).width < 0) {
					FlxSprite(members[i]).x = FlxG.width + Math.round(2000*Math.random());
				}
			}
		}
		
	}
}
