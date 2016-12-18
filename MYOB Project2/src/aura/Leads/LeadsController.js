({
    doInit: function(component) {
        alert("In Leads");
        var User = component.get("c.getLeads");
        User.setCallback(this, function(a) {
            var UserData = a.getReturnValue();
            component.set("v.leads", UserData);  
        });
        $A.enqueueAction(User);
        
    },
    
    AllLeadsStatement : function (component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/allleads"
        });
        urlEvent.fire();
    }/*,
    
    goToURL : function (component, event, helper) {
        var recordId = event.target.value;
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordId,
            "slideDevName": "chatter"
        });
        navEvt.fire();
    },
    
    LeadDetail : function (component, event, helper) {
        var recordId = event.target.value;
        var address = "/lead/"+recordId;
        //var address = '/error/'+recordId;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url" : "/lead/:recordId"
        });
        urlEvent.fire();	
    }*/
})