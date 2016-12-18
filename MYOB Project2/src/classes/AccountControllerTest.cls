@Istest
public class AccountControllerTest {
    public static testmethod void getPartnerTestmethod(){
        Contact con = InsertFutureAccountContact.FutureAccountContact();
        //Contact Con = [select id, Account.id from contact where lastname='TestContactAccount' LIMIT 1];
        //Account Acc = [select id, name from Account where name = 'GrazittiTestAccount'];
        //InsertFutureUser.NewUser(ac.id, con.id);
        //User portalUser = [Select Id From User Where lastname = 'Testinguser12345' Limit 1];
        //Id p = [select id from profile where name='Partner Community User'].id;
        //UserRole portalRole = [Select Id From UserRole Where PortalType = 'Partner' Limit 1];
        /*User testuser = new User(alias = 'test123', email='test123@noemail.com',
                             emailencodingkey='UTF-8', lastname='Testinguser12345', languagelocalekey='en_US',
                             localesidkey='en_US', profileid = p, country='United States', IsActive =true,
                             ContactId = Con.ID,// Account = AccId,
                             //Userroleid = portalRole.Id,  
                             timezonesidkey='America/Los_Angeles', username='tester@noemail.com');
        Test.startTest();
        insert testuser;
        testuser.Account.id = Con.account.Id;
        //testuser.Contactid = Con.id;
        update testuser;  
		Test.stopTest();
        system.runAs(testuser) {                      
           AccountController.getPartner();            
        }
        Account ac = new Account(name ='GrazittiTestAccount');
        insert ac; 
        Contact con = new Contact(LastName ='TestContactAccount', AccountId = ac.Id);
        insert con;
        InsertFutureUser.NewUser(ac.id, con.Id);*/
        Id p = [select id from profile where name='Partner Community User'].id;
        Profile  partnerComProfile=[Select Id from Profile where name ='MYOB Partner Community User'];
        User newUser = new User(Username='inderpalsdhanoa1123344444@noemail.com',IsActive=true,profileId=partnerComProfile.Id);
        newUser.ContactId=Con.id;
        newUser.LastName='LastName';
        newUser.Email='test123@noemail.com';
        newUser.Alias='test123';
        newUser.EmailEncodingKey='ISO-8859-1';
        newUser.LanguageLocaleKey='en_US';
        newUser.LocaleSidKey='en_AU';
        newUser.TimeZoneSidKey='Australia/Sydney';
        insert newuser;
        Test.startTest();
        system.runAs(newUser) {                      
           AccountController.getPartner();            
        }
        Test.stopTest();
    }
}