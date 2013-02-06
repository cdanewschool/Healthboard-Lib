package models.modules.medicalrecords
{
	import models.Comment;
	
	import mx.collections.ArrayCollection;

	public class TestResult
	{
		public var comments:ArrayCollection;
		public var name:String;
		public var result:String;
		public var site:String;
		public var units:String;
		public var warning:Boolean;
		
		public function TestResult()
		{
		}
		
		public static function fromObj( data:Object ):TestResult
		{
			var val:TestResult = new TestResult();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try{ val[prop] = data[prop]; }
					catch(e:Error){}
				}
			}
			
			if( data.hasOwnProperty('comment') )
			{
				var results:ArrayCollection = data.comment is ArrayCollection ? data.comment : new ArrayCollection( [ data.comment ] );
				
				var comments:ArrayCollection = new ArrayCollection();
				
				for each(var result:Object in results) 
				{
					comments.addItem( Comment.fromObj(result) );
				}
				
				val.comments = comments;
			}
			
			return val;
		}
	}
}