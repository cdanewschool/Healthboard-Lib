package edu.newschool.piim.healthboard.controller
{
	import edu.newschool.piim.healthboard.Constants;
	import edu.newschool.piim.healthboard.events.ApplicationEvent;
	import edu.newschool.piim.healthboard.events.AppointmentEvent;
	import edu.newschool.piim.healthboard.model.AppointmentCategory;
	import edu.newschool.piim.healthboard.model.ModuleMappable;
	import edu.newschool.piim.healthboard.model.NextStep;
	import edu.newschool.piim.healthboard.model.UserModel;
	import edu.newschool.piim.healthboard.model.module.AppointmentsModel;
	import edu.newschool.piim.healthboard.model.module.appointments.PatientAppointment;
	import edu.newschool.piim.healthboard.model.module.appointments.TimeSlot;
	import edu.newschool.piim.healthboard.util.DateUtil;
	import edu.newschool.piim.healthboard.view.components.popups.myAppointmentsWindow;
	import edu.newschool.piim.healthboard.view.components.popups.myClassesWindow;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.events.CloseEvent;
	import mx.events.CollectionEvent;
	import mx.managers.PopUpManager;
	import mx.rpc.events.ResultEvent;
	
	import spark.components.Application;
	import spark.components.TitleWindow;
	
	public class AppointmentsController extends BaseModuleController
	{
		private var application:Application;
		
		public function AppointmentsController()
		{
			super();
			
			model = new AppointmentsModel();
			
			model.dataService.url = "data/appointmentCategories.xml";
			model.dataService.addEventListener( ResultEvent.RESULT, categoriesResultHandler );
			
			AppointmentsModel(model).appointmentTypesDataService.url = "data/appointments.xml";
			AppointmentsModel(model).appointmentTypesDataService.addEventListener( ResultEvent.RESULT, dataResultHandler );
			
			AppointmentsModel(model).slotsDataService.addEventListener( ResultEvent.RESULT, onSlotsLoaded );
		}
		
		override public function init():void
		{
			super.init();
			
			application = AppProperties.getInstance().controller.application;
			application.addEventListener( AppointmentEvent.CONFIRM_APPOINTMENT, onConfirmAppointment );
			application.addEventListener( AppointmentEvent.REQUEST_APPOINTMENT, onAppointmentRequest );
			
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
			
			model.appointmentTypesDataService.send();
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
				
				if( appointment.from.time >= today.time )
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
		
		protected function onAppointmentRequest( event:AppointmentEvent ):void 
		{
			var model:AppointmentsModel = model as AppointmentsModel;
			
			var evt:ApplicationEvent = new ApplicationEvent( ApplicationEvent.SET_STATE );
			evt.data = Constants.MODULE_APPOINTMENTS;
			application.dispatchEvent( evt );
			
			if( event.category 
				&& event.category.id == "class" )
			{
				model.isRecommending = true;
				
				var myClass:myClassesWindow = myClassesWindow( PopUpManager.createPopUp( application, myClassesWindow ) as TitleWindow );
				myClass.addEventListener( AppointmentEvent.VIEW_AVAILABILITY, onViewAvailability );
				myClass.addEventListener( CloseEvent.CLOSE, onSchedulingPopupClose );
				PopUpManager.centerPopUp( myClass );
				
				var classID:String = event.data;
				if( classID ) 
					myClass.showClass( classID );
			}
			else
			{
				var myAppointment:myAppointmentsWindow = myAppointmentsWindow( PopUpManager.createPopUp( application, myAppointmentsWindow ) as TitleWindow );
				myAppointment.addEventListener( AppointmentEvent.VIEW_AVAILABILITY, onViewAvailability );
				
				PopUpManager.centerPopUp( myAppointment );
			}
		}
		
		private function onSchedulingPopupClose(event:CloseEvent):void
		{
			TitleWindow(event.currentTarget).removeEventListener( AppointmentEvent.VIEW_AVAILABILITY, onViewAvailability );
		}
		
		protected function onViewAvailability( event:AppointmentEvent ):void
		{
			getAvailable( event.category, event.description );
		}
		
		protected function getAvailable( type:AppointmentCategory = null, description:String = null ):void
		{
			var model:AppointmentsModel = model as AppointmentsModel;
			model.pendingDescription = description;
			
			AppointmentsModel(model).slotsDataService.url = "data/slots/" + (type && type.id == "class" ? "classes" : "appointments" ) + ".xml";	//	temp
			
			model.slotsDataService.send();
		}
		
		private function onSlotsLoaded(event:ResultEvent):void
		{
			var model:AppointmentsModel = model as AppointmentsModel;
			
			var results:ArrayCollection = event.result.appointments.appointment;
			
			var slots:ArrayCollection = new ArrayCollection();
			
			for(var i:int=0; i < results.length; i++) 
			{
				var slot:TimeSlot = TimeSlot.fromObj( results.getItemAt(i) );
				slot.description = model.pendingDescription;
				slots.addItem( slot );
			}
			
			model.pendingDescription = null;
			
			var evt:AppointmentEvent = new AppointmentEvent( AppointmentEvent.AVAILABILITY_LOADED, true );
			evt.data = slots;
			dispatchEvent( evt );
		}
		
		public function onConfirmAppointment( event:AppointmentEvent ):void
		{
			var slot:TimeSlot = event.data as TimeSlot;
			
			var appointment:PatientAppointment = new PatientAppointment();
			appointment.description = slot.description;
			appointment.from = slot.from;
			appointment.provider = AppProperties.getInstance().controller.getUserById( 1, UserModel.TYPE_PROVIDER );
			appointment.to = slot.to;
			
			var model:AppointmentsModel = AppointmentsModel(model);
			model.appointments.addItem( appointment );
			
			onConfirmSlot( appointment );
		}
		
		private function onConfirmSlot( appointment:PatientAppointment ):void
		{
			dispatchEvent( new AppointmentEvent( AppointmentEvent.CONFIRM_APPOINTMENT_SUCCESS, true, false, appointment ) );
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