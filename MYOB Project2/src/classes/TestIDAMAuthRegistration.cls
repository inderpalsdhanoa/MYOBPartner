@isTest
public class TestIDAMAuthRegistration {
    //public Auth.UserData userData;
    //public Contact cont;
    public static String uniqueUsername='email@deepak.email'        ;
    public static Auth.UserData setupUserData(){
        Map<String,String> attributeMap=new Map<String,String>();
        attributeMap.put('username',uniqueUsername);
        Auth.UserData userData=new Auth.UserData(null, null, null, null,uniqueUsername, null, uniqueUsername, null,null,null, attributeMap);
        return userData;
    }
    public static Contact setupContactData(){
        Account a = new Account(Name='Test Account Name');
        insert a;
        Contact cont = new Contact(Firstname='D',Lastname='A',Email=uniqueUsername,AccountId = a.id);
        insert cont;
        return cont;
    }
    public static void setupUserLinkingContact(Contact cont){
        Profile  partnerComProfile=[Select Id from Profile where name ='MYOB Partner Community User'];
        User newUser = new User(Username=cont.Email,IsActive=true,profileId=partnerComProfile.Id);
        newUser.ContactId=cont.id;
        newUser.LastName=cont.LastName;
        newUser.Email=cont.Email;
        newUser.Alias=cont.LastName;
        newUser.EmailEncodingKey='ISO-8859-1';
        newUser.LanguageLocaleKey='en_US';
        newUser.LocaleSidKey='en_AU';
        newUser.TimeZoneSidKey='Australia/Sydney';
        insert newUser;
    }
	@isTest
    public static void testContactNotFound(){
        Auth.UserData userData=setupUserData();
        AutocreatedRegHandler1481026076263 authRegHand = new AutocreatedRegHandler1481026076263();
        authRegHand.createUser(null,userData);
    }
    @isTest
    public static void testContactFoundUserNotLinked(){
        Auth.UserData userData=setupUserData();
        Contact cont = setupContactData();
        AutocreatedRegHandler1481026076263 authRegHand = new AutocreatedRegHandler1481026076263();
        authRegHand.createUser(null,userData);
    }
    @isTest
    public static void testContacFoundUserLinked(){
        Auth.UserData userData=setupUserData();
        Contact cont = setupContactData();
        setupUserLinkingContact(cont);
		AutocreatedRegHandler1481026076263 authRegHand = new AutocreatedRegHandler1481026076263();
        authRegHand.createUser(null,userData);        
    }
}