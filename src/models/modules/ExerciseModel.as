package models.modules
{
	import models.modules.ModuleModel;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class ExerciseModel extends ModuleModel
	{
		public var bookmarks:ArrayCollection;
		
		public var exerciseData:ArrayCollection;
		public var exerciseDataByMeasure:ArrayCollection;
		public var exerciseDataByMeasurePersonal:ArrayCollection;
		public var exerciseDataByMeasurePhysicianAssigned:ArrayCollection;
		public var exerciseDataPersonal:ArrayCollection;	//	for list view
		public var exerciseDataPhysicianAssigned:ArrayCollection;
		
		public var chartMinExPRT:Date = new Date(2011,5,8);
		public var chartMaxExPRT:Date = new Date(2012,9,31);
		public var chartMinExPA:Date = new Date(2011,7,26);
		public var chartMaxExPA:Date = new Date(2012,7,11);
		public var chartMinExPER:Date = new Date(2011,7,26);
		public var chartMaxExPER:Date = new Date(2012,7,11);
		
		public var bikeChartMin:Date = new Date(2011,6,7);
		public var bikeChartMax:Date = new Date(2012,10,22);
		public var bikeMax:String = "08/03/2012";
		public var commentsMax:String = "09/14/2012";	//	TODO:
		public var curlUpsMax:String = "09/24/2012";
		public var exPAcommentsMax:String = "08/03/2012";
		public var mileRunMax:String = "09/24/2012";
		public var PRTscoreMax:String = "09/24/2012";
		public var pushUpsMax:String = "09/24/2012";
		public var runWalkChartMin:Date = new Date(2011,8,1);
		public var runWalkChartMax:Date = new Date(2012,8,15);
		public var runWalkMax:String = "08/03/2012";
		public var weightChartMin:Date = new Date(2011,06,7);
		public var weightChartMax:Date = new Date(2012,10,22);
		
		public var PAproviderCopy:ArrayCollection;
		public var PERproviderCopy:ArrayCollection;
		public var exerciseForWidget:ArrayCollection;
		
		public var exerciseIndices:Array = new Array();
		public var exercisePAIndices:Array = new Array();
		public var exercisePERIndices:Array = new Array();
		
		public var exerciseCurrentIndex:uint;
	}
}