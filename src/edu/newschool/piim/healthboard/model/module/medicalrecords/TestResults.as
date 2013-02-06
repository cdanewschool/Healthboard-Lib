package edu.newschool.piim.healthboard.model.module.medicalrecords
{
	import edu.newschool.piim.healthboard.model.Comment;
	
	import mx.collections.ArrayCollection;
	
	import edu.newschool.piim.healthboard.util.DateUtil;

	[Bindable]
	public class TestResults
	{
		public var comments:ArrayCollection;
		public var collectionDate:Date;
		public var orderDate:Date;
		
		public var results:ArrayCollection;
		
		public function TestResults()
		{
		}
		
		public static function fromObj( data:Object ):TestResults
		{
			var val:TestResults = new TestResults();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try{ val[prop] = data[prop]; }
					catch(e:Error){}
				}
			}
			
			if( data.collectionDate ) val.collectionDate = new Date( Date.parse( DateUtil.modernizeDate( data.collectionDate ) ) );
			if( data.orderDate ) val.orderDate = new Date( Date.parse( DateUtil.modernizeDate( data.orderDate ) ) );
			
			var results:ArrayCollection;
			var result:Object;
			
			if( data.hasOwnProperty('result') )
			{
				results = data.result is ArrayCollection ? data.result : new ArrayCollection( [ data.result ] );
				
				var testResults:ArrayCollection = new ArrayCollection();
				
				for each(result in results) 
				{
					testResults.addItem( TestResult.fromObj(result) );
				}
				
				val.results = testResults;
			}
			
			if( data.hasOwnProperty('comment') )
			{
				results = data.comment is ArrayCollection ? data.comment : new ArrayCollection( [ data.comment ] );
				
				var comments:ArrayCollection = new ArrayCollection();
				
				for each(result in results) 
				{
					comments.addItem( Comment.fromObj(result) );
				}
				
				val.comments = comments;
			}
			
			return val;
		}
		
	}
}