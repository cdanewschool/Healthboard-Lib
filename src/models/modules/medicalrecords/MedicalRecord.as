package models.modules.medicalrecords
{
	import models.AppointmentCategory;
	import models.ImageReference;
	import models.ProviderModel;
	import models.UserModel;
	
	import mx.collections.ArrayCollection;
	
	import util.DateUtil;

	[Bindable]
	public class MedicalRecord
	{
		public var category_id:String;
		public var category:AppointmentCategory;
		public var classification:String;
		public var date:Date;
		public var endDate:Date;
		public var description:String;
		public var interpreter:String;
		public var nextSteps:ArrayCollection;
		public var patient:UserModel;
		public var provider:ProviderModel;
		
		public var images:ArrayCollection;
		public var report:Report;
		public var summary:ArrayCollection;
		public var tests:ArrayCollection;
		
		public function MedicalRecord()
		{
		}
		
		public static function fromObj( data:Object ):MedicalRecord
		{
			var val:MedicalRecord = new MedicalRecord();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try{ val[prop] = data[prop]; }
					catch(e:Error){}
				}
			}

			if( data.hasOwnProperty('end_date') ) val.endDate = new Date( Date.parse( DateUtil.modernizeDate( data.end_date ) ) );
			
			var results:ArrayCollection;
			var result:Object;
			
			if( data.hasOwnProperty('image') )
			{
				results = data.image is ArrayCollection ? data.image : new ArrayCollection( [ data.image ] );
				
				var images:ArrayCollection = new ArrayCollection();
				
				for each(result in results) 
				{
					images.addItem( ImageReference.fromObj(result) );
				}
				
				val.images = images;
			}
			
			if( data.hasOwnProperty('testResult') )
			{
				results = data.testResult is ArrayCollection ? data.testResult : new ArrayCollection( [ data.testResult ] );
				
				var tests:ArrayCollection = new ArrayCollection();
				
				for each(result in results) 
				{
					tests.addItem( TestResults.fromObj(result) );
				}
				
				val.tests = tests;
			}

			if( data.hasOwnProperty('summary')
				&& data.summary.hasOwnProperty('element') )
			{
				results = data.summary.element is ArrayCollection ? data.summary.element : new ArrayCollection( [ data.summary.element ] );
					
				var summaryElements:ArrayCollection = new ArrayCollection();
				
				for each(result in results) 
				{
					summaryElements.addItem( SummaryElement.fromObj(result) );
				}
				
				val.summary = summaryElements;
			}
			
			if( data.hasOwnProperty('report') )
			{
				val.report = Report.fromObj(data.report);
			}
			
			return val;
		}
	}
}