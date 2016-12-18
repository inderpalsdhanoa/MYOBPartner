public with sharing class MYOBLoyaltyPoints { 
    
    @AuraEnabled
    public static String getUserName() {
        return userinfo.getName();
    }
    @AuraEnabled
    public static User getUserInfo() {
        id AccOwnerID = [select user.account.ownerid from user where id = :userinfo.getuserid()].account.ownerid;
        User u = [select id,FirstName, user.contact.email, LastName, smallphotoURl, Phone, city, State 
             from User where ID =: AccOwnerID];
        return u;
    }
    
    @AuraEnabled
    public static string getPhoto() {
        id AccOwnerID = [select user.account.ownerid from user where id = :userinfo.getuserid()].account.ownerid;
        return String.valueOf([SELECT Id, smallPhotoURL FROM User WHERE ID =: AccOwnerID].smallPhotoURL);
    }
    
    @AuraEnabled
    public static Account getPartner() {
        String AccountName = [select Account.name from user where id = :userinfo.getuserid()].Account.name;
        Account Acc = [select owner.name, status__c, LP_Points__c, LP_Status__c, LP_Next_Status__c, LP_Points_to_upgrade__c 
                       from account where name= :AccountName and LP_Status__c != '' LIMIT 1];
        return Acc;
    }
    
    @AuraEnabled
    public static Map<String, Integer> GetUserLoyalityPoints(){
        Id ContID = [select contactid from user where id = :userinfo.getuserid()].contactid;
        String AccountName = [select Account.name from contact where id= :ContID].Account.name;
        Account Acc = [select OwnerId,owner.name, status__c, Points__c, Next_Status__c, Next_Level_Points__c 
                       from Account where name= :AccountName and LP_status__c != '' LIMIT 1];
        String accName = [select user.account.name from user where id = :userinfo.getuserid()].Account.name;
        List<String> parentChildAccount = new List<String>();
        List<Account> accChildList = [Select Id, Name From Account Where parent.Name =: accName];
        if(accChildList != null && accChildList.size()>0){
            for(Account accnt : accChildList){
                parentChildAccount.add(accnt.Name);
            }
        }
        parentChildAccount.add(accName);
        Map<String, Integer> UserScore = new Map<String, Integer>();
        AggregateResult[] groupedResults = [select LP_Points_Category__c, sum(LP_Points__c)
                                 from LP_Partner_Activities__c 
                                 where LP_Partner_Name__r.Name in :parentChildAccount
                                            and LP_Activity_Date__c <= :Date.today()
                                            and (LP_Points_Expiry_Date__c = NULL or LP_Points_Expiry_Date__c <= :Date.today())
                                            and LP_Statement_Only__c = False
                                 group by LP_Points_Category__c];
        for (AggregateResult ar : groupedResults)  {
            If(ar != NULL && ar.get('LP_Points_Category__c') != NULL){
                UserScore.put(string.valueof(ar.get('LP_Points_Category__c')), Integer.valueof(ar.get('expr0')));
            }
        }
        return UserScore;
    }
    
    @AuraEnabled
    public static LP_Tier__c getMaxPointsfromTier() {
        String AccountStatus = [select Account.LP_Status__c from user where id = :userinfo.getuserid()].Account.LP_Status__c;
        LP_Tier__c Tier = [select id, LP_Maximum_Point__c, LP_Minimum_Point__c from LP_Tier__c where name= :AccountStatus LIMIT 1];
        return Tier;
    }
    
    @AuraEnabled
    public static string getEMail() {
       
        String PtrMangrEMailID = [select user.account.Partner_Manager_Email__c from user where id =:userinfo.getuserid()].account.Partner_Manager_Email__c; 
        return PtrMangrEMailID;
    }
}