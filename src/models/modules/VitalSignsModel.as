package models.modules
{
	import models.modules.ModuleModel;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class VitalSignsModel extends ModuleModel
	{
		public static const ID:String = "vitalsigns";
		
		public var dateRange:String;
		
		public var dateMin:Date = new Date(2011,7,26);
		public var dateMax:Date = new Date(2012,8,22);
		
		public var vitalSigns:ArrayCollection;
		public var vitalSignsByDate:ArrayCollection;
		public var vitalSignsForWidget:ArrayCollection;
		
		public var bloodPressureChartMin:Date = new Date(2011,06,7);
		public var bloodPressureChartMax:Date = new Date(2012,10,22);
		
		public var weightChartMin:Date = new Date(2011,06,7);
		public var weightChartMax:Date = new Date(2012,10,22);
		
		public var bloodPressureMax:String = "09/14/2012";
		public var commentsMax:String = "09/14/2012";
		public var heartRateMax:String = "07/14/2012";
		public var heightMax:String = "09/14/2012";
		public var respiratoryMax:String = "09/14/2012";
		public var temperatureMax:String = "09/14/2012";
		public var weightMax:String = "09/14/2012";
		
		public var vitalIndices:Array = new Array();
		
		public var moduleViewIndex:int = 0;
		
		public function VitalSignsModel()
		{
			super();
		}
	}
}