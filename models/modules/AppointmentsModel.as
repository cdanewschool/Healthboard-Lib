package models.modules
{
	import models.modules.ModuleModel;
	
	public class AppointmentsModel extends ModuleModel
	{
		[Bindable] [Embed("images/blueArrowLeft.png")] 	public var blueArrowLeft:Class;
		[Bindable] [Embed("images/blueArrowRight.png")] public var blueArrowRight:Class;
		[Bindable] [Embed("images/grayArrowLeft.png")] 	public var grayArrowLeft:Class;
		[Bindable] [Embed("images/grayArrowRight.png")] public var grayArrowRight:Class;
		
		[Bindable] public var appointments:Array;
		[Bindable] public var currentAppointmentIndex:uint;
		
		[Bindable] public var timeSlots:Object = 
			{
				'date-10-7-2011:04pm': 
				{
					'firstSlot': true,
					'secondSlot': false
				}
			};
		
		[Bindable] public var currentDate:Date = new Date();
		
		public function AppointmentsModel()
		{
			super();
			
			currentAppointmentIndex = 10;
		}
	}
}