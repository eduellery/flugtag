package com.boomstick.flugtag.utils {
	import org.flixel.FlxG;
	
	/**
	 * Lida com inputs de diferentes dispositivos
	 * @author Oscar
	 */
	public class InputHandler {
		
		/**
		 * Se o jogador está pressionando a tela
		 */
		public static function touching():Boolean {
			return FlxG.mouse.pressed();
		}
		
		
		/**
		 * Se o jogador pressionou a tela
		 */
		public static function touched():Boolean {
			return FlxG.mouse.justReleased();
	 	}
		
		/**
		 * Posição X do toque na tela
		 */
		public static function getX():int {
			return FlxG.mouse.x;
		}
		
		/**
		 * Posição Y do toque na tela
		 */
		public static function getY():int {
			return FlxG.mouse.y;
		}
	}
}
