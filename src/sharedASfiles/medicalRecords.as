import mx.utils.ObjectProxy;
import mx.utils.ObjectUtil;

[Bindable] private var myMedRecHorizontalAlternateFill:uint = 0x303030;
[Bindable] private var myMedRecHorizontalFill:uint = 0x4A4A49;

public var wasMedicalRecordsDataLoaded:Boolean = false;
[Bindable] public var medicalRecordsData:ArrayCollection = new ArrayCollection();
[Bindable] public var medicalRecordsDataGrid:ArrayCollection = new ArrayCollection();
[Bindable] private var medicalRecordsCategories:Array; //new Array("Yellow Fever", "Tetanus & Diphteria", "Polio", "Influenza", "Hepatitis A");
[Bindable] public var medicalRecordsNextSteps:ArrayCollection;
private function medicalRecordsResultHandler(event:ResultEvent):void {
	/*if(event.result.autnresponse.responsedata.clusters.cluster is ObjectProxy ) {
	= new ArrayCollection( [event.result.autnresponse.responsedata.clusters.cluster] );
	}
	else {*/
	//clusterData = event.result.autnresponse.responsedata.clusters.cluster;	
	//}
	medicalRecordsData = event.result.medicalRecords.medicalRecord;
	medicalRecordsDataGrid = ObjectUtil.copy(medicalRecordsData) as ArrayCollection;
	medicalRecordsCategories = new Array();		//this is set to a new Array here, so that it is reset not only when the graph is first drawn, but also when the "Required only" checkbox is UNCHECKED, so the categories for the Y axis are re-calculated.
	medicalRecordsNextSteps = new ArrayCollection();
	for(var i:uint = 0; i < medicalRecordsData.length; i++) {
		if(medicalRecordsCategories.indexOf(medicalRecordsData[i].name) == -1) medicalRecordsCategories.push(medicalRecordsData[i].name);
		
		if(medicalRecordsData[i].nextSteps is ArrayCollection) {
			for(var j:uint = 0; j < medicalRecordsData[i].nextSteps.length; j++) {
				medicalRecordsData[i].nextSteps[j].provider = medicalRecordsData[i].provider;		//should I do the same thing with "date", so there wouldn't be a need to create a duplicate? element under <medicalRecord>?
				medicalRecordsNextSteps.addItem(medicalRecordsData[i].nextSteps[j]);
			}
		}
		else if(medicalRecordsData[i].nextSteps is ObjectProxy) {
			medicalRecordsData[i].nextSteps.provider = medicalRecordsData[i].provider;
			medicalRecordsNextSteps.addItem(medicalRecordsData[i].nextSteps);
		}
	}
	calculateServiceUsage();
	
	medicalRecordsCategoriesForTree();
	
	updateMedRecHeightAndColors();
	
	wasMedicalRecordsDataLoaded = true;
}

[Bindable] public var medicalRecordsCategoriesTree:ArrayCollection = new ArrayCollection([
	{category: "Visits", children: []},
	{category: "Diagnostic Studies", children: []},
	{category: "Surgeries"},
	{category: "Procedures"}
]);
private function medicalRecordsCategoriesForTree():void {
	var medicalRecordsCategoriesReversed:Array = unique(medicalRecordsCategories).reverse();
	var currentCategory:int = -1;
	var currentLeaf:uint = 0;
	for(var i:uint = 0; i < medicalRecordsCategoriesReversed.length; i++) {
		if(medicalRecordsCategoriesReversed[i] == "Visits" || medicalRecordsCategoriesReversed[i] == "Diagnostic Studies" || medicalRecordsCategoriesReversed[i] == "Surgeries" || medicalRecordsCategoriesReversed[i] == "Procedures") {
			currentCategory++;
			currentLeaf = 0;
		}
		else {
			var newLeaf:Object = new Object();
			newLeaf = ({category: medicalRecordsCategoriesReversed[i]});
			medicalRecordsCategoriesTree[currentCategory].children[currentLeaf] = newLeaf;
			currentLeaf++;
		}
	}
	
	//setting openItems = the first two only (instead of all 4 categories), because if we have the 4 categories "open", then we have a conflict with the filter (this is done so we could have "Surgeries" and "Procedures" as branches, without children, without the "open/close" arrows)
	var myTreeMedRecOpenItem:ArrayCollection = new ArrayCollection();
	myTreeMedRecOpenItem.addItem(medicalRecordsCategoriesTree[0]);
	myTreeMedRecOpenItem.addItem(medicalRecordsCategoriesTree[1]);	
	myTreeMedRec.openItems = myTreeMedRecOpenItem;
	
	myTreeMedRec.rowCount = medicalRecordsCategories.length;
}

public function updateMedRecHeightAndColors():void {
	plotMedicalRecords.height= medicalRecordsCategories.length * 28 + 24;
	myTreeMedRec.rowCount = medicalRecordsCategories.length;
	
	myMedRecHorizontalAlternateFill = medicalRecordsCategories.length % 2 == 1 ? 0x303030 : 0x4A4A49;
	myMedRecHorizontalFill = medicalRecordsCategories.length % 2 == 1 ? 0x4A4A49 : 0x303030;
}

private function calculateServiceUsage():void {
	var countOutpatient:uint = 0;
	var countDiagnostic:uint = 0;
	for(var i:uint = 0; i < medicalRecordsData.source.length; i++) {
		if(medicalRecordsData[i].classification == "Outpatient") countOutpatient++;
		if(medicalRecordsData[i].name == "Radiology" || medicalRecordsData[i].name == "Labs" || medicalRecordsData[i].name == "Clinical Tests") countDiagnostic++;
	}
	
	lblMedRecOutpatient.text = String(countOutpatient);
	lblMedRecDiagnostic.text = String(countDiagnostic);
}

private function lblHAxisPlotChartDay(cat:Object, pcat:Object, ax:DateTimeAxis):String {
	return dateFormatterDay.format(new Date(cat.fullYear, cat.month, cat.dateUTC));				
}
private function lblHAxisPlotChartMonth(cat:Object, pcat:Object, ax:DateTimeAxis):String {
	return dateFormatter.format(new Date(cat.fullYear, cat.month + 1, cat.dateUTC));				
}
private function lblHAxisPlotChartYear(cat:Object, pcat:Object, ax:DateTimeAxis):String {
	return dateFormatterYear.format(new Date(cat.fullYear, cat.month + 1, cat.dateUTC));				
}
public function lblHAxisPlotChartDayOnly(cat:Object, pcat:Object, ax:DateTimeAxis):String {
	return dateFormatterDayOnly.format(new Date(cat.fullYear, cat.month, cat.dateUTC));				
}