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
		private var _viscosity:Boolean;
		
		private var MAX_SPEED_X:Number = 8;
		private var MAX_SPEED_Y:Number = 8;
		private var ACCELERATION:Number = 0.9;
		private var FRICTION:Number = 0.4;
		
		public function KeyboardMotion(stage:Stage, viscosity:Boolean = false) 
		{
			_stage = stage;
			_viscosity = viscosity;
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
			if (_viscosity) {
				if (_left)
				{
					_speedX -= ACCELERATION;
					if (_speedX <= -MAX_SPEED_X)
					{
						_speedX = -MAX_SPEED_X;
					}
				}
				
				if (_right)
				{
					_speedX += ACCELERATION;
					if (_speedX >= MAX_SPEED_X)
					{
						_speedX = MAX_SPEED_X;
					}
				}
				
				if (!_left && !_right)
				{
					if (_speedX >= 0)
					{
						_speedX -= FRICTION;
						if (_speedX <= 0) _speedX = 0;
					}
					
					if (_speedX < 0)
					{
						_speedX += FRICTION;
						if (_speedX >= 0) _speedX = 0;
					}
				}
				
				if (_up)
				{
					_speedY -= ACCELERATION;
					if (_speedY <= -MAX_SPEED_Y)
					{
						_speedY = -MAX_SPEED_Y;
					}
				}
				
				if (_down)
				{
					_speedY += ACCELERATION;
					if (_speedY >= MAX_SPEED_Y)
					{
						_speedY = MAX_SPEED_Y;
					}
				}
				
				if (!_up && !_down)
				{
					if (_speedY >= 0)
					{
						_speedY -= FRICTION;
						if (_speedY <= 0) _speedY = 0;
					}
					
					if (_speedY < 0)
					{
						_speedY += FRICTION;
						if (_speedY >= 0) _speedY = 0;
					}
				}
			}
			else
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