@isTest
public class AccountController_TestClass {
    public static testmethod void getPartnerTestmethod(){
       
        Account accparent = new Account(name ='GrazittiTestAccount199911122', Client_ID__c='9999992',
                                       status__c='Gold', Points__c=200, Next_Status__c='Diamond', Next_Level_Points__c=300, LP_status__c='Gold' );
        insert accparent;
        Account ac = new Account(name ='GrazittiTestAccount1111', Client_ID__c='99999924',
                                status__c='Gold', Points__c=250, Next_Status__c='Diamond', Next_Level_Points__c=350, LP_status__c='Gold');
        ac.parent = accparent;
        insert ac;
        LP_Partner_Activities__c temp = new LP_Partner_Activities__c(LP_Activity_Date__c = Date.newInstance(2008,12,31),
                                                                     LP_Activity__c='Category', LP_Points_Category__c='Certification Category',
                                                                     LP_Points__c=25, LP_Account_Id__c='123456', 
                                                                     LP_Activity_Id__c='12345678', 
                                                                     LP_Activity_GUID__c='65432108', LP_Partner_Archie_ID__c='9999992', 
                                                                     LP_Partner_GUID__c='90785634');
        insert temp;
        temp.LP_Partner_Name__r = accparent;
        update temp;
        LP_Partner_Activities__c temp1 = new LP_Partner_Activities__c(LP_Activity_Date__c = Date.newInstance(2016,12,31),
                                                                     LP_Activity__c='Category', LP_Points_Category__c='Certification Category',
                                                                     LP_Points__c=25, LP_Account_Id__c='1234567', 
                                                                     LP_Activity_Id__c='123456787', 
                                                                     LP_Activity_GUID__c='654321087', LP_Partner_Archie_ID__c='99999924', 
                                                                     LP_Partner_GUID__c='907856347');
        insert temp1;
        temp1.LP_Partner_Name__r = ac;
        update temp1;
        Contact con = new Contact(LastName ='TestContactAccount', AccountId = accparent.Id);
        insert con;
        lead ls = new Lead(FirstName='GrazittiTestAccountLead1', lastname='GrazittiTestAccountLeadLastname', 
                           LeadSource='Partner Search', Status='Partner Accepted', EMail='abc@myob.com', company='testCompany');
        insert ls;
        ls.account__r = accparent;
        update ls;
        lead ls2 = new Lead(FirstName='GrazittiTestAccountLead2', lastname='GrazittiTestAccountLeadLastname2', 
                           LeadSource='Partner Search', Status='Partner Accepted', EMail='abc2@myob.com', company='testCompany2');
        insert ls2;
        ls2.account__r = ac;
        update ls2;
        
        LP_Tier__c NewTier = new LP_Tier__c(LP_Maximum_Point__c=500, LP_Minimum_Point__c=200,
                                           LP_Tier_End_Date__c=Date.newInstance(2015,12,31), 
                                            LP_Tier_Start_Date__c=Date.newInstance(2016,11,30), name='Gold');
        insert NewTier;
        AddUserandRunAllFunction(con.id);
    }
    

    public static void AddUserandRunAllFunction(id ConId){
        string LeadSortField = 'FIRSTNAME';
        Date StartDate = Date.newInstance(2008,12,31);
        Date EndDate = Date.newInstance(2016,11,30);
        String category = 'Certification Category';
        Id p = [select id from profile where name='Partner Community User'].id;
        Profile  partnerComProfile=[Select Id from Profile where name ='MYOB Partner Community User'];
        
        UserRole portalRole = [Select Id From UserRole Where name = 'KPMG Partner User' Limit 1];

        User newUser = new User(Username='inderpalsdhanoa1123344444@noemail.com',IsActive=true,profileId=partnerComProfile.Id);
        newUser.ContactId=ConId;
        newUser.LastName='LastName';
        newUser.Email='test123@noemail.com';newUser.Alias='test123';
        newUser.EmailEncodingKey='ISO-8859-1';newUser.LanguageLocaleKey='en_US';
        newUser.LocaleSidKey='en_AU';newUser.TimeZoneSidKey='Australia/Sydney';
        //newUser.Userroleid = portalRole.Id; 
        //system.debug('@@@@@@@@'+portalrole.id);

        
        Test.startTest();
                insert newuser;
        system.runAs(newUser) {
            
            AccountController.getPartner();     
            AccountController.getAccounts();
            AccountController.getLeads();
            AccountController.getAllLeads();
            AccountController.getCategoryType();
            AccountController.getFilterResult(category);
            AccountController.getFilterCount(category);
            AccountController.RetrieveAcccountPagination(1,1,'2008-06-30', '2012-06-30', 'Certification Category');
            AccountController.RetrieveAcccountTotalRecord('2008-06-30', '2012-06-30', 'Certification Category');
            AccountController.RetrieveLeadPagination(1,1,LeadSortField);
            AccountController.RetrieveLeadTotalRecord();
            AccountController.SortAccounts('LP_Points_Category__c');
            AccountController.getUserName();
            AccountController.getUserInfo();
            AccountController.getPhoto();
            AccountController.GetUserLoyalityPoints();
            AccountController.getMaxPointsfromTier();
            AccountController.getEMail();
        }
        Test.stopTest();            
    }
}