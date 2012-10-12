package controllers
{
	import ASclasses.Constants;
	
	import controllers.BaseModuleController;
	
	import models.modules.AppointmentsModel;
	
	import mx.utils.ObjectUtil;
	
	import util.DateUtil;
	
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
			
			var today:Date = new Date( model.currentDate.fullYear, model.currentDate.month, model.currentDate.date ); 
			
			AppointmentsModel(model).appointments = new Array
				(
					{datetime: Date.parse('07/7/12 11:00:00'),  details: "Nasal Procedure\nDr. Berg\n(999) 999-9999"},
					{datetime: Date.parse('08/11/12 11:00:00'), details: "Consultation\nDr. Hammond\n(999) 999-9999"},
					{datetime: Date.parse('08/11/12 13:00:00'), details: "Surgery\nDr. Berg\n(999) 999-9999"},
					{datetime: Date.parse('08/11/12 16:00:00'), details: "Blood Test\nDr. Rothstein\n(999) 999-9999"},
					{datetime: Date.parse('08/11/12 19:00:00'), details: "Cardiac Stress Test\nDr. Hammond\n(999) 999-9999"},
					{datetime: Date.parse('09/16/12 11:00:00'), details: "Physician Examination\nDr. Berg\n(999) 999-9999"},
					{datetime: Date.parse('09/16/12 13:00:00'), details: "MRI\nDr. Berg\n(999) 999-9999"},
					{datetime: Date.parse('10/07/12 11:00:00'), details: "Appendectomy\nDr. Berg\n(999) 999-9999"},
					{datetime: Date.parse('10/07/12 13:00:00'), details: "Colonscopy\nDr. Berg\n(999) 999-9999"},
					{datetime: Date.parse('10/16/12 13:00:00'), details: "MRI\nDr. Berg\n(999) 999-9999"},
					
					{datetime: today.time + (DateUtil.HOUR * 11), details: "Physical Examination\nDr. Berg\n(999) 999-9999"},
					{datetime: today.time + (DateUtil.DAY * Math.abs(2 - today.day)) + (DateUtil.HOUR * 11), details: "Physical Therapy\nDr. Berg\n(999) 999-9999"},
					{datetime: today.time + (DateUtil.DAY * Math.abs(4 - today.day)) + (DateUtil.HOUR * 9.5),  details: "Allergies\nDr. Greenfield\n(999) 999-9999"},
					{datetime: today.time + (DateUtil.DAY * Math.abs(3 - today.day)) + (DateUtil.HOUR * 11.5), details: "Flu Vaccination\nDr. Berg\n(999) 999-9999"}
				);
		}
	}
}