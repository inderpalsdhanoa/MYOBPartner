({
    doInit: function(component) {

        var Currentpage = 0;
        var pageSize = component.get("v.pageSize");
        var Account = component.get("c.RetrieveLeadPagination");
        var SortFieldOrder = component.get("v.SortFieldOrder");
        Account.setParams({pagesize : pageSize, pagenumber : Currentpage, SortFieldOrder : SortFieldOrder});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.leads", AccountData);
            Currentpage=Currentpage+1;
            component.set("v.Currentpage",Currentpage);
        });
        $A.enqueueAction(Account);
        var User = component.get("c.RetrieveLeadTotalRecord");
        var pagesize = component.get("v.pageSize");
        User.setCallback(this, function(a) {
            var UserData = a.getReturnValue();
            component.set("v.TotalRecords", UserData);
            var Totalpages = Math.ceil(UserData/pagesize);
            component.set("v.Totalpages", Totalpages);
            component.set("v.prev",true);
            if(UserData <= pageSize){
                component.set("v.next",true);
            }
        });
        $A.enqueueAction(User);
        
        var action = component.get("c.getPartner");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.PartnerDetails", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    Next:function(component, event, helper){
        var next = true;
        var prev = false;
        component.set("v.prev",false);
        var Currentpage = component.get("v.Currentpage");        
        var pageSize = component.get("v.pageSize"); 
        var Totalpages = component.get("v.Totalpages");
        var SortFieldOrder = component.get("v.SortFieldOrder");
        if(Currentpage >= Totalpages){
            Currentpage=Currentpage-1;
        }
        var Account = component.get("c.RetrieveLeadPagination");        
        Account.setParams({pagesize : pageSize, pagenumber : Currentpage, SortFieldOrder : SortFieldOrder});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.leads", AccountData);
            Currentpage=Currentpage+1;
            if(Currentpage >= Totalpages){
                Currentpage = Totalpages;
                component.set("v.Currentpage", Totalpages);
                component.set("v.next",true);
            }
            component.set("v.Currentpage",Currentpage);
        });
        $A.enqueueAction(Account);
    },
    
    Previous:function(component, event, helper){
        var next = false;
        var prev = true;
        component.set("v.next",false);
        var pageSize = component.get("v.pageSize"); 
        var Currentpage = component.get("v.Currentpage"); 
        Currentpage=Currentpage-2;
        if(Currentpage <= 0){
            Currentpage = 0;
            component.set("v.Currentpage", 0);
            component.set("v.prev",true);
        }
        var SortFieldOrder = component.get("v.SortFieldOrder");
        var Account = component.get("c.RetrieveLeadPagination");
        Account.setParams({pagesize : pageSize, pagenumber : Currentpage, SortFieldOrder : SortFieldOrder});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.leads", AccountData);
            Currentpage=Currentpage+1;
            component.set("v.Currentpage",Currentpage);
        });
        $A.enqueueAction(Account);
    },
    
    LastPage:function(component, event, helper){
        var next = false;
        var prev = true;
        component.set("v.next",true);
        component.set("v.prev",false);
        var Totalpages = component.get("v.Totalpages"); 
        var pageSize = component.get("v.pageSize"); 
        var SortFieldOrder = component.get("v.SortFieldOrder");
		var Account = component.get("c.RetrieveLeadPagination");
        Account.setParams({pagesize : pageSize, pagenumber : Totalpages-1, SortFieldOrder : SortFieldOrder});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.leads", AccountData);
            component.set("v.Currentpage",Totalpages);
        });
        $A.enqueueAction(Account);
    },
    
    FirstPage:function(component, event, helper){
        var next = false;
        var prev = true;
        component.set("v.next",false);
        component.set("v.prev",true);
        var Currentpage = 0; 
        var pageSize = component.get("v.pageSize"); 
        var SortFieldOrder = component.get("v.SortFieldOrder");
        var Account = component.get("c.RetrieveLeadPagination");
        Account.setParams({pagesize : pageSize, pagenumber : Currentpage, SortFieldOrder : SortFieldOrder});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.leads", AccountData);
            component.set("v.Currentpage",1);            
        });
        $A.enqueueAction(Account);
    },
    
    LeadSort : function (component, event, helper) {
        var FieldName1 ='';
        var ButtonID = event.getSource().getLocalId();
        component.set("v.SortFieldOrder", ButtonID);
        var pageSize = component.get("v.pageSize");
        var next = false;
        var prev = true;
        component.set("v.next",false);
        component.set("v.prev",true);
        var Currentpage = 0;
        var Account1 = component.get("c.RetrieveLeadPagination");
        Account1.setParams({pagesize : pageSize, pagenumber : Currentpage, SortFieldOrder : ButtonID});
        Account1.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.leads", AccountData);
            component.set("v.Currentpage",1);            
        
        /*var Account1 = component.get("c.SortLeads");
        Account1.setParams({FieldName : ButtonID});  
        Account1.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.leads", AccountData);
            component.set("v.SortFieldOrder", ButtonID);*/
        });
        $A.enqueueAction(Account1);
    }
})