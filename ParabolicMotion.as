package  
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class ParabolicMotion 
	{
		private var _object:DisplayObject;
		private var _isPaused:Boolean;
		private var _x:Number;
		private var _y:Number;
		private var _vx:Number;
		private var _vy:Number;
		private var _worldSize:Object;
		private var _stage:Stage;
		private var _onEndMotion:Function;
		
		private var GRAVITY:Number;
		private var FRICTION:Number;
		
		public function ParabolicMotion(stage:Stage, gravity:Number = 0.9, friction:Number = 0.99, worldSize:Object = null)
		{
			GRAVITY = gravity;
			FRICTION = friction;
			_stage = stage;
			_isPaused = true;
			_worldSize = worldSize;
			
			_stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function start(object:DisplayObject, angle:Number, speed:Number, onEndMotion:Function = null):void
		{
			_isPaused = false;
			_object = object;
			_x = _object.x;
			_y = _object.y;
			_onEndMotion = onEndMotion;
			_vx = speed * Math.cos(-angle * 3.14 / 180);
			_vy = speed * Math.sin(-angle * 3.14 / 180);
		}
		
		public function stop():void
		{
			_isPaused = true;
			_object = null;
			_vx = 0;
			_vy = 0;
		}
		
		public function update(e:Event):void
		{
			if (_isPaused) return;
			
			_vy += GRAVITY;
			_x += _vx;
			_y += _vy;
			
			_vx *= FRICTION;
			_vy *= FRICTION;
			
			if (_worldSize != null)
			{
				if (_x >= _worldSize.width)
				{
					_x = _worldSize.width;
					_vx *= -1;
				}
				
				if (_x <= 0)
				{
					_x = 0;
					_vx *= -1;
				}
				
				if (_y >= _worldSize.height)
				{
					_y = _worldSize.height;
					_vy *= -1;
				}
				
				if (_y <= 0)
				{
					_y = 0;
					_vy *= -1;
				}
			}
			
			var d = Math.sqrt(_vx * _vx + _vy * _vy);
			if (d <= 0.01)
			{
				_stage.removeEventListener(Event.ENTER_FRAME, update);
				_isPaused = true;
				if (_onEndMotion != null) _onEndMotion();
				return;
			}
			
			_object.x = _x;
			_object.y = _y;
		}
		
		public function get isPaused():Boolean 
		{
			return _isPaused;
		}
		
	}

}