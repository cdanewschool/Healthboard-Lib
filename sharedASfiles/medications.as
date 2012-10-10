/*import components.medicalRecords.ServiceDetails;
import components.medicalRecords.myNextStepsHistoryWindow;

import mx.charts.DateTimeAxis;
import mx.controls.Alert;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.managers.PopUpManager;
import mx.utils.ObjectProxy;

import spark.components.TitleWindow;
import spark.events.IndexChangeEvent;
*/

import ASclasses.MyCustomDataTip;

import components.medications.MedicationDetails;
import components.medications.myAddMedication1Window;
import components.medications.myAddMedication2Window;

import flash.display.CapsStyle;
import flash.display.DisplayObject;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.events.FocusEvent;
import flash.ui.Mouse;
import flash.ui.MouseCursor;

import mx.charts.CategoryAxis;
import mx.charts.ChartItem;
import mx.charts.HitData;
import mx.charts.events.ChartItemEvent;
import mx.charts.series.items.PlotSeriesItem;
import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.core.IChildList;
import mx.core.UIComponent;
import mx.events.ListEvent;
import mx.graphics.IFill;
import mx.graphics.SolidColor;
import mx.managers.PopUpManager;
import mx.managers.SystemManager;
import mx.rpc.events.ResultEvent;
import mx.utils.ObjectProxy;
import mx.utils.ObjectUtil;

import spark.components.TitleWindow;

import util.ArrayUtil;
import util.ChartLabelFunctions;

[Bindable] public var medicationsData:ArrayCollection = new ArrayCollection();			//data provider for the Plot Chart
[Bindable] public var medicationsDataFiltered:ArrayCollection;							//data provider for the Data Grid
[Bindable] public var medicationsCategories:Array;										//data provider for the Plot Chart's vertical axis
//[Bindable] private var wasInitialLoadDone:Boolean = false;

[Bindable] public var myHorizontalAlternateFill:uint = 0x303030;
[Bindable] public var myHorizontalFill:uint = 0x4A4A49;

public var wasMedicationDataLoaded:Boolean = false;
private function medicationsResultHandler(event:ResultEvent):void {
	/*if(event.result.autnresponse.responsedata.clusters.cluster is ObjectProxy ) {
	= new ArrayCollection( [event.result.autnresponse.responsedata.clusters.cluster] );
	}
	else {
	clusterData = event.result.autnresponse.responsedata.clusters.cluster;	
	}*/
	
	//	medicationsDataOriginal = event.result.medications.medication;
	//	medicationsData = ObjectUtil.copy(medicationsDataOriginal) as ArrayCollection;		
	medicationsData = event.result.medications.medication;	
	
	medicationsDataFiltered = new ArrayCollection(); //this is set here so when the module is re-opened, it won't be duplicated...
	medicationsCategories = new Array();												//this is set to a new Array here, so that it is reset not only when the graph is first drawn, but also when the "Required only" checkbox is UNCHECKED, so the categories for the Y axis are re-calculated.
	for(var i:uint = 0; i < medicationsData.length; i++) {
		if(medicationsCategories.indexOf(medicationsData[i].name) == -1) {
			medicationsCategories.push(medicationsData[i].name);
			if(medicationsData[i].name != "Prescription Drugs" && medicationsData[i].name != "Over-The-Counter Drugs" && medicationsData[i].name != "Supplements" && medicationsData[i].name != "Herbal Medicines") {
				medicationsDataFiltered.addItem(medicationsData[i]);
				if(medicationsData[i].status == "active") createNonTakenMeds(medicationsData[i]);
			}
		}
	}
	
	medicationsCategoriesForTree();
	
	//if(!wasInitialLoadDone)		//commenting out cause under the "new" format, this function is only called on load...
	filterMedsFromStatus();	//mediFilterStatus();	//we run the filter now, since we want to display only "active" medications when we load the module...
	//wasInitialLoadDone = true;
	//medicationsDataFiltered.source.reverse();	//so the order in the datagrid is the same as in the chart.
	//medicationsCategoriesForTree();	//this line was added after this whole script was written, when we found that bug regarding inactive medications... Its purpose is to update the tree and show ONLY "active" medications on load. This line needs to be here so it runs AFTER the filter is executed. Paradogically, it also needs to stay before the filter, because the filter looks for what's open in the tree... (NOW INSIDE THE filterMedsFromStatus FUNCTION CAUSE WE ALSO NEED IT TO RUN WHEN THE USER SELECTS A DIFFERENT STATUS--active/all)
	
	myHorizontalAlternateFill = medicationsCategories.length % 2 == 1 ? 0x303030 : 0x4A4A49;
	myHorizontalFill = medicationsCategories.length % 2 == 1 ? 0x4A4A49 : 0x303030;
	
	wasMedicationDataLoaded = true;
}

