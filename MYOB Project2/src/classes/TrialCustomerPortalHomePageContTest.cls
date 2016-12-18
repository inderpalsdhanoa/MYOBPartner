@istest(seeAlldata = true)
public class TrialCustomerPortalHomePageContTest {
   
   
   public static testmethod void TrialCustomerPortalHomePageContTest() {
        TrialCustomerPortalHomePageController tcp= new TrialCustomerPortalHomePageController();
        tcp.SortProducts();
        tcp.SortCases();
        tcp.SortSolutions();
        tcp.SortIdeas();
   }
   
   
}