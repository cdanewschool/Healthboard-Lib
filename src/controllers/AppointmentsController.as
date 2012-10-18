package controllers
{
	import ASclasses.Constants;
	
	import controllers.BaseModuleController;
	
	import enum.AppointmentStatus;
	
	import models.modules.AppointmentsModel;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.utils.ObjectUtil;
	
	import util.DateUtil;
	
	public class AppointmentsController extends BaseModuleController
	{
		public function AppointmentsController()
		{
			super();
			
			model = new AppointmentsModel();
		}
		
		override public function init():void
		{
			super.init();
			
			var model:AppointmentsModel = AppointmentsModel(model);
			
			var today:Date = AppProperties.getInstance().controller.model.today;
			
			var appointments:ArrayCollection = new ArrayCollection();
			
			var daysToAddToReachWednesday:Array = [3,2,1,7,6,5,4];
			var daysToAddToReachFriday:Array = [5,4,3,2,1,7,6];
			var nextWeekButNotWednesday:uint = (today.day != 3) ? 7 : 8;
			
			var obj:Object;
			
			obj = new Object();
			obj.date = new Date( today.fullYear, today.month, today.date, 11 );
			obj.desc = "Physical Examination";
			obj.type = "Appointment";
			obj.selected = true;
			obj.provider = "Dr. Berg";
			obj.status = AppointmentStatus.SCHEDULED;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, today.month, today.date + daysToAddToReachFriday[today.day], 9, 30 );;
			obj.desc = "Allergies";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Greenfield";
			obj.status = AppointmentStatus.SCHEDULED;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, today.month, today.date + nextWeekButNotWednesday, 11, 30 );	//aka "next week" (Anthony requested to make sure this doesn't happen on Wednesday, to avoid a usability test conflict with the other existing appointment on Wednesday).
			obj.desc = "Flu Vaccination";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Berg";
			obj.status = AppointmentStatus.SCHEDULED;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, today.month, today.date + daysToAddToReachWednesday[today.day], 13 ); //aka "next week"
			obj.desc = "Physical Therapy";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Berg";
			obj.status = AppointmentStatus.SCHEDULED;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, 8, 16, 11 );
			obj.desc = "Physician Examination";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Berg";
			obj.nextSteps = "Yes";
			obj.nextStepsText = "•Start the Physical Rehabilitation regimen we spoke about. Our Gentle Chair Yoga class would be beneficial if you find the time.\n\n•Continue to check blood sugar twice daily.";
			obj.status = AppointmentStatus.COMPLETED;
			obj.medRecIndex = 10;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, 7, 11, 11 );
			obj.desc = "Consultation";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Hammond";
			obj.status = AppointmentStatus.COMPLETED;
			obj.medRecIndex = 9;
			appointments.addItem( obj );
			
			obj = new Object();
			today = new Date("08/11/2012");
			today.setHours(0,0,0,0);
			obj.date = new Date( today.fullYear, 7, 11, 13 );
			obj.desc = "Surgery";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Berg";
			obj.status = AppointmentStatus.COMPLETED;
			obj.medRecIndex = 8;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, 9, 16, 11 );
			obj.desc = "MRI";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Berg";
			obj.status = AppointmentStatus.COMPLETED;
			obj.medRecIndex = 6;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, 9, 16, 13 );
			obj.desc = "MRI";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Berg";
			obj.status = AppointmentStatus.COMPLETED;
			obj.medRecIndex = 5;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, 7, 11, 16 );
			obj.desc = "Blood Test";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Rothstein";
			obj.status = AppointmentStatus.COMPLETED;
			obj.medRecIndex = 4;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, 7, 11, 19 );
			obj.desc = "Cardiac Stress Test";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Hammond";
			obj.status = AppointmentStatus.COMPLETED;
			obj.medRecIndex = 3;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, 9, 7, 11 );
			obj.desc = "Appendectomy";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Berg";
			obj.status = AppointmentStatus.COMPLETED;
			obj.medRecIndex = 2;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, 6, 7, 11 );
			obj.desc = "Nasal Procedure";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Berg";
			obj.status = AppointmentStatus.COMPLETED;
			obj.medRecIndex = 1;
			appointments.addItem( obj );
			
			obj = new Object();
			obj.date = new Date( today.fullYear, 9, 7, 14 );
			obj.desc = "Colonscopy";
			obj.type = "Appointment";
			obj.selected = false;
			obj.provider = "Dr. Berg";
			obj.status = AppointmentStatus.COMPLETED;
			obj.medRecIndex = 0;
			appointments.addItem( obj );
			
			for each(var appointment in appointments)
			{
				appointment.hour = (appointment.date.hours % 12 ).toString();
				appointment.meridiem = appointment.date.hours<12?"am":"pm";
				appointment.mins = appointment.date.minutes;
				
				appointment.date = new Date( appointment.date.fullYear, appointment.date.month, appointment.date.date );
			}
			
			today = AppProperties.getInstance().controller.model.today;
			
			var defaultAppointment:Object;
			
			var sort:Sort = new Sort();
			sort.compareFunction = DateUtil.compareByDate;
			appointments.sort = sort;
			appointments.refresh();
			
			for(var i:int=0;i<appointments.length;i++)
			{
				var appointment:Object = appointments[i];
				
				if( appointment.date.time >= today.time )
				{
					defaultAppointment = appointment;
					break;
				}
			}
			
			appointments.sort = null;
			appointments.refresh();
			
			model.appointments = appointments;
			model.currentAppointmentIndex = defaultAppointment ? model.appointments.getItemIndex(defaultAppointment) : 0;
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
	}
}