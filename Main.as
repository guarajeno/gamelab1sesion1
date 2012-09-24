package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author  o
	 */
	public class Main extends MovieClip 
	{
		private var _curva_1:CurveMotion;
		private var _curva_2:CurveMotion;
		private var _lineal:LinearMotion;
		private var _keyboard:KeyboardMotion;
		private var _bola:Bola;
		private var _enemigo:Enemigo;
		
		public function Main():void 
		{
			init();
			//this.stage.addEventListener(KeyboardEvent.KEY_DOWN, disparar);
			this.stage.addEventListener(MouseEvent.CLICK, disparar);
			this.stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void 
		{
			
		}
		
		private function init(e:Event = null):void 
		{
			_keyboard = new KeyboardMotion(stage, { width:800, height:600 } );
			
			_curva_1 = new CurveMotion(stage);
			_curva_2 = new CurveMotion(stage);
			
			//_lineal = new LinearMotion(stage);
			//
			//_lineal.addPoint(new Point(100, 200));
			//_lineal.addPoint(new Point(400, 100));
			//_lineal.addPoint(new Point(700, 200));
			
			
			_curva_1.addPoint(new Point(100, 200));
			_curva_1.addPoint(new Point(400, 100));
			_curva_1.addPoint(new Point(700, 200));
			
			_curva_2.addPoint(new Point(700, 200));
			_curva_2.addPoint(new Point(400, 100));
			_curva_2.addPoint(new Point(100, 200));
			
			// enemigo
			_enemigo = new Enemigo();
			addChild(_enemigo);
			
			_curva_1.start(_enemigo, 2000, onEndCurva_1);
			//_lineal.start(_enemigo, 2000, null)
			
			// bola
			_bola = new Bola();
			_bola.x = 400;
			_bola.y = 500;
			addChild(_bola);
			
			_keyboard.start(_bola);
		}
		
		private function onEndCurva_1():void 
		{
			_curva_2.start(_enemigo, 2000, onEndCurva_2);
		}
		
		private function onEndCurva_2():void 
		{
			_curva_1.start(_enemigo, 2000, onEndCurva_1);
		}
		
		private function disparar(e:MouseEvent):void
		{
			// cada vez que dispara se crea una bala y su movimiento
			var bala:Bala = new Bala();
			bala.x = _bola.x;
			bala.y = _bola.y;
			addChild(bala);
			
			var angulo:Number = -Math.atan2(e.stageY - _bola.y, e.stageX - _bola.x) * 180 / 3.14;
			
			var disparador:ParabolicMotion = new ParabolicMotion(stage, 0.98, 0.97, { width:800, height:600 });
			disparador.start(bala, angulo, 30);
		}
	}
	
}