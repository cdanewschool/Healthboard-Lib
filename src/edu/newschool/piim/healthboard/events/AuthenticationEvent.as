package edu.newschool.piim.healthboard.events 
{
	import flash.events.Event;
	
	public class AuthenticationEvent extends Event
	{
		public static const SUCCESS:String = "authenticationSuccess";
		public static const ERROR:String = "authenticationError";
		public static const PROMPT:String = "authenticationPrompt";
		
		public var onAuthenticatedCallback:Function;
		public var onAuthenticatedCallbackArgs:*;
		
		public function AuthenticationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new AuthenticationEvent(type, bubbles, cancelable);
		}
	}
}