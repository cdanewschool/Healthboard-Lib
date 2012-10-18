package models.modules
{
	import enum.AppointmentStatus;
	import enum.DateRanges;
	
	import models.modules.ModuleModel;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class AppointmentsModel extends ModuleModel
	{
		public static const STATUSES:ArrayCollection = new ArrayCollection( [ AppointmentStatus.ALL, AppointmentStatus.SCHEDULED, AppointmentStatus.COMPLETED ] );
		
		[Embed("images/blueArrowLeft.png")] 	public var blueArrowLeft:Class;
		[Embed("images/blueArrowRight.png")] public var blueArrowRight:Class;
		[Embed("images/grayArrowLeft.png")] 	public var grayArrowLeft:Class;
		[Embed("images/grayArrowRight.png")] public var grayArrowRight:Class;
		
		public var appointments:ArrayCollection;
		
		public var currentAppointmentIndex:uint;
		
		public var timeSlots:Object = 
			{
				'date-10-7-2011:04pm': 
				{
					'firstSlot': true,
					'secondSlot': false
				}
			};
		
		public var currentDate:Date = new Date();
		
		public var dateRange:String = DateRanges.YEAR;
		public var status:String = AppointmentStatus.ALL;
		
		public var isRecommending:Boolean;
		
		public function AppointmentsModel()
		{
			super();
		}
	}
}