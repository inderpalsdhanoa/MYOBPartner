trigger CaseAssignmentTrigger on Case (after insert) {
    List<Case> caseList = new List<Case>();
    if(Trigger.isAfter && Trigger.isInsert){
        for (Case caseObj : Trigger.new) {
            if(caseObj.Status != 'Closed'){
                caseList.add(new Case(id = caseObj.id));
            }    
        }
   
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = true;
        Database.update(caseList, dmo);
    }
}