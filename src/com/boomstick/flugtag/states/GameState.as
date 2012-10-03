package com.boomstick.flugtag.states {
	import com.boomstick.flugtag.utils.InputHandler;
	import com.boomstick.flugtag.utils.Constantes;
	import flash.desktop.NativeApplication;
	import org.flixel.FlxPoint;
	import org.flixel.FlxText;
	import org.flixel.FlxObject;
	import com.boomstick.flugtag.props.Gaivotas;
	import com.boomstick.flugtag.props.Baloes;
	import com.boomstick.flugtag.props.Rochas;
	import com.boomstick.flugtag.props.Lanchas;
	import com.boomstick.flugtag.props.Clouds;
	import com.boomstick.flugtag.props.GaugeLauncher;
	import com.boomstick.flugtag.props.FlxBackdrop;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxState;

	/**
	 * Estado principal do jogo
	 * @author Oscar
	 */
	public class GameState extends FlxState {
		
		[Embed(source = "plat.jpg")] 
		private var platJPG:Class;
		
		[Embed(source = "mascotinho.png")] 
		private var mascote:Class;
		
		[Embed(source = "placar.jpg")] 
		private var placPNG:Class;
		
		/**
		 * Oceano (sprite loopável)
		 */
		private var oceano:FlxBackdrop;
		/**
		 * Jogador aviao
		 */
		private var player:FlxSprite;
		/**
		 * Plataforma
		 */
		private var plataforma : FlxSprite;
		/**
		 * Nuvens (back)
		 */
		private var cloudsB : Clouds;
		/**
		 * Nuvens (frente)
		 */
		private var cloudsF : Clouds;
		/**
		 * Lanchas
		 */
		private var lanchas : Lanchas;
		/**
		 * Rochas
		 */
		private var rochas : Rochas;
		/**
		 * Baloes
		 */
		private var baloes : Baloes;
		/**
		 * Gaivotas
		 */
		private var gaivotas : Gaivotas;
		 
		/**
		 * Barra de lançamento
		 */
		private var gauge:GaugeLauncher;
		
		/**
		 * Velocidade horizontal
		 */
		private var speed:int;
		
		/**
		 * Último Y (cálculo de momento)
		 */
		private var lastY:int;
		
		/**
		 * Momento
		 */
		private var momentum:int;
		
		/**
		 * Aceleração do momento
		 */
		private var momentumAcel:int;
		
		/**
		 * Gravidade
		 */
		private var gravity:Number;
		
		/**
		 * Tempo de turbo
		 */
		private var boostTime:uint = 0;
		
		/**
		 * Flag para saber se perdeu
		 */
		private var loser:Boolean = false;
		
		/**
		 * Estado do jogo:
		 * 0 na plataforma, estático
		 * 1 na plataforma, medidor rodando
		 * 2 voando
		 * 3 caiu, apresentar resultados
		 */
		private var state:uint;
		
		/**
		 * Pontos (UI)
		 */
		private var score:FlxText;
		
		/**
		 * Placar com resultado final do jogo
		 */
		private var placar:FlxSprite;
		
		public function GameState() {
			speed = 0;
			state = 0;
		}
		
		override public function create():void {
			
			// Cor do céu
			FlxG.bgColor = 0xFF7EC7F7;
			
			// Plataforma
			plataforma = new FlxSprite();
			plataforma.loadGraphic(platJPG);
			plataforma.x = 0;
			plataforma.y = FlxG.height - plataforma.height;
			
			// Oceano
			oceano = new FlxBackdrop();
			
			// Jogador
			player = new FlxSprite();
			player.loadGraphic(mascote);
			player.x = plataforma.width - player.width;
			player.y = plataforma.y - player.height;
			
			cloudsB = new Clouds(2);
			cloudsF = new Clouds(1);
			lanchas = new Lanchas(1);
			gaivotas = new Gaivotas(1);
			rochas = new Rochas(1);
			baloes = new Baloes(2);
			
			// Resetar pontuação
			FlxG.score = 0;
			
			// Y incial
			lastY = player.y;
			gravity = Constantes.GRAVITY;
			
			// Aceleração do momento inical
			momentumAcel = 0;
			
			// Barra de lançamento
			gauge = new GaugeLauncher();
			
			// Pontuação
			// TODO melhorar
			score = new FlxText(FlxG.width - 150, 0, 100);
			score.scale = new FlxPoint(2, 2);
			score.shadow = 0xff000000;
			score.scrollFactor.x = 0;
			score.scrollFactor.y = 0;
			score.alignment = "right";
			score.text = "0";
			
			add(rochas);
			add(lanchas);
			add(oceano);
			add(cloudsB);
			add(gaivotas);
			add(baloes);
			add(plataforma);
			add(player);
			add(cloudsF);
			add(score);
		}
		
		override public function update():void {
			super.update();
			
			switch(state) {
				case 0: {
					// Esperando toque para iniciar
					if (InputHandler.touching()) {
						
						add(gauge);
						add(gauge.redCan);
						
						// Vai pro estado 1
						state = 1;
					}
					break;
				}
				case 1: {
					// Espera soltar a barra
					if (!InputHandler.touching()) {
						
						speed = -gauge.getSpeed();
						updateStuffSpeed();
						
						remove(gauge.redCan);
						remove(gauge);
						
						player.acceleration.y = Constantes.GRAVITY;
						
						// Vai pro estado 2
						state = 2;
					}
					break;
				}
				case 2: {
					// Voando
					
					FlxG.score += Math.max(1,-speed/150);
					score.text = FlxG.score.toString();
					
					FlxG.overlap(player, lanchas, turbo);
					FlxG.overlap(player, baloes, turbo);
					FlxG.collide(player, gaivotas, dead);
					FlxG.collide(player, rochas, dead);
					
					if (boostTime > 0 && !loser) {
						boostTime--;
						if (boostTime == 0) {
							speed /= 2;
							updateStuffSpeed();
						}
					}
					
					// Destruir plataforma
					if (plataforma != null && plataforma.x + plataforma.width < 0) {
						this.remove(plataforma);
						plataforma.destroy();
					}
					
					// Morreu
					if (player.y > oceano.y || player.x + player.width < -30) {
						state = 3;
					}
					
					player.angle = (180 - Math.atan2(player.velocity.y, speed) * 180 / Math.PI) % 360;
					
					// Calcular momento
					if (!loser && InputHandler.touching() && Math.abs(InputHandler.getY() - lastY) > Constantes.MOM_TRESHOLD) {
						var oldMomentum:int = momentum;
						
						momentum = InputHandler.getY() - lastY;
						
						if (momentum > Constantes.MAX_VARIATION) {
							momentum = Constantes.MAX_VARIATION;
						} else if (momentum < -Constantes.MAX_VARIATION) {
							momentum = -Constantes.MAX_VARIATION;
						}
						
						lastY = player.y;
						
						// Se o momento trocou de sinal
						if ((oldMomentum < 0 && momentum > 0) ||
							(oldMomentum > 0 && momentum < 0)) {
							momentum += Math.round(-oldMomentum);
							if ((player.velocity.y > 0 && momentum < 0) ||
								(player.velocity.y < 0 && momentum > 0)) {
								player.velocity.y *= -1;
							}
						}
						
						momentumAcel += momentum;
						
						if (momentumAcel >= 0 && momentumAcel > Constantes.MAX_MOMENTUM) {
							momentumAcel = Constantes.MAX_MOMENTUM;
						} else if (momentumAcel < 0 && momentumAcel < -Constantes.MAX_MOMENTUM) {
							momentumAcel = -Constantes.MAX_MOMENTUM;
						}
					}
					
					gravity += Constantes.GRAVITY_ACEL;
					player.acceleration.y = gravity + momentumAcel;
					break;
				}
				case 3: {
					placar = new FlxSprite();
					placar.loadGraphic(placPNG);
					placar.x = (FlxG.width - placar.width)/2;
					placar.y = (FlxG.height - placar.height)/2;
					
					add(placar);
					
					// Fim do jogo, mostrar resultado
					remove(score);
					
					score = new FlxText(placar.x + (placar.width)*1.42, placar.y + 160, 200);
					score.scale = new FlxPoint(8, 8);
					score.color = 0xFFFF2222;
					score.shadow = 0xFFFFFF77;
					score.scrollFactor.x = 0;
					score.scrollFactor.y = 0;
					score.text = FlxG.score.toString();
					add(score);
					
					remove(player);
					player.destroy();
					
					state = 4;
					break;
				}
				case 4: {
					// Esperando escolher opção do menu
					if (InputHandler.touched()) {
						
						var xI:int = InputHandler.getX() - (FlxG.width - placar.width)/2;
						var yI:int = InputHandler.getY() - (FlxG.height - placar.height)/2;
						
						// TODO criar classe botão para evitar essas medidas	
						if (yI >= 295 && yI <= 385) {
							// Retry
							if (xI >= 15 && xI <= 210) {
								FlxG.switchState(new GameState());
							// Quit
							} else if (xI >= 255 && xI <= 445) {
								NativeApplication.nativeApplication.exit();
							}
						}
					}
				}
					
			}
		}
		
		private function updateStuffSpeed():void {
			if (plataforma != null) {
				plataforma.velocity.x = speed;
			}
			oceano.velX = speed;
			cloudsB.velX = speed;
			cloudsF.velX = speed;
			rochas.velX = speed;
			baloes.velX = speed;
			gaivotas.velX = speed;
			lanchas.velX = speed;
		}
		
		/**
		 * TURBO
		 */
		private function turbo(player:FlxObject, balaoLancha:FlxObject):void {
			if (boostTime == 0) {
				speed *= 2;
				boostTime = Constantes.BOOST_TIME;
				updateStuffSpeed();
			}
		}
		
		/**
		 * DEAD
		 */
		private function dead(player:FlxObject, gaivoRochas:FlxObject):void {
			speed = 0;
			loser = true;
		}
	}
}
