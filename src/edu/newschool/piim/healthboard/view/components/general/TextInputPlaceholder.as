package edu.newschool.piim.healthboard.view.components.general
{
	import flash.events.FocusEvent;

	import spark.components.TextInput;

	public class TextInputPlaceholder extends TextInput
	{
		private var _placeholder:String;

		public function TextInputPlaceholder()
		{
			super();
			
			addEventListener( FocusEvent.FOCUS_IN, onFocusIn );
			addEventListener( FocusEvent.FOCUS_OUT, onFocusOut );
		}

		private function onFocusIn( event:FocusEvent ):void
		{
			if( super.text == placeholder ) text = '';
		}

		private function onFocusOut( event:FocusEvent ):void
		{
			if( super.text == '' ) text = placeholder;
		}

		public function get placeholder():String
		{
			return _placeholder;
		}

		public function set placeholder(value:String):void
		{
			_placeholder = value;
			
			text = placeholder;
		}
		
		override public function get text():String
		{
			var text:String = super.text;
			
			if( text == placeholder ) return null;
			
			return text;
		}
	}
}