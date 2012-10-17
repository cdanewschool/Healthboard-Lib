public var wasImmunizationDataLoaded:Boolean = false;
[Bindable] public var immunizationsData:ArrayCollection = new ArrayCollection();			//data provider for the Plot Chart
[Bindable] public var immunizationsDataFiltered:ArrayCollection;							//data provider for the Data Grid
[Bindable] private var immunizationsCategories:Array; //new Array("Yellow Fever", "Tetanus & Diphteria", "Polio", "Influenza", "Hepatitis A");
private function immunizationsResultHandler(event:ResultEvent):void {
	/*if(event.result.autnresponse.responsedata.clusters.cluster is ObjectProxy ) {
	= new ArrayCollection( [event.result.autnresponse.responsedata.clusters.cluster] );
	}
	else {*/
	//clusterData = event.result.autnresponse.responsedata.clusters.cluster;	
	//}
	immunizationsData = event.result.immunizations.immunization;
	immunizationsDataFiltered = new ArrayCollection();
	immunizationsCategories = new Array();		//this is set to a new Array here, so that it is reset not only when the graph is first drawn, but also when the "Required only" checkbox is UNCHECKED, so the categories for the Y axis are re-calculated.
	for(var i:uint = 0; i < immunizationsData.length; i++) {
		if(immunizationsCategories.indexOf(immunizationsData[i].name) == -1) {
			immunizationsCategories.push(immunizationsData[i].name);
			immunizationsDataFiltered.addItem(immunizationsData[i]);
		}
	}
	immunizationsDataFiltered.source.reverse();	//so the order in the datagrid is the same as in the chart.
	getImmunizationsDueNumber();
	wasImmunizationDataLoaded = true;
}

/* This is used to get the number to be displayed at the top of the module */
[Bindable] private var immunizationsDueNumber:uint = 0;
private function getImmunizationsDueNumber():void {
	var count:uint = 0;
	for(var i:uint = 0; i < immunizationsData.source.length; i++) {
		var immunizationDate:Date = new Date(immunizationsData[i].date.substr(6),immunizationsData[i].date.substr(0,2)-1,immunizationsData[i].date.substr(3,2));
		var todayWithTime:Date = new Date();
		var today:Date = new Date(todayWithTime.getFullYear(),todayWithTime.getMonth(),todayWithTime.getDate());
		
		if(immunizationsData[i].completed != true) {
			if(immunizationDate.getTime() < today.getTime()) {
				count++;
			}
			else if(immunizationDate.getTime() > today.getTime()) {
				count++;
			}
		}
	}
	immunizationsDueNumber = count;
}