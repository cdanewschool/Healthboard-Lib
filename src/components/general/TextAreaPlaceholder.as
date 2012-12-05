package components.general
{
	import flash.events.FocusEvent;
	
	import spark.components.TextArea;
	import spark.components.TextInput;

	public class TextAreaPlaceholder extends TextArea
	{
		private var _placeholder:String;

		public function TextAreaPlaceholder()
		{
			super();
			
			addEventListener( FocusEvent.FOCUS_IN, onFocusIn );
			addEventListener( FocusEvent.FOCUS_OUT, onFocusOut );
		}

		private function onFocusIn( event:FocusEvent ):void
		{
			if( text == placeholder ) text = '';
		}

		private function onFocusOut( event:FocusEvent ):void
		{
			if( text == '' ) text = placeholder;
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
	}
}