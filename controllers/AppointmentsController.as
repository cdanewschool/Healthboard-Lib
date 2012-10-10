package controllers
{
	import ASclasses.Constants;
	
	import mx.utils.ObjectUtil;
	
	import controllers.BaseModuleController;
	
	import models.modules.AppointmentsModel;
	
	public class AppointmentsController extends BaseModuleController
	{
		public function AppointmentsController()
		{
			super();
			
			model = new AppointmentsModel();
			
			populateDatesForWidget();
		}
		
		public function setAvailable(set:String, reason:String):void
		{
			var model:AppointmentsModel = AppointmentsModel(model);
			
			var currentDate:Date = new Date();
			
			var myDate1:String = 'date-' + (currentDate.getMonth()+1) + '-' + currentDate.getDate() + '-' + currentDate.getFullYear() + ':12pm';
			var myDate2:String = 'date-' + (currentDate.getMonth()+1) + '-' + (currentDate.getDate()+1) + '-' + currentDate.getFullYear() + ':10am';
			var myDate3:String = 'date-' + (currentDate.getMonth()+1) + '-' + (currentDate.getDate()+1) + '-' + currentDate.getFullYear() + ':07am';
			var myDate4:String = 'date-' + (currentDate.getMonth()+1) + '-' + (currentDate.getDate()+7) + '-' + currentDate.getFullYear() + ':07am';
			var myDate5:String = 'date-' + (currentDate.getMonth()+2) + '-6-' + currentDate.getFullYear() + ':08am';
			var myDate6:String = 'date-' + (currentDate.getMonth()+1) + '-' + (currentDate.getDate()+7) + '-' + currentDate.getFullYear() + ':08am';
			var myDate7:String = 'date-' + (currentDate.getMonth()+2) + '-6-' + currentDate.getFullYear() + ':07am';
			
			var timeSlots:Object = ObjectUtil.clone( model.timeSlots );
			
			if(set == 'set1')
			{
				timeSlots[myDate3] = 
					{
						'firstSlot': true,
						'secondSlot': true,
						'reason': reason,
						'type': "class",
						'has hour slot': function():String
						{
							return 'adsf';
						}
					};
				timeSlots[myDate4] = 
					{
						'firstSlot': true,
						'secondSlot': true,
						'reason': reason,
						'type': "class"
					};
				timeSlots[myDate5] = 
					{
						'firstSlot': true,
						'secondSlot': false,
						'reason': reason,
						'type': "class"
					};
			}
			else
			{
				/*_timeSlots = {
				'date-3-22-2012:12pm': {
				'firstSlot': true,
				'secondSlot': true,
				'reason': reason,
				'type': "appointment"
				},
				'date-3-23-2012:10am': {
				'firstSlot': false,
				'secondSlot': true,
				'reason': reason,
				'type': "appointment"
				}
				};*/
				
				timeSlots[myDate1] = 
					{
						'firstSlot': true,
						'secondSlot': true,
						'reason': reason,
						'type': "appointment"
					}
				timeSlots[myDate2] = 
					{
						'firstSlot': false,
						'secondSlot': true,
						'reason': reason,
						'type': "appointment"
					}
				timeSlots[myDate6] = 
					{
						'firstSlot': true,
						'secondSlot': true,
						'reason': reason,
						'type': "appointment"
					}
				timeSlots[myDate7] =
					{
						'firstSlot': false,
						'secondSlot': true,
						'reason': reason,
						'type': "appointment"
					}
			}
			
			model.timeSlots = timeSlots;
		}
		
		private function populateDatesForWidget():void
		{
			var model:AppointmentsModel = AppointmentsModel(model);
			
			var myDate:Date = new Date( new Date().setHours(0,0,0,0) );
			var daysToAddToReachWednesday:Array = [3,2,1,7,6,5,4];
			var daysToAddToReachFriday:Array = [5,4,3,2,1,7,6];
			var nextWeekButNotWednesday:uint = (myDate.getDay() != 3) ? 7 : 8;
			
			AppointmentsModel(model).appointments = new Array
				(
					{month:"JULY", date: 7, daytime: "THURSDAY 11:00 AM", details: "Nasal Procedure\nDr. Berg\n(999) 999-9999"},
					{month:"AUGUST", date: 11, daytime: "THURSDAY 11:00 AM", details: "Consultation\nDr. Hammond\n(999) 999-9999"},
					{month:"AUGUST", date: 11, daytime: "THURSDAY 1:00 PM", details: "Surgery\nDr. Berg\n(999) 999-9999"},
					{month:"AUGUST", date: 11, daytime: "THURSDAY 4:00 PM", details: "Blood Test\nDr. Rothstein\n(999) 999-9999"},
					{month:"AUGUST", date: 11, daytime: "THURSDAY 7:00 PM", details: "Cardiac Stress Test\nDr. Hammond\n(999) 999-9999"},
					{month:"SEPTEMBER", date: 16, daytime: "FRIDAY 11:00 AM", details: "Physician Examination\nDr. Berg\n(999) 999-9999"},
					{month:"SEPTEMBER", date: 16, daytime: "FRIDAY 1:00 PM", details: "MRI\nDr. Berg\n(999) 999-9999"},
					{month:"OCTOBER", date: 7, daytime: "FRIDAY 11:00 AM", details: "Appendectomy\nDr. Berg\n(999) 999-9999"},
					{month:"OCTOBER", date: 7, daytime: "FRIDAY 1:00 PM", details: "Colonscopy\nDr. Berg\n(999) 999-9999"},
					{month:"OCTOBER", date: 16, daytime: "MONDAY 1:00 PM", details: "MRI\nDr. Berg\n(999) 999-9999"},
					{month:String(Constants.MONTHS[model.currentDate.getMonth()]).toUpperCase(), date: model.currentDate.getDate(), daytime: String(Constants.DAYS[model.currentDate.getDay()]).toUpperCase() + ' 11:00 AM', details: "Physical Examination\nDr. Berg\n(999) 999-9999"},
					{month:String(Constants.MONTHS[new Date(new Date().setDate(myDate.date + daysToAddToReachWednesday[model.currentDate.getDay()])).getMonth()]).toUpperCase(), date: new Date(new Date().setDate(myDate.date + daysToAddToReachWednesday[model.currentDate.getDay()])).getDate(), daytime: 'WEDNESDAY 11:00 AM', details: "Physical Therapy\nDr. Berg\n(999) 999-9999"},
					{month:String(Constants.MONTHS[new Date(new Date().setDate(myDate.date + daysToAddToReachFriday[model.currentDate.getDay()])).getMonth()]).toUpperCase(), date: new Date(new Date().setDate(myDate.date + daysToAddToReachFriday[model.currentDate.getDay()])).getDate(), daytime: 'FRIDAY 9:30 AM', details: "Allergies\nDr. Greenfield\n(999) 999-9999"},
					{month:String(Constants.MONTHS[new Date(new Date().setDate(myDate.date + nextWeekButNotWednesday)).getMonth()]).toUpperCase(), date: new Date(new Date().setDate(myDate.date + nextWeekButNotWednesday)).getDate(), daytime: (myDate.getDay() != 3) ? String(Constants.DAYS[myDate.getDay()]).toUpperCase() + ' 11:30 AM' : 'THURSDAY 11:30 AM', details: "Flu Vaccination\nDr. Berg\n(999) 999-9999"}
				);
		}
	}
}