import mx.collections.ArrayCollection;

[Bindable] public var exerciseData:ArrayCollection = new ArrayCollection([
	{dateProvider: '07/24/2011', date: '07/24/2011', series:"PRTresults", PRTscore: 60, mileRun: 62, curlUps: 80, pushUps: 92, weight: 203, min:14, sec:40, curlTimes:40, pushTimes:20, type: "provider", expectation:'expectation', comments:'', index:0},
	{dateProvider: '10/11/2011', date: '10/11/2011', series:"PRTresults", PRTscore: 61, mileRun: 61, curlUps: 60, pushUps: 48, weight: 200, min:14, sec:40, curlTimes:40, pushTimes:20, type: "provider", expectation:'expectation', comments:'', index:1},
	{datePatient: '11/03/2011', date: '11/03/2011', series:"PRTresults", PRTscore: 74, mileRun: 46, curlUps: 60, pushUps: 56, weight: 205, min:14, sec:10, curlTimes:30, pushTimes:20, type: "patient", expectation:'expectation', comments:'', index:2},
	{datePatient: '01/03/2012', date: '01/03/2012', series:"PRTresults", PRTscore: 81, mileRun: 56, curlUps: 50, pushUps: 70, weight: 210, min:15, sec:0, curlTimes:35, pushTimes:25, type: "patient", expectation:'expectation', comments:'', index:3},
	{datePatient: '05/03/2012', date: '05/03/2012', series:"PRTresults", PRTscore: 86, mileRun: 60, curlUps: 52, pushUps: 65, weight: 208, min:14, sec:30, curlTimes:35, pushTimes:25, type: "patient", expectation:'expectation', comments:'', index:4},
	{dateProvider: '09/24/2012', date: '09/24/2012', series:"PRTresults", PRTscore: 92, mileRun: 64, curlUps: 55, pushUps: 50, weight: 175, min:13, sec:50, curlTimes:40, pushTimes:24, type: "provider", expectation:'expectation', comments:'', index:5}
]);

[Bindable] public var exerciseDataByMeasure:ArrayCollection = new ArrayCollection([
	{ measure: "Avg. PRT Score", chartMin: 35, chartMax: 100,
		chart:[ { data:[{value:56, expectation:45, date:'07/24/2011', type:'provider', measure:'PRTscore'},
						{value:61, expectation:45, date:'10/11/2011', type:'provider', measure:'PRTscore'},
						{value:74, expectation:45, date:'11/03/2011', type:'patient', measure:'PRTscore'},
						{value:81, expectation:45, date:'01/03/2012', type:'patient', measure:'PRTscore'},
						{value:86, expectation:45, date:'05/03/2012', type:'patient', measure:'PRTscore'},
						{value:92, expectation:45, date:'09/24/2012', type:'provider', measure:'PRTscore'}]
			  } ]
	},
	{ measure: "1.5 Mile Run", chartMin: 35, chartMax: 100,
		chart:[ { data:[{value:62, expectation:45, target:62, targetMin:14, targetSec:40, date:'07/24/2011', type:'provider', measure:'mileRun', min:14, sec:40},
						{value:63, expectation:45, target:62, date:'10/11/2011', type:'provider', measure:'mileRun', min:14, sec:35},
						{value:64, expectation:45, target:62, date:'11/03/2011', type:'patient', measure:'mileRun', min:14, sec:30},
						{value:60, expectation:45, target:62, date:'01/03/2012', type:'patient', measure:'mileRun', min:14, sec:50},
						{value:60, expectation:45, target:62, date:'05/03/2012', type:'patient', measure:'mileRun', min:14, sec:30},
						{value:62, expectation:45, target:62, date:'09/24/2012', type:'provider', measure:'mileRun', min:14, sec:40}]
			  } ]
	},
	{ measure: "Curl Ups", chartMin: 35, chartMax: 100,
		chart:[ { data:[{value:80, expectation:45, date:'07/24/2011', type:'provider', measure:'curlUps', times:40},
						{value:81, expectation:45, date:'10/11/2011', type:'provider', measure:'curlUps', times:40},
						{value:56, expectation:45, date:'11/03/2011', type:'patient', measure:'curlUps', times:30},
						{value:50, expectation:45, date:'01/03/2012', type:'patient', measure:'curlUps', times:35},
						{value:52, expectation:45, date:'05/03/2012', type:'patient', measure:'curlUps', times:35},
						{value:70, expectation:45, date:'09/24/2012', type:'provider', measure:'curlUps', times:40}]
			  } ]
	},
	{ measure: "Push Ups", chartMin: 35, chartMax: 100,
		chart:[ { data:[{value:92, expectation:45, date:'07/24/2011', type:'provider', measure:'pushUps', times:20},
						{value:92, expectation:45, date:'10/11/2011', type:'provider', measure:'pushUps', times:20},
						{value:64, expectation:45, date:'11/03/2011', type:'patient', measure:'pushUps', times:20},
						{value:55, expectation:45, date:'01/03/2012', type:'patient', measure:'pushUps', times:25},
						{value:65, expectation:45, date:'05/03/2012', type:'patient', measure:'pushUps', times:25},
						{value:50, expectation:45, date:'09/24/2012', type:'provider', measure:'pushUps', times:24}]
			  } ]
	}
]);

