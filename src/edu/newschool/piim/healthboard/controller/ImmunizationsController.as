package edu.newschool.piim.healthboard.controller
{
	import edu.newschool.piim.healthboard.controller.BaseModuleController;
	
	import edu.newschool.piim.healthboard.model.module.ImmunizationsModel;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	
	import edu.newschool.piim.healthboard.util.DateUtil;
	
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
				var immunization:Object = model.immunizationsData.getItemAt(i);
				if( immunization.hasOwnProperty('date') ) immunization.date = DateUtil.modernizeDate( immunization.date );
				
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
				var immunizationDate:Date = new Date();
				immunizationDate.setTime( Date.parse( model.immunizationsData[i].date ) );
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