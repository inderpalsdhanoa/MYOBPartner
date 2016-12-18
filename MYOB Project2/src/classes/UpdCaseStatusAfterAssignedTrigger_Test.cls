@isTest(seealldata=true)
public class UpdCaseStatusAfterAssignedTrigger_Test {
  	public static List<AgentWork> newAgentWorkList;
    public static Datetime Datetimenow;
    public static ServiceChannel serviceChannel;
    public static Account accnt1;
    public static Case case1;
    public static User user1;
    
    static void init(){ 
		serviceChannel = [SELECT Id FROM ServiceChannel WHERE Masterlabel = 'Cases Channel'];
        accnt1 = [SELECT Id FROM Account WHERE Name = '1 Place Limited'];
        case1 = new Case(Origin = 'Web', Accountid = accnt1.Id);
        insert case1;
        
        user1 = new User();
        user1.id = UserInfo.getUserId(); 
     
        newAgentWorkList = New List<AgentWork>();
        Datetimenow = System.now();
        newAgentWorkList.add(New AgentWork(
             //ServiceChannelId = '0N9O0000000003U',
            ServiceChannelId = serviceChannel.Id,
      		UserId = user1.Id,
            //WorkItemId = '500O000000A4x5q'
            WorkItemId = case1.Id
        ));   
 
        System.runAs(user1){        
          insert newAgentWorkList; 
        }
    }    
    
    static testMethod void testAgentWorkTrigger(){
        init();
        //User user1 = new User();
        //user1.id = UserInfo.getUserId();  
        System.runAs(user1){
            Test.startTest();
            update newAgentWorkList;
            Test.stopTest();
        }
    }
}