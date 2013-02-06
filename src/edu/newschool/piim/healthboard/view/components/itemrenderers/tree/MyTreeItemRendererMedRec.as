package edu.newschool.piim.healthboard.view.components.itemrenderers.tree
{
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import mx.controls.LinkButton;
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.controls.treeClasses.TreeListData;
	
	public class MyTreeItemRendererMedRec extends TreeItemRenderer
	{
		public function MyTreeItemRendererMedRec()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			if(super.data){
				if(TreeListData(super.listData).hasChildren) {
					//
				}
				else {
					if(TreeListData(super.listData).label == "Surgeries" || TreeListData(super.listData).label == "Procedures") {
						//
					}
					else {
						var myTextFormat:TextFormat = new TextFormat();
						myTextFormat.bold = false;
						label.setColor(0xFFFFFF);
						label.setTextFormat(myTextFormat);
					}
				}
			}
		}
	}
}