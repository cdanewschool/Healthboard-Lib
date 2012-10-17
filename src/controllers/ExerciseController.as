package controllers
{
	import controllers.BaseModuleController;
	
	import models.modules.ExerciseModel;
	
	import mx.charts.ChartItem;
	import mx.charts.series.items.LineSeriesItem;
	import mx.collections.ArrayCollection;
	import mx.graphics.IFill;
	
	import styles.ChartStyles;
	
	public class ExerciseController extends BaseModuleController
	{
		public function ExerciseController()
		{
			super();
			
			model = new ExerciseModel();
		}
		
		override public function init():void
		{
			super.init();
			
			var model:ExerciseModel = model as ExerciseModel;
			
			var fullname:String = AppProperties.getInstance().controller.model.fullname;
			
			model.exerciseCurrentIndex = 4;
			
			model.exerciseData = new ArrayCollection
				(
					[
						{dateProvider: '07/24/2011', date: '07/24/2011', series:"PRTresults", PRTscore: 60, mileRun: 62, curlUps: 80, pushUps: 92, weight: 203, min:14, sec:40, curlTimes:40, pushTimes:20, type: "provider", expectation:'expectation', comments:'', index:0},
						{dateProvider: '10/11/2011', date: '10/11/2011', series:"PRTresults", PRTscore: 61, mileRun: 61, curlUps: 60, pushUps: 48, weight: 200, min:14, sec:40, curlTimes:40, pushTimes:20, type: "provider", expectation:'expectation', comments:'', index:1},
						{datePatient: '11/03/2011', date: '11/03/2011', series:"PRTresults", PRTscore: 74, mileRun: 46, curlUps: 60, pushUps: 56, weight: 205, min:14, sec:10, curlTimes:30, pushTimes:20, type: "patient", expectation:'expectation', comments:'', index:2},
						{datePatient: '01/03/2012', date: '01/03/2012', series:"PRTresults", PRTscore: 81, mileRun: 56, curlUps: 50, pushUps: 70, weight: 210, min:15, sec:0, curlTimes:35, pushTimes:25, type: "patient", expectation:'expectation', comments:'', index:3},
						{datePatient: '05/03/2012', date: '05/03/2012', series:"PRTresults", PRTscore: 86, mileRun: 60, curlUps: 52, pushUps: 65, weight: 208, min:14, sec:30, curlTimes:35, pushTimes:25, type: "patient", expectation:'expectation', comments:'', index:4},
						{dateProvider: '09/24/2012', date: '09/24/2012', series:"PRTresults", PRTscore: 92, mileRun: 64, curlUps: 55, pushUps: 50, weight: 205, min:13, sec:50, curlTimes:40, pushTimes:24, type: "provider", expectation:'expectation', comments:'', index:5}
					]
				);
			
			model.exerciseDataByMeasure = new ArrayCollection
				(
					[
						{
							measure: "Avg. PRT Score", chartMin: 35, chartMax: 100,
							chart:
							[ 
								{ 
									data:
									[
										{value:56, expectation:45, date:'07/24/2011', type:'provider', measure:'PRTscore'},
										{value:61, expectation:45, date:'10/11/2011', type:'provider', measure:'PRTscore'},
										{value:74, expectation:45, date:'11/03/2011', type:'patient', measure:'PRTscore'},
										{value:81, expectation:45, date:'01/03/2012', type:'patient', measure:'PRTscore'},
										{value:86, expectation:45, date:'05/03/2012', type:'patient', measure:'PRTscore'},
										{value:92, expectation:45, date:'09/24/2012', type:'provider', measure:'PRTscore'}
									]
								}
							]
						},
						
						{
							measure: "1.5 Mile Run", chartMin: 35, chartMax: 100,
							chart:
							[ 
								{ 
									data:
									[
										{value:62, expectation:45, target:62, targetMin:14, targetSec:40, date:'07/24/2011', type:'provider', measure:'mileRun', min:14, sec:40},
										{value:63, expectation:45, target:62, date:'10/11/2011', type:'provider', measure:'mileRun', min:14, sec:35},
										{value:64, expectation:45, target:62, date:'11/03/2011', type:'patient', measure:'mileRun', min:14, sec:30},
										{value:60, expectation:45, target:62, date:'01/03/2012', type:'patient', measure:'mileRun', min:14, sec:50},
										{value:60, expectation:45, target:62, date:'05/03/2012', type:'patient', measure:'mileRun', min:14, sec:30},
										{value:62, expectation:45, target:62, date:'09/24/2012', type:'provider', measure:'mileRun', min:14, sec:40}
									]
								}
							]
						},
						
						{
							measure: "Curl Ups", chartMin: 35, chartMax: 100,
							chart:
							[ 
								{ 
									data:
									[
										{value:80, expectation:45, date:'07/24/2011', type:'provider', measure:'curlUps', times:40},
										{value:81, expectation:45, date:'10/11/2011', type:'provider', measure:'curlUps', times:40},
										{value:56, expectation:45, date:'11/03/2011', type:'patient', measure:'curlUps', times:30},
										{value:50, expectation:45, date:'01/03/2012', type:'patient', measure:'curlUps', times:35},
										{value:52, expectation:45, date:'05/03/2012', type:'patient', measure:'curlUps', times:35},
										{value:70, expectation:45, date:'09/24/2012', type:'provider', measure:'curlUps', times:40}
									]
								} 
							]
						},
						
						{
							measure: "Push Ups", chartMin: 35, chartMax: 100,
							chart:
							[ 
								{ 
									data:
									[
										{value:92, expectation:45, date:'07/24/2011', type:'provider', measure:'pushUps', times:20},
										{value:92, expectation:45, date:'10/11/2011', type:'provider', measure:'pushUps', times:20},
										{value:64, expectation:45, date:'11/03/2011', type:'patient', measure:'pushUps', times:20},
										{value:55, expectation:45, date:'01/03/2012', type:'patient', measure:'pushUps', times:25},
										{value:65, expectation:45, date:'05/03/2012', type:'patient', measure:'pushUps', times:25},
										{value:50, expectation:45, date:'09/24/2012', type:'provider', measure:'pushUps', times:24}
									]
								}
							]
						}
					]
				);
			
			model.exerciseDataPhysicianAssigned =  new ArrayCollection
				(
					[
						{date: '10/11/2011', runWalk: 30, runWalkMiles: 3.0, bike: 30, expectation:'expectation', index:0, comments:'I was feeling fine and enjoying exercising.', type: "patient"},
						{date: '11/11/2011', runWalk: 32, runWalkMiles: 3.0, bike: 29, expectation:'expectation', index:1, comments:'I was feeling fine and enjoying exercising.', type: "patient"},
						{date: '12/11/2011', runWalk: 34, runWalkMiles: 3.0, bike: 28, expectation:'expectation', index:2, comments:'I was feeling fine and enjoying exercising.', type: "patient"},
						{date: '01/11/2012', runWalk: 27, runWalkMiles: 3.0, bike: 31, expectation:'expectation', index:3, comments:'I was feeling fine and enjoying exercising.', type: "patient"},
						{date: '08/03/2012', runWalk: 30, runWalkMiles: 3.0, bike: 34, expectation:'expectation', index:4, comments:'I was feeling fine and enjoying exercising.', type: "patient"}
					]
				);
			
			model.exerciseDataByMeasurePhysicianAssigned = new ArrayCollection
				(
					[
						{ 
							measure: "Run / Walk", chartMin:15, chartMax:45,
							chart:
							[ 
								{
									data:
									[
										{value:30, expectation:30, date:'10/11/2011',miles:3.0, measure:'runWalk'},
										{value:32, expectation:30, date:'11/11/2011',miles:3.0, measure:'runWalk'},
										{value:34, expectation:30, date:'12/11/2011',miles:3.0, measure:'runWalk'},
										{value:27, expectation:30, date:'01/11/2012',miles:3.0, measure:'runWalk'},
										{value:30, expectation:30, date:'08/03/2012',miles:3.0, measure:'runWalk'}
									]
								}
							]
						},
						
						{ 
							measure: "Bike", chartMin:15, chartMax:45,
							chart:
							[ 
								{
									data:
									[
										{value:30, expectation:30, date:'10/11/2011', measure:'bike'},
										{value:29, expectation:30, date:'11/11/2011', measure:'bike'},
										{value:28, expectation:30, date:'12/11/2011', measure:'bike'},
										{value:31, expectation:30, date:'01/11/2012', measure:'bike'},
										{value:34, expectation:30, date:'08/03/2012', measure:'bike'}
									]
								}
							]
						},
						
						{
							measure: "Comments", chartType: "comments",
							chart:
							[ 
								{ 
									data:
									[
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'10/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'11/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'12/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'01/11/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'08/03/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'}
									]
								}
							]
						}
					]
				);
			
			model.exerciseDataPersonal = new ArrayCollection
				(
					[
						{date: '10/11/2011', activity: 'Bike', comments:'I was feeling fine and enjoying exercising.'},
						{date: '10/11/2011', activity: 'Hike', comments:'I was feeling fine and enjoying exercising.'},
						{date: '11/11/2011', activity: 'Bike', comments:'I was feeling fine and enjoying exercising.'},
						{date: '11/11/2011', activity: 'Hike', comments:'I was feeling fine and enjoying exercising.'},
						{date: '12/11/2011', activity: 'Bike', comments:'I was feeling fine and enjoying exercising.'},
						{date: '12/11/2011', activity: 'Hike', comments:'I was feeling fine and enjoying exercising.'},
						{date: '01/11/2012', activity: 'Bike', comments:'I was feeling fine and enjoying exercising.'},
						{date: '01/11/2012', activity: 'Hike', comments:'I was feeling fine and enjoying exercising.'},
						{date: '08/03/2012', activity: 'Bike', comments:'I was feeling fine and enjoying exercising.'},
						{date: '08/03/2012', activity: 'Hike', comments:'I was feeling fine and enjoying exercising.'}
					]
				);
			
			model.exerciseDataByMeasurePersonal = new ArrayCollection
				(
					[
						{ 
							measure: "Bike", chartMin:15, chartMax:45, chartType:'trackable',
							chart:
							[ 
								{
									data:
									[
										{value:30, expectation:30, date:'10/11/2011', measure:'bike'},
										{value:29, expectation:30, date:'11/11/2011', measure:'bike'},
										{value:28, expectation:30, date:'12/11/2011', measure:'bike'},
										{value:31, expectation:30, date:'01/11/2012', measure:'bike'},
										{value:34, expectation:30, date:'08/03/2012', measure:'bike'}
									]
								}
							]
						},
						
						{ 
							measure: "Hike", chartMin:15, chartMax:45, chartType: 'untrackable',
							chart:
							[
								{
									data:
									[
										{value:"This is my comment", expectation:30, date:'10/11/2011',measure:'hike', yvalue:30},
										{value:"This is my comment", expectation:30, date:'11/11/2011', measure:'hike', yvalue:30},
										{value:"This is my comment", expectation:30, date:'12/11/2011', measure:'hike', yvalue:30},
										{value:"This is my comment", expectation:30, date:'01/11/2012',measure:'hike', yvalue:30},
										{value:"This is my comment", expectation:30, date:'08/03/2012', measure:'hike', yvalue:30}
									]
								}
							]
						},
						
						{ 
							measure: "Comments", chartType: 'untrackable',
							chart:
							[ 
								{ 
									data:
									[
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'10/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'11/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'12/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'01/11/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'08/03/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'}
									]
								}
							]
						}
					]
				);
			
			model.PAproviderCopy = new ArrayCollection( model.exerciseDataByMeasurePhysicianAssigned.toArray() );
			model.PERproviderCopy = new ArrayCollection( model.exerciseDataByMeasurePersonal.toArray() );
			
			model.exerciseForWidget = new ArrayCollection
				(
					[
						{ exerciseType: "Most Recent PRT", lastDate: model.exerciseData.getItemAt(3).date, chartType: "normal", chartMin: 155, chartMax: 190, chart: model.exerciseData.getItemAt(3) },
						{ exerciseType: "Physician-assigned", lastDate: model.exerciseDataByMeasurePhysicianAssigned.getItemAt(0).chart[0].data[model.exerciseDataByMeasurePhysicianAssigned.getItemAt(0).chart[0].data.length - 1].date, chartType: "double", chartMin: 40, chartMax: 160, chart: model.PAproviderCopy },
						{ exerciseType: "Personal", lastDate: model.exerciseDataByMeasurePersonal.getItemAt(0).chart[0].data[model.exerciseDataByMeasurePersonal.getItemAt(0).chart[0].data.length - 1].date, chartType: "normal", chartMin: 40, chartMax: 85, chart: model.PERproviderCopy }	
					]
				);
			
			updatePAIndices();
			
			filterProvidersForWidget();
		}
		
		//	this function removes "Comments" and "Hiking" (untrackable exercise) for the WIDGET
		public function filterProvidersForWidget():void 
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			model.PAproviderCopy.source.splice(-1);
			model.PERproviderCopy.source.splice(-2);
		}
		
		public function updateExerciseIndices():void
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			var exerciseIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.exerciseDataByMeasure.length; i++) {
				exerciseIndicesTemp.push( model.exerciseDataByMeasure.getItemAt(i).measure );
			}
			
			model.exerciseIndices = exerciseIndicesTemp;
		}
		
		public function updatePAIndices():void 
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			var exercisePAIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.exerciseDataByMeasurePhysicianAssigned.length; i++) 
			{
				exercisePAIndicesTemp.push( model.exerciseDataByMeasurePhysicianAssigned.getItemAt(i).measure );
			}
			
			model.exercisePAIndices = exercisePAIndicesTemp;
		}
		
		public function updateExercisePERIndices():void
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			var exercisePERIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.exerciseDataByMeasurePersonal.length; i++) 
			{
				exercisePERIndicesTemp.push( model.exerciseDataByMeasurePersonal.getItemAt(i).measure );
			}
			
			model.exercisePERIndices = exercisePERIndicesTemp;
		}
		
		public function fillFunction(element:ChartItem, index:Number):IFill 
		{
			var item:LineSeriesItem = LineSeriesItem(element);
			var chartStyles:ChartStyles = AppProperties.getInstance().controller.model.chartStyles;
			
			return (item.item.type == 'provider') ? chartStyles.colorVitalSignsProvider : chartStyles.colorVitalSignsPatient;
		}
	}
}