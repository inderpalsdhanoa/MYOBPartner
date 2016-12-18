public class AccountController {
    
    @AuraEnabled
    public static Account getPartner() {
        String AccountName = [select Account.name from user where id = :userinfo.getuserid()].Account.name; 
        Account Acc = [select owner.name, status__c, LP_Points__c, LP_Status__c, LP_Next_Status__c, LP_Points_to_upgrade__c 
                       from account where name= :AccountName  LIMIT 1];
       return Acc;
    }
    
    @AuraEnabled
    public static List<LP_Partner_Activities__c> getAccounts() {
        List<LP_Partner_Activities__c> AllRecords = new List<LP_Partner_Activities__c>();
        List<String> parentChildAccount = new List<String>();
        string accName = [select Account.name from user where id = :userinfo.getuserid()].Account.name; 
        List<Account> accChildList = [Select Id,Name From Account Where parent.Name =: accName];
        if(accChildList != null && accChildList.size()>0){
            for(Account acc : accChildList){
                parentChildAccount.add(acc.Name);
            }
        }
        parentChildAccount.add(accName);       
        AllRecords = [select LP_Activity_Date__c, LP_Activity__c, LP_Points_Category__c, LP_Points__c 
                      from LP_Partner_Activities__c 
                      where LP_Partner_Name__r.Name in :parentChildAccount 
                      and LP_Activity_Date__c <= today
                      and (LP_Points_Expiry_Date__c = NULL or LP_Points_Expiry_Date__c <= today)
                      and LP_Statement_Only__c = False
                      Order By LP_Points__c Desc  LIMIT 15];
        
        return AllRecords;
    }
    
    @AuraEnabled
    public static List<Lead> getLeads() {
        List<Lead> AllLeads = new List<Lead>();
        List<String> parentChildAccount = new List<String>();
        string accName = [select Account.name from user where id = :userinfo.getuserid()].Account.name; 
        List<Account> accChildList = [Select Id,Name From Account Where parent.Name =: accName];
        if(accChildList != null && accChildList.size()>0){
            for(Account acc : accChildList){
                parentChildAccount.add(acc.Name);
            }
        }
        parentChildAccount.add(accName);
        AllLeads = [select id, Name, Status, Date_Created__c, LeadSource 
                    from lead 
                    where lead.account__r.name in :parentChildAccount 
                    and Date_Created__c <= today
                    Order By Date_Created__c Desc];
        return AllLeads;
    }
    
    @AuraEnabled
    public static List<Lead> getAllLeads() {
        List<Lead> AllLeads = new List<Lead>();
        String accName = [select user.account.name from user where id = :userinfo.getuserid()].Account.name;
        List<String> parentChildAccount = new List<String>();
        List<Account> accChildList = [Select Id,Name From Account Where parent.Name =: accName];
        if(accChildList != null && accChildList.size()>0){
            for(Account acc : accChildList){
                parentChildAccount.add(acc.Name);
            }
        }
        parentChildAccount.add(accName);
        AllLeads = [select FirstName, lastname, LeadSource, Name, Status, EMail 
                    from lead  
                    where lead.account__r.name in :parentChildAccount
                    and Date_Created__c <= today
                    Order By Date_Created__c Desc];
        return AllLeads;
    }
    
    @AuraEnabled
    public static List<string> getCategoryType() {
        List<string> Temp = new List<string>();
        String accName = [select user.account.name from user where id = :userinfo.getuserid()].Account.name;
        List<String> parentChildAccount = new List<String>();
        List<Account> accChildList = [Select Id,Name From Account Where parent.Name =: accName];
        if(accChildList != null && accChildList.size()>0){
            for(Account acc : accChildList){
                parentChildAccount.add(acc.Name);
            }
        }
        parentChildAccount.add(accName);
        AggregateResult[] groupedResults = [select LP_Points_Category__c, sum(LP_Points__c)
                                            from LP_Partner_Activities__c 
                                            where LP_Partner_Name__r.Name in :parentChildAccount
                                            group by LP_Points_Category__c];
        Temp.add('All Category Types');
        for (AggregateResult ar : groupedResults)  {
            Temp.add(string.valueof(ar.get('LP_Points_Category__c')));
        }
        return Temp;
    }
    
    @AuraEnabled
    public static Integer getFilterCount(String Category) {
        Integer CategoryCount;
        String accName = [select user.account.name from user where id = :userinfo.getuserid()].Account.name;
        List<String> parentChildAccount = new List<String>();
        List<Account> accChildList = [Select Id,Name From Account Where parent.Name =: accName];
        if(accChildList != null && accChildList.size()>0){
            for(Account acc : accChildList){
                parentChildAccount.add(acc.Name);
            }
        }
        parentChildAccount.add(accName);
        String whereClause = 'LP_Partner_Name__r.Name in :parentChildAccount and ';
        String query = 'Select count() From LP_Partner_Activities__c';
         
        if(Category != null && Category != '' && Category != 'All Category Types'){
            whereClause += 'LP_Points_Category__c = \''+Category+'\'';
        }
        if(whereClause != ''){
            query += ' Where '+ whereClause;
        }
        system.debug('@@query:'+query);
        CategoryCount = Database.countQuery(query);
        return CategoryCount;
    }
    
  @AuraEnabled
    public static List<LP_Partner_Activities__c> RetrieveAcccountPagination (Integer pagesize, Integer pagenumber, String StartDate, String EndDate, String category){
        String accname = [select user.account.name from user where id = :userinfo.getuserid()].Account.name;
        List<String> parentChildAccount = new List<String>();
        List<Account> accChildList = [Select Id,Name From Account Where parent.Name =: accName];
        if(accChildList != null && accChildList.size()>0){
            for(Account acc : accChildList){
                parentChildAccount.add(acc.Name);
            }
        }
        parentChildAccount.add(accName);
        List<LP_Partner_Activities__c> Activity = new List<LP_Partner_Activities__c>();
        Integer offsetVal = Integer.valueOf(pagesize) * Integer.valueOf(pagenumber);
        String Query = 'select LP_Activity_Date__c, LP_Activity__c, LP_Points_Category__c, LP_Points__c from LP_Partner_Activities__c where LP_Partner_Name__r.Name in :parentChildAccount and LP_Activity_Date__c <= today and (LP_Points_Expiry_Date__c = NULL or LP_Points_Expiry_Date__c <= today) and LP_Statement_Only__c =False';
        if(StartDate != null ){
            Query += ' AND LP_Activity_Date__c >= '+StartDate; 
        }
        if(EndDate != null){
            Query += ' AND LP_Activity_Date__c <= '+EndDate; 
        }
        if(Category != null && Category != '' && Category != 'All Category Types'){
            Query += ' AND LP_Points_Category__c = \''+Category+'\'';
        }
        Query = Query + ' Order By LP_Points__c Desc LIMIT '+ Pagesize +' OFFSET '+ offsetVal; 
        
        Activity = Database.query(query);
        return Activity;
    } 
    
    @AuraEnabled
    public static Integer RetrieveAcccountTotalRecord(String StartDate, String EndDate, String category){
        String AccName = [select user.account.name from user where id = :userinfo.getuserid()].Account.name;
        List<String> parentChildAccount = new List<String>();
        List<Account> accChildList = [Select Id,Name From Account Where parent.Name =: accName];
        if(accChildList != null && accChildList.size()>0){
            for(Account acc : accChildList){
                parentChildAccount.add(acc.Name);
            }
        }
        parentChildAccount.add(accName);
        Integer recCount = 0;
        String Query = 'select Count() from LP_Partner_Activities__c where LP_Partner_Name__r.Name in :parentChildAccount and LP_Activity_Date__c <= today and (LP_Points_Expiry_Date__c = NULL or LP_Points_Expiry_Date__c <= today) and LP_Statement_Only__c =False';
        if(StartDate != null ){ 
            Query += ' AND LP_Activity_Date__c >= '+StartDate; 
        }
        if(EndDate != null){
            Query += ' AND LP_Activity_Date__c <= '+EndDate; 
        }
        if(Category != null && Category != '' && Category != 'All Category Types'){
            Query += ' AND LP_Points_Category__c = \''+Category+'\'';
        }
        recCount = Database.countQuery(Query);
        system.debug('@@@The Count is '+Reccount);
        return recCount;
    }   
    
    @AuraEnabled
    public static List<Lead> RetrieveLeadPagination (Integer pagesize, Integer pagenumber, String SortFieldOrder){
        List<String> parentChildAccount = new List<String>();
        String AccName = [select user.account.name from user where id = :userinfo.getuserid()].Account.name;
        List<Account> accChildList = [Select Id,Name From Account Where parent.Name =: accName];
        if(accChildList != null && accChildList.size()>0){
            for(Account acc : accChildList){
                parentChildAccount.add(acc.Name);
            }
        }
        parentChildAccount.add(accName);
        List<Lead> Leads = new List<Lead>();
        Integer offsetVal = Integer.valueOf(pagesize) * Integer.valueOf(pagenumber);
        String Query = 'select FirstName, lastname, LeadSource, Name, Status, EMail, phone from lead where lead.account__r.name in :parentChildAccount';
        if(SortFieldOrder != NULL && SortFieldOrder != ''){
            Query = Query + ' ORDER BY ' + SortFieldOrder + ' NULLS LAST LIMIT '+ Pagesize +' OFFSET '+ offsetVal; 
        } else {
            Query = Query +  ' ORDER BY FIRSTNAME ASC ' + ' NULLS LAST LIMIT '+ Pagesize +' OFFSET '+ offsetVal; 
        }
        Leads = Database.query(query);
        return Leads;
    } 
    
    @AuraEnabled
    public static Integer RetrieveLeadTotalRecord(){
        List<String> parentChildAccount = new List<String>();
        String AccName = [select user.account.name from user where id = :userinfo.getuserid()].Account.name;
        List<Account> accChildList = [Select Id, Name From Account Where parent.Name =: accName];
        if(accChildList != null && accChildList.size()>0){
            for(Account acc : accChildList){
                parentChildAccount.add(acc.Name);
            }
        }
        parentChildAccount.add(accName);
        Integer recCount = 0;
        String Query = 'select Count() from lead where lead.account__r.name in :parentChildAccount';
        recCount = Database.countQuery(query);
        return recCount;
    }
    
    @AuraEnabled
    public static List<LP_Partner_Activities__c> SortAccounts(String FieldName){
        List<LP_Partner_Activities__c> AllRecords = new List<LP_Partner_Activities__c>();
        Set<String> parentChildAccount = new Set<String>();
        string accName = [select Account.name from user where id = :userinfo.getuserid()].Account.name; 
        List<Account> accChildList = [Select Id, Name From Account Where parent.Name =: accName];
        if(accChildList != null && accChildList.size()>0){
            for(Account acc : accChildList){
                parentChildAccount.add(acc.Name);
            }
        }
        parentChildAccount.add(accName);
        string Query = 'select LP_Activity_Date__c, LP_Points_Category__c, LP_Activity__c, LP_Points__c from LP_Partner_Activities__c where LP_Partner_Name__r.Name in :parentChildAccount order by '+FieldName+' '+' LIMIT 15';
        AllRecords = database.query(Query);
        return(AllRecords);
    }
    
    // Functions of MYOBLOY
    
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
    public static Map<String, Integer> GetUserLoyalityPoints(){
        Id ContID = [select contactid from user where id = :userinfo.getuserid()].contactid;
        String AccountName = [select Account.name from contact where id= :ContID].Account.name;
        Account Acc = [select OwnerId, owner.name, status__c, Points__c, Next_Status__c, Next_Level_Points__c 
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
        system.debug('@@parentChildAccount'+parentChildAccount);
        AggregateResult[] groupedResults = [select LP_Points_Category__c, sum(LP_Points__c)
                                 from LP_Partner_Activities__c 
                                 where LP_Partner_Name__r.Name in :parentChildAccount
                                            and LP_Activity_Date__c <= today
                                            and (LP_Points_Expiry_Date__c = NULL or LP_Points_Expiry_Date__c <= today)
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