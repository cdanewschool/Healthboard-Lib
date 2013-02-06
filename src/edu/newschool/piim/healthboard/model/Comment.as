package edu.newschool.piim.healthboard.model
{
	import edu.newschool.piim.healthboard.util.DateUtil;

	[Bindable]
	public class Comment
	{
		public var date:Date;
		public var owner:UserModel;
		public var ownerId:int;
		public var ownerType:String;
		public var text:String;
		
		public static function fromObj( data:Object ):Comment
		{
			var val:Comment = new Comment();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try{ val[prop] = data[prop]; }
					catch(e:Error){}
				}
			}
			
			val.ownerId = data.owner_id;
			val.ownerType = data.owner_type;
			
			if( data.date ) val.date = new Date( Date.parse( DateUtil.modernizeDate( data.date ) ) );
			
			if( val.ownerId && val.ownerType )
			{
				val.owner = AppProperties.getInstance().controller.getUserById( val.ownerId, val.ownerType );
			}
			
			return val;
		}
	}
}