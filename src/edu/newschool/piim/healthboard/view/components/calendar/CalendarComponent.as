package edu.newschool.piim.healthboard.view.components.calendar
{
	import edu.newschool.piim.healthboard.view.components.calendar.renderer.ICalendarDayItemRenderer;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	import mx.events.CalendarLayoutChangeEvent;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.states.State;
	
	import spark.collections.Sort;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.List;
	import spark.components.Scroller;
	import spark.components.VScrollBar;
	import spark.formatters.DateTimeFormatter;
	import spark.layouts.ColumnAlign;
	import spark.layouts.RowAlign;
	import spark.layouts.TileLayout;
	import spark.layouts.TileOrientation;
	
	[Event(name="change", type="mx.events.CalendarLayoutChangeEvent")]
	public class CalendarComponent extends Group
	{
		public static const MODE_WEEK:String = "week";
		public static const MODE_MONTH:String = "month";
		
		private static const STATE_DEFAULT:String = "default";
		private static const STATE_SELECT:String = "select";
		
		public static const DAY:Number = 1000 * 60 * 60 * 24;
		
		public function CalendarComponent()
		{
			super();
			
			_mode = MODE_MONTH;
			
			headerFormatter = new DateTimeFormatter();
			headerFormatter.dateTimePattern = _dateTimePattern = "EEEE";
			
			sidebarFormatter = new DateTimeFormatter();
			sidebarFormatter.dateTimePattern = _timePattern = "HH mm";
			
			states.push( new State( {name:STATE_DEFAULT} ) );
			states.push( new State( {name:STATE_SELECT} ) );
			
			currentState = STATE_DEFAULT;
			
			addEventListener( FlexEvent.CREATION_COMPLETE, init)
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		private var grid:List;
		private var content:Group;
		private var dateStart:Date;
		private var dayCount:int;
		private var header:Group;
		private var headerFormatter:DateTimeFormatter;
		private var scroller:Scroller;
		private var sidebar:Group;
		private var sidebarFormatter:DateTimeFormatter;
		private var slots:ArrayCollection;
		
		//--------------------------------------------------------------------------
		//
		//  Overridden properties
		//
		//--------------------------------------------------------------------------
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			
			invalidateProperties();
		}
		
		override public function set currentState(value:String):void
		{
			super.currentState = value;
			
			dataDirty = true;
			
			invalidateProperties();
			invalidateDisplayList();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  calendarRowHeight
		//---------------------------------- 
		
		private var _calendarRowHeight:Number = 100;

		public function get calendarRowHeight():Number
		{
			return _calendarRowHeight;
		}

		public function set calendarRowHeight(value:Number):void
		{
			_calendarRowHeight = value;
			
			invalidateDisplayList();
		}

		
		//----------------------------------
		//  clickNavigation
		//---------------------------------- 
		
		private var _clickNavigation:Boolean = false;
		
		public function get clickNavigation():Boolean
		{
			return _clickNavigation;
		}
		
		public function set clickNavigation(value:Boolean):void
		{
			_clickNavigation = value;
			
			invalidateProperties();
		}
		
		private var dateDirty:Boolean;
		private var dataDirty:Boolean;
		
		//----------------------------------
		//  dateTimePattern
		//---------------------------------- 
		
		private var _dateTimePattern:String;
		
		public function get dateTimePattern():String
		{
			return _dateTimePattern;
		}
		
		public function set dateTimePattern(value:String):void
		{
			dateDirty = true;
			
			_dateTimePattern = value;
			
			invalidateProperties();
			invalidateDisplayList();
		}
		
		//----------------------------------
		//  highlightedDate
		//---------------------------------- 
		
		private var _highlightedDate:Date;
		
		public function get highlightedDate():Date
		{
			return _highlightedDate;
		}
		
		public function set highlightedDate(value:Date):void
		{
			_highlightedDate = value;
			
			invalidateProperties();
		}
		
		//----------------------------------
		//  itemRenderer
		//---------------------------------- 
		
		private var _itemRenderer:Class;
		
		public function get itemRenderer():Class
		{
			return _itemRenderer;
		}
		
		public function set itemRenderer(value:Class):void
		{
			if( !value is ICalendarDayItemRenderer )  
				throw new Error( 'itemRenderer must implement ICalendarItem' );
			
			itemRendererDirty = _itemRenderer != value;
			
			_itemRenderer = value;
		}
		
		private var itemRendererDirty:Boolean;
		
		//----------------------------------
		//  items
		//---------------------------------- 
		
		private var _items:ArrayCollection;
		
		public function set items(value:ArrayCollection):void
		{
			if( !dataDirty ) dataDirty = _items != value;
			
			if( _items ) _items.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onItemsChange);
			
			_items = value;
			
			if( _items ) _items.addEventListener(CollectionEvent.COLLECTION_CHANGE, onItemsChange);
			
			invalidateProperties();
			invalidateDisplayList();
		}
		
		public function get items():ArrayCollection{ return _items; }
		
		//----------------------------------
		//  mode
		//---------------------------------- 
		
		private var _mode:String = MODE_MONTH;
		
		public function get mode():String
		{
			return _mode;
		}
		
		[Bindable]
		public function set mode(value:String):void
		{
			if( !(value == MODE_WEEK || value == MODE_MONTH) )  
				throw new Error( 'Invalid mode' );
			
			dataDirty = true;
			
			_mode = value;
			
			invalidateProperties();
			invalidateDisplayList();
		}
		
		//----------------------------------
		//  selectedDate
		//---------------------------------- 
		
		private var _selectedDate:Date;
		
		public function get selectedDate():Date
		{
			return _selectedDate;
		}
		
		public function set selectedDate(value:Date):void
		{
			if( _selectedDate == value ) return;
			
			var dirty:Boolean = true;
			
			if( ( _selectedDate && mode == MODE_MONTH && _selectedDate.fullYear == value.fullYear && _selectedDate.month == value.month )
				|| ( _selectedDate && mode == MODE_WEEK && _selectedDate.fullYear == value.fullYear && _selectedDate.month == value.month && Math.round(_selectedDate.date/7) == Math.round(value.date/7) ) )
			{
				dirty = false;		
			}
			
			if( !clickNavigation && !dirty ) return;
			
			dateDirty = dataDirty = dirty;
			
			_selectedDate = new Date( value.fullYear, value.month, value.date );
			
			invalidateProperties();
			invalidateDisplayList();
		}
		
		//----------------------------------
		//  timePattern
		//---------------------------------- 
		
		private var _timePattern:String;
		
		public function get timePattern():String
		{
			return _timePattern;
		}
		
		public function set timePattern(value:String):void
		{
			dateDirty = true;
			
			_timePattern = value;
			
			invalidateProperties();
			invalidateDisplayList();
		}
		
		//----------------------------------
		//  weekHourFrom
		//---------------------------------- 
		
		public var weekHourFrom:int = 6;
		
		//----------------------------------
		//  weekHourTo
		//---------------------------------- 
		
		public var weekHourTo:int = 24;
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods: UIComponent
		//
		//--------------------------------------------------------------------------
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			content = new Group();
			addElement(content);
			
			scroller = new Scroller();
			scroller.setStyle('horizontalScrollPolicy','off');
			addElement(scroller);
			
			scroller.viewport = content;
			
			var layout:TileLayout;
			
			layout = new TileLayout();
			layout.horizontalGap = -1;
			layout.orientation = TileOrientation.ROWS;
			layout.rowAlign = RowAlign.JUSTIFY_USING_HEIGHT;
			
			header = new Group();
			header.layout = layout;
			content.addElement(header);
			
			layout = new TileLayout();
			layout.horizontalGap = -1;
			layout.orientation = TileOrientation.ROWS;
			layout.requestedColumnCount = 1;
			layout.rowAlign = RowAlign.JUSTIFY_USING_HEIGHT;
			layout.verticalGap = -1;
			
			sidebar = new Group();
			sidebar.width = 50;
			sidebar.layout = layout;
			content.addElement(sidebar);
			
			layout = new TileLayout();
			layout.horizontalGap = -1;
			layout.requestedColumnCount = 7;
			layout.columnAlign = ColumnAlign.LEFT;
			layout.rowAlign = RowAlign.TOP;
			layout.verticalGap = -1;
			
			grid = new List();
			grid.layout = layout;
			grid.allowMultipleSelection = false;
			grid.useVirtualLayout = false;
			grid.setStyle('borderAlpha', 0);
			grid.setStyle('contentBackgroundAlpha', 0);
			grid.setStyle('horizontalScrollPolicy', 'off');
			grid.addEventListener(FlexEvent.CHANGING,onSelectionChange);
			grid.addEventListener(Event.CHANGE,onDateSelect);
			content.addElement(grid);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if( !initialized ) return;
			
			sidebar.visible = sidebar.includeInLayout = mode==MODE_WEEK;
			
			var i:int;
			var j:int;
			
			if( itemRendererDirty )
			{
				grid.itemRenderer = new ClassFactory( itemRenderer );
				itemRendererDirty = false;
			}
			
			(grid.layout as TileLayout).orientation = mode==MODE_WEEK?TileOrientation.COLUMNS:TileOrientation.ROWS;
			
			if( dateDirty )
			{
				var dateStart:Date;
				var dateEnd:Date;
				var dateCursor:Date;
				
				var date:Date;
				var label:Label;
				
				var datesDataProvider:ArrayCollection = new ArrayCollection();
				
				headerFormatter.dateTimePattern = dateTimePattern;
				sidebarFormatter.dateTimePattern = timePattern;
				
				if( mode == MODE_WEEK )
				{
					//	set date range
					dateStart = new Date( selectedDate.fullYear, selectedDate.month, selectedDate.date );
					while( dateStart.day > 0 ) dateStart.date -= 1;
					
					dateEnd = new Date( dateStart.fullYear, dateStart.month, dateStart.date + 7 );
					
					dateCursor = new Date();
					dateCursor.setTime( dateStart.time );
					
					//	populate an array of all display dates
					dayCount = (dateEnd.time - dateStart.time ) / DAY;
					
					for(i=0;i<=dayCount;i++)
					{
						for(j=weekHourFrom;j<weekHourTo;j++)
						{
							date = new Date();
							date.setTime( dateCursor.time );
							date.setHours( j );
							
							datesDataProvider.addItem( date );
						}
						
						dateCursor.date += 1;
					}
					
					sidebar.removeAllElements();
					
					for(i=weekHourFrom;i<weekHourTo;i++)
					{
						label = new Label();
						label.text = sidebarFormatter.format( new Date(null,null,null,i) );
						label.styleName = "white11";
						label.setStyle('textAlign','right');
						label.width = 40;
						sidebar.addElement( label );
					}
					
					this.dateStart = dateStart;
				}
				else if( mode == MODE_MONTH )
				{
					//	set date range
					dateStart = new Date( selectedDate.fullYear, selectedDate.month, selectedDate.date );						
					dateEnd = new Date( dateStart.fullYear, dateStart.month+1, 1 );
					
					while( dateStart.date > 1 ) dateStart.date -= 1;
					while( dateStart.day > 0 ) dateStart.date -= 1;
					
					dateEnd.date -= 1;
					while( dateEnd.day < 6 ) dateEnd.date += 1;
					
					//	populate an array of all display dates
					dayCount = (dateEnd.time - dateStart.time ) / DAY;
					
					dateCursor = new Date();
					dateCursor.setTime( dateStart.time );
					
					for(i=0;i<=dayCount;i++)
					{
						date = new Date();
						date.setTime( dateCursor.time );
						
						datesDataProvider.addItem( date );
						
						dateCursor.date += 1;
					}
					
					this.dateStart = dateStart;
				}
				
				//	populate header
				date = new Date();
				date.time = dateStart.time;
				
				header.removeAllElements();
				
				for(i=0;i<7;i++)
				{
					label = new Label();
					label.text = headerFormatter.format( date );
					label.styleName = "white11";
					label.setStyle('textAlign','center');
					header.addElement( label );
					
					date.date += 1;
				}
				
				grid.dataProvider = datesDataProvider;
				grid.validateNow();
				
				dateDirty = false;
			}
			
			if( dataDirty && this.dateStart )
			{
				var items:Dictionary = new Dictionary();
				
				dateCursor = new Date();
				dateCursor.setTime( this.dateStart.time );
				
				//	populate dictionary of items by date
				if( mode == MODE_WEEK )
				{
					var itemsForDate:ArrayCollection;
					
					for(i=0;i<=dayCount;i++)
					{
						for(j=weekHourFrom;j<weekHourTo;j++)
						{
							dateCursor.hours = j;
							
							itemsForDate = getItemsForDate( dateCursor );
							
							if( itemsForDate && itemsForDate.length ) 
								items[ dateCursor.time ] = itemsForDate;
						}
						
						dateCursor.date += 1;
					}
				}
				else if( mode == MODE_MONTH )
				{
					for(i=0;i<=dayCount;i++)
					{
						itemsForDate = getItemsForDate( dateCursor );
						if( itemsForDate && itemsForDate.length ) items[ dateCursor.time ] = itemsForDate;
						
						dateCursor.date += 1;
					}
				}
				
				grid.validateNow();
				
				for(i=0;i<grid.dataGroup.numElements;i++)
				{
					var item:ICalendarDayItemRenderer = grid.dataGroup.getElementAt(i) as ICalendarDayItemRenderer;
					
					if( items[ item.date.time ]
						&& items[ item.date.time ] is ArrayCollection
						&& (items[ item.date.time ] as ArrayCollection).length )
					{
						var sort:Sort = new Sort();
						sort.compareFunction = sortByDate;
						
						item.appointments = items[ item.date.time ];
						item.appointments.sort = sort;
						item.appointments.refresh();
					}
					else
					{
						item.appointments = null;
					}
				}
				
				dataDirty = false;
			}
			
			if( highlightedDate )
			{
				for each(var d:Date in grid.dataProvider)
				{
					if( d.time == highlightedDate.time )
					{
						grid.selectedIndex = grid.dataProvider.getItemIndex( d );
						break;
					}
				}
			}
			else
			{
				grid.selectedIndex = -1;
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			if(!initialized) return;
			
			var width:Number = unscaledWidth;
			var height:Number = unscaledHeight;
			
			var x:int=0;
			var y:int=0;
			
			scroller.width = width;
			scroller.height = height;
			
			//	header
			var layout:TileLayout = header.layout as TileLayout;
			
			header.height = 20;
			y += header.height;
			
			layout = (grid.layout as TileLayout);
			
			if( mode == MODE_WEEK )
			{
				x += 5;
				
				sidebar.x = x;
				sidebar.y = y;
				x += sidebar.width;
				
				width -= x;
				width += 6;
				
				//	grid
				grid.x = x;
				grid.y = y;
				
				header.x = grid.x;
				header.width = grid.width;
				
				(sidebar.layout as TileLayout).rowHeight = calendarRowHeight;
				
				layout.requestedRowCount = weekHourTo - weekHourFrom;
				layout.rowHeight = calendarRowHeight;
				
				if( layout.rowCount * layout.rowHeight > scroller.height ) 
					width -= scroller.verticalScrollBar.width;
				
				layout.columnWidth = width / layout.requestedColumnCount;
				
				(header.layout as TileLayout).requestedColumnCount = 7;
				(header.layout as TileLayout).columnWidth = layout.columnWidth;
			}
			else if( mode == MODE_MONTH )
			{
				//	grid
				grid.y = y;
				grid.width = width;
				
				if( layout.rowCount * layout.rowHeight > scroller.height ) 
					width -= scroller.verticalScrollBar.width;
				
				layout.requestedColumnCount = 7;
				layout.rowHeight = calendarRowHeight;
				layout.columnWidth = width / layout.columnCount;
				
				(header.layout as TileLayout).requestedColumnCount = 7;
				(header.layout as TileLayout).columnWidth = layout.columnWidth;
			}
		}
		
		private function onDateSelect( event:Event ):void
		{
			var date:Date = new Date();
			date.time = grid.selectedItem;
			
			selectedDate = date;
			
			var evt:CalendarLayoutChangeEvent = new CalendarLayoutChangeEvent( CalendarLayoutChangeEvent.CHANGE, true );
			dispatchEvent( evt );
		}
		
		private function onSelectionChange( event:Event ):void
		{ 
			if( !clickNavigation ) event.preventDefault(); 
		}
		
		private function getItemsForDate( date:Date ):ArrayCollection
		{
			var items:ArrayCollection = new ArrayCollection();
			
			if( !dataProvider ) return items;
			
			for(var i:int=0;i<dataProvider.length;i++)
			{
				var item:ICalendarItem = dataProvider.getItemAt(i) as ICalendarItem;
				
				var itemDate:Date = item.from as Date;
				
				var match:Boolean = date.fullYear == itemDate.fullYear
					&& date.month == itemDate.month
					&& date.date == itemDate.date;
				
				if( mode == MODE_WEEK ) match = match && date.hours == itemDate.hours;
				if( match ) items.addItem( item );
			}
			
			return items;
		}
		
		public function get dataProvider():ArrayCollection
		{
			if( currentState == STATE_SELECT )
			{
				var _dataProvider:ArrayCollection = new ArrayCollection();
				
				if( items != null ) _dataProvider.source = _dataProvider.source.concat( items.source );
				if( slots != null ) _dataProvider.source = _dataProvider.source.concat( slots.source );
				
				return _dataProvider;
			}
			
			return items;
		}

		private function onItemsChange(event:CollectionEvent):void
		{
			if( currentState != STATE_DEFAULT ) currentState = STATE_DEFAULT;
			
			if( event.kind == CollectionEventKind.ADD || event.kind == CollectionEventKind.REMOVE )
			{
				dataDirty = true;
				
				invalidateProperties();
				invalidateDisplayList();
			}
		}
		
		private function onItemSelect(event:CalendarEvent):void
		{
			if( !event.data.selected ) return;
			
			if( currentState == STATE_DEFAULT
				&& ICalendarItem(event.data).isScheduled )
			{
				for(var i:int=0;i<dataProvider.length;i++)
				{
					var item:ICalendarItem = dataProvider.getItemAt(i) as ICalendarItem;
					
					if( item != event.data && item.selected )
					{
						(dataProvider.getItemAt(i) as ICalendarItem).selected = false;
						
						break;
					}
				}
			}
		}
		
		public function showSlots( slots:ArrayCollection ):void
		{
			this.slots = slots;
			
			currentState = STATE_SELECT;
		}
		
		private function init(event:FlexEvent):void
		{
			selectedDate = new Date();
			
			grid.addEventListener( CalendarEvent.SELECT, onItemSelect );
			
			invalidateProperties();
		}
		
		private function sortByDate(item1:ICalendarItem, item2:ICalendarItem, fields:Array = null):int
		{
			if( item1.from.time < item2.from.time ) return -1;
			if( item1.from.time > item2.from.time ) return 1;
			
			return 0;
		}
	}
}