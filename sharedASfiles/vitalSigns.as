[Bindable] public var arrVitalSigns:ArrayCollection = new ArrayCollection([
	{ vital: "Weight", chartType: "normal", chartMin: 155, chartMax: 190,
		chart:[ { data:[{value:180, expectation:170, date:'02/03/2011', type:'patient', vital:'weight'},{value:185, expectation:170, date:'03/03/2011', type:'provider', vital:'weight'},{value:175, expectation:170, date:'04/03/2011', type:'patient', vital:'weight'},{value:170, expectation:170, date:'12/14/2011', type:'patient', vital:'weight'},{value:165, expectation:170, date:'01/14/2012', type:'patient', vital:'weight'},{value:180, expectation:170, date:'02/14/2012', type:'provider', vital:'weight'}]} ] },
	
	{ vital: "Blood pressure", chartType: "double", chartMin: 40, chartMax: 160,
		chart:[ { data:[{value:140, expectation:120, value2:90, expectation2:80, date:'02/03/2011', type:'patient', vital:'bloodPressure'},{value:135, expectation:120, value2:85, expectation2:80, date:'03/03/2011', type:'provider', vital:'bloodPressure'},{value:115, expectation:120, value2:75, expectation2:80, date:'04/03/2011', type:'patient', vital:'bloodPressure'},{value:100, expectation:120, value2:60, expectation2:80, date:'10/03/2011', type:'patient', vital:'bloodPressure'},{value:100, expectation:120, value2:60, expectation2:80, date:'11/03/2011', type:'patient', vital:'bloodPressure'},{value:120, expectation:120, value2:80, expectation2:80, date:'12/14/2011', type:'patient', vital:'bloodPressure'},{value:120, expectation:120, value2:80, expectation2:80, date:'01/14/2012', type:'patient', vital:'bloodPressure'},{value:138, expectation:120, value2:90, expectation2:80, date:'02/14/2012', type:'provider', vital:'bloodPressure'}]} ] },
	
	{ vital: "Heart rate", chartType: "normal", chartMin: 40, chartMax: 85,
		chart:[ { data:[{value:50, expectation:65, date:'02/03/2011', type:'patient', vital:'heartRate'},{value:70, expectation:65, date:'03/03/2011', type:'provider', vital:'heartRate'},{value:75, expectation:65, date:'04/03/2011', type:'patient', vital:'heartRate'},{value:60, expectation:65, date:'10/03/2011', type:'patient', vital:'heartRate'},{value:55, expectation:65, date:'11/03/2011', type:'patient', vital:'heartRate'},{value:70, expectation:65, date:'12/14/2011', type:'patient', vital:'heartRate'}]} ] },
	
	{ vital: "Respiratory", chartType: "normal", chartMin: 0, chartMax: 38,
		chart:[ { data:[{value:26, expectation:18, date:'02/03/2011', type:'patient', vital:'respiratory'},{value:10, expectation:18, date:'03/03/2011', type:'provider', vital:'respiratory'},{value:10, expectation:18, date:'04/03/2011', type:'patient', vital:'respiratory'},{value:28, expectation:18, date:'01/14/2012', type:'patient', vital:'respiratory'},{value:26, expectation:18, date:'02/14/2012', type:'provider', vital:'respiratory'}]} ] },
	
	{ vital: "Temperature", chartType: "normal", chartMin: 76, chartMax: 118,
		chart:[ { data:[{value:98, expectation:98, date:'02/03/2011', type:'patient', vital:'temperature'},{value:110, expectation:98, date:'03/03/2011', type:'provider', vital:'temperature'},{value:98, expectation:98, date:'03/04/2011', type:'patient', vital:'temperature'},{value:98, expectation:98, date:'02/14/2012', type:'provider', vital:'temperature'}]} ] },
	
	{ vital: "Height", chartType: "normal", chartMin: 61, chartMax: 81,
		chart:[ { data:[{value:71, expectation:71, date:'02/03/2011', type:'patient', vital:'height'},{value:71, expectation:71, date:'02/14/2012', type:'provider', vital:'height'}] } ] },
	
	{ vital: "Comments", chartType: "comments",
		chart:[ { data:[{type:'provider',expectation:'expectation',author:'Dr. Andrew Berg',dateProvider:'04/03/2011',comments:'The patient has gotten closer to his target weight', vital:'comments'},{type:'provider',expectation:'expectation',author:'Dr. Andrew Berg',dateProvider:'02/14/2012',comments:'The patient has gotten closer to his target weight', vital:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'03/03/2011',comments:'I got closer to my target weight', vital:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'06/01/2011',comments:'I got closer to my target weight', vital:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'07/01/2011',comments:'I got closer to my target weight', vital:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'01/14/2012',comments:'I got closer to my target weight', vital:'comments'},{type:'patient',expectation:'expectation',author:fullname,datePatient:'02/13/2012',comments:'I got closer to my target weight', vital:'comments'}] } ] },
	
]);

