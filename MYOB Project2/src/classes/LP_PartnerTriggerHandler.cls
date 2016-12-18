/*
        Date         : 14 Nov 2016
        Project      : Loyalty Program
        Author       : SMS Management & Technology
        Description  : Trigger handler for the Activities trigger
        			 * Ensuring any child partners created from Loyalty Service are related to
        			   thier parent partner 
*/
public with sharing class LP_PartnerTriggerHandler {

	public static void associateParentInsertion(List<Account> newMap) {
		Set<String> setExtParentAccId = new Set<String>();
		Map<String,String> mapParentAccount = new Map<String,String>();

		// Get a list of all the external Id's for the partners
		for(Account aC : newMap) {
			if(aC.LP_Parent_Archie_Client_Id__c != NULL)
				setExtParentAccId.add(aC.LP_Parent_Archie_Client_Id__c);
		}
		
		// Map the external Id's to their Salesforce Id's
		for(Account aC : [SELECT Id, Client_ID__c FROM Account WHERE Client_ID__c IN :setExtParentAccId]) {
			mapParentAccount.put(aC.Client_ID__c, aC.Id);
		}
		
		try {
			for(Account aC : newMap) {
				if(aC.LP_Parent_Archie_Client_Id__c != NULL) {
					// If a parent has already been created in Salesforce then the Map will contain
					// the Id and associate with the same. In case a child which had a parent is updated
					// to another parent partner and the respective partner already exists in Salesforce
					// mapping will happen. If the updated parent does not exist in Salesforce then we
					// set is as NULL so that the scheduled job can identify the same and try to associate.
					if(mapParentAccount.containsKey(aC.LP_Parent_Archie_Client_Id__c)) {
						aC.ParentID = mapParentAccount.get(aC.LP_Parent_Archie_Client_Id__c);
						aC.LP_Acc_Related_List__c = mapParentAccount.get(aC.LP_Parent_Archie_Client_Id__c);
					} else {
						aC.ParentID = NULL;
						aC.LP_Acc_Related_List__c = NULL;
					}
				} else {
					// If the parent parter associated is removed then clear it 
					aC.ParentID = NULL;
					aC.LP_Acc_Related_List__c = NULL;
				}
			}
		} catch(exception e) {
			LP_ErrorLogHandler.log('Parent partner association failure during insertion',string.ValueOf(e),'LP_PartnerTriggerHandler');
		}
	}
	
	public static void associateParentUpdation(Map<Id,Account> newMap, Map<Id,Account> oldMap) {
		Set<String> setExtParentAccId = new Set<String>();
		Map<String,String> mapParentAccount = new Map<String,String>();
		List<Account> lstAccount = new List<Account>();
		lstAccount = newMap.values();

		// Get a list of all the external Id's for the partners
		for(Account aC : lstAccount) {
			if(aC.LP_Parent_Archie_Client_Id__c != NULL)
				setExtParentAccId.add(aC.LP_Parent_Archie_Client_Id__c);
		}
		
		// Map the external Id's to their Salesforce Id's
		for(Account aC : [SELECT Id, Client_ID__c FROM Account WHERE Client_ID__c IN :setExtParentAccId]) {
			mapParentAccount.put(aC.Client_ID__c, aC.Id);
		}
		
		try {
			for(Account aC : lstAccount) {
				if(aC.LP_Parent_Archie_Client_Id__c != NULL) {
					// If a parent has already been created in Salesforce then the Map will contain
					// the Id and associate with the same. In case a child which had a parent is updated
					// to another parent partner and the respective partner already exists in Salesforce
					// mapping will happen. If the updated parent does not exist in Salesforce then we
					// set is as NULL so that the scheduled job can identify the same and try to associate.
					if(mapParentAccount.containsKey(aC.LP_Parent_Archie_Client_Id__c)) {
						aC.ParentId = mapParentAccount.get(aC.LP_Parent_Archie_Client_Id__c);
						aC.LP_Acc_Related_List__c = mapParentAccount.get(aC.LP_Parent_Archie_Client_Id__c);
					} else {
						aC.ParentId = NULL;
						aC.LP_Acc_Related_List__c = NULL;
					}
				} else {
					// If the parent parter associated is removed then clear it 
					aC.ParentId = NULL;
					aC.LP_Acc_Related_List__c = NULL;
				}
			}
		} catch(exception e) {
			LP_ErrorLogHandler.log('Parent partner association failure during updation',string.ValueOf(e),'LP_PartnerTriggerHandler');
		}
	}
}