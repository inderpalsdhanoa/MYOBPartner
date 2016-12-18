public class ActivityTiles {
    // Chris Whitbread
    @AuraEnabled
    public static String getUserName() {
        return userinfo.getName();
    }
    
    @AuraEnabled
    public static Map<String, Integer> GetUserLoyalityPoints(){
        Map<String, Integer> UserScore = new Map<String, Integer>();
        AggregateResult[] groupedResults = [select LP_Category__c, sum(LP_Points__c)
                                 from LP_Partner_Activities__c 
                                 where owner.name = :userinfo.getName() 
                                 group by LP_Category__c];
        for (AggregateResult ar : groupedResults)  {
            If(ar != NULL){
                UserScore.put(string.valueof(ar.get('LP_Category__c')), Integer.valueof(ar.get('expr0')));
                //system.debug('########' + string.valueof(ar.get('LP_Category__c')) + '########' + Integer.valueof(ar.get('expr0')));
            }
        }
        return UserScore;
    }
}