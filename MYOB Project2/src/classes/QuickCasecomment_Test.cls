@isTest(seealldata=true)
private class QuickCasecomment_Test {
    public static List<Case> newCaseList; 
    public static String comment;
    public static Id caseId;
    public static String isPublic1;
    public static String isPublic2;
    public static String subject;
    public static String description;
    public static Account accnt1;
    public static Contact contact1;
    public static Boolean result;
    
    static void init(){
            newCaseList = New List<Case>();
            subject = 'Request';
            description = 'Test Desc';
            accnt1 = [SELECT Id FROM Account WHERE Name = '1 Place Limited'];
            contact1 = [SELECT Id from Contact WHERE AccountId =: accnt1.Id LIMIT 1];
            comment = 'good';    
            isPublic1 = 'true';
            isPublic2 = 'false';
        
            newCaseList.add(new Case(
                AccountId = accnt1.Id,
                ContactId = contact1.Id,
                Subject =   subject,
                Description = description,
                IsEscalated = false
            ));
    }
                
    static testMethod void testWithNewCaseComment(){
        init();
        Test.startTest();
        insert newCaseList;
        for(Case c:newCaseList){
            caseId = c.Id;
        }
        CaseComment cc1 = new CaseComment(ParentId = caseId, isPublished = true, CommentBody = 'test');
        ApexPages.StandardController sc = new ApexPages.StandardController(cc1);
        QuickCasecomment qcc = new QuickCasecomment(sc);
        
        result = QuickCasecomment.CreateComment(caseId, comment, isPublic1); 
        result = QuickCasecomment.CreateComment(caseId, comment, isPublic2); 
        
        comment = '1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111';
        for(Integer i = 0;i<=20; i++ ){
            comment = comment + '1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111';
         }
        result = QuickCasecomment.CreateComment(caseId, comment, isPublic2); 
        Test.stopTest();
    }
        
}