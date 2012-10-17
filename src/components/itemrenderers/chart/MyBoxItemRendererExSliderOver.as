package components.itemrenderers.chart
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import models.modules.ExerciseModel;
	
	import mx.charts.ChartItem;
	import mx.charts.chartClasses.GraphicsUtilities;
	import mx.charts.renderers.BoxItemRenderer;
	import mx.core.FlexGlobals;
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	import mx.utils.ColorUtil;
	
	public class MyBoxItemRendererExSliderOver extends BoxItemRenderer
	{
		private var _data:Object;
		
		public function MyBoxItemRendererExSliderOver()
		{
			super();
		}
		
		override public function get data():Object
		{
			return _data;
		}
		
		/**
		 *  @private
		 */
		override public function set data(value:Object):void
		{
			if (_data == value)
				return;
			_data = value;
		}
		
		/**
		 *  @private
		 */
		override protected function updateDisplayList(unscaledWidth:Number,
													  unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			var fill:IFill;
			var state:String = "";
			
			if (_data is ChartItem && _data.hasOwnProperty('fill'))
			{
				state = _data.currentState;
				fill = _data.fill;
			}	 	
			else
				fill = GraphicsUtilities.fillFromStyle(getStyle('fill'));
			
			var color:uint;
			var adjustedRadius:Number = 0;
			
			switch (state)
			{
				case ChartItem.FOCUSED:
				case ChartItem.ROLLOVER:
					if (styleManager.isValidStyleValue(getStyle('itemRollOverColor')))
						color = getStyle('itemRollOverColor');
					else
						color = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(fill),-20);
					fill = new SolidColor(color);		
					adjustedRadius = getStyle('adjustedRadius');
					if (!adjustedRadius)
						adjustedRadius = 0;
					break;
				case ChartItem.DISABLED:
					if (styleManager.isValidStyleValue(getStyle('itemDisabledColor')))
						color = getStyle('itemDisabledColor');
					else
						color = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(fill),20);
					fill = new SolidColor(GraphicsUtilities.colorFromFill(color));
					break;
				case ChartItem.FOCUSEDSELECTED:
				case ChartItem.SELECTED:
					if (styleManager.isValidStyleValue(getStyle('itemSelectionColor')))
						color = getStyle('itemSelectionColor');
					else
						color = ColorUtil.adjustBrightness2(GraphicsUtilities.colorFromFill(fill),-30);
					fill = new SolidColor(color);				
					adjustedRadius = getStyle('adjustedRadius');
					if (!adjustedRadius)
						adjustedRadius = 0;
					break;
			}
			
			var stroke:IStroke;
			if( _data.item.index != ExerciseModel( AppProperties.getInstance().controller.exerciseController.model ).exerciseCurrentIndex ) {
				stroke = getStyle("stroke");
			}
			else {
				stroke = new SolidColorStroke(0xFFFFFF,1);
				fill = AppProperties.getInstance().controller.model.chartStyles.colorVitalSignsProvider;
			}
			//var stroke:IStroke = getStyle("stroke");
			
			var w:Number = stroke ? stroke.weight / 2 : 0;
			
			var rc:Rectangle = new Rectangle(w - adjustedRadius, w - adjustedRadius, width - 2 * w + adjustedRadius * 2, height - 2 * w + adjustedRadius * 2);
			
			var g:Graphics = graphics;
			g.clear();		
			g.moveTo(rc.left,rc.top);
			if (stroke)
				stroke.apply(g,null,null);
			if (fill)
				fill.begin(g,rc,null);
			g.lineTo(rc.right,rc.top);
			g.lineTo(rc.right,rc.bottom);
			g.lineTo(rc.left,rc.bottom);
			g.lineTo(rc.left,rc.top);
			if (fill)
				fill.end(g);
		}
	}
}