private function medicationsResultHandlerForWidget(event:ResultEvent):void {
	medicationsData = event.result.medications.medication;	
	
	medicationsDataFiltered = new ArrayCollection(); //this is set here so when the module is re-opened, it won't be duplicated...
	medicationsCategories = new Array();												//this is set to a new Array here, so that it is reset not only when the graph is first drawn, but also when the "Required only" checkbox is UNCHECKED, so the categories for the Y axis are re-calculated.
	for(var i:uint = 0; i < medicationsData.length; i++) {
		if(medicationsCategories.indexOf(medicationsData[i].name) == -1) {
			medicationsCategories.push(medicationsData[i].name);
			if(medicationsData[i].name != "Prescription Drugs" && medicationsData[i].name != "Over-The-Counter Drugs" && medicationsData[i].name != "Supplements" && medicationsData[i].name != "Herbal Medicines") {
				medicationsDataFiltered.addItem(medicationsData[i]);
				if(medicationsData[i].status == "active") createNonTakenMeds(medicationsData[i]);
			}
		}
	}
	
	filterMedsFromWidget();	//mediFilterStatus();	//we run the filter now, since we want to display only "active" medications when we load the module...
}

//taken from myAddMedication2Window.mxml
private function createNonTakenMeds(med:Object):void {
	var myDate:Date = new Date("06/17/2012");
	var myDateString:String;
	var twoDigitMonth:String;
	var twoDigitHours:String;
	var myHours:uint = 12;
	var myMeridiem:String = "PM";
	var myFrequency:uint = 1;
	var myRecurrence:String = "day";
	
	var newMedicationOP:ObjectProxy;
	var newMedication:Object;
	for(var i:uint = 0; i < 110; i++){
		newMedication = new Object();
		newMedication = ObjectUtil.copy(med);
		myDate.setDate(myDate.date+i);
		twoDigitMonth = (myDate.getMonth() + 1 < 10) ? "0" + (myDate.getMonth() + 1) + "/" : (myDate.getMonth() + 1) + "/";
		twoDigitHours = (myHours < 10) ? "0" + myHours + ":" : myHours + ":";		//adding the extra colon to ensure it's a string
		
		myDateString = twoDigitMonth + myDate.getDate() + "/" + myDate.getFullYear() + " " + twoDigitHours + "00:00 " + myMeridiem;
		
		/*if(med.type == "OTC") newMedication.dateO = myDateString;
		else if(med.type == "Supplement") newMedication.dateS = myDateString;
		else if(med.type == "Herbal") newMedication.dateH = myDateString;
		else if(med.type == "Prescription") newMedication.dateP = myDateString;*/
		newMedication.date = myDateString;
		newMedication.overdose = false;
		
		newMedicationOP = new ObjectProxy(newMedication);		//casting to ObjectProxy, otherwise the points in the graph don't get updated/taken when clicked...
		
		medicationsData.addItem(newMedicationOP);		//parentApplication.medicationsData.addItem(newMedication);
	}
}


[Bindable] public var medicationsCategoriesTree:ArrayCollection; /* = new ArrayCollection([
{category: "Prescription Drugs", children: []},
{category: "Over-The-Counter Drugs", children: []},
{category: "Supplements", children: []},
{category: "Herbal Medicines", children: []}
]);*/
private function medicationsCategoriesForTree():void {
	medicationsCategoriesTree = new ArrayCollection([	//added here when debugging the "inactive" medications bug, so that it's reset when it's run the second time...
		{category: "Prescription Drugs", children: []},
		{category: "Over-The-Counter Drugs", children: []},
		{category: "Supplements", children: []},
		{category: "Herbal Medicines", children: []}
	]);
	var medicationsCategoriesReversed:Array = ArrayUtil.unique(medicationsCategories).reverse();
	var currentCategory:int = -1;
	var currentLeaf:uint = 0;
	for(var i:uint = 0; i < medicationsCategoriesReversed.length; i++) {
		if(medicationsCategoriesReversed[i] == "Prescription Drugs" || medicationsCategoriesReversed[i] == "Over-The-Counter Drugs" || medicationsCategoriesReversed[i] == "Supplements" || medicationsCategoriesReversed[i] == "Herbal Medicines") {
			currentCategory++;
			currentLeaf = 0;
		}
		else {
			var newLeaf:Object = new Object();
			newLeaf = ({category: medicationsCategoriesReversed[i]});
			medicationsCategoriesTree[currentCategory].children[currentLeaf] = newLeaf;
			currentLeaf++;
		}
	}
	medicationsCategoriesTree.refresh();		//added...
	myTree.rowCount = medicationsCategories.length;
}

