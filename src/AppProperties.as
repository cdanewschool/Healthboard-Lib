package 
{
	import edu.newschool.piim.healthboard.controller.Controller;

	public class AppProperties
	{
		private static var __instance:AppProperties;
		
		public var controller:Controller;
		
		public function AppProperties( enforcer:SingletonEnforcer )
		{
		}
		
		public static function getInstance():AppProperties
		{
			if( !__instance ) __instance = new AppProperties( new SingletonEnforcer() );
			
			return __instance;
		}
	}
}
internal class SingletonEnforcer
{
}