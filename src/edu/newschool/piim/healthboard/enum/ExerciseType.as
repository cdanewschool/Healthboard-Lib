package edu.newschool.piim.healthboard.enum
{
	public class ExerciseType
	{
		public static const BIKE:String = "bike";
		public static const CURL_UPS:String = "curlups";
		public static const ELLIPTICAL:String = "elliptical"
		public static const HIKE:String = "hike";
		public static const OVERVIEW:String = "overview";
		public static const PUSH_UPS:String = "pushups";
		public static const RUN:String = "run";
		public static const SWIM:String = "swim";
		public static const WEIGHT:String = "weight";
		public static const YOGA:String = "yoga";
		
		public static function getLabel( type:String ):String
		{
			if( type == BIKE ) return "Bike";
			if( type == CURL_UPS ) return "Curl Ups";
			if( type == ELLIPTICAL) return "Elliptical Machine";
			if( type == HIKE ) return "Hike";
			if( type == OVERVIEW ) return "Overview";
			if( type == PUSH_UPS ) return "Push Ups";
			if( type == RUN ) return "Run / Walk";
			if( type == SWIM ) return "Swimming";
			if( type == WEIGHT ) return "Weight Training";
			if( type == YOGA ) return "Yoga";
			
			return "";
		}
	}
}