[Bindable] public var exerciseDataPhysicianAssigned:ArrayCollection = new ArrayCollection([
	{date: '10/11/2011', runWalk: 30, runWalkMiles: 3.0, bike: 30, expectation:'expectation', index:0, comments:'I was feeling fine and enjoying exercising.', type: "patient"},
	{date: '11/11/2011', runWalk: 32, runWalkMiles: 3.0, bike: 29, expectation:'expectation', index:1, comments:'I was feeling fine and enjoying exercising.', type: "patient"},
	{date: '12/11/2011', runWalk: 34, runWalkMiles: 3.0, bike: 28, expectation:'expectation', index:2, comments:'I was feeling fine and enjoying exercising.', type: "patient"},
	{date: '01/11/2012', runWalk: 27, runWalkMiles: 3.0, bike: 31, expectation:'expectation', index:3, comments:'I was feeling fine and enjoying exercising.', type: "patient"},
	{date: '08/03/2012', runWalk: 30, runWalkMiles: 3.0, bike: 34, expectation:'expectation', index:4, comments:'I was feeling fine and enjoying exercising.', type: "patient"}
]);

[Bindable] public var exerciseDataByMeasurePhysicianAssigned:ArrayCollection = new ArrayCollection([
	{ measure: "Run / Walk", chartMin:15, chartMax:45,
		chart:[ {data:[{value:30, expectation:30, date:'10/11/2011',miles:3.0, measure:'runWalk'},
					   {value:32, expectation:30, date:'11/11/2011',miles:3.0, measure:'runWalk'},
					   {value:34, expectation:30, date:'12/11/2011',miles:3.0, measure:'runWalk'},
					   {value:27, expectation:30, date:'01/11/2012',miles:3.0, measure:'runWalk'},
					   {value:30, expectation:30, date:'08/03/2012',miles:3.0, measure:'runWalk'}]
				}]
	},
	{ measure: "Bike", chartMin:15, chartMax:45,
		chart:[ {data:[{value:30, expectation:30, date:'10/11/2011', measure:'bike'},{value:29, expectation:30, date:'11/11/2011', measure:'bike'},{value:28, expectation:30, date:'12/11/2011', measure:'bike'},{value:31, expectation:30, date:'01/11/2012', measure:'bike'},{value:34, expectation:30, date:'08/03/2012', measure:'bike'}]}]},
	{ measure: "Comments", chartType: "comments",
		chart:[ { data:[{type:'patient',expectation:'expectation',author:fullname,datePatient:'10/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'11/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'12/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'01/11/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'08/03/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'}]}]}
]);

//for list view
[Bindable] public var exerciseDataPersonal:ArrayCollection = new ArrayCollection([
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
]);

