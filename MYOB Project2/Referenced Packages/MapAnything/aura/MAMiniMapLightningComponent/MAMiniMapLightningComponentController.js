({
	doInit : function(component, event, helper) {
       console.log('getComponent');
       var param1 = component.get('v.param1');
       var param2 = component.get('v.param2');
       var param3 = component.get('v.param3');
       var miniMapId = component.get('v.minimapid');
       var path = component.get('v.domain') == '' || !component.get('v.domain')? '' : component.get('v.domain');
       
        if(path != '' && path.indexOf('/') != 0) {
            path = '/' + path;
        }
       var url = path + '/apex/sma__MAMiniMapLightning?Id=' + component.get('v.recordId') + '&p1=' + param1 + '&param2=' + param2 + '&param3=' + param3 + '&miniMapId=' + miniMapId;
       console.log(url);
       component.set("v.url", encodeURI(url));

	}
})