package models
{
	import enum.ColorScheme;
	import enum.DateFormat;
	import enum.SummaryType;
	import enum.Unit;
	import enum.ViewMode;

	public class UserPreferences
	{
		//	general
		public var colorScheme:String = ColorScheme.BLACK;
		public var dateFormat:String = DateFormat.FORMAT_1;
		public var fontZoom:int = 0;
		public var language:String = "english";
		public var timeZone:String = "EST";
		public var unit:String = Unit.AMERICAN;
		public var viewMode:String = ViewMode.BUTTON;
		
		//	notifications
		public var summariesActivated:Boolean = true;
		public var summariesType:String = SummaryType.EMAIL;
		public var summariesFrequencyPerUnit:int = 1;
		public var summariesFrequencyUnit:String = "day";
		//	notifications -> alerts (health focus)
		public var alertsShowPinnedItems:Boolean = true;
		//	notifications -> appointments
		public var appointmentsShowRequests:Boolean = true;
		public var appointmentsShowClassReservations:Boolean = false;
		public var appointmentsShowCancellations:Boolean = false;
		public var appointmentsShowTeamAvailability:Boolean = true;
		//	notifications -> chat
		public var chatShowUpcomingActivity:Boolean = false;
		public var chatShowNewAppointments:Boolean = false;
		//	notifications -> exercise
		public var exerciseShowPRTPatients:Boolean = true;
		public var exerciseShowGoalActivity:Boolean = false;
		public var exerciseShowExerciseActivity:Boolean = false;
		public var exerciseShowSelfReportedResults:Boolean = false;
		//	notifications -> immunizations
		public var immunizationsShowOverdueVaccinations:Boolean = true;
		//	notifications -> medical records
		public var medicalRecordsShowCompletedNextSteps:Boolean = true;
		public var mecicalRecordsShowOtherNextSteps:Boolean = false;
		//	notifications -> medications
		public var medicationsShowRenewalRequests:Boolean = true;
		public var medicationsShowInteractionWarnings:Boolean = true;
		public var medicationsShowPatientsWhoHaventTakenMedication:Boolean = true;
		public var medicationsShowPatientsWhoHaventTakenMedicationFrequency:String = "day";
		public var medicationsShowPatientsWhoHaventTakenMedicationFrequencyPerUnit:int = 1;
		public var medicationsShowPatientAddedMedications:Boolean = false;
		public var medicationsShowNewPrescriptionsBoolean = false;
		//	notifications -> messages
		public var messagesDisplayInboxActivityBoolean = true;
		//	notifications -> patient search
		public var patientSearchShowSearchActvity:Boolean = true;
		public var patientSearchSearchActivityFilterByUrgent:Boolean = true;
		//	notifications -> public health advisory
		public var healthAdvisoryShowNew:Boolean = true;
		public var healthAdvisoryShowActive:Boolean = false;
		//	notifications -> vital signs
		public var vitalSignsShowRecentlyRecordedVitals:Boolean = true;
		public var vitalSignsShowPatientEnteredGoals:Boolean = false;
		public var vitalSignsShowRecentlyActivatedTrackers:Boolean = false;
		
		//	security
		public var autoLockInterval:int = 5;	//	minutes
		
		
		public function UserPreferences()
		{
		}
	}
}