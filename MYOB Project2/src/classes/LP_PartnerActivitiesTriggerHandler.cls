/*
        Date         : 22 Nov 2016
        Project      : Loyalty Program
        Author       : SMS Management & Technology
        Description  : Trigger handler for the Activities trigger
        			 * Ensuring the activities created from the loyalty service are related to 
        			   their partners
*/
public class LP_PartnerActivitiesTriggerHandler {
	
	// When a new activity is created
	public static void associatePartnerInsertion(List<LP_Partner_Activities__c> newMap) {
		Set<String> setExtAccId = new Set<String>();
		Map<String,String> mapAccount = new Map<String,String>();

		// Get a list of all the external Id's for the partners
		for(LP_Partner_Activities__c pA : newMap) {
			setExtAccId.add(pA.LP_Partner_Archie_ID__c);
		}

		// Map the external Id's to their Salesforce Id's
		for(Account aC : [SELECT Id, Client_ID__c FROM Account WHERE Client_ID__c IN :setExtAccId]) {
			mapAccount.put(aC.Client_ID__c, aC.Id);
		}

		try {
			for(LP_Partner_Activities__c pA : newMap) {
				if(pA.LP_Partner_Archie_ID__c != NULL && pA.LP_Statement_Only__c == false) {
					if(mapAccount.containsKey(pA.LP_Partner_Archie_ID__c))
						pA.LP_Partner_Name__c = Id.valueOf(mapAccount.get(pA.LP_Partner_Archie_ID__c));
					else 
						pA.LP_Partner_Name__c = NULL;
				} else {
					pA.LP_Partner_Name__c = NULL;
				}
			}
		} catch(exception e) {
			LP_ErrorLogHandler.log('Activity partner association failure during insertion',string.ValueOf(e),'LP_PartnerActivitiesTriggerHandler');	
		}
	}
	
	// When an existing activity is updated
	public static void associatePartnerUpdation(Map<Id,LP_Partner_Activities__c> newMap, Map<Id,LP_Partner_Activities__c> oldMap) {
		Set<String> setExtAccId = new Set<String>();
		Map<String,String> mapAccount = new Map<String,String>();
		List<LP_Partner_Activities__c> lstActivities = new List<LP_Partner_Activities__c>();
		lstActivities = newMap.values();

		// Get a list of all the external Id's for the partners
		for(LP_Partner_Activities__c pA : lstActivities) {
			setExtAccId.add(pA.LP_Partner_Archie_ID__c);
		}

		// Map the external Id's to their Salesforce Id's
		for(Account aC : [SELECT Id, Client_ID__c FROM Account WHERE Client_ID__c IN :setExtAccId]) {
			mapAccount.put(aC.Client_ID__c, aC.Id);
		}
		
		try {
			for(LP_Partner_Activities__c pA : lstActivities) {
				if(pA.LP_Partner_Archie_ID__c != oldMap.get(pA.Id).LP_Partner_Archie_ID__c) {
					if(pA.LP_Partner_Archie_ID__c != NULL && pA.LP_Statement_Only__c == false) {
						if(mapAccount.containsKey(pA.LP_Partner_Archie_ID__c))
							pA.LP_Partner_Name__c = Id.valueOf(mapAccount.get(pA.LP_Partner_Archie_ID__c));
						else 
							pA.LP_Partner_Name__c = NULL;
					} else {
						pA.LP_Partner_Name__c = NULL;
					}
				}
			}
		} catch(exception e) {
			LP_ErrorLogHandler.log('Activity partner association failure during updation',string.ValueOf(e),'LP_PartnerActivitiesTriggerHandler');
		}
	}
}