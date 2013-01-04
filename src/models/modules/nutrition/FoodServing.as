package models.modules.nutrition
{
	import enum.DietClassQuantifier;
	
	import models.modules.NutritionModel;

	[Bindable]
	public class FoodServing
	{
		public static const ALCOHOL:String = "alochol";
		public static const DAIRY:String = "dairy";
		public static const FATS_AND_OILS:String = "fatsoils";
		public static const FRUITS:String = "fruits";
		public static const GRAINS:String = "grains";
		public static const PROTEINS:String = "proteins";
		public static const SODIUM:String = "sodium";
		public static const SUGARS:String = "sugars";
		public static const VEGETABLES:String = "vegetables";
		public static const WATER:String = "water";
		
		public var id:String;
		public var listMinMax:Boolean;
		public var quantifier:String;
		public var servingSize:String;
		public var title:String;
		public var unit:String;
		public var isPrimary:Boolean;
		
		public function FoodServing( title:String, id:String = null, unit:String = 'servings', quantifier:String = null, servingSize:String = '1', listMinMax:Boolean = false, isPrimary:Boolean = false )
		{
			this.title = title;
			this.id = id;
			this.unit = unit;
			this.quantifier = quantifier ? quantifier : DietClassQuantifier.EXACTLY;
			this.servingSize = servingSize;
			this.listMinMax = listMinMax;
			this.isPrimary = isPrimary;
		}
		
		public function get icon():Class
		{
			var model:NutritionModel = AppProperties.getInstance().controller.nutritionController.model as NutritionModel;
			
			if( id == SODIUM ) return model.iconSodium;
			if( id == FATS_AND_OILS ) return model.iconFatsAndOils;
			if( id == SUGARS ) return model.iconSugars;
			if( id == ALCOHOL ) return model.iconAlcohol;
			if( id == WATER ) return model.iconWater;
			
			return null;
		}
		
		public function get iconBig():Class
		{
			var model:NutritionModel = AppProperties.getInstance().controller.nutritionController.model as NutritionModel;
			
			if( id == SODIUM ) return model.sodiumEmpty;
			if( id == FATS_AND_OILS ) return model.fatsOilsEmpty;
			if( id == SUGARS ) return model.sugarsEmpty;
			if( id == ALCOHOL ) return model.alcoholEmpty;
			if( id == WATER ) return model.waterEmpty;
			
			return null;
		}
	}
}