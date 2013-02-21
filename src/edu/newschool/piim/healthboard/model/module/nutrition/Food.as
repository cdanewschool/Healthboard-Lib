package edu.newschool.piim.healthboard.model.module.nutrition
{
	import edu.newschool.piim.healthboard.model.FileUpload;

	[Bindable]
	public class Food
	{
		public var name:String;
		public var directions:String;
		public var image:*;
		
		public function Food( name:String = null, directions:String = null, image:* = null )
		{
			this.name = name;
			this.directions = directions;
			this.image = image;
		}
	}
}