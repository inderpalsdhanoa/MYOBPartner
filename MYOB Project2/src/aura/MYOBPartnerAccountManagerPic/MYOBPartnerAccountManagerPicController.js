({  
    doInit: function(component) {
        alert("In Partner manager Pic");
        var User = component.get("c.getUserInfo");
        
        User.setCallback(this, function(a) {
            var UserData = a.getReturnValue();
            component.set("v.UserInfo", UserData);
        });
        $A.enqueueAction(User);
        
        User = component.get("c.getPhoto");
        User.setCallback(this, function(a) {
            var UserData = a.getReturnValue();
            component.set("v.pictureSrc", UserData);
        });
        $A.enqueueAction(User);   
        
        User = component.get("c.getEMail");        
        User.setCallback(this, function(a) {
            var UserData = a.getReturnValue();
            component.set("v.PtrMngrEMail", UserData);
        });
        $A.enqueueAction(User); 
        
    }
})