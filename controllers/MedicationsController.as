package controllers
{
	import components.medications.myRequestRenewalWindow;
	
	import events.ApplicationDataEvent;
	
	import models.modules.MedicationsModel;
	
	import mx.charts.ChartItem;
	import mx.charts.series.items.PlotSeriesItem;
	import mx.collections.ArrayCollection;
	import mx.graphics.IFill;
	import mx.graphics.SolidColor;
	import mx.managers.PopUpManager;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	import mx.utils.ObjectProxy;
	import mx.utils.ObjectUtil;
	
	import spark.components.TitleWindow;
	
	import styles.ChartStyles;
	
	public class MedicationsController extends BaseModuleController
	{
		public function MedicationsController()
		{
			super();
			
			model = new MedicationsModel();
			model.dataService.url = "data/medications.xml";
			model.dataService.addEventListener( ResultEvent.RESULT, dataResultHandler );
		}
		
		public function requestRenewal( medicationData:Object ):void 
		{
			var myRequestRenewal:myRequestRenewalWindow = myRequestRenewalWindow( PopUpManager.createPopUp( AppProperties.getInstance().controller.application, myRequestRenewalWindow ) as TitleWindow );
			myRequestRenewal.medNameDosage = medicationData.dose != '' ? medicationData.name + ' - ' + medicationData.dose : medicationData.name;
			
			PopUpManager.centerPopUp(myRequestRenewal);
		}
		
		override public function dataResultHandler(event:ResultEvent):void 
		{
			var model:MedicationsModel = model as MedicationsModel;
			
			model.medicationsData = event.result.medications.medication;	
			model.medicationsDataFiltered = new ArrayCollection(); //	this is set here so when the module is re-opened, it won't be duplicated...
			model.medicationsCategories = new Array();			 //	this is set to a new Array here, so that it is reset not only when the graph is first drawn, but also when the "Required only" checkbox is UNCHECKED, so the categories for the Y axis are re-calculated.
			
			for(var i:uint = 0; i < model.medicationsData.length; i++) 
			{
				if(model.medicationsCategories.indexOf(model.medicationsData[i].name) == -1) 
				{
					model.medicationsCategories.push(model.medicationsData[i].name);
					
					if(	model.medicationsData[i].name != "Prescription Drugs" 
						&& model.medicationsData[i].name != "Over-The-Counter Drugs" 
						&& model.medicationsData[i].name != "Supplements" 
						&& model.medicationsData[i].name != "Herbal Medicines") 
					{
						model.medicationsDataFiltered.addItem(model.medicationsData[i]);
						
						if(model.medicationsData[i].status == "active") 
							createNonTakenMeds(model.medicationsData[i]);
					}
				}
			}
			
			model.medicationsDataWidget = new ArrayCollection( model.medicationsData.source.slice() );
			
			filterMedsFromWidget();	//mediFilterStatus();	//we run the filter now, since we want to display only "active" medications when we load the module...
			
			super.dataResultHandler(event);
		}
		
		public function filterMedsFromWidget():void 
		{
			var model:MedicationsModel = model as MedicationsModel;
			
			model.medicationsDataWidget.filterFunction = filterMedicationsWidget;
			model.medicationsDataWidget.refresh();
			
			model.medicationsCategoriesWidget = new Array();
			
			for(var j:uint = 0; j < model.medicationsDataWidget.length; j++) 
			{
				if( model.medicationsCategoriesWidget.indexOf(model.medicationsDataWidget[j].name) == -1) 
				{
					model.medicationsCategoriesWidget.push(model.medicationsDataWidget[j].name);
				}
			}
		}
		
		public function filterMedicationsWidget(item:Object):Boolean 
		{
			return item.status != "inactive" && item.name != "Prescription Drugs" && item.name != "Over-The-Counter Drugs" && item.name != "Supplements" && item.name != "Herbal Medicines";
		}
		
		public function filterMedsFromStatus():void 
		{
			var model:MedicationsModel = model as MedicationsModel;
			
			model.medicationsData.filterFunction = filterMedications;
			model.medicationsData.refresh();
			
			model.medicationsDataFiltered = new ArrayCollection(); //this is set here so when the module is re-opened, it won't be duplicated...
			model.medicationsCategories = new Array();
			
			for(var j:uint = 0; j < model.medicationsData.length; j++) 
			{
				if( model.medicationsCategories.indexOf( model.medicationsData[j].name ) == -1) {
					model.medicationsCategories.push( model.medicationsData[j].name );
					
					if( model.medicationsData[j].name != "Prescription Drugs" && model.medicationsData[j].name != "Over-The-Counter Drugs" && model.medicationsData[j].name != "Supplements" && model.medicationsData[j].name != "Herbal Medicines" ) 
						model.medicationsDataFiltered.addItem( model.medicationsData[j] );
				}
			}
			
			model.medicationsDataFiltered.source.reverse();	//so the order in the datagrid is the same as in the chart.
		}
		
		//(this filterFunction was modified to avoid the conflict I was having when changing the status (active/all) and some of the nodes were previously hidden because they were inactive categories... (when going back go "active" they wouldn't show up because of the myOpenLeaves.indexOf(item.name) != -1 criteria...
		//the original function was left untouched (see below filterMedications2), but it's only used when updating filterMedsFromTreeNew()...
		private function filterMedications(item:Object):Boolean 
		{
			/*	NOAH: commented this out because it's doing nothing
			var myOpenLeaves:Array = new Array();
			var arrMedCategories:Array = new Array("Prescription Drugs","Over-The-Counter Drugs","Supplements","Herbal Medicines");
			var myOpenCategories:Array = new Array();
			
			for(var i:uint = 0; i < myTree.openItems.length; i++) 
			{
				myOpenCategories.push(myTree.openItems[i].category);
			}
			
			var count:uint = 0;
			
			for(var x:uint = 0; x < arrMedCategories.length; x++) 
			{
				myOpenLeaves.push( arrMedCategories[x] );
				
				if( myOpenCategories.indexOf(arrMedCategories[x]) == -1 ) 
				{
					//myOpenLeaves.push(arrMedCategories[x]);
					count--;
				}
				else 
				{
					//myOpenLeaves.push(myTree.openItems[count].category);
					for( var j:uint = 0; j < myTree.openItems[count].children.length; j++ ) 
					{
						myOpenLeaves.push( myTree.openItems[count].children[j].category);
					}
				}
				count++;
			}
			
			*/
			
			//return dropMediFilter.selectedIndex == 0 ? myOpenLeaves.indexOf(item.name) != -1 && item.status != "inactive" : myOpenLeaves.indexOf(item.name) != -1;
			return MedicationsModel(model).type == MedicationsModel.TYPE_ACTIVE == 0 ? item.status != "inactive" : true;
			
			//var pattern:RegExp = new RegExp("[^]*"+medicationsSearch.text+"[^]*", "i");
			//return pattern.test(item.name) || pattern.test(item.dose) || pattern.test(item.type) || pattern.test(item.prescription) || pattern.test(item.directions) || pattern.test(item.pharmacy) || pattern.test(item.lastFilledDate);
		}
		
		public function medicationsFillFunction(element:ChartItem, index:Number):IFill 
		{
			var chartStyles:ChartStyles = AppProperties.getInstance().controller.model.chartStyles;
			
			var item:PlotSeriesItem = PlotSeriesItem(element);
			var c:SolidColor = chartStyles.colorMedicationsPast; //gray	
			
			if(item.item.taken) 
			{
				if( item.item.asNeeded ) 
				{
					c = chartStyles.colorMedicalRecordsInpatient;		//orange
				}
				else 
				{
					c = chartStyles.colorMedicalRecordsOutpatient;	//blue
				}
			}
			
			return c;
		}
		
		private function createNonTakenMeds(med:Object):void 
		{
			var model:MedicationsModel = model as MedicationsModel;
			
			var myDate:Date = new Date("06/17/2012");
			var myDateString:String;
			var twoDigitMonth:String;
			var twoDigitHours:String;
			var myHours:uint = 12;
			var myMeridiem:String = "PM";
			var myFrequency:uint = 1;
			var myRecurrence:String = "day";
			
			var newMedicationOP:ObjectProxy;
			var newMedication:Object;
			
			for(var i:uint = 0; i < 110; i++)
			{
				newMedication = new Object();
				newMedication = ObjectUtil.copy(med);
				myDate.setDate(myDate.date+i);
				twoDigitMonth = (myDate.getMonth() + 1 < 10) ? "0" + (myDate.getMonth() + 1) + "/" : (myDate.getMonth() + 1) + "/";
				twoDigitHours = (myHours < 10) ? "0" + myHours + ":" : myHours + ":";		//adding the extra colon to ensure it's a string
				
				myDateString = twoDigitMonth + myDate.getDate() + "/" + myDate.getFullYear() + " " + twoDigitHours + "00:00 " + myMeridiem;
				
				/*if(med.type == "OTC") newMedication.dateO = myDateString;
				else if(med.type == "Supplement") newMedication.dateS = myDateString;
				else if(med.type == "Herbal") newMedication.dateH = myDateString;
				else if(med.type == "Prescription") newMedication.dateP = myDateString;*/
				newMedication.date = myDateString;
				newMedication.overdose = false;
				
				newMedicationOP = new ObjectProxy(newMedication);		//casting to ObjectProxy, otherwise the points in the graph don't get updated/taken when clicked...
				
				model.medicationsData.addItem(newMedicationOP);		//parentApplication.medicationsData.addItem(newMedication);
			}
		}
	}
}