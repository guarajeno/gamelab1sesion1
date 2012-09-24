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
	public class LinearMotion 
	{
		private var _x:Number;
		private var _y:Number;
		private var _t:Number;
		private var _dt:Number;
		private var _isPaused:Boolean;
		private var _object:DisplayObject;
		private var _onEndMotion:Function;
		private var _stage:Stage;
		
		private var _currentIndex:int;
		private var _points:Array = [];
		
		public function LinearMotion(stage:Stage) 
		{
			_stage = stage;
			_t = 0;
			_currentIndex = 0;
			_isPaused = true;
			
			_stage.addEventListener(Event.ENTER_FRAME, update);
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
			_dt = 1000 * (_points.length) / (30 * duration);
			_onEndMotion = onEndMotion;
			_isPaused = false;
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
			if (_t >= 1)
			{
				_t = 0;
				_currentIndex += 1;
				if (_currentIndex == _points.length - 1)
				{
					if (_onEndMotion != null) _onEndMotion();
					_stage.removeEventListener(Event.ENTER_FRAME, update);
					_isPaused = true;
					_currentIndex = 0;
					return;
				}
			}
			
			_x = _points[_currentIndex + 1].x * _t + _points[_currentIndex].x * (1 - _t);
			_y = _points[_currentIndex + 1].y * _t + _points[_currentIndex].y * (1 - _t);
			
			_object.x = _x;
			_object.y = _y;
		}
		
	}

}