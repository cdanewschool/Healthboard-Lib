package edu.newschool.piim.healthboard.model
{
	[Bindable]
	public class ImageReference
	{
		public var caption:String;
		public var rotation:Number;
		public var url:String;
		
		public function ImageReference()
		{
			rotation = 0;
		}
		
		public static function fromObj( data:Object ):ImageReference
		{
			var val:ImageReference = new ImageReference();
			
			for (var prop:String in data)
			{
				if( val.hasOwnProperty( prop ) )
				{
					try{ val[prop] = data[prop]; }
					catch(e:Error){}
				}
			}
			
			return val;
		}
	}
}