public function medicationsFillFunction(element:ChartItem, index:Number):IFill {
	var item:PlotSeriesItem = PlotSeriesItem(element);
	var c:SolidColor = controller.model.chartStyles.colorMedicationsPast; //gray	
	
	//if(item.item.taken == true && item.item.dateHpast == null && item.item.dateSpast == null && item.item.dateOpast == null && item.item.datePpast == null) { //if the medication isn't one in the past
	if(item.item.taken) {
		/*if(item.item.type == "Prescription") {
		c = colorMedicalRecordsOutpatient;	//blue
		}
		else if(item.item.type == "OTC") {
		c = colorMedicationsOverTheCounterDrugs;		//pink
		}
		else if(item.item.type == "Supplement") {
		c = colorMedicalRecordsInpatient;		//orange
		}
		else if(item.item.type == "Herbal") {
		c = colorMedicationsHerbalMedicines;		//green
		}*/
		if(item.item.asNeeded) {
			c = controller.model.chartStyles.colorMedicalRecordsInpatient;		//orange
		}
		else {
			c = controller.model.chartStyles.colorMedicalRecordsOutpatient;	//blue
		}
	}
	
	return c;
}

private function dataTipsMedications(hd:HitData):String {
	var intake:String;
	var date:String;
	//if(hd.item.datePpast == null && hd.item.dateOpast == null && hd.item.dateSpast == null && hd.item.dateHpast == null) {
	intake = "Last intake";
	/*if(hd.item.type == "Prescription") date = hd.item.dateP;
	else if(hd.item.type == "OTC") date = hd.item.dateO;
	else if(hd.item.type == "Supplement") date = hd.item.dateS;
	else if(hd.item.type == "Herbal") date = hd.item.dateH;*/
	date = hd.item.date;
	//}
	/*else {
	intake = "Past intake";
	if(hd.item.type == "Prescription") date = hd.item.datePpast;
	else if(hd.item.type == "OTC") date = hd.item.dateOpast;
	else if(hd.item.type == "Supplement") date = hd.item.dateSpast;
	else if(hd.item.type == "Herbal") date = hd.item.dateHpast;
	}*/
	
	return "<i>" + intake + "</i><br><br><font color='#1D1D1B'>" + date + "<br>1 tablet</font><br><br><i>Click to view medication details</i>";
}

private function dataTipsMedicationsNew(hd:HitData):String {
	return hd.item.taken ? (hd.item.dateAN != null || (hd.item.intake == hd.item.directedIntake && (hd.item.frequency == null || hd.item.frequency == hd.item.directedFrequency)) ? "Mark as Not Taken" : (hd.item.intake > hd.item.directedIntake || hd.item.frequency > hd.item.directedFrequency) ? "Overdose" : "Underdose") : "Mark as Taken";
}

//(not) commented out... no longer using datatips on this chart...
private function applyCustomDataTipsMedi():void {
	plotMedications.setStyle("dataTipRenderer",MyCustomDataTip);    
}

private function switchMedicationsView(index:uint):void {
	viewsMedications.selectedIndex = index;
	if(index == 0) {
		btnMedicationsChart.setStyle("chromeColor", 0xFF931E);
		btnMedicationsList.setStyle("chromeColor", 0xB3B3B3);
	}
	else {
		btnMedicationsChart.setStyle("chromeColor", 0xB3B3B3);
		btnMedicationsList.setStyle("chromeColor", 0xFF931E);
	}
}

private function showMedicationDetails(e:ChartItemEvent):void{
	viewMedicationDetails(e.hitData.item);
}

private function showMedicationDetailsDG(e:ListEvent):void {
	viewMedicationDetails(e.itemRenderer.data);
}

public function showMedicationDetailsAxis(med:String):void {
	if(med != "Prescription Drugs" && med != "Over-The-Counter Drugs" && med != "Supplements" && med != "Herbal Medicines") {
		for(var i:uint = 0; i < medicationsData.length; i++) {
			if(medicationsData.getItemAt(i).name == med) break;
		}
		//uncomment>> PopUpManager.removePopUp(myChartPopup);		//remove existing popup (if any).
		viewMedicationDetails(medicationsData.getItemAt(i));
	}
}

public var arrOpenTabsME:Array = new Array();
public function viewMedicationDetails(service:Object):void {
	var isServiceAlreadyOpen:Boolean = false;
	for(var j:uint = 0; j < arrOpenTabsME.length; j++) {
		if(arrOpenTabsME[j] == service.name) {
			isServiceAlreadyOpen = true;
			viewStackMedications.selectedIndex = j + 1;		//+1 because in arrOpenTabs we don't include the first tab
			break;
		}
	}
	if(!isServiceAlreadyOpen) {
		var medicationDetails:MedicationDetails = new MedicationDetails();
		medicationDetails.medicationData = service;
		viewStackMedications.addChild(medicationDetails);
		tabsMedications.selectedIndex = viewStackMedications.length - 1;
		arrOpenTabsME.push(service.name);
	}
}

