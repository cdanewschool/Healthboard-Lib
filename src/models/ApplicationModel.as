package models
{
	import ASclasses.Constants;
	
	import events.ApplicationDataEvent;
	import events.ApplicationEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import styles.ChartStyles;

	[Bindable]
	public class ApplicationModel extends EventDispatcher
	{
		public var fullname:String;
		
		public var patientAlerts:ArrayCollection;
		
		public var chartStyles:ChartStyles;
		
		private var _patientAlertsLoaded:Boolean;
		
		public var today:Date;
		
		public var viewMode:String = Constants.STATE_LOGGED_IN;
		
		public function ApplicationModel()
		{
			super();
			
			patientAlerts = new ArrayCollection();
			
			today = new Date();
		}

		private function dispatchDataLoad( data:* ):void
		{
			var evt:ApplicationDataEvent = new ApplicationDataEvent( ApplicationDataEvent.LOADED, true );
			evt.data = data;
			dispatchEvent( evt );
		}
		
		public function get patientAlertsLoaded():Boolean
		{
			return _patientAlertsLoaded;
		}

		public function set patientAlertsLoaded(value:Boolean):void
		{
			_patientAlertsLoaded = value;
			
			if( _patientAlertsLoaded )
			{
				dispatchDataLoad( patientAlerts );
			}
		}
	}
}