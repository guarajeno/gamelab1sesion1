package  
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author 
	 */
	public class KeyboardMotion 
	{
		// A ver si funciona!!!!!
		// trololo
		private var _object:DisplayObject;
		private var _stage:Stage;
		
		private var _left:Boolean;
		private var _right:Boolean;
		private var _up:Boolean;
		private var _down:Boolean;
		
		private var _x:Number;
		private var _y:Number;
		private var _speedX:Number;
		private var _speedY:Number;
		private var _worldSize:Object;
		
		private var MAX_SPEED_X:Number = 8;
		private var MAX_SPEED_Y:Number = 8;
		private var ACCELERATION:Number = 0.9;
		private var FRICTION:Number = 0.4;
		
		public function KeyboardMotion(stage:Stage, worldSize:Object = null) 
		{
			_stage = stage;
			_worldSize = worldSize;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			_stage.addEventListener(Event.ENTER_FRAME, update);
			_speedX = 0;
			_speedY = 0;
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch (e.keyCode)
			{
				case 37:
				{
					_left = true;
					break;
				}
				case 38:
				{
					_up = true;
					break;
				}
				case 39:
				{
					_right = true;
					break;
				}
				case 40:
				{
					_down = true;
					break;
				}
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			switch (e.keyCode)
			{
				case 37:
				{
					_left = false;
					break;
				}
				case 38:
				{
					_up = false;
					break;
				}
				case 39:
				{
					_right = false;
					break;
				}
				case 40:
				{
					_down = false;
					break;
				}
			}
		}
		
		public function update(e:Event)
		{
			if (_left)
			{
				_speedX = -MAX_SPEED_X;
			}
			
			if (_right)
			{
				_speedX = MAX_SPEED_X;
			}
			
			if (!_left && !_right)
			{
				_speedX = 0;
			}
			
			if (_up)
			{
				_speedY = -MAX_SPEED_Y;
			}
			
			if (_down)
			{
				_speedY = MAX_SPEED_Y;
			}
			
			if (!_up && !_down)
			{
				_speedY = 0;
			}
			
			if (_worldSize != null)
			{
				if (_x >= _worldSize.width)
				{
					_x = _worldSize.width;
				}
				
				if (_x <= 0)
				{
					_x = 0;
				}
				
				if (_y >= _worldSize.height)
				{
					_y = _worldSize.height;
				}
				
				if (_y <= 0)
				{
					_y = 0;
				}
			}
			
			_x += _speedX;
			_y += _speedY;
			
			_object.x = _x;
			_object.y = _y;
		}
		
		public function start(object:DisplayObject):void
		{
			_object = object;
			_x = _object.x;
			_y = _object.y;
		}
	}
}