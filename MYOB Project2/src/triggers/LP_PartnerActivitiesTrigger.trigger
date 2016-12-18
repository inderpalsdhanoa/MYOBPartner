/*
	Date		: 21 Nov 2016
	Author		: SMS Management & Technology
	Description : Trigger for Activities object
*/
trigger LP_PartnerActivitiesTrigger on LP_Partner_Activities__c (before insert, before update) {
    
    if(trigger.isBefore && trigger.isInsert ) {
    	LP_PartnerActivitiesTriggerHandler.associatePartnerInsertion(trigger.new);
    }
    
    if(trigger.isBefore && trigger.isUpdate ) {
    	map<Id,LP_Partner_Activities__c> newMap = new map<Id,LP_Partner_Activities__c>(trigger.new);
    	map<Id,LP_Partner_Activities__c> oldMap = new map<Id,LP_Partner_Activities__c>(trigger.old);
	 	LP_PartnerActivitiesTriggerHandler.associatePartnerUpdation(newMap, oldMap);
	}
}