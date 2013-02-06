package edu.newschool.piim.healthboard.model.module
{
	import edu.newschool.piim.healthboard.enum.DateRanges;
	
	import edu.newschool.piim.healthboard.model.module.ModuleModel;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class ImmunizationsModel extends ModuleModel
	{
		public static const ID:String = "immunizations";
		
		//	data provider for the Plot Chart
		public var immunizationsData:ArrayCollection = new ArrayCollection();
		//	data provider for the Data Grid
		public var immunizationsDataFiltered:ArrayCollection;
		
		public var immunizationsCategories:Array;
		public var immunizationsDueNumber:uint = 0;
		
		private var today:Date = new Date();	
		
		public var minDate:Date = new Date( today.fullYear, today.month - 7, 14 );
		public var maxDate:Date = new Date( today.fullYear, today.month + 5, 14 );
		
		public var dateRange:String = DateRanges.YEAR;
		
		public function ImmunizationsModel()
		{
			super();
		}
	}
}