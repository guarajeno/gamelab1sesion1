package  
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class CurveMotion 
	{
		private var _x:Number;
		private var _y:Number;
		private var _t:Number;
		private var _dt:Number;
		private var _isPaused:Boolean;
		private var _object:DisplayObject;
		private var _onEndMotion:Function;
		private var _stage:Stage;
		
		private var _points:Array = [];
		
		public function CurveMotion(stage:Stage) 
		{
			_stage = stage;
			_t = 0;
			_isPaused = true;
		}
		
		public function addPoint(point:Point):void
		{
			_points.push(point);
		}
		
		public function start(object:DisplayObject, duration:int, onEndMotion:Function = null):void
		{
			_object = object;
			_object.x = _points[0].x;
			_object.y = _points[0].y;
			_dt = 1000 / (30 * duration);
			_onEndMotion = onEndMotion;
			_isPaused = false;
			
			_stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function stop():void
		{
			_isPaused = true;
		}
		
		public function update(e:Event):void
		{
			if (_isPaused) return;
			if (_points.length < 3) {
				trace("Se debe agregar al menos 3 puntos.");
			}
			
			_t += _dt;
			
			if (_t >= 1) {
				_t = 0;
				_isPaused = true;
				_stage.removeEventListener(Event.ENTER_FRAME, update);
				if (_onEndMotion != null) _onEndMotion();
				return;
			}
			
			_x = 0;
			_y = 0;
			
			for (var i:int = 0; i < _points.length; i++ )
			{
				var l:Number = lagrange(i, _t);
				_x += l * _points[i].x;
				_y += l * _points[i].y;
			}
			
			_object.x = _x;
			_object.y = _y;
		}
		
		private function lagrange(i:int, t:Number):Number
		{
			var num:Number = 1;
			var den:Number = 1;
			var n:int = _points.length;
			
			for (var k:int = 0; k < n; k++)
			{
				if (k != i)
				{
					num *= (t - k / (n - 1));
				}
			}
			
			for (var j:int = 0; j < n; j++)
			{
				if (j != i)
				{
					den *= (i / (n - 1) - j / (n - 1));
				}
			}
			
			return (num / den);
		}
	}
}