package models
{
	import enum.RelationshipType;

	public class RelationModel extends PersonModel
	{
		public var type:String;
		
		public function RelationModel()
		{
			super();
		}
		
		public function toString():String
		{
			return lastName + ', ' + firstName;
		}
		
		public static function fromObj( data:Object ):RelationModel
		{
			var val:RelationModel = new RelationModel();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try
					{
						val[prop] = data[prop];
					}
					catch(e:Error){}
				}
			}
			
			return val;
		}
	}
}