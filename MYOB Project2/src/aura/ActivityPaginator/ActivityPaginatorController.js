({
	previousPage : function(component, event, helper) {
        var myEvent = $A.get("e.ManPackInderpal:HousePageChange");
        myEvent.setParams({ "direction": "previous"});
        myEvent.fire();
	},
	nextPage : function(component, event, helper) {
        var myEvent = $A.get("e.ManPackInderpal:HousePageChange");
        myEvent.setParams({ "direction": "next"});
        myEvent.fire();
	},
    
    // Could do with 1 instead of 2
    pageChange: function(component, event, helper) {
        var page = component.get("v.page") || 1;
        var direction = event.getParam("direction");
        page = direction === "previous" ? (page - 1) : (page + 1);
        //helper.getsObjectRecords(component,page);
    }
})