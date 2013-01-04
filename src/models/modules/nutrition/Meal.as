package models.modules.nutrition
{
	[Bindable]
	public class Meal
	{
		public var name:String;
		public var description:String;
		public var link:String;
		
		public function Meal( name:String = null, description:String = null, link:String = null )
		{
			this.name = name;
			this.description = description;
			this.link = link;
		}
	}
}