package com.boomstick.flugtag.props {
	import com.boomstick.flugtag.utils.VisualAssets;
	import flash.display.Bitmap;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;

	/**
	 * Elementos interativos que aparecem, passam e somem da tela
	 * (e.g. lanchas, balões, gaivotas, rochas, nuvens)
	 * @author Oscar
	 */
	public class InteractiveProps extends FlxGroup {
		
		/**
		 * Velocidade X da tela
		 */
		public var velX:int;
		/**
		 * Velocidade inicial deste elemento
		 */
		private var initVelX:int;
		
		/**
		 * Frequência (pixels de distância) com que o elemento reaparece
		 */
		private var frequency:uint;
		
		/**
		 * Alturas disponíveis para o elemento (resortear a altura)
		 */
		private var sortableHeight:int = 0;
		
		/**
		 * Quantidade desse grupo de elementos
		 */
		private var qnt:uint;
		
		public function InteractiveProps(graphics:Array, grounded:Boolean, qnt:uint, frequency:uint = 2000, heightAdjust:int = 0, initVelx:int = 0, outOfScreen:Boolean = true, MaxSize:uint = 0) {
			super(MaxSize);
			
			this.qnt = qnt;
			this.initVelX = initVelx;
			this.frequency = frequency;
			
			for (var i:uint = 0; i < qnt; i++) {
				var el:FlxSprite = new FlxSprite();
							
				// Carregar gráfico aleatório
				el.loadGraphic(graphics[Math.floor(Math.random()*graphics.length)]);
				
				var ocean:Bitmap = new VisualAssets.OCEAN();
				
				if (grounded) {
					el.y = FlxG.height - ocean.height + heightAdjust - el.height;
				} else {
					sortableHeight = FlxG.height - ocean.height + heightAdjust - el.height;
					el.y = Math.round((sortableHeight) * Math.random());
				}
				if (outOfScreen) {
					el.x = FlxG.width + Math.round(frequency*Math.random());
				} else {
					el.x = Math.round(frequency*Math.random());
				}
				el.velocity.x = initVelX;
				
				add(el);
			}
		}
		
		override public function update():void {
			super.update();
			for (var i:uint = 0; i < qnt; i++) {
				FlxSprite(members[i]).velocity.x = initVelX + velX;
				if (FlxSprite(members[i]).x + FlxSprite(members[i]).width < 0) {
					FlxSprite(members[i]).x = FlxG.width + Math.round(frequency*Math.random());
					if (sortableHeight != 0) {
						FlxSprite(members[i]).y = Math.round((sortableHeight) * Math.random());
					}
				}
			}
		}
	}
}