[Bindable] public var exerciseDataByMeasurePersonal:ArrayCollection = new ArrayCollection([
	{ measure: "Bike", chartMin:15, chartMax:45, chartType:'trackable',
		chart:[ {data:[{value:30, expectation:30, date:'10/11/2011', measure:'bike'},{value:29, expectation:30, date:'11/11/2011', measure:'bike'},{value:28, expectation:30, date:'12/11/2011', measure:'bike'},{value:31, expectation:30, date:'01/11/2012', measure:'bike'},{value:34, expectation:30, date:'08/03/2012', measure:'bike'}]}]},
	{ measure: "Hike", chartMin:15, chartMax:45, chartType: 'untrackable',
		chart:[ {data:[{value:"This is my comment", expectation:30, date:'10/11/2011',measure:'hike', yvalue:30},{value:"This is my comment", expectation:30, date:'11/11/2011', measure:'hike', yvalue:30},{value:"This is my comment", expectation:30, date:'12/11/2011', measure:'hike', yvalue:30},{value:"This is my comment", expectation:30, date:'01/11/2012',measure:'hike', yvalue:30},{value:"This is my comment", expectation:30, date:'08/03/2012', measure:'hike', yvalue:30}]}]},
	{ measure: "Comments", chartType: 'untrackable',
		chart:[ { data:[{type:'patient',expectation:'expectation',author:fullname,datePatient:'10/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'11/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'12/11/2011',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'01/11/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'08/03/2012',comments:'I was feeling fine and enjoying exercising.', measure:'comments'}]}]}
]);

[Bindable] public var chartMinExPRT:Date = new Date(2011,5,8);
[Bindable] public var chartMaxExPRT:Date = new Date(2012,9,31);
[Bindable] public var chartMinExPA:Date = new Date(2011,7,26);
[Bindable] public var chartMaxExPA:Date = new Date(2012,7,11);
[Bindable] public var chartMinExPER:Date = new Date(2011,7,26);
[Bindable] public var chartMaxExPER:Date = new Date(2012,7,11);

//
[Bindable] public var PRTscoreMax:String = "09/24/2012";
[Bindable] public var mileRunMax:String = "09/24/2012";
[Bindable] public var curlUpsMax:String = "09/24/2012";
[Bindable] public var pushUpsMax:String = "09/24/2012";
[Bindable] public var runWalkChartMin:Date = new Date(2011,8,1);
[Bindable] public var runWalkChartMax:Date = new Date(2012,8,15);
[Bindable] public var runWalkMax:String = "08/03/2012";
[Bindable] public var bikeChartMin:Date = new Date(2011,6,7);
[Bindable] public var bikeChartMax:Date = new Date(2012,10,22);
[Bindable] public var bikeMax:String = "08/03/2012";
[Bindable] public var exPAcommentsMax:String = "08/03/2012";


[Bindable] public var PAproviderCopy:ArrayCollection = new ArrayCollection(exerciseDataByMeasurePhysicianAssigned.toArray());
[Bindable] public var PERproviderCopy:ArrayCollection = new ArrayCollection(exerciseDataByMeasurePersonal.toArray());
[Bindable] public var arrExerciseForWidget:ArrayCollection = new ArrayCollection([
	{ exerciseType: "Most Recent PRT", lastDate: exerciseData.getItemAt(3).date, chartType: "normal", chartMin: 155, chartMax: 190, chart: exerciseData.getItemAt(3) },
	{ exerciseType: "Physician-assigned", lastDate: exerciseDataByMeasurePhysicianAssigned.getItemAt(0).chart[0].data[exerciseDataByMeasurePhysicianAssigned.getItemAt(0).chart[0].data.length - 1].date, chartType: "double", chartMin: 40, chartMax: 160, chart: PAproviderCopy },
	{ exerciseType: "Personal", lastDate: exerciseDataByMeasurePersonal.getItemAt(0).chart[0].data[exerciseDataByMeasurePersonal.getItemAt(0).chart[0].data.length - 1].date, chartType: "normal", chartMin: 40, chartMax: 85, chart: PERproviderCopy }	
]);
[Bindable] public var collapsedExercisesPixels:uint = 0;	//used for recalculating widget's height
//this function removes "Comments" and "Hiking" (untrackable exercise) for the WIDGET
public function filterProvidersForWidget():void {
	PAproviderCopy.source.splice(-1);
	PERproviderCopy.source.splice(-2);
}


[Bindable] public var exercisePAIndices:Array = new Array();
public function updateExercisePAIndices():void {
	var exercisePAIndicesTemp:Array = new Array();
	for(var i:uint = 0; i < exerciseDataByMeasurePhysicianAssigned.length; i++) {
		exercisePAIndicesTemp.push(exerciseDataByMeasurePhysicianAssigned.getItemAt(i).measure);
	}
	exercisePAIndices = exercisePAIndicesTemp;
}
