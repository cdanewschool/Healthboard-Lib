package models.modules.nutrition
{
	import enum.DietClassQuantifier;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import models.UserModel;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class FoodPlan extends EventDispatcher
	{
		public static const AVERAGE:FoodPlan = new FoodPlan
			(
				"Average diet", 
				"Maintain current weight and nutritive conditions",
				"Eat well balanced meals and do not exceed the daily calorie budget",
				new Date(),
				new ArrayCollection
				(
					[
						new MealCategory
						( 
							'Breakfast',
							new ArrayCollection
							(
								[
									new Meal( null, "3/4 cup bran flakes cereal; 1 medium banana; and1 cup low-fat milk." ),
									new Meal( null, "1 slice whole wheat bread; 1 tsp soft (tub) margarine; and 1 cup orange juice" ),
									new Meal( null, "1 slice French toast, whole grain: 1 medium egg (for French toast); 1 teaspoon oil;" ),
								]
							)
						), 
						new MealCategory
						( 
							'Lunch',
							new ArrayCollection
							(
								[
									new Meal( null, "Grilled chicken breast\nLentil soup\n1 glass of juice" )
								]
							)
						), 
						new MealCategory
						( 
							'Dinner',
							new ArrayCollection
							(
								[
									new Meal( null, "2 fillets of trout; 4 pieces roasted beets; 3 cups of water" )
								]
							)
						), 
						new MealCategory
						( 
							'Snack',
							new ArrayCollection
							(
								[
									new Meal( null, "16 pieces of baby carrots" )
								]
							)
						), 
					]
				),
				new ArrayCollection
				(
					[
						new FoodServing( 'Fruits', FoodServing.FRUITS, 'servings', DietClassQuantifier.EXACTLY, '5-6', false, true ),
						new FoodServing( 'Grains', FoodServing.GRAINS, 'servings', DietClassQuantifier.EXACTLY, '5-6', false, true ),
						new FoodServing( 'Vegetables', FoodServing.VEGETABLES, 'servings', DietClassQuantifier.EXACTLY, '5-6', false, true ),
						new FoodServing( 'Proteins', FoodServing.PROTEINS, 'servings', DietClassQuantifier.MAXIMUM, '3', false, true ),
						new FoodServing( 'Dairy', FoodServing.DAIRY, 'servings', DietClassQuantifier.MAXIMUM, '3', false, true ),
						new FoodServing( 'Sodium', FoodServing.SODIUM, 'milligrams', DietClassQuantifier.EXACTLY, '2,000' ),
						new FoodServing( 'Fats & Oils', FoodServing.FATS_AND_OILS, 'servings', DietClassQuantifier.EXACTLY, '2-3' ),
						new FoodServing( 'Sugars', FoodServing.SUGARS, 'servings', DietClassQuantifier.LESS_THAN, '1' ),
						new FoodServing( 'Alcohol', FoodServing.ALCOHOL, 'drinks', DietClassQuantifier.LESS_THAN, '2' ),
						new FoodServing( 'Water', FoodServing.WATER, 'cups', DietClassQuantifier.MINIMUM, '8' )
					]
				),
				new ArrayCollection
				(
					[
						new Food('Cheese',null,'assets/images/nutrition/foods/cheese.jpg'),
						new Food('Red meat',null,'assets/images/nutrition/foods/redmeat.jpg'),
						new Food('Ice cream',null,'assets/images/nutrition/foods/icecream.jpg'),
						new Food('Fried Chicken',null,'assets/images/nutrition/foods/friedchicken.jpg'),
						new Food('Hamburgers',null,'assets/images/nutrition/foods/hamburgers.jpg'),
						new Food('Soda',null,'assets/images/nutrition/foods/soda.jpg')
					]
				),
				new ArrayCollection
				(
					[
						new Food('Whole Wheat Bread',null,'assets/images/nutrition/foods/bread.jpg'),
						new Food('Berries',null,'assets/images/nutrition/foods/berries.jpg'),
						new Food('Vegetables',null,'assets/images/nutrition/foods/vegetables.jpg'),
						new Food('Grapes',null,'assets/images/nutrition/foods/grapes.jpg'),
						new Food('Lettuce',null,'assets/images/nutrition/foods/lettuce.jpg'),
						new Food('Water',null,'assets/images/nutrition/foods/water.jpg')
					]
				),
				new ArrayCollection
				(
					[
						{note: "Try to avoid any salty food to decrease sodium.", completed:false, removed:false, recommendation:"Nutrition Workshop"},
						{note: "Start the day with a whole grain cereal – wheat flakes, toasted O’s, or oatmeal are some examples.", completed:false, removed:false, recommendation:"Set a Reminder"}
					]
				),
				2000
			);
		
		private var _directions:String;
		private var _name:String;
		private var _patient:UserModel;
		private var _provider:UserModel;
		private var _reasons:String;
		private var _startingDate:Date;
		
		private var _servingCategories:ArrayCollection 
		
		private var _foodsToIncrease:ArrayCollection;
		private var _foodsToLimit:ArrayCollection;
		private var _mealCategories:ArrayCollection;
		private var _notes:ArrayCollection;
		
		public var calorieBudget:int;
		
		public var dirty:Boolean;
		
		public function FoodPlan( name:String = "", reasons:String = "", directions:String = "", startingDate:Date = null, 
								  mealCategories:ArrayCollection = null, servingCategories:ArrayCollection = null, 
								  foodsToLimit:ArrayCollection = null, foodsToIncrease:ArrayCollection = null, 
								  notes:ArrayCollection = null, calorieBudget:int = 0,
								  patient:UserModel = null, provider:UserModel = null )
		{
			this.name = name;
			this.reasons = reasons;
			this.directions = directions;
			this.startingDate = startingDate ? startingDate : new Date();
			
			this.mealCategories = mealCategories ? mealCategories : new ArrayCollection();
			this.servingCategories = servingCategories ? servingCategories : new ArrayCollection();
			this.foodsToLimit = foodsToLimit ? foodsToLimit : new ArrayCollection();
			this.foodsToIncrease = foodsToIncrease ? foodsToIncrease : new ArrayCollection();
			this.notes = notes;
			this.calorieBudget = calorieBudget;
			
			this.provider = provider;
			
			dirty = false;
		}

		public function addNote( note:Object ):void
		{
			notes && notes.length ? notes.addItem( note ) : notes = new ArrayCollection( [ note ] );
			
			dispatchEvent( new Event( Event.CHANGE, true ) );
		}
		
		public function getFoodGroupById(id:String):FoodServing
		{
			for each(var foodGroup:FoodServing in servingCategories)
			{
				if( foodGroup.title.toLowerCase() == id )
				{
					return foodGroup;
				}
			}
			
			return null;
		}
		
		public function get directions():String
		{
			return _directions;
		}

		public function set directions(value:String):void
		{
			_directions = value;
			
			dirty = true;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
			
			dirty = true;
		}

		public function get patient():UserModel
		{
			return _patient;
		}
		
		public function set patient(value:UserModel):void
		{
			_patient = value;
		}
		
		public function get provider():UserModel
		{
			return _provider;
		}

		public function set provider(value:UserModel):void
		{
			_provider = value;
		}

		public function get reasons():String
		{
			return _reasons;
		}

		public function set reasons(value:String):void
		{
			_reasons = value;
			
			dirty = true;
		}

		public function get startingDate():Date
		{
			return _startingDate;
		}

		public function set startingDate(value:Date):void
		{
			_startingDate = value;
			
			dirty = true;
		}

		public function get servingCategories():ArrayCollection
		{
			return _servingCategories;
		}

		public function set servingCategories(value:ArrayCollection):void
		{
			_servingCategories = value;
			
			dirty = true;
		}

		public function get foodsToIncrease():ArrayCollection
		{
			return _foodsToIncrease;
		}

		public function set foodsToIncrease(value:ArrayCollection):void
		{
			_foodsToIncrease = value;
			
			dirty = true;
		}

		public function get foodsToLimit():ArrayCollection
		{
			return _foodsToLimit;
		}

		public function set foodsToLimit(value:ArrayCollection):void
		{
			_foodsToLimit = value;
			
			dirty = true;
		}

		public function get mealCategories():ArrayCollection
		{
			return _mealCategories;
		}

		public function set mealCategories(value:ArrayCollection):void
		{
			_mealCategories = value;
			
			dirty = true;
		}

		public function get notes():ArrayCollection
		{
			return _notes;
		}

		public function set notes(value:ArrayCollection):void
		{
			_notes = value;
		}
	}
}