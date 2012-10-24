package controllers
{
	import models.ApplicationModel;
	import models.modules.MedicalRecordsModel;
	
	import mx.charts.DateTimeAxis;
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	
	import util.ArrayUtil;
	import util.DateFormatters;

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
				if( model.medicalRecordsData[i].hasOwnProperty('date') ) model.medicalRecordsData[i].date = modernizeDate( model.medicalRecordsData[i].date );
				if( model.medicalRecordsData[i].hasOwnProperty('inpdate') ) model.medicalRecordsData[i].inpdate = modernizeDate( model.medicalRecordsData[i].inpdate );
				
				if( model.medicalRecordsDataGrid[i].hasOwnProperty('date') ) model.medicalRecordsDataGrid[i].date = modernizeDate( model.medicalRecordsDataGrid[i].date );
				if( model.medicalRecordsDataGrid[i].hasOwnProperty('inpdate') ) model.medicalRecordsDataGrid[i].inpdate = modernizeDate( model.medicalRecordsDataGrid[i].inpdate );
				
				if( model.medicalRecordsCategories.getItemIndex( model.medicalRecordsData[i].name ) == -1) model.medicalRecordsCategories.addItem( model.medicalRecordsData[i].name );
				
				if( model.medicalRecordsData[i].nextSteps is ArrayCollection) 
				{
					for(var j:uint = 0; j < model.medicalRecordsData[i].nextSteps.length; j++) {
						model.medicalRecordsData[i].nextSteps[j].provider = model.medicalRecordsData[i].provider;		//should I do the same thing with "date", so there wouldn't be a need to create a duplicate? element under <medicalRecord>?
						model.medicalRecordsNextSteps.addItem( model.medicalRecordsData[i].nextSteps[j] );
					}
				}
				else if( model.medicalRecordsData[i].nextSteps is ObjectProxy ) 
				{
					model.medicalRecordsData[i].nextSteps.provider = model.medicalRecordsData[i].provider;
					model.medicalRecordsNextSteps.addItem( model.medicalRecordsData[i].nextSteps );
				}
			}
			
			super.dataResultHandler(event);
		}
		
		
	}
}