public class Paginator {
    @AuraEnabled
    public static List<LP_Partner_Activities__c> RetrieveActivityStatement (Boolean Next, Boolean Prev, Integer pagesize, Integer pagenumber){
        List<LP_Partner_Activities__c> Activity = new List<LP_Partner_Activities__c>();
        Integer offset = pagesize * pagenumber;
        String Query = 'select LP_Start_Date__c, LP_Activity__c, LP_Category__c, LP_Points__c from LP_Partner_Activities__c';
        Query = Query + ' LIMIT '+ Pagesize +' OFFSET '+ offset; 
        Activity = Database.query(query);
        return Activity;
    }  
}