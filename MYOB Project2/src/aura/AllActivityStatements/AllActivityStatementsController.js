({
    doInit : function(component, event, helper) {
        
        var Currentpage = 0; 
        var pageSize = component.get("v.pageSize");
        var FilterCategory = component.find("levels").get("v.value");
        var FilterStartDate = component.find("StartDate").get("v.value");
        var FilterEndDate = component.find("EndDate").get("v.value");
        var Account = component.get("c.RetrieveAcccountPagination");
        Account.setParams({pagesize : pageSize, pagenumber : Currentpage, StartDate : FilterStartDate, EndDate : FilterEndDate, category : FilterCategory});     
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.accounts", AccountData);
            Currentpage=Currentpage+1;
            component.set("v.Currentpage",Currentpage);
            
        });
        $A.enqueueAction(Account);
        
        var action = component.get("c.getPartner");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.PartnerDetails", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
        var Account = component.get("c.getCategoryType");
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.AllCategory", AccountData);
        });
        $A.enqueueAction(Account);
        
        var Account = component.get("c.RetrieveAcccountTotalRecord");
        Account.setParams({StartDate : FilterStartDate, EndDate : FilterEndDate, category : FilterCategory});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.TotalRecords", AccountData);
            component.set("v.Totalpages", Math.ceil(AccountData/pageSize));
            component.set("v.prev",true);
            if(AccountData <= pageSize){
                component.set("v.next",true);
            }
        });
        $A.enqueueAction(Account);       
    },
    
    onChangeCatergoryType : function(component, event, helper) { 
        
        var Currentpage = 0; 
        var pageSize = component.get("v.pageSize");
        var FilterCategory = component.find("levels").get("v.value");
        var FilterStartDate = component.find("StartDate").get("v.value");
        var FilterEndDate = component.find("EndDate").get("v.value");        
        var Account = component.get("c.getFilterResult");
        Account.setParams({Category : selectedCatg});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.accounts", AccountData);
        });
        $A.enqueueAction(Account);
        
        var FilterCount = component.get("c.getFilterCount");
        FilterCount.setParams({Category : selectedCatg});
        FilterCount.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.TotalRecords", AccountData);
            alert(AccountData);
        });
        $A.enqueueAction(FilterCount);
    },
    
    onChangeCatergoryTypePagination : function(component, event, helper) {
        
        component.set("v.prev",false);
        component.set("v.next",false);
        var Currentpage = 0; 
        var pageSize = component.get("v.pageSize");
        var FilterCategory = component.find("levels").get("v.value");
        var FilterStartDate = component.find("StartDate").get("v.value");
        var FilterEndDate = component.find("EndDate").get("v.value");
        var Account = component.get("c.RetrieveAcccountPagination");
        Account.setParams({pagesize : pageSize, pagenumber : Currentpage, StartDate : FilterStartDate, EndDate : FilterEndDate, category : FilterCategory});     
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.accounts", AccountData);
        });
        $A.enqueueAction(Account);
        
        var Account = component.get("c.RetrieveAcccountTotalRecord");
        Account.setParams({StartDate : FilterStartDate, EndDate : FilterEndDate, category : FilterCategory});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.TotalRecords", AccountData);
            var totPages = Math.ceil(AccountData/pageSize);
            component.set("v.Totalpages", totPages);
            if(AccountData <= pageSize){
                component.set("v.prev",true);
                component.set("v.next",true);
            }
        });
        $A.enqueueAction(Account);          
    },
    
    onChangeMonth : function(component, event, helper) {
        var selectedCatg = component.find("levels").get("v.value");
        var selectedMonth = component.find("month").get("v.value");
        var Account = component.get("c.getFilterResult");
        Account.setParams({Category : selectedCatg, Month : selectedMonth});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.accounts", AccountData);
        });
        $A.enqueueAction(Account);
    },
    
    DateFilterPagination : function(component, event, helper) {
        var Currentpage = 0;
        var pageSize = component.get("v.pageSize");
        var FilterCategory = component.find("levels").get("v.value");
        var FilterStartDate = component.get("v.StartDate");
        var FilterEndDate = component.get("v.EndDate");
        if(FilterStartDate == '' || FilterStartDate == null && (FilterEndDate != null && FilterEndDate != '')){
            alert("Enter From");
        }else if(FilterEndDate == '' || FilterEndDate == null && (FilterStartDate != null && FilterStartDate != '')) {
            alert("Enter To");   
        }else if ((FilterEndDate == '' || FilterEndDate == null) && (FilterEndDate == '' || FilterEndDate == null)){
            alert ("Enter Both dates");
        } else if(FilterEndDate < FilterStartDate ){
            alert ("From less than To");
            component.set("v.StartDate", null);
            component.set("v.EndDate", null);
        } else {
            var Account = component.get("c.RetrieveAcccountPagination");
            Account.setParams({pagesize : pageSize, pagenumber : Currentpage, StartDate : FilterStartDate, EndDate : FilterEndDate, category : FilterCategory});     
            
            Account.setCallback(this, function(a) {
                var AccountData = a.getReturnValue();
                component.set("v.accounts", AccountData);
            });
            $A.enqueueAction(Account);
            var Account = component.get("c.RetrieveAcccountTotalRecord");
            Account.setParams({StartDate : FilterStartDate, EndDate : FilterEndDate, category : FilterCategory});
            Account.setCallback(this, function(a) {
                var AccountData = a.getReturnValue();
                component.set("v.TotalRecords", AccountData);
                var totPages = Math.ceil(AccountData/pageSize);
                component.set("v.Totalpages", totPages);
                if(AccountData <= pageSize){
                    component.set("v.prev",true);
                    component.set("v.next",true);
                }            
            });
            $A.enqueueAction(Account);          
        }
    },
    
    ResetFilter  : function(component, event, helper) {
        component.set("v.StartDate",null);
        component.set("v.EndDate",null);
        component.set("v.AllCategory", null);
        component.set("v.next", false);
        component.set("v.prev", false);
        var Currentpage = 0; 
        var pageSize = component.get("v.pageSize");
        var Account = component.get("c.RetrieveAcccountPagination");
        Account.setParams({pagesize : pageSize, pagenumber : Currentpage, StartDate : null, EndDate : null, category : null});     
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.accounts", AccountData);
            Currentpage=Currentpage+1;
            component.set("v.Currentpage",Currentpage);
        });
        $A.enqueueAction(Account);
        var Account = component.get("c.RetrieveAcccountTotalRecord");
        Account.setParams({StartDate : null, EndDate : null, category : null});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.TotalRecords", AccountData);
            var totPages = Math.ceil(AccountData/pageSize);
            component.set("v.Totalpages", totPages);
            component.set("v.prev",true);
            if(AccountData <= pageSize){
                component.set("v.next",true);
            }
        });
        $A.enqueueAction(Account);  
        var Account = component.get("c.getCategoryType");
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.AllCategory", AccountData);
        });
        $A.enqueueAction(Account);
    },
    
    NextPagination:function(component, event, helper){
        var next = true;
        var prev = false;
        var FilterCategory = component.find("levels").get("v.value");
        var FilterStartDate = component.find("StartDate").get("v.value");
        var FilterEndDate = component.find("EndDate").get("v.value");
        component.set("v.prev",false);
        var Currentpage = component.get("v.Currentpage");        
        var pageSize = component.get("v.pageSize"); 
        var Totalpages = component.get("v.Totalpages");
        if(Currentpage >= Totalpages){
            Currentpage=Currentpage-1;
        }
        var Account = component.get("c.RetrieveAcccountPagination");        
        Account.setParams({pagesize : pageSize, pagenumber : Currentpage, StartDate : FilterStartDate, EndDate : FilterEndDate, category : FilterCategory});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.accounts", AccountData);
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
        var FilterCategory = component.find("levels").get("v.value");
        var FilterStartDate = component.find("StartDate").get("v.value");
        var FilterEndDate = component.find("EndDate").get("v.value");
        var pageSize = component.get("v.pageSize"); 
        var Currentpage = component.get("v.Currentpage"); 
        Currentpage=Currentpage-2;
        if(Currentpage <= 0){
            Currentpage = 0;
            component.set("v.Currentpage", 0);
            component.set("v.prev",true);
        }
        var Account = component.get("c.RetrieveAcccountPagination");
        Account.setParams({pagesize : pageSize, pagenumber : Currentpage, StartDate : FilterStartDate, EndDate : FilterEndDate, category : FilterCategory});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.accounts", AccountData);
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
        var FilterCategory = component.find("levels").get("v.value");
        var FilterStartDate = component.find("StartDate").get("v.value");
        var FilterEndDate = component.find("EndDate").get("v.value");
        var Account = component.get("c.RetrieveAcccountPagination");
        Account.setParams({pagesize : pageSize, pagenumber : Totalpages-1, StartDate : FilterStartDate, EndDate : FilterEndDate, category : FilterCategory});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.accounts", AccountData);
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
        var FilterCategory = component.find("levels").get("v.value");
        var FilterStartDate = component.find("StartDate").get("v.value");
        var FilterEndDate = component.find("EndDate").get("v.value");        
        var Account = component.get("c.RetrieveAcccountPagination");
        Account.setParams({pagesize : pageSize, pagenumber : Currentpage, StartDate : FilterStartDate, EndDate : FilterEndDate, category : FilterCategory});
        Account.setCallback(this, function(a) {
            var AccountData = a.getReturnValue();
            component.set("v.accounts", AccountData);
            component.set("v.Currentpage",1);
        });
        $A.enqueueAction(Account);
    }
})