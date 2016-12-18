({
    
    doInit: function(component){ 
        
        var action = component.get("c.GetUserLoyalityPoints");
        action.setCallback(this, function(response){
            var ste = response.getState();
            if (ste === "SUCCESS") {
                var custs = [];
                var conts = response.getReturnValue();
                for(key in conts) {
                    custs.push({value:conts[key], key:key});
                } 
                component.set("v.UserLoyaltyScore",custs);
            }
        });
        $A.enqueueAction(action);
        
        action = component.get("c.getUserName");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.Name", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
        
    }
})