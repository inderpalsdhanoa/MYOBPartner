trigger UpdateCaseStatusAfterAssignedTrigger on AgentWork (after update) {

    // Define collection variables
    List<Case> caseList = new List<Case>();
    Set<Id> caseSet = new Set<Id>();

    // Iterate over each AgentWork, add Id to set if master object is Case
    try {
        if(Trigger.isAfter && Trigger.isUpdate){
 			for (AgentWork aw : Trigger.New) {
                String wiId = aw.WorkItemId;
                String Status = aw.Status;
                Datetime AcceptDateTime = aw.AcceptDateTime;
                system.debug(Status);
                //Schema.SObjectType wiSObjType = wiId.getSObjectType();
                //String wiSObjName = wiSObjType.getDescribe().getName();
                //if (wiSObjName == 'Case') {
                if (wiId.left(3) == '500' && AcceptDateTime != NULL && AcceptDateTime !=Trigger.oldMap.get(aw.id).AcceptDateTime/*&& aw.Status == 'Opened'*/) {    
                    caseSet.add(aw.WorkItemId);
                }
            }
            system.debug(caseSet.size());
    
            // Update status of each case
            caseList = [SELECT Id, Status FROM Case WHERE Id IN: caseSet];
            system.debug(caseList.size());
            for (Case cl : caseList) {
                cl.Status = 'In Progress';
                cl.In_Progress_DateTime__c= System.now();
            }
            system.debug(caseList);
            // Update case statuses
            update caseList;           
        }
            
    }
    catch (Exception e) {
        system.debug('ERROR = '+e.getMessage());
    }

    
}