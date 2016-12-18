@isTest(seealldata=true)
private class CaseAssignForInlineEditTrigger_Test {

  public static List<Case> newCaseList; 
    public static String contact;
    public static String account;
    public static String primaryCategory;
    public static String category;
    public static String subCategory;
    public static String subject;
    public static String description;
    public static Account accnt1;
    public static Contact contact1;
    
    static void init(){
        newCaseList = New List<Case>();
        //contact = 'roy test test';
        //account = '1 Place Limited';
        //primaryCategory = 'Administrative Request';
        //category = 'Billing & Finance';
        //subCategory = 'Cancellations';
        subject = 'Request';
        description = 'Test Desc';
        accnt1 = [SELECT Id FROM Account WHERE Name = '1 Place Limited'];
        contact1 = [SELECT Id from Contact WHERE AccountId =: accnt1.Id LIMIT 1];
        
        newCaseList.add(new Case(
            //AccountId = '001O000000qepZH',
            //ContactId = '003O000000srMIe',
            //Primary_Category__c = primaryCategory,
            //Categ__c = category,
      		//Sub_Category__c = subCategory,
      		AccountId = accnt1.Id,
            ContactId = contact1.Id,
            Subject =   subject,
            Description = description,
            IsEscalated = false
        ));
        //newCaseList = [SELECT Id, IsEscalated FROM Case WHERE IsEscalated = false AND Status = 'In Progress' AND OwnerId = '00GO0000002Hd7e'];
        
        insert newCaseList;
        
        for(Case caseObj1:newCaseList){
            caseObj1.IsEscalated = true;
        }
    }
    
    static testMethod void testWithExistingCase(){
        init();
        Test.startTest();
        update newCaseList;
        Test.stopTest();
    }
   
}