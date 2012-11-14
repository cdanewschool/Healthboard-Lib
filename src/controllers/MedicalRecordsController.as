package controllers
{
	import ASclasses.Constants;
	
	import events.ApplicationEvent;
	import events.AppointmentEvent;
	
	import flash.events.Event;
	
	import models.ApplicationModel;
	import models.NextStep;
	import models.modules.AppointmentsModel;
	import models.modules.ExerciseModel;
	import models.modules.MedicalRecordsModel;
	import models.modules.NutritionModel;
	import models.modules.VitalSignsModel;
	
	import mx.charts.DateTimeAxis;
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	
	import util.ArrayUtil;
	import util.DateFormatters;
	import util.DateUtil;

	public class MedicalRecordsController extends BaseModuleController
	{
		public function MedicalRecordsController()
		{
			super();
			
			model = new MedicalRecordsModel();
			model.dataService.url = "data/medicalRecords.xml";
			model.dataService.addEventListener( ResultEvent.RESULT, dataResultHandler );
		}
		
		override public function init():void
		{
			super.init();
			
			var model:MedicalRecordsModel = model as MedicalRecordsModel;
			
			model.medicalRecordsProblemList = new ArrayCollection
				(
					[
						{ problem: "The patient is experiencing high levels of stress in the past few months.", dateEntered: new Date( 2011, 2, 11 ), provider: "Dr. Berg" }
					]
				);
		}
		
		override public function dataResultHandler(event:ResultEvent):void 
		{
			var model:MedicalRecordsModel = model as MedicalRecordsModel;
			
			model.medicalRecordsData = event.result.medicalRecords.medicalRecord;
			model.medicalRecordsDataGrid = ObjectUtil.copy( model.medicalRecordsData ) as ArrayCollection;
			model.medicalRecordsCategories = new ArrayCollection();		//this is set to a new Array here, so that it is reset not only when the graph is first drawn, but also when the "Required only" checkbox is UNCHECKED, so the categories for the Y axis are re-calculated.
			model.medicalRecordsNextSteps = new ArrayCollection();
			
			var nextSteps:ArrayCollection = new ArrayCollection();
			
			for(var i:uint = 0; i < model.medicalRecordsData.length; i++) 
			{
				var medicalRecordObj:Object = model.medicalRecordsData.getItemAt(i);
				var medicalRecordGridObj:Object = model.medicalRecordsDataGrid.getItemAt(i);
				
				if( medicalRecordObj.hasOwnProperty('date') ) medicalRecordObj.date = DateUtil.modernizeDate( medicalRecordObj.date );
				if( medicalRecordObj.hasOwnProperty('inpdate') ) medicalRecordObj.inpdate = DateUtil.modernizeDate( medicalRecordObj.inpdate );
				
				if( medicalRecordGridObj.hasOwnProperty('date') ) medicalRecordGridObj.date = DateUtil.modernizeDate( medicalRecordGridObj.date );
				if( medicalRecordGridObj.hasOwnProperty('inpdate') ) medicalRecordGridObj.inpdate = DateUtil.modernizeDate( medicalRecordGridObj.inpdate );
				
				if( model.medicalRecordsCategories.getItemIndex( medicalRecordObj.name ) == -1) model.medicalRecordsCategories.addItem( medicalRecordObj.name );
				
				var nextStepObj:Object;
				var nextStep:NextStep;
				
				var nextStepsForRecord:ArrayCollection = new ArrayCollection();
				
				if( medicalRecordObj.nextSteps is ArrayCollection) 
				{
					for(var j:uint = 0; j < medicalRecordObj.nextSteps.length; j++) 
					{
						nextStepObj = medicalRecordObj.nextSteps[j];
						
						nextStep = NextStep.fromObj( nextStepObj );
						nextStep.dateAssigned = new Date( Date.parse( medicalRecordObj.date ) );
						nextStep.assignee = medicalRecordObj.provider;
						
						nextSteps.addItem( nextStep );
						nextStepsForRecord.addItem( nextStep );
					}
				}
				else if( medicalRecordObj.nextSteps is ObjectProxy ) 
				{
					nextStepObj = medicalRecordObj.nextSteps;
					
					nextStep = NextStep.fromObj( nextStepObj );
					nextStep.dateAssigned = new Date( Date.parse( medicalRecordObj.date ) );
					nextStep.assignee = medicalRecordObj.provider;
					
					nextSteps.addItem( nextStep );
					nextStepsForRecord.addItem( nextStep );
				}
				
				medicalRecordObj.nextSteps = nextStepsForRecord;
				medicalRecordGridObj.nextSteps = nextStepsForRecord;
			}
			
			model.medicalRecordsNextSteps = nextSteps;
			model.medicalRecordsNextSteps.addEventListener( CollectionEvent.COLLECTION_CHANGE, onNextStepsChange );
			
			onNextStepsChange();
			
			super.dataResultHandler(event);
		}
		
		private function onNextStepsChange(event:CollectionEvent=null):void
		{
			var model:MedicalRecordsModel = model as MedicalRecordsModel;
			
			model.medicalRecordsNextStepsActive = new ArrayCollection( model.medicalRecordsNextSteps.source.slice() );
			model.medicalRecordsNextStepsActive.filterFunction = filterByCompleted;
			model.medicalRecordsNextStepsActive.refresh();
		}
		
		private function filterByCompleted( item:NextStep ):Boolean
		{
			return !item.completed;
		}
		
		public function showNextStep( item:NextStep ):void
		{
			var evt:Event;
			
			var module:String;
			
			if( item.area == ExerciseModel.ID )
				module = Constants.MODULE_EXERCISE;
			else if( item.area == NutritionModel.ID )
				module = Constants.MODULE_NUTRITION;
			else if( item.area == AppointmentsModel.ID )
			{
				if( item.recommendation )
				{
					if( item.type == "class" )
						evt = new AppointmentEvent( AppointmentEvent.REQUEST_CLASS, true, false, item.actionId );
					else
						evt = new AppointmentEvent( AppointmentEvent.REQUEST_APPOINTMENT, true );
					
					AppProperties.getInstance().controller.application.dispatchEvent( evt );
				}
				else
				{
					module = Constants.MODULE_APPOINTMENTS;
				}						
			}
			else if( item.area == VitalSignsModel.ID )
				module = Constants.MODULE_VITAL_SIGNS;
			else if( item.area == MedicalRecordsModel.ID )
				module = Constants.MODULE_MEDICAL_RECORDS;
			
			if( module )
			{
				evt = new ApplicationEvent( ApplicationEvent.SET_STATE, true, false, module );
				AppProperties.getInstance().controller.application.dispatchEvent( evt );
			}
		}
		
		public function getMedicalRecordByNextStep( nextStep:NextStep ):Object
		{
			var model:MedicalRecordsModel = model as MedicalRecordsModel;
			
			for each(var medicalRecord:Object in model.medicalRecordsData)
			{
				if( !medicalRecord.nextSteps ) continue;
				
				if( medicalRecord.nextSteps.getItemIndex( nextStep ) > -1 )
				{
					return medicalRecord;
				}
			}
			
			return null;
		}
	}
}
