package com.boomstick.flugtag.utils {
	import org.flixel.FlxPoint;
	/**
	 * Constantes
	 * @author Oscar
	 */
	public class Constantes {
		
		/**
		 * Versão do jogo (V_nome_dispositivo)
		 */
		// BlackBerry
		public static const V_BB10:String = "BB10";
		public static const V_PLAYBOOK:String = "PlayB";
		
		/**
		 * Resoluções de tela (D_nome_dispositivo)
		 */
		// BlackBerry
		public static const D_BB10:FlxPoint = new FlxPoint(1280, 768);
		public static const D_PLAYBOOK:FlxPoint = new FlxPoint(1024, 600);
	
		/**
		 * Gravidade do jogo
		 */
		public static const GRAVITY:int = 100;
		
		/**
		 * Aceleração da gravidade (foda-se a física)
		 */
		public static const GRAVITY_ACEL:Number = 0.5;
		
		/**
		 * Momento máximo
		 */
		 public static const MAX_MOMENTUM:int = 5;
				
		/**
		 * Treshold do toque para calcular momento
		 */
		public static const MOM_TRESHOLD:int = 10;
		
		/**
		 * Teto da variação entre o clique e a nave
		 */
		public static const MAX_VARIATION:int = 50;
		
		/**
		 * Tempo de turbo
		 */
		public static const BOOST_TIME:uint = 120;
	}
}
