trigger CaseAssignmentForInlineEditingTrigger on Case (after update) {
	List<Case> caseList = new List<Case>();
    
    if(Trigger.isAfter && Trigger.isUpdate){
        for (Case caseObj : Trigger.new) {
            if(caseObj.IsEscalated == true && caseObj.IsEscalated != Trigger.oldMap.get(caseObj.id).IsEscalated){
                caseList.add(new Case(id = caseObj.id));
            }
        }
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = true;
        Database.update(caseList, dmo);
    }
}