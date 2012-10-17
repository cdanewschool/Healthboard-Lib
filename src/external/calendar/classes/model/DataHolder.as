package external.calendar.classes.model
{
	import external.calendar.classes.events.CustomEvents;
	
	import flash.events.EventDispatcher;
	
	import mx.core.Application;
	import mx.core.FlexGlobals;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * DataHolder class represent all data which needs to be stored
	 * or needs to be used by any of the classes.
	 * It also dispatches events on adding a new event from any of the views.
	 * It is a singletone class so only single instance will be created through out the application cycle.
	 */
	public class DataHolder extends EventDispatcher
	{
		import flash.events.EventDispatcher;
		
		public static var objDataHolder:DataHolder;
		
		private var m_arrEvents:ArrayCollection; 
		
		public function DataHolder()
		{
			m_arrEvents = new ArrayCollection();
		}
		
		// return class instance and if it is not created then create it first and the return.
		public static function getInstance():DataHolder
		{
			if(objDataHolder == null)
			{
				objDataHolder = new DataHolder;
			}
			
			return objDataHolder;
		}
		
		// will add any event. used by day view and week view to do so.
		public function addEvent(_obj:Object, update:Boolean = true):void
		{
			m_arrEvents.addItem(_obj);
			if(update) updateViews();		//Added the "update" boolean on 20120517, as a quick fix to solve to huge loading time on the Appointments module. Without this, updateViews() gets called unnecessarily every single time each of the initial appointments is added, causing the loading time issues.
		}
		
		// dispatch event to main.mxml to update views as per new event added
		public function updateViews():void
		{
			dispatchEvent(new CustomEvents(CustomEvents.ADD_NEW_EVENT));
		}
		
		// currently not being used but could be used when we need to add a functionality of removing an event
		public function removeEventAt(index:int):void
		{
			m_arrEvents.removeItemAt(index);
		}
		
		//DB
		public function removeEvent(event:Object):void {
			m_arrEvents.removeItemAt(m_arrEvents.getItemIndex(event));
			updateViews();
		}
		
		// set and get dataprovider, which store all event related data
		public function set dataProvider(_arrEvents:ArrayCollection):void
		{
			m_arrEvents = _arrEvents;
			updateViews();
		}
		
		[Bindable] public function get dataProvider():ArrayCollection
		{
			return m_arrEvents;
		}
	}
}