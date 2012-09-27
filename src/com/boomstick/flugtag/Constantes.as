package com.boomstick.flugtag {
	/**
	 * Constantes
	 * @author Oscar
	 */
	public class Constantes {
	
		/**
		 * Gravidade do jogo
		 */
		public static var GRAVITY:int = 100;
		
		/**
		 * Aceleração da gravidade (foda-se a física)
		 */
		public static var GRAVITY_ACEL:Number = 0.5;
		
		/**
		 * Momento máximo
		 */
		 public static var MAX_MOMENTUM:int = 5;
				
		/**
		 * Treshold do toque para calcular momento
		 */
		public static var MOM_TRESHOLD:int = 10;
		
		/**
		 * Teto da variação entre o clique e a nave
		 */
		public static var MAX_VARIATION:int = 50;
		
		/**
		 * Tempo de turbo
		 */
		public static var BOOST_TIME:uint = 120;
	}
}
