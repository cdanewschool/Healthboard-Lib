package models.modules.appointments
{
	import enum.AppointmentStatus;
	import enum.AppointmentType;
	
	import models.NextStep;
	import models.ProviderModel;
	import models.UserModel;
	import models.modules.medicalrecords.MedicalRecord;
	
	import mx.collections.ArrayCollection;
	
	import util.DateUtil;

	[Bindable]
	public class PatientAppointment
	{
		public var classification:String;
		public var description:String;
		public var medicalRecords:ArrayCollection;
		public var nextSteps:ArrayCollection;
		public var patient:UserModel;
		public var provider:*;
		public var selected:Boolean;
		public var status:String;
		
		public var type:String = AppointmentType.MEDICAL;
		
		private var _date:Date;
		public var endDate:Date;
		
		public function PatientAppointment()
		{
		}
		
		public function get meridiem():String
		{
			return date.hours < 12?"am":"pm";
		}
		
		public function get hour():String
		{
			return (date.hours % 12 ).toString();
		}

		public function get mins():int
		{
			return date.minutes;
		}
		
		public function get date():Date
		{
			return _date;
		}

		public function set date(value:Date):void
		{
			_date = value;
			
			if( date )
			{
				status = date.time < new Date().time ? AppointmentStatus.COMPLETED : AppointmentStatus.SCHEDULED;
			}
		}
		
		public static function fromObj( data:Object ):PatientAppointment
		{
			var val:PatientAppointment = new PatientAppointment();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try{ val[prop] = data[prop]; }
					catch(e:Error){}
				}
			}
			
			val.date = new Date( Date.parse( DateUtil.modernizeDate( data.date ) ) );
			val.patient =  AppProperties.getInstance().controller.getUserById( data.patient_id, UserModel.TYPE_PATIENT );
			val.provider = AppProperties.getInstance().controller.getUserById( data.provider_id, UserModel.TYPE_PROVIDER ) as ProviderModel;
			
			var results:ArrayCollection;
			var result:Object;
			
			if( data.hasOwnProperty('nextStep') )
			{
				results = data.nextStep is ArrayCollection ? data.nextStep : new ArrayCollection( [ data.nextStep ] );
				var nextSteps:ArrayCollection = new ArrayCollection();
				
				for each(result in results) 
				{
					var nextStep:NextStep = NextStep.fromObj(result)
					nextStep.dateAssigned = val.date;
					nextStep.assignee = val.provider.fullName;
					
					nextSteps.addItem( nextStep );
				}
				
				val.nextSteps = nextSteps;
			}
			
			if( data.hasOwnProperty('medicalRecord') )
			{
				results = data.medicalRecord is ArrayCollection ? data.medicalRecord : new ArrayCollection( [ data.medicalRecord ] );
				var medicalRecords:ArrayCollection = new ArrayCollection();
				
				for each(result in results) 
				{
					var medicalRecord:MedicalRecord = MedicalRecord.fromObj(result);
					medicalRecord.classification = val.classification;
					medicalRecord.category = AppProperties.getInstance().controller.appointmentsController.getCategoryById( medicalRecord.category_id );
					medicalRecord.date = val.date;
					medicalRecord.patient = val.patient;
					medicalRecord.provider = val.provider;
					medicalRecord.nextSteps = val.nextSteps;
					medicalRecords.addItem( medicalRecord );
					
					if( medicalRecord.description == null ) medicalRecord.description = val.description;
				}
				
				val.medicalRecords = medicalRecords;
			}
			
			return val;
		}
	}
}