[Bindable] public var minDateMedi:Date = new Date( "Jun 13 2012 12:00:00 AM");
[Bindable] private var maxDateMedi:Date = new Date( "Jun 19 2012 12:00:00 PM");
[Bindable] public var maxDateMediWidget:Date = new Date( "Jun 19 2012 12:20:00 AM");

private function medicationsSetMinMax():void {
	hAxisMedications.minimum = minDateMedi;	//new Date( "Oct 1 2010 12:00:00 PM");
	hAxisMedications.maximum = maxDateMedi;	//new Date( "Oct 1 2011 12:00:00 PM");
	
	/*	canvasMed.lineStyle(1.76,0xFFFFFF,1,true,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.MITER,2);
	canvasMed.moveTo('09/13/2011','Jiang Ya Pian');		//canvas.moveTo(dateFormatterToday.format(new Date()),immunizationsCategories.length);
	canvasMed.lineTo('09/16/2011 12:00:00 PM','Jiang Ya Pian');	//canvas.lineTo(dateFormatterToday.format(new Date()),0.05);
	canvasMed.moveTo('09/13/2011','Lipodrene');
	canvasMed.lineTo('09/16/2011 12:00:00 PM','Lipodrene');
	canvasMed.moveTo('09/13/2011','Ferrous Sulfate');
	canvasMed.lineTo('09/16/2011 12:00:00 PM','Ferrous Sulfate');
	canvasMed.moveTo('09/13/2011','Warfarin (Coumadin®)');
	canvasMed.lineTo('09/16/2011 12:00:00 PM','Warfarin (Coumadin®)');
	canvasMed.moveTo('09/13/2011','HCTZ (Esidrex/Oretic)');
	canvasMed.lineTo('09/16/2011 12:00:00 PM','HCTZ (Esidrex/Oretic)');
	canvasMed.moveTo('09/13/2011','Lisinopril (Prinivil/Zestril)');
	canvasMed.lineTo('09/16/2011 12:00:00 PM','Lisinopril (Prinivil/Zestril)');*/
	
	/*	canvasMed.lineStyle(3,0x4A4A49,1,true,LineScaleMode.NORMAL,CapsStyle.SQUARE,JointStyle.MITER,2);
	canvasMed.moveTo('09/13/2011','Jiang Ya Pian');
	canvasMed.lineTo('09/19/2011 12:00:00 PM','Jiang Ya Pian');
	canvasMed.moveTo('09/13/2011','Herbal Medicines');
	canvasMed.lineTo('09/19/2011 12:00:00 PM','Herbal Medicines');
	canvasMed.lineStyle(1,0x4D4D4D,1,true,LineScaleMode.NORMAL,CapsStyle.SQUARE,JointStyle.MITER,2);
	canvasMed.moveTo('09/13/2011','Jiang Ya Pian');
	canvasMed.lineTo('09/19/2011 12:00:00 PM','Jiang Ya Pian');	
	canvasMed.moveTo('09/13/2011','Herbal Medicines');
	canvasMed.lineTo('09/19/2011 12:00:00 PM','Herbal Medicines');*/
	controller.model.chartStyles.canvasMed.lineStyle(100,0x00ADEE,.2,true,LineScaleMode.NORMAL,CapsStyle.SQUARE,JointStyle.MITER,2);
	controller.model.chartStyles.canvasMed.moveTo('06/16/2012 12:00:00 PM','Prescription Drugs');
	controller.model.chartStyles.canvasMed.lineTo('06/16/2012 12:00:00 PM','Herbal Medicines');
}

public function medicationsSetMinMaxWidget():void {
	hAxisMedicationsWidget.minimum = minDateMedi;
	hAxisMedicationsWidget.maximum = maxDateMediWidget;
	controller.model.chartStyles.canvasMedWidget.lineStyle(75,0x00ADEE,.2,true,LineScaleMode.NORMAL,CapsStyle.SQUARE,JointStyle.MITER,2);
	controller.model.chartStyles.canvasMedWidget.moveTo('06/16/2012 12:00:00 PM','Lisinopril (Prinivil/Zestril)');
	controller.model.chartStyles.canvasMedWidget.lineTo('06/16/2012 12:00:00 PM','Jiang Ya Pian');
}

