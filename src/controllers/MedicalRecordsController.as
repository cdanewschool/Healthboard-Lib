package controllers
{
	import models.ApplicationModel;
	import models.NextStep;
	import models.modules.MedicalRecordsModel;
	
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
			
			for(var i:uint = 0; i < model.medicalRecordsData.length; i++) 
			{
				var medicalRecordObj:Object = model.medicalRecordsData.getItemAt(i);
				var medicalRecordGridObj:Object = model.medicalRecordsDataGrid.getItemAt(i);
				
				if( medicalRecordObj.hasOwnProperty('date') ) medicalRecordObj.date = DateUtil.modernizeDate( medicalRecordObj.date );
				if( medicalRecordObj.hasOwnProperty('inpdate') ) medicalRecordObj.inpdate = DateUtil.modernizeDate( medicalRecordObj.inpdate );
				
				if( medicalRecordGridObj.hasOwnProperty('date') ) medicalRecordGridObj.date = DateUtil.modernizeDate( medicalRecordGridObj.date );
				if( medicalRecordGridObj.hasOwnProperty('inpdate') ) medicalRecordGridObj.inpdate = DateUtil.modernizeDate( medicalRecordGridObj.inpdate );
				
				if( model.medicalRecordsCategories.getItemIndex( medicalRecordObj.name ) == -1) model.medicalRecordsCategories.addItem( medicalRecordObj.name );
				
				if( medicalRecordObj.nextSteps is ArrayCollection) 
				{
					for(var j:uint = 0; j < medicalRecordObj.nextSteps.length; j++) 
					{
						var nextStepObj:Object = medicalRecordObj.nextSteps[j];
						
						medicalRecordObj.nextSteps[j].provider = medicalRecordObj.provider;		//should I do the same thing with "date", so there wouldn't be a need to create a duplicate? element under <medicalRecord>?
						
						var nextStep:NextStep = NextStep.fromObj( nextStepObj );
						nextStep.dateAssigned = new Date( Date.parse( medicalRecordObj.date ) );
						nextStep.assignee = medicalRecordObj.provider;
						
						model.medicalRecordsNextSteps.addItem( nextStep );
					}
				}
				else if( medicalRecordObj.nextSteps is ObjectProxy ) 
				{
					medicalRecordObj.nextSteps.provider = medicalRecordObj.provider;
					model.medicalRecordsNextSteps.addItem( medicalRecordObj.nextSteps );
				}
			}
			
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
	}
}