package models
{
	import events.ApplicationDataEvent;
	import events.ApplicationEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import styles.ChartStyles;

	[Bindable]
	public class ApplicationModel extends EventDispatcher
	{
		public var patientAlerts:ArrayCollection;
		public var patientAppointments:ArrayCollection;
		public var patientVitalSigns:ArrayCollection;
		
		public var patientAppointmentIndex:int;
		
		public var chartStyles:ChartStyles;
		
		private var _patientAlertsLoaded:Boolean;
		
		public function ApplicationModel()
		{
			super();
			
			patientAlerts = new ArrayCollection();
			patientAppointments = new ArrayCollection();
			patientVitalSigns = new ArrayCollection();
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