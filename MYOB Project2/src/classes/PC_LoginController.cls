public class PC_LoginController {
    public PC_LoginController(){
        
        
        //Let's retrieve the access token
        Jwt.Configuration config = new Jwt.Configuration();  
        config.jwtUsername = '*Username*';  
        config.jwtSigningCertificateName = 'jwt';  
        config.jwtHostname = 'login.salesforce.com';  
        config.jwtConnectedAppConsumerKey = '3MVG9ZL0ppGP5UrDuuJUM_rEsWssjiNNnZYbDMEys4St8gtSqYHT6_LCQSBNWy.OVRP9mk3CeC6zT0Pd7Ke4k';  
        String accessToken = new Jwt(config).requestAccessToken();
        
        
        // Now, we can call the web service
        HttpRequest req = new HttpRequest();  
        req.setMethod('GET');
        req.setEndpoint('https://devpartner-loyalty.cs6.force.com');  
        req.setHeader('Authorization', 'OAuth '+ accessToken);
        
        Http http = new Http();
        
        try {  
            HTTPResponse res = http.send(req);    
            
            //Helpful debug messages
            System.debug('STATUS:'+ res.getStatus());
            System.debug('STATUS_CODE:'+ res.getStatusCode());
            
            String accounts = res.getBody();
            
        } catch (System.CalloutException e) {
            System.debug(e.getMessage());
        }
    }
}