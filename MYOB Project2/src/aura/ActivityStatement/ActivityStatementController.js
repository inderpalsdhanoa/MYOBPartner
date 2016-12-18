({
    doInit : function(component, event, helper) {
        alert("In Actv Stmnt");
        var Account = component.get("c.getAccounts");
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.accounts", AccountData);
        });
        $A.enqueueAction(Account);
        
    },
    
    AllActvStmnt : function (component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/allactivitystatements"
        });
        urlEvent.fire();
    },
    
    AccntSort : function (component, event, helper) {
        var FieldName1 ='';
        var ButtonID = event.getSource().getLocalId();
        
        if(ButtonID=='DateAsc'){
            FieldName1 = 'LP_Activity_Date__c ASC';
        } else if(ButtonID=='DateDsc'){          
            FieldName1 = 'LP_Activity_Date__c DESC'; 
        } else if(ButtonID=='CategorygAsc'){
            FieldName1 = 'LP_Points_Category__c ASC';
        } else if(ButtonID=='CategoryDsc'){
            FieldName1 = 'LP_Points_Category__c DESC';  
        } else if(ButtonID=='ActivityAsc'){
            FieldName1 = 'LP_Activity__c ASC';  
        } else if(ButtonID=='ActivityDsc'){
            FieldName1 = 'LP_Activity__c DESC';  
        } else if(ButtonID=='PointsAsc'){
            FieldName1 = 'LP_Points__c ASC';
        } else {
          FieldName1 = 'LP_Points__c DESC';  
        }
        var Account1 = component.get("c.SortAccounts");
        Account1.setParams({FieldName : FieldName1});  
        Account1.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.accounts", AccountData);
        });
        $A.enqueueAction(Account1);
    }
})