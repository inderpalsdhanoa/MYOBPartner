({  
    doInit: function(cmp){
        alert("In Points Totall");
		var action1 = cmp.get("c.getPartner");
		action1.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.PartnerDetails", response.getReturnValue());
                var status = cmp.get("{!v.PartnerDetails.LP_Points_to_upgrade__c}");
            }
        });
        $A.enqueueAction(action1); 
        
        action = cmp.get("c.getMaxPointsfromTier");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var res = response.getReturnValue()
                cmp.set("v.TierValues", res.LP_Maximum_Point__c);
            }
        });
        $A.enqueueAction(action); 
        
        action = cmp.get("c.GetUserLoyalityPoints");
        action.setCallback(this, function(response){
            var ste = response.getState();
            if (ste === "SUCCESS") {
                var NoOfTiles = 0, TileWidth=0;
                var custs = [];
                var conts = response.getReturnValue();
                for(key in conts) {
                    NoOfTiles++;
                    custs.push({value:conts[key], key:key});
                }
                TileWidth = 100/NoOfTiles;
                cmp.set("v.UserLoyaltyScore", custs);
            }
        });
        $A.enqueueAction(action);
    }
})