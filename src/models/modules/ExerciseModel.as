package models.modules
{
	import models.modules.ModuleModel;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class ExerciseModel extends ModuleModel
	{
		public static const ID:String = "exercise";
		
		[Embed(source='/images/vitalSignsCommentPatient.png')] public var commentIconPatient:Class;
		[Embed(source='/images/vitalSignsCommentProvider.png')] public var commentIconProvider:Class;
		
		[Embed(source='/images/exerciseHappy.png')] public var performanceIconGood:Class;
		[Embed(source='/images/exerciseNeutral.png')] public var performanceIconNeutral:Class;
		[Embed(source='/images/exerciseSad.png')] public var performanceIconBad:Class;
		
		[Embed(source='/images/exercise/prt.png')] public var iconOverview:Class;
		[Embed(source='/images/exercise/bike.png')] public var iconBike:Class;
		[Embed(source='/images/exercise/curlups.png')] public var iconCurlUps:Class;
		[Embed(source='/images/exercise/elliptical.png')] public var iconMachine:Class;
		[Embed(source='/images/exercise/pushups.png')] public var iconPushUps:Class;
		[Embed(source='/images/exercise/run.png')] public var iconRun:Class;
		[Embed(source='/images/exercise/swim.png')] public var iconSwim:Class;
		[Embed(source='/images/exercise/weight.png')] public var iconWeight:Class;
		[Embed(source='/images/exercise/yoga.png')] public var iconYoga:Class;
		
		[Embed(source='/images/exercise/widget/bike.png')] public var iconBikeWidget:Class;
		[Embed(source='/images/exercise/widget/curlups.png')] public var iconCurlUpsWidget:Class;
		[Embed(source='/images/exercise/widget/pushups.png')] public var iconPushUpsWidget:Class;
		[Embed(source='/images/exercise/widget/run.png')] public var iconRunWidget:Class;
		[Embed(source='/images/exercise/widget/weight.png')] public var iconWeightWidget:Class;
		
		public var bookmarks:ArrayCollection;
		
		public var exerciseData:ArrayCollection;
		public var exerciseDataByMeasure:ArrayCollection;
		public var exerciseDataByMeasurePersonal:ArrayCollection;
		public var exerciseDataByMeasurePhysicianAssigned:ArrayCollection;
		public var exerciseDataPersonal:ArrayCollection;	//	for list view
		public var exerciseDataPhysicianAssigned:ArrayCollection;
		public var exerciseDataPhysicianAssigned2:ArrayCollection;
		
		/**
		 * TODO: 
		 * 	-	remove hard-coded min/max values and reference data instead
		 * 	-	update chart itemrenderers to change their state generically
		*/
		public var chartMinExPRT:Date = new Date(2011,5,8);
		public var chartMaxExPRT:Date = new Date(2012,9,31);
		public var chartMinExPA:Date = new Date(2011,7,26);
		public var chartMaxExPA:Date = new Date(2012,7,11);
		public var chartMinExPER:Date = new Date(2011,7,26);
		public var chartMaxExPER:Date = new Date(2012,7,11);
		
		public var bikeChartMin:Date = new Date(2011,6,7);
		public var bikeChartMax:Date = new Date(2012,10,22);
		public var bikeMax:String = "08/03/2012";
		public var weightMax:String = "08/03/2012";
		public var commentsMax:String = "09/14/2012";
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
		
		public var exerciseForWidget:ArrayCollection;
		
		public var exerciseIndices:Array = new Array();
		public var exercisePAIndices:Array = new Array();
		public var exercisePERIndices:Array = new Array();
		
		public var exerciseCurrentIndex:uint;
	}
}