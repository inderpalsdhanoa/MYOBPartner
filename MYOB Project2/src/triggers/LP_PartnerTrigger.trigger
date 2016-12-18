/*
	Date		: 21 Nov 2016
	Author		: SMS Management & Technology
	Description : Trigger for Partner object
*/
trigger LP_PartnerTrigger on Account (before insert, before update) {
    
    if(trigger.isBefore && trigger.isInsert ) {
    	LP_PartnerTriggerHandler.associateParentInsertion(trigger.new);
    }
    
    if(trigger.isBefore && trigger.isUpdate ) {
    	map<Id,Account> newMap = new map<Id,Account>(trigger.new);
    	map<Id,Account> oldMap = new map<Id,Account>(trigger.old);
	 	LP_PartnerTriggerHandler.associateParentUpdation(newMap, oldMap);
	}
}