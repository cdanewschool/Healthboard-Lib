package controllers
{
	import controllers.BaseModuleController;
	
	import models.modules.ImmunizationsModel;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	
	public class ImmunizationsController extends BaseModuleController
	{
		public function ImmunizationsController()
		{
			super();
			
			model = new ImmunizationsModel();
			model.dataService.url = "data/immunizations.xml";
			model.dataService.addEventListener( ResultEvent.RESULT, dataResultHandler );
		}
		
		override public function dataResultHandler(event:ResultEvent):void 
		{
			var model:ImmunizationsModel = model as ImmunizationsModel;
			
			model.immunizationsData = event.result.immunizations.immunization;
			model.immunizationsDataFiltered = new ArrayCollection();
			model.immunizationsCategories = new Array();		//	this is set to a new Array here, so that it is reset not only when the graph is first drawn, but also when the "Required only" checkbox is UNCHECKED, so the categories for the Y axis are re-calculated.
			
			for(var i:uint = 0; i < model.immunizationsData.length; i++)
			{
				if( model.immunizationsCategories.indexOf(model.immunizationsData.getItemAt(i).name) == -1 ) 
				{
					model.immunizationsCategories.push( model.immunizationsData.getItemAt(i).name );
					model.immunizationsDataFiltered.addItem( model.immunizationsData.getItemAt(i) );
				}
			}
			
			//	so the order in the datagrid is the same as in the chart.
			model.immunizationsDataFiltered.source.reverse();
			
			getImmunizationsDueNumber();
			
			super.dataResultHandler(event);
		}
		
		/**
		 * Same as previous two, used by "ImmunizationDetails.mxml" and main DataGrid view to display Status
		 */
		public function getStatus(completed:Boolean, immunizationDateString:String):String 
		{
			var c:String = "Due Within One Month"	//yellow
			var immunizationDate:Date = new Date( immunizationDateString );
			var todayWithTime:Date = new Date();
			var today:Date = new Date(todayWithTime.getFullYear(),todayWithTime.getMonth(),todayWithTime.getDate());
			
			if(completed == true) 
			{
				c = "Completed";
			}
			else if(immunizationDate.getTime() == today.getTime()) 
			{
				c = "Addressed Today for Immunizations Have Been Given";
			}
			else if(immunizationDate.getTime() < today.getTime()) 
			{
				c = "Overdue";		//red
			}
			
			return c;
		}
		
		/* This is used to get the number to be displayed at the top of the module */
		private function getImmunizationsDueNumber():void 
		{
			var model:ImmunizationsModel = model as ImmunizationsModel;
			
			var count:uint = 0;
			
			for(var i:uint = 0; i < model.immunizationsData.source.length; i++) 
			{
				var immunizationDate:Date = new Date( model.immunizationsData[i].date.substr(6), model.immunizationsData[i].date.substr(0,2)-1, model.immunizationsData[i].date.substr(3,2));
				var todayWithTime:Date = new Date();
				var today:Date = new Date(todayWithTime.getFullYear(),todayWithTime.getMonth(),todayWithTime.getDate());
				
				if(model.immunizationsData[i].completed != true) 
				{
					if(immunizationDate.getTime() < today.getTime()) 
					{
						count++;
					}
					else if(immunizationDate.getTime() > today.getTime()) 
					{
						count++;
					}
				}
			}
			
			model.immunizationsDueNumber = count;
		}
	}
}