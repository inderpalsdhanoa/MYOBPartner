public class InsertFutureUser {
    public static void NewUser(id Acc, id ConID){
        Id p = [select id from profile where name='Partner Community User'].id;
        //UserRole portalRole = [Select Id From UserRole Where PortalType = 'Partner' Limit 1];        
        /*UserRole portalRole = [Select Id From UserRole Where name = 'KPMG Partner User' Limit 1];
        system.debug('@@@portalRole'+portalRole);
        User testuser = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testinguser12345', languagelocalekey='en_US',
                             localesidkey='en_US', profileid = p, country='United States', IsActive =true,
                             ContactId = ConID, //Account = AccId,
                             Userroleid = portalRole.Id,  
                             timezonesidkey='America/Los_Angeles', username='tester@noemail.com');*/
        Profile  partnerComProfile=[Select Id from Profile where name ='MYOB Partner Community User'];
        User newUser = new User(Username='inderpalsdhanoa1123344444@noemail.com',IsActive=true,profileId=partnerComProfile.Id);
        newUser.ContactId=Conid;
        newUser.LastName='LastName';
        newUser.Email='test123@noemail.com';
        newUser.Alias='test123';
        newUser.EmailEncodingKey='ISO-8859-1';
        newUser.LanguageLocaleKey='en_US';
        newUser.LocaleSidKey='en_AU';
        newUser.TimeZoneSidKey='Australia/Sydney';
        insert newuser;
        //newUser.Account.id = Acc;
        //update testuser;
        system.runAs(newUser) {                      
           AccountController.getPartner();            
        }
    }
}