({
    doInit : function(component, event, helper) {
        var action = component.get("c.getActivityPoints");
        alert("After getActivityPoints");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                alert(state);
                var custs = [];
                var conts = response.getReturnValue();
                for(key in conts) {
                    alert(conts[key]);
                    custs.push({value:conts[key], key:key});
                }
                component.set("v.ActivityPoints", custs);
                alert(custs);
            }
        });
        $A.enqueueAction(action);
        
    }
})