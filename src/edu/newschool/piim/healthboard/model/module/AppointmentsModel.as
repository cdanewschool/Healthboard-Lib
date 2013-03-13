package edu.newschool.piim.healthboard.model.module
{
	import edu.newschool.piim.healthboard.enum.AppointmentStatus;
	import edu.newschool.piim.healthboard.enum.DateRanges;
	import edu.newschool.piim.healthboard.model.module.ModuleModel;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.http.mxml.HTTPService;
	
	[Bindable] 
	public class AppointmentsModel extends ModuleModel
	{
		public static const ID:String = "appointments";
		
		public static const STATUSES:ArrayCollection = new ArrayCollection( [ AppointmentStatus.ALL, AppointmentStatus.SCHEDULED, AppointmentStatus.COMPLETED ] );
		
		[Embed("/images/blueArrowLeft.png")] 	public var blueArrowLeft:Class;
		[Embed("/images/blueArrowRight.png")] public var blueArrowRight:Class;
		[Embed("/images/grayArrowLeft.png")] 	public var grayArrowLeft:Class;
		[Embed("/images/grayArrowRight.png")] public var grayArrowRight:Class;
		
		public var appointments:ArrayCollection;
		public var appointmentCategories:ArrayCollection;
		
		public var currentAppointmentIndex:uint;
		
		public var currentDate:Date = new Date();
		
		public var dateRange:String = DateRanges.YEAR;
		public var status:String = AppointmentStatus.ALL;
		
		public var isRecommending:Boolean;
		
		public var appointmentTypesDataService:HTTPService;
		public var slotsDataService:HTTPService;

		public var nextSteps:ArrayCollection = new ArrayCollection();
		public var nextStepsActive:ArrayCollection = new ArrayCollection();
		
		public var pendingDescription:String;
		
		public function AppointmentsModel()
		{
			super();
			
			appointmentTypesDataService = new HTTPService();
			slotsDataService = new HTTPService();
		}
	}
}