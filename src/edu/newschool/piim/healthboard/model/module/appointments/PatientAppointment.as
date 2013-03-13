package edu.newschool.piim.healthboard.model.module.appointments
{
	import edu.newschool.piim.healthboard.enum.AppointmentStatus;
	import edu.newschool.piim.healthboard.enum.AppointmentType;
	import edu.newschool.piim.healthboard.model.NextStep;
	import edu.newschool.piim.healthboard.model.ProviderModel;
	import edu.newschool.piim.healthboard.model.UserModel;
	import edu.newschool.piim.healthboard.model.module.medicalrecords.MedicalRecord;
	import edu.newschool.piim.healthboard.util.DateUtil;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class PatientAppointment extends TimeSlot
	{
		public var classification:String;
		public var medicalRecords:ArrayCollection;
		public var nextSteps:ArrayCollection;
		public var patient:UserModel;
		public var provider:*;
		public var status:String;
		
		public var type:String = AppointmentType.MEDICAL;
		
		public function PatientAppointment()
		{
			_scheduled = true;
		}
		
		public function get date():Date{ return from; }
		
		override public function set from(value:Date):void
		{
			super.from = value;
			
			if( from )
			{
				status = from.time < new Date().time ? AppointmentStatus.COMPLETED : AppointmentStatus.SCHEDULED;
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
			
			if( data.hasOwnProperty('from') ) val.from = new Date( Date.parse( DateUtil.modernizeDate( data.from ) ) );
			if( data.hasOwnProperty('to') ) 
			{
				val.to = new Date( Date.parse( DateUtil.modernizeDate( data.to ) ) );
			}
			else if( val.from )
			{
				var to:Date = new Date();
				to.time = val.from.time + (1000 * 60 * 30);
				val.to = to;
			}
			
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
					nextStep.dateAssigned = val.from;
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
					medicalRecord.date = val.from;
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