package models.modules
{
	import models.modules.ModuleModel;
	
	import mx.collections.ArrayCollection;
	
	[Bindable] 
	public class VitalSignsModel extends ModuleModel
	{
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
		
		public var vitalIndices:Array = new Array();
		
		public function VitalSignsModel()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			var fullname:String = AppProperties.getInstance().controller.model.fullname;
			
			vitalSigns = new ArrayCollection
				(
					[
						{ 
							vital: "Weight", chartType: "normal", chartMin: 160, chartMax: 210,
							chart:
							[ 
								{ 
									data:
									[
										{value:200, expectation:170, date:'09/03/2011', type:'patient', vital:'weight'},
										{value:195, expectation:170, date:'10/03/2011', type:'provider', vital:'weight'},
										{value:190, expectation:170, date:'11/03/2011', type:'patient', vital:'weight'},
										{value:180, expectation:170, date:'07/14/2012', type:'patient', vital:'weight'},
										{value:185, expectation:170, date:'08/14/2012', type:'provider', vital:'weight'},
										{value:175, expectation:170, date:'09/14/2012', type:'patient', vital:'weight'}
									]
								} 
							]
						},
						
						{ 
							vital: "Blood pressure", chartType: "double", chartMin: 60, chartMax: 160,
							chart:
							[ 
								{ 
									data:
									[
										{value:145, expectation:120, value2:92, expectation2:80, date:'09/03/2011', type:'patient', vital:'bloodPressure'},
										{value:139, expectation:120, value2:85, expectation2:80, date:'10/03/2011', type:'provider', vital:'bloodPressure'},
										{value:130, expectation:120, value2:82, expectation2:80, date:'11/03/2011', type:'patient', vital:'bloodPressure'},
										{value:128, expectation:120, value2:80, expectation2:80, date:'05/03/2012', type:'patient', vital:'bloodPressure'},
										{value:126, expectation:120, value2:80, expectation2:80, date:'06/03/2012', type:'patient', vital:'bloodPressure'},
										{value:130, expectation:120, value2:82, expectation2:80, date:'07/14/2012', type:'patient', vital:'bloodPressure'},
										{value:124, expectation:120, value2:76, expectation2:80, date:'08/14/2012', type:'provider', vital:'bloodPressure'},
										{value:120, expectation:120, value2:78, expectation2:80, date:'09/14/2012', type:'patient', vital:'bloodPressure'}
									]
								}
							]
						},
						
						{ 
							vital: "Heart rate", chartType: "normal", chartMin: 55, chartMax: 110,
							chart:
							[ 
								{ 
									data:
									[
										{value:85, expectation:65, date:'09/03/2011', type:'patient', vital:'heartRate'},
										{value:80, expectation:65, date:'10/03/2011', type:'provider', vital:'heartRate'},
										{value:98, expectation:65, date:'11/03/2011', type:'patient', vital:'heartRate'},
										{value:76, expectation:65, date:'05/03/2012', type:'patient', vital:'heartRate'},
										{value:70, expectation:65, date:'06/03/2012', type:'patient', vital:'heartRate'},
										{value:66, expectation:65, date:'07/14/2012', type:'patient', vital:'heartRate'}
									]
								} 
							]
						},
						
						{ 
							vital: "Respiratory", chartType: "normal", chartMin: 8, chartMax: 38,
							chart:
							[ 
								{ 
									data:
									[
										{value:26, expectation:18, date:'09/03/2011', type:'patient', vital:'respiratory'},
										{value:24, expectation:18, date:'10/03/2011', type:'provider', vital:'respiratory'},
										{value:28, expectation:18, date:'11/03/2011', type:'patient', vital:'respiratory'},
										{value:22, expectation:18, date:'08/14/2012', type:'provider', vital:'respiratory'},
										{value:20, expectation:18, date:'09/08/2012', type:'patient', vital:'respiratory'},
										{value:20, expectation:18, date:'09/14/2012', type:'patient', vital:'respiratory'}
									]
								} 
							]
						},
						
						{ 
							vital: "Temperature", chartType: "normal", chartMin: 80, chartMax: 118,
							chart:
							[ 
								{ 
									data:
									[
										{value:98, expectation:98, date:'09/03/2011', type:'patient', vital:'temperature'},
										{value:107, expectation:98, date:'10/03/2011', type:'provider', vital:'temperature'},
										{value:98, expectation:98, date:'10/04/2011', type:'patient', vital:'temperature'},
										{value:98, expectation:98, date:'08/14/2012', type:'provider', vital:'temperature'},
										{value:103, expectation:98, date:'09/14/2012', type:'patient', vital:'temperature'}
									]
								} 
							]
						},
						
						{ 
							vital: "Height", chartType: "normal", chartMin: 61, chartMax: 81,
							chart:
							[ 
								{ 
									data:
									[
										{value:71, expectation:71, date:'09/03/2011', type:'patient', vital:'height'},
										{value:71, expectation:71, date:'09/14/2012', type:'patient', vital:'height'}]
								} 
							]
						},
						
						{ 
							vital: "Comments", chartType: "comments",
							chart:
							[ 
								{ 
									data:
									[
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'09/03/2011',comments:'I got closer to my target weight', vital:'comments'},
										{type:'provider',expectation:'expectation',author:'Dr. Andrew Berg',dateProvider:'10/03/2011',comments:'The patient has gotten closer to his target weight', vital:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'11/03/2011',comments:'I got closer to my target weight', vital:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'01/01/2012',comments:'I got closer to my target weight', vital:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'02/01/2012',comments:'I got closer to my target weight', vital:'comments'},
										{type:'provider',expectation:'expectation',author:fullname,dateProvider:'08/14/2012',comments:'Slight weight increase, please be aware.', vital:'comments'},
										{type:'patient',expectation:'expectation',author:fullname,datePatient:'09/08/2012',comments:'Respiratory rate is normal, but I am not feeling so well.', vital:'comments'}
									]
								} 
							]
						}	
					]
				);
			
			vitalSignsByDate = new ArrayCollection
				(
					[
						{Date:'09/03/2011', WeightBMI: '200 / 27.8', BloodPressure: '145/92', HeartRate: 85, Respiratory: 26, Temperature: 98, Height: "5'11''", Comments: 'I got closer to my target weight', RecordedBy: 'You', abnormalWeight: true, abnormalPressure: true},
						{Date:'10/03/2011', WeightBMI: '195 / 27.1', BloodPressure: '139/85', HeartRate: 80, Respiratory: 24, Temperature: 107, Height: '', Comments: 'I got closer to my target weight', RecordedBy: 'Dr. Andrew Berg', abnormalWeight: true, abnormalPressure: false},
						{Date:'10/04/2011', WeightBMI: '', BloodPressure: '', HeartRate: '', Respiratory: '', Temperature: 98, Height: '', Comments: '', RecordedBy: 'You'},	
						{Date:'11/03/2011', WeightBMI: '190 / 26.4', BloodPressure: '130/82', HeartRate: 98, Respiratory: 28, Temperature: '', Height: '', Comments: 'The patient has gotten closer to his target weight', RecordedBy: 'You'},
						{Date:'01/01/2012', WeightBMI: '', BloodPressure: '', HeartRate: '', Respiratory: '', Temperature: '', Height: '', Comments: 'I got closer to my target weight', RecordedBy: 'You'},
						{Date:'02/01/2012', WeightBMI: '', BloodPressure: '', HeartRate: '', Respiratory: '', Temperature: '', Height: '', Comments: 'I got closer to my target weight', RecordedBy: 'You'},
						{Date:'05/03/2012', WeightBMI: '', BloodPressure: '128/80', HeartRate: 76, Respiratory: '', Temperature: '', Height: '', Comments: '', RecordedBy: 'You'},
						{Date:'06/03/2012', WeightBMI: '', BloodPressure: '126/80', HeartRate: 70, Respiratory: '', Temperature: '', Height: '', Comments: '', RecordedBy: 'You'},
						{Date:'07/14/2012', WeightBMI: '180 / 25.1', BloodPressure: '130/82', HeartRate: 66, Respiratory: '', Temperature: '', Height: '', Comments: '', RecordedBy: 'You'},
						{Date:'08/14/2012', WeightBMI: '185 / 25.7', BloodPressure: '124/76', HeartRate: '', Respiratory: '22', Temperature: 98, Height: '', Comments: 'Slight weight increase, please be aware.', RecordedBy: 'Dr. Andrew Berg'},
						{Date:'09/08/2012', WeightBMI: '', BloodPressure: '', HeartRate: '', Respiratory: '20', Temperature: '', Height: '', Comments: 'Respiratory rate is normal, but I am not feeling so well.', RecordedBy: 'You'},
						{Date:'09/14/2012', WeightBMI: '175 / 24.4', BloodPressure: '120/78', HeartRate: '', Respiratory: '20', Temperature: 103, Height: "5'11''", Comments: '', RecordedBy: 'You', abnormalWeight: true, abnormalPressure: false}
					]
				);
			
			vitalSignsForWidget = new ArrayCollection( vitalSigns.toArray() );	
		}
	}
}