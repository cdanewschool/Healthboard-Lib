package edu.newschool.piim.healthboard.controller
{
	import edu.newschool.piim.healthboard.Constants;
	
	import edu.newschool.piim.healthboard.controller.BaseModuleController;
	
	import edu.newschool.piim.healthboard.enum.AppointmentStatus;
	
	import edu.newschool.piim.healthboard.model.AppointmentCategory;
	import edu.newschool.piim.healthboard.model.ModuleMappable;
	import edu.newschool.piim.healthboard.model.NextStep;
	import edu.newschool.piim.healthboard.model.UserModel;
	import edu.newschool.piim.healthboard.model.module.AppointmentsModel;
	import edu.newschool.piim.healthboard.model.module.appointments.PatientAppointment;
	import edu.newschool.piim.healthboard.model.module.medicalrecords.MedicalRecord;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.events.CollectionEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.ObjectUtil;
	
	import edu.newschool.piim.healthboard.util.DateUtil;
	
	public class AppointmentsController extends BaseModuleController
	{
		public function AppointmentsController()
		{
			super();
			
			model = new AppointmentsModel();
			
			model.dataService.url = "data/appointmentCategories.xml";
			model.dataService.addEventListener( ResultEvent.RESULT, categoriesResultHandler );
			
			AppointmentsModel(model).dataService2.url = "data/appointments.xml";
			AppointmentsModel(model).dataService2.addEventListener( ResultEvent.RESULT, dataResultHandler );
		}
		
		override public function init():void
		{
			super.init();
			
			model.dataService.send();
		}
		
		public function categoriesResultHandler(event:ResultEvent):void 
		{
			var model:AppointmentsModel = model as AppointmentsModel;
			
			var results:ArrayCollection = event.result.categories.category;
			
			var categories:ArrayCollection = new ArrayCollection();
			
			var i:int = 0;
			
			for(i=0; i < results.length; i++) 
			{
				var category:AppointmentCategory = AppointmentCategory.fromObj( results.getItemAt(i) );
				categories.addItem( category );
			}
			
			model.appointmentCategories = categories;
			
			model.dataService2.send();
		}
		
		override public function dataResultHandler(event:ResultEvent):void 
		{
			var model:AppointmentsModel = model as AppointmentsModel;
			
			var results:ArrayCollection = event.result.appointments.appointment;
			
			var appointments:ArrayCollection = new ArrayCollection();
			
			var appointment:PatientAppointment;
			
			var i:int = 0;
			
			for(i=0; i < results.length; i++) 
			{
				appointment = PatientAppointment.fromObj( results.getItemAt(i) );
				appointments.addItem( appointment );
			}
			
			var sort:Sort = new Sort();
			sort.compareFunction = DateUtil.compareByDate;
			appointments.sort = sort;
			appointments.refresh();
			
			var today:Date = AppProperties.getInstance().controller.model.today;
			var defaultAppointment:PatientAppointment;
			
			var nextSteps:ArrayCollection = new ArrayCollection();
			
			for(i=0;i<appointments.length;i++)
			{
				appointment = appointments[i];
				
				if( appointment.nextSteps ) 
					for(var j:uint = 0; j < appointment.nextSteps.length; j++) 
						nextSteps.addItem( appointment.nextSteps.getItemAt(j) );
			}
			
			model.nextSteps = nextSteps;
			model.nextSteps.addEventListener( CollectionEvent.COLLECTION_CHANGE, onNextStepsChange );
			
			onNextStepsChange();
			
			for(i=0;i<appointments.length;i++)
			{
				appointment = appointments[i];
				
				if( appointment.date.time >= today.time )
				{
					defaultAppointment = appointment;
					break;
				}
			}
			
			model.currentAppointmentIndex = defaultAppointment ? appointments.getItemIndex(defaultAppointment) : 0;
			
			model.appointments = appointments;
			
			super.dataResultHandler(event);
		}
		
		private function onNextStepsChange(event:CollectionEvent=null):void
		{
			var model:AppointmentsModel = model as AppointmentsModel;
			
			model.nextStepsActive = new ArrayCollection( model.nextSteps.source.slice() );
			model.nextStepsActive.filterFunction = filterByCompleted;
			model.nextStepsActive.refresh();
		}
		
		private function filterByCompleted( item:NextStep ):Boolean
		{
			return !item.completed && !item.removed;
		}
		
		public function showNextStep( item:NextStep ):void
		{
			AppProperties.getInstance().controller.processModuleMappable( item as ModuleMappable );
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
		
		public function getCategoryById( id:String ):AppointmentCategory
		{
			var model:AppointmentsModel = AppointmentsModel(model);

			for each(var category:AppointmentCategory in model.appointmentCategories)
			{
				if( category.id == id ) return category;
				
				for each(var subCategory:AppointmentCategory in category.children)
				{
					if( subCategory.id == id) return subCategory;
				}
			}
			
			return null;
		}
	}
}