[Bindable] public var arrVitalSignsForWidget:ArrayCollection = new ArrayCollection(arrVitalSigns.toArray());		//identical to arrVitalSigns, but we will remove "Height" and "Comments" when first loading the widget.
[Bindable] public var collapsedVitals:uint = 0;	//used for recalculating widget's height

[Bindable] public var arrVitalSignsByDate:ArrayCollection = new ArrayCollection([
	{Date:'02/03/2011', WeightBMI: '180 / 25.1', BloodPressure: '140/90', HeartRate: 50, Respiratory: 26, Temperature: 98, Height: "5'11''", Comments: '', RecordedBy: 'You', abnormalWeight: true, abnormalPressure: true},
	{Date:'03/03/2011', WeightBMI: '185 / 25.7', BloodPressure: '135/85', HeartRate: 70, Respiratory: 10, Temperature: 104, Height: '', Comments: 'I got closer to my target weight', RecordedBy: 'Dr. Andrew Berg', abnormalWeight: true, abnormalPressure: false},
	{Date:'03/04/2011', WeightBMI: '', BloodPressure: '', HeartRate: '', Respiratory: '', Temperature: 98, Height: '', Comments: '', RecordedBy: 'You'},	
	{Date:'04/03/2011', WeightBMI: '175 / 24.4', BloodPressure: '115/75', HeartRate: 75, Respiratory: 10, Temperature: '', Height: '', Comments: 'The patient has gotten closer to his target weight', RecordedBy: 'You'},
	{Date:'06/01/2011', WeightBMI: '', BloodPressure: '', HeartRate: '', Respiratory: '', Temperature: '', Height: '', Comments: 'I got closer to my target weight', RecordedBy: 'You'},
	{Date:'07/01/2011', WeightBMI: '', BloodPressure: '', HeartRate: '', Respiratory: '', Temperature: '', Height: '', Comments: 'I got closer to my target weight', RecordedBy: 'You'},
	{Date:'10/03/2011', WeightBMI: '', BloodPressure: '100/60', HeartRate: 60, Respiratory: '', Temperature: '', Height: '', Comments: '', RecordedBy: 'You'},
	{Date:'11/03/2011', WeightBMI: '', BloodPressure: '100/60', HeartRate: 55, Respiratory: '', Temperature: '', Height: '', Comments: '', RecordedBy: 'You'},
	{Date:'12/14/2011', WeightBMI: '170 / 23.7', BloodPressure: '120/80', HeartRate: 70, Respiratory: '', Temperature: '', Height: '', Comments: '', RecordedBy: 'You'},
	{Date:'01/14/2012', WeightBMI: '165 / 23', BloodPressure: '120/80', HeartRate: '', Respiratory: '28', Temperature: '', Height: '', Comments: 'I got closer to my target weight', RecordedBy: 'You'},
	{Date:'02/14/2012', WeightBMI: '180 / 25.1', BloodPressure: '138/90', HeartRate: '', Respiratory: '26', Temperature: '98', Height: "5'11''", Comments: 'The patient has gotten closer to his target weight', RecordedBy: 'Dr. Andrew Berg', abnormalWeight: true, abnormalPressure: false}
]);

[Bindable] public var chartMin:Date = new Date(2011,0,26);
[Bindable] public var chartMax:Date = new Date(2012,1,22);
[Bindable] public var weightChartMin:Date = new Date(2010,11,7);
[Bindable] public var weightChartMax:Date = new Date(2012,3,22);
[Bindable] public var bloodPressureChartMin:Date = new Date(2010,11,7);
[Bindable] public var bloodPressureChartMax:Date = new Date(2012,3,22);
[Bindable] public var weightMax:String = "02/14/2012";
[Bindable] public var bloodPressureMax:String = "02/14/2012";
[Bindable] public var heartRateMax:String = "12/14/2011";
[Bindable] public var respiratoryMax:String = "02/14/2012";
[Bindable] public var temperatureMax:String = "02/14/2012";
[Bindable] public var heightMax:String = "02/14/2012";
[Bindable] public var commentsMax:String = "02/14/2012";

[Bindable] public var vitalIndices:Array = new Array();
public function updateVitalIndices():void {
	var vitalIndicesTemp:Array = new Array();
	for(var i:uint = 0; i < arrVitalSigns.length; i++) {
		vitalIndicesTemp.push(arrVitalSigns.getItemAt(i).vital);
	}
	vitalIndices = vitalIndicesTemp;
}