private function handleMedicationsDateRange(range:String):void {
	if(range == '1w') {
		minDateMedi = new Date( "Jun 13 2012 12:00:00 AM");
		maxDateMedi = new Date( "Jun 19 2012 12:00:00 PM");
		hAxisMedications.labelFunction = ChartLabelFunctions.lblHAxisPlotChartDay;
		controller.model.chartStyles.medicationsVerticalGridLine.alpha = 0;
		hAxisMedications.minorTickInterval = 12;
		hAxisMedications.minorTickUnits = "hours";
		btnMedi1m.selected = btnMedi3m.selected = btnMedi1y.selected = btnMedi3y.selected = btnMediAll.selected = btnMediCustom.selected = false;
	}
	else if(range == '1m') {
		minDateMedi = new Date("May 19 2012 12:00:00 PM");
		maxDateMedi = new Date("Jun 19 2012 12:00:00 PM");
		hAxisMedications.labelFunction = ChartLabelFunctions.lblHAxisPlotChartDay;
		controller.model.chartStyles.medicationsVerticalGridLine.alpha = 0;
		hAxisMedications.minorTickInterval = 1;
		hAxisMedications.minorTickUnits = "days";
		btnMedi1w.selected = btnMedi3m.selected = btnMedi1y.selected = btnMedi3y.selected = btnMediAll.selected = btnMediCustom.selected = false;
	}
	else if(range == '3m') {
		minDateMedi = new Date( "Mar 19 2012 12:00:00 PM");
		maxDateMedi = new Date( "Jun 19 2012 12:00:00 PM");
		hAxisMedications.labelFunction = ChartLabelFunctions.lblHAxisPlotChartMonth;
		controller.model.chartStyles.medicationsVerticalGridLine.alpha = 0;
		hAxisMedications.minorTickInterval = 1;
		hAxisMedications.minorTickUnits = "days";
		btnMedi1w.selected = btnMedi1m.selected = btnMedi1y.selected = btnMedi3y.selected = btnMediAll.selected = btnMediCustom.selected = false;
	}
	else if(range == '1y') {
		minDateMedi = new Date( "Aug 20 2011 12:00:00 PM");
		maxDateMedi = new Date( "Aug 20 2012 12:00:00 PM");
		hAxisMedications.labelFunction = ChartLabelFunctions.lblHAxisPlotChartMonth;
		controller.model.chartStyles.medicationsVerticalGridLine.alpha = 0;
		hAxisMedications.minorTickInterval = NaN;
		hAxisMedications.minorTickUnits = "years";
		btnMedi1w.selected = btnMedi1m.selected = btnMedi3m.selected = btnMedi3y.selected = btnMediAll.selected = btnMediCustom.selected = false;
	}
	else if(range == '3y') {
		minDateMedi = new Date( "Aug 20 2009 12:00:00 PM");
		maxDateMedi = new Date( "Aug 20 2012 12:00:00 PM");
		hAxisMedications.labelFunction = ChartLabelFunctions.lblHAxisPlotChartYear;
		controller.model.chartStyles.medicationsVerticalGridLine.alpha = 0.3;
		hAxisMedications.minorTickInterval = 1;
		hAxisMedications.minorTickUnits = "months";
		btnMedi1w.selected = btnMedi1m.selected = btnMedi3m.selected = btnMedi1y.selected = btnMediAll.selected = btnMediCustom.selected = false;
	}
	else if(range == 'all') {
		minDateMedi = new Date( "Aug 20 2009 12:00:00 PM");
		maxDateMedi = new Date( "Aug 20 2012 12:00:00 PM");
		hAxisMedications.labelFunction = ChartLabelFunctions.lblHAxisPlotChartYear;
		controller.model.chartStyles.medicationsVerticalGridLine.alpha = 0.3;
		hAxisMedications.minorTickInterval = 1;
		hAxisMedications.minorTickUnits = "months";
		btnMedi1w.selected = btnMedi1m.selected = btnMedi3m.selected = btnMedi1y.selected = btnMedi3y.selected = btnMediCustom.selected = false;
	}
	hAxisMedications.minimum = minDateMedi;
	hAxisMedications.maximum = maxDateMedi;
	
	/*for(var i:uint = 0; i < immunizationsCategories.length; i++) {
	var minDatePlus1:Date = minDate;
	minDatePlus1.setDate(minDate.getDate() + 1);
	canvas.moveTo(this.dateFormatterToday.format(minDatePlus1),this.immunizationsCategories[i]);
	canvas.lineTo(this.dateFormatterToday.format(maxDate),this.immunizationsCategories[i]);
	}*/
}

private function lblMedicationsNameDose(item:Object, column:DataGridColumn):String {
	return item.dose != '' ? item.name + ' - ' + item.dose : item.name;
}

private function addMedication():void {
	//uncomment>> PopUpManager.removePopUp(myChartPopup);		//remove existing popup (if any).
	var myAddMedication1:myAddMedication1Window = myAddMedication1Window(PopUpManager.createPopUp(this, myAddMedication1Window) as spark.components.TitleWindow);
	PopUpManager.centerPopUp(myAddMedication1);
}

