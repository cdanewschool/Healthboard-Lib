package controllers
{
	import controllers.BaseModuleController;
	
	import models.modules.VitalSignsModel;
	
	import mx.collections.ArrayCollection;
	
	public class VitalSignsController extends BaseModuleController
	{
		public function VitalSignsController()
		{
			super();
			
			model = new VitalSignsModel();
		}
		
		override public function init():void
		{
			var fullname:String = "Isaac Goodman";
			
			//	TODO: merge vitalSigns and vitalSigns by date into one array
			
			VitalSignsModel(model).vitalSigns = new ArrayCollection
				(
					[
						{ 
							vital: "Comments", chartType: "comments",
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'09/03/2011',comments:'I got closer to my target weight', vital:'comments'},
												{type:'provider',expectation:'expectation',author:'Dr. Andrew Berg',dateProvider:'10/03/2011',comments:'The patient has gotten closer to his target weight', vital:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'11/03/2011',comments:'I got closer to my target weight', vital:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'01/01/2012',comments:'I got closer to my target weight', vital:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'02/01/2012',comments:'I got closer to my target weight', vital:'comments'},
												{type:'provider',expectation:'expectation',author:fullname,dateProvider:'08/14/2012',comments:'Slight weight increase, please be aware.', vital:'comments'},
												{type:'patient',expectation:'expectation',author:fullname,datePatient:'09/08/2012',comments:'respiratory rate is normal, but I am not feeling so well.', vital:'comments'}
											]
										)
									} 
								]
							)
						},
						
						{ 
							vital: "Weight", chartType: "normal", chartMin: 160, chartMax: 210,
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{value:200, expectation:170, date:'09/03/2011', type:'patient', vital:'weight'},
												{value:195, expectation:170, date:'10/03/2011', type:'provider', vital:'weight'},
												{value:190, expectation:170, date:'11/03/2011', type:'patient', vital:'weight'},
												{value:180, expectation:170, date:'07/14/2012', type:'patient', vital:'weight'},
												{value:185, expectation:170, date:'08/14/2012', type:'provider', vital:'weight'},
												{value:175, expectation:170, date:'09/14/2012', type:'patient', vital:'weight'}
											]
										)
									} 
								]
							)
						},
						
						{ 
							vital: "Blood pressure", chartType: "double", chartMin: 60, chartMax: 160,
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
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
										)
									}
								]
							)
						},
						
						{ 
							vital: "Heart rate", chartType: "normal", chartMin: 55, chartMax: 110,
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{value:85, expectation:65, date:'09/03/2011', type:'patient', vital:'heartRate'},
												{value:80, expectation:65, date:'10/03/2011', type:'provider', vital:'heartRate'},
												{value:98, expectation:65, date:'11/03/2011', type:'patient', vital:'heartRate'},
												{value:76, expectation:65, date:'05/03/2012', type:'patient', vital:'heartRate'},
												{value:70, expectation:65, date:'06/03/2012', type:'patient', vital:'heartRate'},
												{value:66, expectation:65, date:'07/14/2012', type:'patient', vital:'heartRate'}
											]
										)
									} 
								]
							)
						},
						
						{ 
							vital: "Respiratory", chartType: "normal", chartMin: 8, chartMax: 38,
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{value:26, expectation:18, date:'09/03/2011', type:'patient', vital:'respiratory'},
												{value:24, expectation:18, date:'10/03/2011', type:'provider', vital:'respiratory'},
												{value:28, expectation:18, date:'11/03/2011', type:'patient', vital:'respiratory'},
												{value:22, expectation:18, date:'08/14/2012', type:'provider', vital:'respiratory'},
												{value:20, expectation:18, date:'09/08/2012', type:'patient', vital:'respiratory'},
												{value:20, expectation:18, date:'09/14/2012', type:'patient', vital:'respiratory'}
											]
										)
									} 
								]
							)
						},
						
						{ 
							vital: "Temperature", chartType: "normal", chartMin: 80, chartMax: 118,
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{value:98, expectation:98, date:'09/03/2011', type:'patient', vital:'temperature'},
												{value:107, expectation:98, date:'10/03/2011', type:'provider', vital:'temperature'},
												{value:98, expectation:98, date:'10/04/2011', type:'patient', vital:'temperature'},
												{value:98, expectation:98, date:'08/14/2012', type:'provider', vital:'temperature'},
												{value:103, expectation:98, date:'09/14/2012', type:'patient', vital:'temperature'}
											]
										)
									} 
								]
							)
						},
						
						{ 
							vital: "Height", chartType: "normal", chartMin: 61, chartMax: 81,
							chart: new ArrayCollection
							(
								[ 
									{ 
										data: new ArrayCollection
										(
											[
												{value:71, expectation:71, date:'09/03/2011', type:'patient', vital:'height'},
												{value:71, expectation:71, date:'09/14/2012', type:'patient', vital:'height'}
											]
										)
									} 
								]
							)
						}
						
					]
				);
			
			VitalSignsModel(model).vitalSignsByDate = new ArrayCollection
				(
					[
						{date:'09/03/2011', weightBMI: '200 / 27.8', bloodPressure: '145/92', heartRate: 85, respiratory: 26, temperature: 98, height: "5'11''", recordedBy: 'You', comments: new ArrayCollection( [{comment:'I got closer to my target weight', author: 'You', date:new Date()}]), abnormalWeight: true, abnormalPressure: true},
						{date:'10/03/2011', weightBMI: '195 / 27.1', bloodPressure: '139/85', heartRate: 80, respiratory: 24, temperature: 107, height: '', recordedBy: 'Dr. Andrew Berg', comments: new ArrayCollection( [{comment:'I got closer to my target weight', author: 'Dr. Andrew Berg', date:new Date()}]),  abnormalWeight: true, abnormalPressure: false},
						{date:'10/04/2011', weightBMI: '', bloodPressure: '', heartRate: '', respiratory: '', temperature: 98, height: ''},	
						{date:'11/03/2011', weightBMI: '190 / 26.4', bloodPressure: '130/82', heartRate: 98, respiratory: 28, temperature: '', height: '', recordedBy: 'You', comments: new ArrayCollection( [{comment:'The patient has gotten closer to his target weight', author: 'You', date:new Date()}]) },
						{date:'01/01/2012', weightBMI: '', bloodPressure: '', heartRate: '', respiratory: '', temperature: '', height: '', comments: new ArrayCollection( [{comment:'I got closer to my target weight', author: 'You', date:new Date()}])},
						{date:'02/01/2012', weightBMI: '', bloodPressure: '', heartRate: '', respiratory: '', temperature: '', height: '', comments: new ArrayCollection( [{comment:'I got closer to my target weight', author: 'You', date:new Date()}])},
						{date:'05/03/2012', weightBMI: '', bloodPressure: '128/80', heartRate: 76, respiratory: '', temperature: '', height: ''},
						{date:'06/03/2012', weightBMI: '', bloodPressure: '126/80', heartRate: 70, respiratory: '', temperature: '', height: ''},
						{date:'07/14/2012', weightBMI: '180 / 25.1', bloodPressure: '130/82', heartRate: 66, respiratory: '', temperature: '', height: ''},
						{date:'08/14/2012', weightBMI: '185 / 25.7', bloodPressure: '124/76', heartRate: '', respiratory: '22', temperature: 98, height: '', recordedBy: 'Dr. Andrew Berg', comments: new ArrayCollection( [{comment:'Slight weight increase, please be aware.', author: 'Dr. Andrew Berg', date:new Date()}])},
						{date:'09/08/2012', weightBMI: '', bloodPressure: '', heartRate: '', respiratory: '20', temperature: '', height: '', recordedBy: 'You', comments: new ArrayCollection( [{comment:'respiratory rate is normal, but I am not feeling so well.', author: 'You', date:new Date()}])},
						{date:'09/14/2012', weightBMI: '175 / 24.4', bloodPressure: '120/78', heartRate: '', respiratory: '20', temperature: 103, height: "5'11''", abnormalWeight: true, abnormalPressure: false, recordedBy: 'You'}
					]
				);
			
			var vitalSignsForWidgetSource:Array = VitalSignsModel(model).vitalSigns.source.slice();
			vitalSignsForWidgetSource.pop();		//remove height		//vitalSignsForWidgetSource.splice(-2);
			vitalSignsForWidgetSource.shift();		//remove comments
			
			VitalSignsModel(model).vitalSignsForWidget = new ArrayCollection( vitalSignsForWidgetSource );
		}
		
		public function updateVitalIndices():void 
		{
			var model:VitalSignsModel = model as VitalSignsModel;
			
			var vitalIndicesTemp:Array = new Array();
			
			for(var i:uint = 0; i < model.vitalSigns.length; i++) 
			{
				vitalIndicesTemp.push( model.vitalSigns.getItemAt(i).vital );
			}
			
			model.vitalIndices = vitalIndicesTemp;
		}
	}
}