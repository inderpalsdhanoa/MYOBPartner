@isTest(seealldata=true)
private class NewCaseTriggerAssignment_Test {
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
        primaryCategory = 'Administrative Request';
        category = 'Billing & Finance';
        subCategory = 'Cancellations';
        subject = 'Request';
        description = 'Test Desc';
        accnt1 = [SELECT Id FROM Account WHERE Name = '1 Place Limited'];
        contact1 = [SELECT Id from Contact WHERE AccountId =: accnt1.Id LIMIT 1];
        
        newCaseList.add(new Case(
            //AccountId = '001O000000qepZH',
            AccountId = accnt1.Id,
            //ContactId = '003O000000srMIe',
            ContactId = contact1.Id,
            //Primary_Category__c = primaryCategory,
            //Categ__c = category,
            //Sub_Category__c = subCategory,
            Subject =   subject,
            Description = description
        ));
    }
    
    static testMethod void testWithNewCase(){
        init();
        Test.startTest();
        insert newCaseList;
        Test.stopTest();
    }
    
}