public function centerPopup(popup:myAddMedication2Window):void {
	PopUpManager.centerPopUp(popup);
}

private function searchFilterMedications():void {
	switchMedicationsView(1);
	viewStackMedications.selectedIndex = 0;
	medicationsDataFiltered.filterFunction = filterSearchMedications;
	medicationsDataFiltered.refresh();
	
	if(medicationsDataFiltered.length == 0) {
		//plotMedications.visible = plotMedications.includeInLayout = legendMedications.visible = legendMedications.includeInLayout = medicationsDGHeader.visible = medicationsDGHeader.includeInLayout = medicationsDGLine.visible = medicationsDGLine.includeInLayout = medicationsList.visible = medicationsList.includeInLayout = false;
		medicationsList.visible = medicationsList.includeInLayout = false;
		//lblNoMedicalRecords1.visible = lblNoMedicalRecords1.includeInLayout = lblNoMedicalRecords2.visible = lblNoMedicalRecords2.includeInLayout = true;
		lblNoMedications.visible = lblNoMedications.includeInLayout = true;
	}
	else {
		//plotMedications.visible = plotMedications.includeInLayout = legendMedications.visible = legendMedications.includeInLayout = medicationsDGHeader.visible = medicationsDGHeader.includeInLayout = medicationsDGLine.visible = medicationsDGLine.includeInLayout = medicationsList.visible = medicationsList.includeInLayout = true;
		medicationsList.visible = medicationsList.includeInLayout = true;
		//lblNoMedicalRecords1.visible = lblNoMedicalRecords1.includeInLayout = lblNoMedicalRecords2.visible = lblNoMedicalRecords2.includeInLayout = false;
		lblNoMedications.visible = lblNoMedications.includeInLayout = false;
	}
	
	/*	if(medicationsSearch.text != "") {
	hgSearchMedications.visible = hgSearchMedications.includeInLayout = true;
	lblSearchResultsMedications.text = 'Search Results: "' + medicationsSearch.text + '"';
	}
	else hgSearchMedications.visible = hgSearchMedications.includeInLayout = false;*/
}

private function filterSearchMedications(item:Object):Boolean {
	var pattern:RegExp = new RegExp("[^]*"+medicationsSearch.text+"[^]*", "i");
	return pattern.test(item.name) || pattern.test(item.dose) || pattern.test(item.type) || pattern.test(item.prescription) || pattern.test(item.directions) || pattern.test(item.pharmacy) || pattern.test(item.lastFilledDate);
}

private function clearSearchMedications():void {
	medicationsSearch.text = 'Search medications';
	medicationsDataFiltered.filterFunction = null;
	medicationsDataFiltered.refresh();
	//hgSearchMedications.visible = hgSearchMedications.includeInLayout = false;
	medicationsList.visible = medicationsList.includeInLayout = true;
	lblNoMedications.visible = lblNoMedications.includeInLayout = false;
}

/*private function mediFilterStatus():void {
if(dropMediFilter.selectedIndex == 0) {
for(var i:uint = 0; i < medicationsData.length; i++) {
if(medicationsData[i].status == "inactive") {
medicationsData.removeItemAt(i);
i--;
}
}
}
else {
medicationsData = ObjectUtil.copy(medicationsDataOriginal) as ArrayCollection;
}

//The following is done so that once we check the "Required Only" box, not only we hide the "not required points", but also remove the entire "row" or "category" for the non-required immunization. Therefore, we reset immunizationsCategories.
medicationsDataFiltered = new ArrayCollection(); //this is set here so when the module is re-opened, it won't be duplicated...
medicationsCategories = new Array();		//this is set to a new Array here, so that it is reset not only when the graph is first drawn, but also when the "Required only" checkbox is UNCHECKED, so the categories for the Y axis are re-calculated.
for(var j:uint = 0; j < medicationsData.length; j++) {
if(medicationsCategories.indexOf(medicationsData[j].name) == -1) {
medicationsCategories.push(medicationsData[j].name);
if(medicationsData[j].name != "Prescription Drugs" && medicationsData[j].name != "Over-The-Counter Drugs" && medicationsData[j].name != "Supplements" && medicationsData[j].name != "Herbal Medicines") medicationsDataFiltered.addItem(medicationsData[j]);
}
}

medicationsDataFiltered.source.reverse();	//so the order in the datagrid is the same as in the chart.

plotMedications.height= medicationsCategories.length * 34 + 29;
}*/

