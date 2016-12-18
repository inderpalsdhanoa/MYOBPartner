/*
    Date            : 27-10-2016
    Author          : SMS Management & Technology
    Description     : Batch class utility
*/
public class LP_BatchUtil {
    
    // Get IDAM token
    public static String getToken(Id jobId, String element) {
        HttpRequest request = new HttpRequest();    
        request.setMethod('POST');
        request.setEndpoint('callout:MYOB_Oauth');
        request.setHeader('Content-Length', '0');
        request.setBody('grant_type=client_credentials&resource=e4139687-3ec7-4371-bfb0-f638c353347c');

        try {
            Http http = new Http();
            HttpResponse response = http.send(request);
            Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            return String.valueOf(jsonResponse.get('access_token'));        
        } catch(exception e) {
            LP_ErrorLogHandler.log('Failure to retrieve access token', string.valueOf(e), element, '', '', string.valueOf(jobId));
            return null;
        }
    }
    
    // Post to endpoint    
    public static Integer postData(String requestType, String endPoint, String accessToken, String jsonData) {
        
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        if(requestType == 'PATCH') { 
            request.setHeader('X-HTTP-Method-Override','PATCH'); 
        }
        request.setEndpoint(endPoint);
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setHeader('Content-Type','application/json');
        request.setBody(jsonData);  

        Http http = new Http();
        HttpResponse response = http.send(request);
        
        System.debug('+++++++++++++++++++++  Data : ' + response);
        System.debug('+++++++++++++++++++++  Stat : ' + response.getStatusCode());

        return response.getStatusCode();
    }  
    
    // Send email on job completion
    public static void sendEmail(String subject,Id jobID, Boolean hasError) {
        // Get apex job details
        AsyncApexJob theJob = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email, ExtendedStatus 
                                                                                                                FROM AsyncApexJob 
                                                                                                                WHERE Id = :jobID];     
        // Get the email address from custom setting 
        LS_Email_Group__c emailgrp = LS_Email_Group__c.getOrgDefaults();

        // Email with error status to be sent out on completion of the job
        String jobStatus = 'no errors.';
        if(hasError) {
            jobStatus = 'errors.';
        } 
        
        // Create url to access the Salesforce erorr log object                                                                                                         
        String baseUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        Schema.DescribeSObjectResult objErrorLog = LP_Error_Log__c.sObjectType.getDescribe();
        String objErrorURL = baseUrl + '/' +objErrorLog.getKeyPrefix();

        // Create and send the email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setUseSignature(false);
        mail.setToAddresses(new String[] {emailgrp.Name,userinfo.getUserEmail()}); // Email group from custom setting + user who manually triggers
        mail.setSubject(subject + theJob.Status);
        mail.setHtmlBody('<p>Hi <br/><br/>The batch Apex job processed ' + theJob.TotalJobItems + ' batches with '+ jobStatus +
                         '<br/><br/>Correltion ID : ' + jobID +
                         '<br/><br/><a href="'+ objErrorURL +'">'+ objErrorURL +'</a><br/><br/>MYOB<br/><br/></p>');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }
}