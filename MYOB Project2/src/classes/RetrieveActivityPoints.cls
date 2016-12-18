public class RetrieveActivityPoints {
    @AuraEnabled
    public static List<LP_Partner_Activities__c> getActivityPoints (){
        ID ContactID = [select contactid from user where id = :userinfo.getUserId()].id;
        String PartnerName = [select Account.name from Contact where id = :ContactID].name;
        List<LP_Partner_Activities__c> Records = new List<LP_Partner_Activities__c>();
        Records =[select LP_Start_Date__c, LP_Category__c, LP_Activity__c, LP_Points__c 
                 from LP_Partner_Activities__c
                 where LP_Account__r.name = :PartnerName];
        return Records;
    }
}