private function filterMedsFromStatus():void {
	medicationsData.filterFunction = filterMedications;
	medicationsData.refresh();
	
	medicationsDataFiltered = new ArrayCollection(); //this is set here so when the module is re-opened, it won't be duplicated...
	medicationsCategories = new Array();
	for(var j:uint = 0; j < medicationsData.length; j++) {
		if(medicationsCategories.indexOf(medicationsData[j].name) == -1) {
			medicationsCategories.push(medicationsData[j].name);
			if(medicationsData[j].name != "Prescription Drugs" && medicationsData[j].name != "Over-The-Counter Drugs" && medicationsData[j].name != "Supplements" && medicationsData[j].name != "Herbal Medicines") medicationsDataFiltered.addItem(medicationsData[j]);
		}
	}
	
	medicationsDataFiltered.source.reverse();	//so the order in the datagrid is the same as in the chart.
	
	updateMedsHeightAndColors();
	medicationsCategoriesForTree();		//this line was added after this whole script was written, when we found that bug regarding inactive medications... Its purpose is to update the tree so that it is consistent with what's on the graph. On load, it forces the tree to show ONLY "active" medications. This line needs to be here so it runs AFTER the filter is executed. Paradogically, it also needs to stay before the filter (see above), because the filter looks for what's open in the tree...
}

private function filterMedsFromWidget():void {
	medicationsData.filterFunction = filterMedicationsWidget;
	medicationsData.refresh();
	
	medicationsCategories = new Array();
	for(var j:uint = 0; j < medicationsData.length; j++) {
		if(medicationsCategories.indexOf(medicationsData[j].name) == -1) {
			medicationsCategories.push(medicationsData[j].name);
		}
	}
}

/*
private function filterMedsFromTree():void {
var myOpenLeaves:Array = new Array();
var arrMedCategories:Array = new Array("Prescription Drugs","Over-The-Counter Drugs","Supplements","Herbal Medicines");
var myOpenCategories:Array = new Array();
for(var i:uint = 0; i < myTree.openItems.length; i++) {
myOpenCategories.push(myTree.openItems[i].category);
}

var count:uint = 0;
for(var x:uint = 0; x < arrMedCategories.length; x++) {
myOpenLeaves.push(arrMedCategories[x]);
if(myOpenCategories.indexOf(arrMedCategories[x]) == -1) {
//myOpenLeaves.push(arrMedCategories[x]);
count--;
}
else {
//myOpenLeaves.push(myTree.openItems[count].category);
for(var j:uint = 0; j < myTree.openItems[count].children.length; j++) {
myOpenLeaves.push(myTree.openItems[count].children[j].category);
}
}
count++;
}

//for(var i:uint = 0; i < myTree.openItems.length; i++) {
//	myOpenLeaves.push(myTree.openItems[i].category);
//	for(var j:uint = 0; j < myTree.openItems[i].children.length; j++) {
//		myOpenLeaves.push(myTree.openItems[i].children[j].category);
//	}
//}

for(var k:uint = 0; k < medicationsData.length; k++) {
if(myOpenLeaves.indexOf(medicationsData[k].name) == -1) {
medicationsData.removeItemAt(k);
k--;
}
}

medicationsCategories = new Array();
for(var l:uint = 0; l < medicationsData.length; l++) {
if(medicationsCategories.indexOf(medicationsData[l].name) == -1) medicationsCategories.push(medicationsData[l].name);
}

plotMedications.height= medicationsCategories.length * 34 + 29;

//mediFilterStatus();	//we run the filter now, since we want to display only "active" medications when we load the module...
}
*/
private function filterMedsFromTreeNew():void {
	medicationsData.filterFunction = filterMedications2;
	medicationsData.refresh();
	
	medicationsCategories = new Array();
	for(var l:uint = 0; l < medicationsData.length; l++) {
		if(medicationsCategories.indexOf(medicationsData[l].name) == -1) medicationsCategories.push(medicationsData[l].name);
	}
	
	updateMedsHeightAndColors();
}

public function updateMedsHeightAndColors():void {
	plotMedications.height= medicationsCategories.length * 34 + 29;
	myTree.rowCount = medicationsCategories.length;
	
	myHorizontalAlternateFill = medicationsCategories.length % 2 == 1 ? 0x303030 : 0x4A4A49;
	myHorizontalFill = medicationsCategories.length % 2 == 1 ? 0x4A4A49 : 0x303030;
}

