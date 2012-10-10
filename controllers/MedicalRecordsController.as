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
		
		override public function dataResultHandler(event:ResultEvent):void 
		{
			var model:MedicalRecordsModel = model as MedicalRecordsModel;
			
			model.medicalRecordsData = event.result.medicalRecords.medicalRecord;
			model.medicalRecordsDataGrid = ObjectUtil.copy( model.medicalRecordsData ) as ArrayCollection;
			model.medicalRecordsCategories = new Array();		//this is set to a new Array here, so that it is reset not only when the graph is first drawn, but also when the "Required only" checkbox is UNCHECKED, so the categories for the Y axis are re-calculated.
			model.medicalRecordsNextSteps = new ArrayCollection();
			
			for(var i:uint = 0; i < model.medicalRecordsData.length; i++) 
			{
				if( model.medicalRecordsCategories.indexOf( model.medicalRecordsData[i].name ) == -1) model.medicalRecordsCategories.push( model.medicalRecordsData[i].name );
				
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
			
			medicalRecordsCategoriesForTree();
			
			updateMedRecHeightAndColors();
			
			super.dataResultHandler(event);
		}
		
		private function medicalRecordsCategoriesForTree():void 
		{
			var model:MedicalRecordsModel = model as MedicalRecordsModel;
			
			var medicalRecordsCategoriesReversed:Array = ArrayUtil.unique( model.medicalRecordsCategories ).reverse();
			var currentCategory:int = -1;
			var currentLeaf:uint = 0;
			
			for(var i:uint = 0; i < medicalRecordsCategoriesReversed.length; i++) 
			{
				if(medicalRecordsCategoriesReversed[i] == "Visits" || medicalRecordsCategoriesReversed[i] == "Diagnostic Studies" || medicalRecordsCategoriesReversed[i] == "Surgeries" || medicalRecordsCategoriesReversed[i] == "Procedures") {
					currentCategory++;
					currentLeaf = 0;
				}
				else 
				{
					var newLeaf:Object = new Object();
					newLeaf = ({category: medicalRecordsCategoriesReversed[i]});
					model.medicalRecordsCategoriesTree[currentCategory].children[currentLeaf] = newLeaf;
					currentLeaf++;
				}
			}
		}
		
		public function updateMedRecHeightAndColors():void 
		{
		}
		
	}
}