({
    doInit : function(component, event, helper) {
        alert("In new Theme");
    },
    /*toggleArrow :function (component, event, helper) {
        /*$('#HomeAttr').removeAttr("style");
        $('#LeadAttr').removeAttr("style");
        $('#ActvStmntAttr').attr("style");
        var target = event.target || event.srcElement;
        var id = target.id;
        alert("Id"+id);
        var arrowSpanUP=$('#ArrowUp');
        var arrowSpanDown=$('#ArrowDown');
        if(arrowSpanUP.is(":visible")){
            arrowSpanDown.show();arrowSpanUP.hide();
        } else if(arrowSpanDown.is(":visible")){
            arrowSpanDown.hide();arrowSpanUP.show();
        }
    },
    
    OtherLinktoggleArrow :function (component, event, helper) {
        var OtherLinkUp=$('#OtherLinkArrowUp');
        var OtherLinkDown=$('#OtherLinkArrowDown');
        if(OtherLinkUp.is(":visible")){
            OtherLinkDown.show();OtherLinkUp.hide();
        } else if(OtherLinkDown.is(":visible")){
            OtherLinkDown.hide();OtherLinkUp.show();
        }
    },*/
    
    ResClick : function (component, event, helper) {
        $('#HomeAttr').removeAttr("style");
        $('#LeadAttr').removeAttr("style");
        $('#ActvStmntAttr').removeAttr("style");
    },
    
    onScreenClick  : function (component, event, helper) {
        var target = event.target || event.srcElement;
        var id = target.id;
        if(id != 'ResourceID' && id != 'ArrowUp' && id != 'ArrowDown'){
            $('#ArrowDown').hide();$('#ArrowUp').show();
        } else {
            if($('#ArrowDown').is(":visible")){
                $('#ArrowDown').hide();$('#ArrowUp').show();   
            } else {
                if($('#ArrowUp').is(":visible")){
                    $('#ArrowDown').show();$('#ArrowUp').hide(); 
                }
            }
        }
        if(id != 'OtherLinkArrowUp' && id != 'OtherLinkArrowDown' && id != 'OtherLinks'){
            $('#OtherLinkArrowUp').show();$('#OtherLinkArrowDown').hide();
        } else {
            if($('#OtherLinkArrowDown').is(":visible")){
                $('#OtherLinkArrowDown').hide();$('#OtherLinkArrowUp').show();
            } else {
                if($('#OtherLinkArrowUp').is(":visible")){
                    $('#OtherLinkArrowDown').show();$('#OtherLinkArrowUp').hide();
                }
            }
        }
    },
    
    ActvStmnt : function (component, event, helper) {

        $('#HomeAttr').removeAttr("style");
        $('#LeadAttr').removeAttr("style");
        $('#ActvStmntAttr').attr("style", "border-bottom: 2px solid #800080");
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/allactivitystatements"
        });
        urlEvent.fire();
    },
    
    Leads : function (component, event, helper) {
        
        $('#HomeAttr').removeAttr("style");
        $('#ActvStmntAttr').removeAttr("style");
        $('#LeadAttr').attr("style", "border-bottom: 2px solid #800080");
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/allleads"
        });
        urlEvent.fire();
    },
    
    HomePage : function (component, event, helper) {
        $('#LeadAttr').removeAttr("style");
        $('#ActvStmntAttr').removeAttr("style");
        $('#HomeAttr').attr("style", "border-bottom: 2px solid #800080");
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
        "url": "/"
    });
    urlEvent.fire();
    }
})