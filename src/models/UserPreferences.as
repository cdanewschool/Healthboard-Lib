package models
{
	import enum.ColorSchemeType;
	import enum.ControlAlign;
	import enum.DateFormatType;
	import enum.SummaryType;
	import enum.TimeFormatType;
	import enum.UnitType;
	import enum.ViewModeType;
	
	import flash.utils.describeType;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class UserPreferences
	{
		//	general
		public var colorScheme:String = ColorSchemeType.BLACK;
		public var dateFormat:String = DateFormatType.FORMAT_1;
		public var fontSize:int = 0;
		public var language:String = "en_US";
		public var timeFormat:String = TimeFormatType.FORMAT_1;
		public var timeZone:String = "EST";
		public var unit:String = UnitType.AMERICAN;
		public var viewMode:String = ViewModeType.BUTTON;
		
		//	notifications
		public var summariesActivated:Boolean = false;
		public var summariesType:String = SummaryType.EMAIL;
		public var summariesFrequencyPerUnit:int = 1;
		public var summariesFrequencyUnit:String = "day";
		//	notifications -> alerts (health focus)
		public var alertsShowPinnedItems:Boolean = true;
		//	notifications -> appointments
		public var appointmentsRequirePassword:Boolean = false;
		public var appointmentsAllowConfirmationBySpecifiedUsers:Boolean = false;
		public var appointmentsShowRequests:Boolean = true;
		public var appointmentsShowClassReservations:Boolean = false;
		public var appointmentsShowCancellations:Boolean = false;
		public var appointmentsShowTeamAvailability:Boolean = true;
		//	notifications -> chat
		public var chatRequirePassword:Boolean = false;
		public var chatShowUpcomingActivity:Boolean = false;
		public var chatShowNewAppointments:Boolean = false;
		//	decision support
		public var decisonSupportRequirePassword:Boolean = false;
		//	notifications -> exercise
		public var exerciseRequirePassword:Boolean = false;
		public var exerciseShowPRTPatients:Boolean = true;
		public var exerciseShowGoalActivity:Boolean = false;
		public var exerciseShowExerciseActivity:Boolean = false;
		public var exerciseShowSelfReportedResults:Boolean = false;
		//	notifications -> immunizations
		public var immunizationRequirePassword:Boolean = false;
		public var immunizationsShowOverdueVaccinations:Boolean = true;
		//	notifications -> medical records
		public var medicalRecordRequirePassword:Boolean = false;
		public var medicalRecordsShowCompletedNextSteps:Boolean = true;
		public var mecicalRecordsShowOtherNextSteps:Boolean = false;
		//	notifications -> medications
		public var medicationsRequirePassword:Boolean = false;
		public var medicationsShowRenewalRequests:Boolean = true;
		public var medicationsShowInteractionWarnings:Boolean = true;
		public var medicationsShowPatientsWhoHaventTakenMedication:Boolean = true;
		public var medicationsShowPatientsWhoHaventTakenMedicationFrequency:String = "day";
		public var medicationsShowPatientsWhoHaventTakenMedicationFrequencyPerUnit:int = 1;
		public var medicationsShowPatientAddedMedications:Boolean = false;
		public var medicationsShowNewPrescriptionsBoolean = false;
		//	notifications -> messages
		public var messagesRequirePassword:Boolean = false;
		public var messagesShowInboxActivity:Boolean = true;
		public var messagesRestrictToUrgent:Boolean = true;
		//	nutrition
		public var nutritionRequirePassword:Boolean = false;
		//	notifications -> patient search
		public var patientSearchRequirePassword:Boolean = false;
		public var patientSearchShowSearchActvity:Boolean = true;
		public var patientSearchRestrictToUrgent:Boolean = true;
		//	notifications -> public health advisory
		public var publicHealthAdvisoryRequirePassword:Boolean = false;
		public var publicHealthAdvisoryShowNew:Boolean = true;
		public var publicHealthAdvisoryShowActive:Boolean = false;
		//	team profile
		public var teamProfileRequirePassword:Boolean = false;
		//	notifications -> vital signs
		public var vitalSignsRequirePassword:Boolean = false;
		public var vitalSignsShowRecentlyRecordedVitals:Boolean = true;
		public var vitalSignsShowPatientEnteredGoals:Boolean = false;
		public var vitalSignsShowRecentlyActivatedTrackers:Boolean = false;
		
		//	security
		public var autoLockIntervalMinutes:Number = 5;	//	minutes
		
		public var appointmentConfirmees:ArrayCollection = new ArrayCollection();
		
		public var chatPopupDefaultPosition:String = ControlAlign.BOTTOM_RIGHT;
		public var chatShowAsAvaiableOnLogin:Boolean = true;
		public var chatEnableVoiceChat:Boolean = true;
		public var chatEnableVideoChat:Boolean = true;
		public var chatEnableTimeStamp:Boolean = false;
		
		public var autoResponderActive:Boolean = false;
		public var autoResponderDateFrom:Date;
		public var autoResponderDateTo:Date;
		public var autoResponse:String;
		
		public var signatureActive:Boolean = false;
		public var signature:String;
		
		public function UserPreferences()
		{
		}
		
		public function clone():UserPreferences
		{
			var val:UserPreferences = new UserPreferences();
			
			var definition:XML = describeType(this);
			
			for each(var prop:XML in definition..accessor)
			{
				if( prop.@access == "readonly" ) continue;
				
				val[prop.@name] = this[prop.@name];
			}
			
			return val;
		}
		
		public function copy( from:UserPreferences ):void
		{
			var definition:XML = describeType(this);
			
			for each(var prop:XML in definition..accessor)
			{
				if( prop.@access == "readonly" ) continue;
				
				this[prop.@name] = from[prop.@name];
			}
		}
	}
}