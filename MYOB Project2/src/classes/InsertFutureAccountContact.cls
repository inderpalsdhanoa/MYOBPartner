public class InsertFutureAccountContact {
    public static contact FutureAccountContact(){
        Account ac = new Account(name ='GrazittiTestAccount') ;
        insert ac; 
        Contact con = new Contact(LastName ='TestContactAccount', AccountId = ac.Id);
        insert con;
        return con;
    }
}