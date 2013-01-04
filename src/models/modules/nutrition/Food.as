package models.modules.nutrition
{
	import models.FileUpload;

	[Bindable]
	public class Food
	{
		public var name:String;
		public var directions:String;
		public var image:*;
		
		public function Food( name:String, directions:String = null, image:* = null )
		{
			this.name = name;
			this.directions = directions;
			this.image = image;
		}
	}
}