package edu.newschool.piim.healthboard.controller
{
	import edu.newschool.piim.healthboard.controller.BaseModuleController;
	
	import edu.newschool.piim.healthboard.enum.ExerciseType;
	
	import edu.newschool.piim.healthboard.model.module.ExerciseModel;
	import edu.newschool.piim.healthboard.model.module.exercise.ExerciseActivity;
	import edu.newschool.piim.healthboard.model.module.exercise.ExerciseActivityGroup;
	
	import mx.charts.ChartItem;
	import mx.charts.series.items.LineSeriesItem;
	import mx.collections.ArrayCollection;
	import mx.graphics.IFill;
	
	import edu.newschool.piim.healthboard.view.styles.ChartStyles;
	
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
			
			var fullname:String = "Isaac Goodman";
			
			model.exerciseCurrentIndex = 4;
			
			model.exerciseData = new ArrayCollection
				(
					[
						{dateProvider: '07/24/2011', date: '07/24/2011', series:"PRTresults", PRTscore: 78, mileRun: 62, curlUps: 80, pushUps: 92, weight: 203, min:14, sec:40, curlTimes:40, pushTimes:20, type: "provider", expectation:'expectation', comments:'', index:0},
						{dateProvider: '10/11/2011', date: '10/11/2011', series:"PRTresults", PRTscore: 79, mileRun: 61, curlUps: 60, pushUps: 48, weight: 200, min:14, sec:40, curlTimes:40, pushTimes:20, type: "provider", expectation:'expectation', comments:'', index:1},
						{datePatient: '11/03/2011', date: '11/03/2011', series:"PRTresults", PRTscore: 61, mileRun: 46, curlUps: 60, pushUps: 56, weight: 205, min:14, sec:10, curlTimes:30, pushTimes:20, type: "patient", expectation:'expectation', comments:'', index:2},
						{datePatient: '01/03/2012', date: '01/03/2012', series:"PRTresults", PRTscore: 55, mileRun: 56, curlUps: 50, pushUps: 70, weight: 210, min:15, sec:0, curlTimes:35, pushTimes:25, type: "patient", expectation:'expectation', comments:'', index:3},
						{datePatient: '05/03/2012', date: '05/03/2012', series:"PRTresults", PRTscore: 59, mileRun: 60, curlUps: 52, pushUps: 65, weight: 208, min:14, sec:30, curlTimes:35, pushTimes:25, type: "patient", expectation:'expectation', comments:'', index:4},
						{dateProvider: '09/24/2012', date: '09/24/2012', series:"PRTresults", PRTscore: 61, mileRun: 64, curlUps: 55, pushUps: 50, weight: 205, min:13, sec:50, curlTimes:40, pushTimes:24, type: "provider", expectation:'expectation', comments:'', index:5}
					]
				);
			
			model.exerciseDataByMeasure = new ArrayCollection
				(
					[
						{
							type: "overview", type: ExerciseType.OVERVIEW, measure: "Overall PRT Score", chartMin: 35, chartMax: 100,
							chart:  new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{value:78, expectation:45, date:'07/24/2011', type:'provider', measure:'PRTscore'},
												{value:79, expectation:45, date:'10/11/2011', type:'provider', measure:'PRTscore'},
												{value:61, expectation:45, date:'11/03/2011', type:'patient', measure:'PRTscore'},
												{value:55, expectation:45, date:'01/03/2012', type:'patient', measure:'PRTscore'},
												{value:59, expectation:45, date:'05/03/2012', type:'patient', measure:'PRTscore'},
												{value:61, expectation:45, date:'09/24/2012', type:'provider', measure:'PRTscore'}
											]
										)
									}
								]
							)
						},
						
						{
							measure: "1.5 Mile Run", type: ExerciseType.RUN, chartMin: 35, chartMax: 100,
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{value:62, expectation:45, target:62, targetMin:14, targetSec:40, date:'07/24/2011', type:'provider', measure:'mileRun', min:14, sec:40},
												{value:63, expectation:45, target:62, date:'10/11/2011', type:'provider', measure:'mileRun', min:14, sec:35},
												{value:64, expectation:45, target:62, date:'11/03/2011', type:'patient', measure:'mileRun', min:14, sec:30},
												{value:60, expectation:45, target:62, date:'01/03/2012', type:'patient', measure:'mileRun', min:14, sec:50},
												{value:60, expectation:45, target:62, date:'05/03/2012', type:'patient', measure:'mileRun', min:14, sec:30},
												{value:62, expectation:45, target:62, date:'09/24/2012', type:'provider', measure:'mileRun', min:14, sec:40}
											]
										)
									}
								]
							)
						},
						
						{
							measure: "Curl Ups", type: ExerciseType.CURL_UPS, chartMin: 35, chartMax: 100,
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{value:80, expectation:45, date:'07/24/2011', type:'provider', measure:'curlUps', times:40},
												{value:81, expectation:45, date:'10/11/2011', type:'provider', measure:'curlUps', times:40},
												{value:56, expectation:45, date:'11/03/2011', type:'patient', measure:'curlUps', times:30},
												{value:50, expectation:45, date:'01/03/2012', type:'patient', measure:'curlUps', times:35},
												{value:52, expectation:45, date:'05/03/2012', type:'patient', measure:'curlUps', times:35},
												{value:70, expectation:45, date:'09/24/2012', type:'provider', measure:'curlUps', times:40}
											]
										)
									} 
								]
							)
						},
						
						{
							measure: "Push Ups", type: ExerciseType.PUSH_UPS, chartMin: 35, chartMax: 100,
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{value:92, expectation:45, date:'07/24/2011', type:'provider', measure:'pushUps', times:20},
												{value:92, expectation:45, date:'10/11/2011', type:'provider', measure:'pushUps', times:20},
												{value:64, expectation:45, date:'11/03/2011', type:'patient', measure:'pushUps', times:20},
												{value:55, expectation:45, date:'01/03/2012', type:'patient', measure:'pushUps', times:25},
												{value:65, expectation:45, date:'05/03/2012', type:'patient', measure:'pushUps', times:25},
												{value:50, expectation:45, date:'09/24/2012', type:'provider', measure:'pushUps', times:24}
											]
										)
									}
								]
							)
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
							type: 'comments', measure: "Comments", category: "Endurance", chartType: "comments",
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'10/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'11/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'12/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'01/11/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'08/03/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
												{type:'provider',expectation:'expectation',author:fullname,dateProvider:'08/03/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'}
											]
										)
									}
								]
							)
						},
						
						{ 
							type: ExerciseType.RUN, measure: "Run / Walk", category: "Endurance", unit: "minutes", unit2: "miles",
							chartType:'trackable', chartMin:15, chartMax:45, 
							chart: new ArrayCollection
							(
								[ 
									{
										data: new ArrayCollection
										(
											[
												{value:30, value2: 3.0, expectation:30, date:'10/11/2011', measure:'runWalk'},
												{value:32, value2: 3.0, expectation:30, date:'11/11/2011', measure:'runWalk'},
												{value:34, value2: 3.0, expectation:30, date:'12/11/2011', measure:'runWalk'},
												{value:27, value2: 3.0, expectation:30, date:'01/11/2012', measure:'runWalk'},
												{value:30, value2: 3.0, expectation:30, date:'08/03/2012', measure:'runWalk'}
											]
										)
									}
								]
							)
						},
						
						{ 
							type: ExerciseType.BIKE, measure: "Bike", unit: "minutes", unit2: "miles",
							chartMin:15, chartMax:45, chartType:'trackable', 
							chart: new ArrayCollection
							(
								[ 
									{
										data: new ArrayCollection
										(
											[
												{value:30, value2: 6.5, expectation:30, date:'10/11/2011', measure:'bike'},
												{value:29, value2: 8, expectation:30, date:'11/11/2011', measure:'bike'},
												{value:28, value2: 7.5, expectation:30, date:'12/11/2011', measure:'bike'},
												{value:31, value2: 5.5, expectation:30, date:'01/11/2012', measure:'bike'},
												{value:34, value2: 6.3, expectation:30, date:'08/03/2012', measure:'bike'}
											]
										)
									}
								]
							)
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
							type: 'comments', measure: "Comments", chartType: 'untrackable',
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'10/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'11/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'12/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'01/11/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'08/03/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'}
											]
										)
									}
								]
							)
						},
						
						{ 
							type: ExerciseType.BIKE, measure: "Bike", chartMin:15, chartMax:45, chartType:'trackable', unit: "minutes", unit2: "miles",
							chart: new ArrayCollection
							(
								[ 
									{
										data: new ArrayCollection
										(
											[
												{value:30, value2: 9.1, expectation:30, date:'10/11/2011', measure:'bike'},
												{value:29, value2: 8.6, expectation:30, date:'11/11/2011', measure:'bike'},
												{value:28, value2: 7.1, expectation:30, date:'12/11/2011', measure:'bike'},
												{value:31, value2: 6.5, expectation:30, date:'01/11/2012', measure:'bike'},
												{value:34, value2: 9.4, expectation:30, date:'08/03/2012', measure:'bike'}
											]
										)
									}
								]
							)
						},
						
						{ 
							type: ExerciseType.HIKE, measure: "Hike", chartMin:15, chartMax:45, chartType: 'untrackable', unit: "times",
							chart: new ArrayCollection
							(
								[
									{
										data: new ArrayCollection
										(
											[
												{value:"This is my comment", expectation:30, date:'10/11/2011',measure:'hike', yvalue:30},
												{value:"This is my comment", expectation:30, date:'11/11/2011', measure:'hike', yvalue:30},
												{value:"This is my comment", expectation:30, date:'12/11/2011', measure:'hike', yvalue:30},
												{value:"This is my comment", expectation:30, date:'01/11/2012',measure:'hike', yvalue:30},
												{value:"This is my comment", expectation:30, date:'08/03/2012', measure:'hike', yvalue:30}
											]
										)
									}
								]
							)
						}
						
					]
				);
			
			model.exerciseDataPhysicianAssigned2 =  new ArrayCollection
				(
					[
						new ExerciseActivityGroup
						(
							"Endurance", 
							"Exercises to enhance endurance",
							new ArrayCollection
							(
								[
									new ExerciseActivity( "Run/Walk", "assets/images/exercise/run.png", null, null, 3, 'weeks' ),
									new ExerciseActivity( "Bike", "assets/images/exercise/bike.png", null, null, 1, 'weeks' ),
									new ExerciseActivity( "Elliptical Machine", "assets/images/exercise/elliptical.png", null, null, 1, 'weeks' ),
									new ExerciseActivity( "Swim", "assets/images/exercise/swim.png", null, null, 1, 'weeks' ),
								]
							)
						),
						new ExerciseActivityGroup( "Flexibility" ),
						new ExerciseActivityGroup( "Strength" ),
						new ExerciseActivityGroup( "Diabetes" ),
						new ExerciseActivityGroup( "Exercise" ),
						new ExerciseActivityGroup( "Pregnant" )
					]
				);
			
			var exercisesProvider:Array = [];
			var exercisesPatient:Array = [];
			
			var exercise:Object;
			
			for each(exercise in model.exerciseDataByMeasurePhysicianAssigned)
				if( exercise.chartType == 'trackable' ) 
					exercisesProvider.push( exercise );
				
			for each(exercise in model.exerciseDataByMeasurePersonal)
				if( exercise.chartType == 'trackable' ) 
					exercisesPatient.push( exercise );
				
			model.exerciseForWidget = new ArrayCollection
				(
					[
						{ exerciseType: "Most Recent PRT", lastDate: model.exerciseData.getItemAt( model.exerciseData.length - 1 ).date, chartType: "normal", chartMin: 155, chartMax: 190, chart: model.exerciseData.getItemAt( model.exerciseData.length - 1 ) },
						{ exerciseType: "Physician-assigned", lastDate: model.exerciseDataByMeasurePhysicianAssigned.getItemAt(1).chart.getItemAt(0).data.getItemAt( model.exerciseDataByMeasurePhysicianAssigned.getItemAt(1).chart.getItemAt(0).data.length - 1 ).date, chartType: "double", chartMin: 40, chartMax: 160, chart: exercisesProvider },
						{ exerciseType: "Personal", lastDate: model.exerciseDataByMeasurePersonal.getItemAt(1).chart.getItemAt(0).data.getItemAt( model.exerciseDataByMeasurePersonal.getItemAt(1).chart.getItemAt(0).data.length - 1 ).date, chartType: "normal", chartMin: 40, chartMax: 85, chart: exercisesPatient }	
					]
				);
			
			updateExerciseIndices();
			updatePAIndices();
		}
		
		public function updateExerciseIndices():void
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			var exerciseIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.exerciseDataByMeasure.length; i++) {
				exerciseIndicesTemp.push( model.exerciseDataByMeasure.getItemAt(i).type );
			}
			
			model.exerciseIndices = exerciseIndicesTemp;
		}
		
		public function updatePAIndices():void 
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			var exercisePAIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.exerciseDataByMeasurePhysicianAssigned.length; i++) 
			{
				exercisePAIndicesTemp.push( model.exerciseDataByMeasurePhysicianAssigned.getItemAt(i).type );
			}
			
			model.exercisePAIndices = exercisePAIndicesTemp;
		}
		
		public function updateExercisePERIndices():void
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			var exercisePERIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.exerciseDataByMeasurePersonal.length; i++) 
			{
				exercisePERIndicesTemp.push( model.exerciseDataByMeasurePersonal.getItemAt(i).type );
			}
			
			model.exercisePERIndices = exercisePERIndicesTemp;
		}
		
		public function fillFunction(element:ChartItem, index:Number):IFill 
		{
			var item:LineSeriesItem = LineSeriesItem(element);
			var chartStyles:ChartStyles = AppProperties.getInstance().controller.model.chartStyles;
			
			return (item.item.type == 'provider') ? chartStyles.colorVitalSignsProvider : chartStyles.colorVitalSignsPatient;
		}
		
		public function getIconForExercise(data:Object, widget:Boolean = false):Class
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			if( data.type == ExerciseType.BIKE ) return widget ? model.iconBikeWidget : model.iconBike;
			if( data.type == ExerciseType.CURL_UPS ) return widget ? model.iconCurlUpsWidget : model.iconCurlUps;
			if( data.type == ExerciseType.ELLIPTICAL ) return widget ? model.iconMachine : model.iconMachine;
			if( data.type == ExerciseType.PUSH_UPS ) return widget ? model.iconPushUpsWidget : model.iconPushUps;
			if( data.type == ExerciseType.RUN ) return widget ? model.iconRunWidget : model.iconRun;
			if( data.type == ExerciseType.SWIM ) return widget ? model.iconSwim : model.iconSwim;
			if( data.type == ExerciseType.YOGA ) return widget ? model.iconYoga : model.iconYoga;
			if( data.type == ExerciseType.WEIGHT ) return widget ? model.iconWeightWidget : model.iconWeight;
			
			return null;
		}
		
		public function getPerformanceIconForExercise(data:Object):Class
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			if( data.value <= 45 ) return model.performanceIconBad;
			if( data.value >= 60 ) return model.performanceIconGood;
			
			return model.performanceIconNeutral;
		}
		
		public function getPerformanceLabelForExercise(data:Object):String
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			if( data.value <= 45 ) return "Bad";
			if( data.value >= 60 ) return "Good";
			
			return "Satisfactory";
		}
		
		public function getPerformanceLabelColorForExercise(data:Object):uint
		{
			var model:ExerciseModel = model as ExerciseModel;
			
			if( data.value <= 45 ) return 0xE32426;
			if( data.value >= 60 ) return 0x349846;
			
			return 0xCCCB30;
		}
	}
}