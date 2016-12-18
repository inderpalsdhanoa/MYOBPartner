@IsTest
public class AccountController_Test {
    public static testmethod void getPartnerTestmethod(){
        Contact con = AccountContact();
        Id p = [select id from profile where name='Partner Community User'].id;
        Profile  partnerComProfile=[Select Id from Profile where name ='MYOB Partner Community User'];
        

        //UserRole portalRole = [Select Id From UserRole Where PortalType = 'Partner' Limit 1];
        UserRole portalRole = [Select Id From UserRole Where Name = 'My Role' Limit 1];
        
        
        User newUser = new User(Username='inderpalsdhanoa1123344444@noemail.com',IsActive=true,profileId=partnerComProfile.Id);
        newUser.ContactId=Con.id;newUser.LastName='LastName';
        newUser.Email='test123@noemail.com';newUser.Alias='test123';
        newUser.EmailEncodingKey='ISO-8859-1';newUser.LanguageLocaleKey='en_US';
        newUser.LocaleSidKey='en_AU';newUser.TimeZoneSidKey='Australia/Sydney';
        newUser.Userroleid = portalRole.Id;  
        insert newUser;
        
        Test.startTest();
        system.runAs(newUser) {    
            AccountController.getPartner();     
            AccountController.getAccounts();
            AccountController.getLeads();
            AccountController.getAllLeads();
            AccountController.getCategoryType();
            //AccountController.getFilterResult();
            //AccountController.getFilterCount();
            //AccountController.RetrieveAcccountPagination();
            //AccountController.RetrieveAcccountTotalRecord();
            //AccountController.RetrieveLeadPagination();
            AccountController.RetrieveLeadTotalRecord();
            //AccountController.SortAccounts();
            AccountController.getUserName();
            AccountController.getPhoto();
            AccountController.GetUserLoyalityPoints();
            //AccountController.getMaxPointsfromTier();
            AccountController.getEMail();
        }
        Test.stopTest();            
    }
    
    public static contact AccountContact(){
        UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
        insert r;
            
        Account accparent = new Account(name ='GrazittiTestAccount199911122', Client_ID__c='9999992');
        insert accparent;
        Account ac = new Account(name ='GrazittiTestAccount1111', Client_ID__c='99999924');
        //ac.parent = accparent.Id;
        insert ac;
        LP_Partner_Activities__c temp = new LP_Partner_Activities__c(LP_Activity_Date__c = Date.newInstance(2008,12,31),
                                                                     LP_Activity__c='Category', LP_Points_Category__c='Category',
                                                                     LP_Points__c=25, LP_Account_Id__c='123456', 
                                                                     LP_Activity_Id__c='12345678', 
                                                                     LP_Activity_GUID__c='65432108', LP_Partner_Archie_ID__c='9999992', 
                                                                     LP_Partner_GUID__c='90785634');
        insert temp;
        temp.LP_Partner_Name__r = accparent;
        update temp;
        LP_Partner_Activities__c temp1 = new LP_Partner_Activities__c(LP_Activity_Date__c = Date.newInstance(2016,12,31),
                                                                     LP_Activity__c='Category', LP_Points_Category__c='Category',
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
        return con;
    }
    
}