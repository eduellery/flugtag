package com.boomstick.flugtag {
	import com.boomstick.flugtag.utils.Constantes;
	import com.boomstick.flugtag.states.GameState;
	import org.flixel.FlxGame;

	// O comando abaixo é resolvido em tempo de compilação
	// então é necessário sempre lembrar de mudá-lo,
	// pois não se pode usar variáveis
	[SWF(width="1024", height="600", frameRate="60",
	backgroundColor="#FFFFFF")]   
	
	public dynamic class Flugtag extends FlxGame {
		
		// Dispositivo que receberá o aplicativo
		public static const VERSION:String = Constantes.V_PLAYBOOK;
		
		public function Flugtag() {
			
			var w:uint = 0, h:uint = 0;
			
			// Calcular resolução do jogo
			switch(Flugtag.VERSION) {
				case Constantes.V_PLAYBOOK: {
					w = Constantes.D_PLAYBOOK.x;
					h = Constantes.D_PLAYBOOK.y;
					break;
				}
				case Constantes.V_BB10: {
					w = Constantes.D_BB10.x;
					h = Constantes.D_BB10.y;
					break;
				}
			}

			
			super(w, h, GameState, 1, 60, 60, true);
		}
	}
}