//(this filterFunction was modified to avoid the conflict I was having when changing the status (active/all) and some of the nodes were previously hidden because they were inactive categories... (when going back go "active" they wouldn't show up because of the myOpenLeaves.indexOf(item.name) != -1 criteria...
//the original function was left untouched (see below filterMedications2), but it's only used when updating filterMedsFromTreeNew()...
private function filterMedications(item:Object):Boolean {
	var myOpenLeaves:Array = new Array();
	var arrMedCategories:Array = new Array("Prescription Drugs","Over-The-Counter Drugs","Supplements","Herbal Medicines");
	var myOpenCategories:Array = new Array();
	for(var i:uint = 0; i < myTree.openItems.length; i++) {
		myOpenCategories.push(myTree.openItems[i].category);
	}
	
	var count:uint = 0;
	for(var x:uint = 0; x < arrMedCategories.length; x++) {
		myOpenLeaves.push(arrMedCategories[x]);
		if(myOpenCategories.indexOf(arrMedCategories[x]) == -1) {
			//myOpenLeaves.push(arrMedCategories[x]);
			count--;
		}
		else {
			//myOpenLeaves.push(myTree.openItems[count].category);
			for(var j:uint = 0; j < myTree.openItems[count].children.length; j++) {
				myOpenLeaves.push(myTree.openItems[count].children[j].category);
			}
		}
		count++;
	}
	
	//return dropMediFilter.selectedIndex == 0 ? myOpenLeaves.indexOf(item.name) != -1 && item.status != "inactive" : myOpenLeaves.indexOf(item.name) != -1;
	return dropMediFilter.selectedIndex == 0 ? item.status != "inactive" : true;
	
	//var pattern:RegExp = new RegExp("[^]*"+medicationsSearch.text+"[^]*", "i");
	//return pattern.test(item.name) || pattern.test(item.dose) || pattern.test(item.type) || pattern.test(item.prescription) || pattern.test(item.directions) || pattern.test(item.pharmacy) || pattern.test(item.lastFilledDate);
}

//(this is the original filterFunction)
private function filterMedications2(item:Object):Boolean {
	var myOpenLeaves:Array = new Array();
	var arrMedCategories:Array = new Array("Prescription Drugs","Over-The-Counter Drugs","Supplements","Herbal Medicines");
	var myOpenCategories:Array = new Array();
	for(var i:uint = 0; i < myTree.openItems.length; i++) {
		myOpenCategories.push(myTree.openItems[i].category);
	}
	
	var count:uint = 0;
	for(var x:uint = 0; x < arrMedCategories.length; x++) {
		myOpenLeaves.push(arrMedCategories[x]);
		if(myOpenCategories.indexOf(arrMedCategories[x]) == -1) {
			//myOpenLeaves.push(arrMedCategories[x]);
			count--;
		}
		else {
			//myOpenLeaves.push(myTree.openItems[count].category);
			for(var j:uint = 0; j < myTree.openItems[count].children.length; j++) {
				myOpenLeaves.push(myTree.openItems[count].children[j].category);
			}
		}
		count++;
	}
	
	return dropMediFilter.selectedIndex == 0 ? myOpenLeaves.indexOf(item.name) != -1 && item.status != "inactive" : myOpenLeaves.indexOf(item.name) != -1;
	//return dropMediFilter.selectedIndex == 0 ? item.status != "inactive" : true;
}

private function filterMedicationsWidget(item:Object):Boolean {
	return item.status != "inactive" && item.name != "Prescription Drugs" && item.name != "Over-The-Counter Drugs" && item.name != "Supplements" && item.name != "Herbal Medicines";
}

/*
private function mediFilterStatus():void {
if(dropMediFilter.selectedIndex == 0) {
for(var i:uint = 0; i < medicationsData.length; i++) {
if(medicationsData[i].status == "inactive") {
medicationsData.removeItemAt(i);
i--;
}
}

//The following is done so that once we check the "Required Only" box, not only we hide the "not required points", but also remove the entire "row" or "category" for the non-required immunization. Therefore, we reset immunizationsCategories.
medicationsCategories = new Array();
medicationsDataFiltered = new ArrayCollection(); //this is set here so when the module is re-opened, it won't be duplicated...
for(var j:uint = 0; j < medicationsData.length; j++) {
if(medicationsCategories.indexOf(medicationsData[j].name) == -1) {
medicationsCategories.push(medicationsData[j].name);
if(medicationsData[j].name != "Prescription Drugs" && medicationsData[j].name != "Over-The-Counter Drugs" && medicationsData[j].name != "Supplements" && medicationsData[j].name != "Herbal Medicines") medicationsDataFiltered.addItem(medicationsData[j]);
}
}
medicationsDataFiltered.source.reverse();	//so the order in the datagrid is the same as in the chart.	
}
else {
medicationsXMLdata.send();
}
}
*/

public function getLabelDataTipMedications(name:String):String {
	for(var i:uint = 0; i < medicationsData.length; i++) {
		if(medicationsData[i].name == name) return medicationsData[i].description;
	}
	return '';
}

private function lblVAxisMedNull(item:Object, prevValue:Object, axis:CategoryAxis, categoryItem:Object):String {
	return "         ";		//this is quick (and efficient) fix to being able to display the axis renderer (WITH THE LONG MINOR TICKS) in the appropriate place without messing up the horizontal placement (witohut this the chart looks messed up because there would be no labels which means the labels for the x-axis start more to the right, which mess up the chart...)
}