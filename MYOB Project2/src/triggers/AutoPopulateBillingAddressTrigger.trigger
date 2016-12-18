trigger AutoPopulateBillingAddressTrigger on Account (before insert, before update) {

if ((trigger.isInsert || trigger.isUpdate) && trigger.isBefore) {
   for ( Account account: Trigger.New) {
        if (account.Copy_Head_Office_Address_to_Billing__c == true) {
             if (account.Head_Office_Coutnry__c != null) {
                 account.Billing_Country_new__c = account.Head_Office_Coutnry__c;
             }
             if (account.Head_Office_Street__c != null) {
                 account.Billing_Street_new__c = account.Head_Office_Street__c;
             }
             if (account.Head_Office_City__c != null) {
                 account.Billing_City_new__c = account.Head_Office_City__c;
             }
             if (account.Head_Office_State__c != null) {
                 account.Billing_State_new__c = account.Head_Office_State__c;
             }
             if (account.Head_Office_Zip_Postal_Code__c != null) {
                 account.Billing_Zip_new__c = account.Head_Office_Zip_Postal_Code__c;
             }
           }
      }
}
}