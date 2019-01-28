public class QB_HelloWorldController {
    public static String statusMessage {
        get { return statusMessage; }
        set { statusMessage = value; }
    }
    
    public static String baseURL {
        get { return baseURL; }
        set { baseURL = value; }
    }
    
    public static PageReference connectToQuickbooks () {
        try {
            
            Sample_App_Info__mdt metadataInfo = [SELECT Client_ID__c, Client_Secret__c, Auth_URL__c, Callback_URL__c FROM Sample_App_Info__mdt];
            String clientId = metadataInfo.Client_ID__c;
            String callbackUrl = metadataInfo.Callback_URL__c;   
            String authEndpoint = metadataInfo.Auth_URL__c;
            String scope = 'com.intuit.quickbooks.accounting';
            
            String endPoint = authEndpoint + '?client_id=' + clientId + '&state=1234&response_type=code&scope=' +scope+ '&redirect_uri=' + callbackUrl;
            PageReference pageRef = new PageReference(endPoint);
            return pageRef;
        }
        catch(System.Exception e){
            System.debug('Exception found in class QB_HelloWorldController method connectToQuickbooks ' + e.getMessage());
            System.debug('Exception found in class QB_HelloWorldController method connectToQuickbooks ' + e.getLineNumber());
            statusMessage = 'Exception: ' + e.getMessage();
            return null;
        } 
    }
    
    public static HttpResponse makeHttpGetRequest (String endPointPath) {
        Sample_App_Info__mdt urlInfo = [SELECT Base_URL__c FROM Sample_App_Info__mdt];
        baseURL = urlInfo.Base_URL__c;
        
        API_Token__c apiToken = [Select Access_Token__c, Realm_ID__c from API_Token__c ORDER BY LastModifiedDate DESC limit 1];
        String accessToken = apiToken.Access_Token__c ;
        String realmId = apiToken.Realm_ID__c;
        
        String errorMessage ='';
        String endPoint = baseURL + realmId + endPointPath;
        HttpRequest httpReq = new HttpRequest();
        HttpResponse httpRes = new HttpResponse();
        Http http = new Http();
        httpReq.setMethod('GET');
        httpReq.setEndPoint(endPoint);
        httpReq.setHeader('Authorization' , 'Bearer ' + accessToken);
        httpReq.setHeader('Accept' , 'application/json');
        
        try{
            httpRes = http.send(httpReq);
        }
        catch(System.Exception e){
            System.debug('Exception found in class QB_HelloWorldController method connectToQuickbooks ' + e.getMessage());
            System.debug('Exception found in class QB_HelloWorldController method connectToQuickbooks ' + e.getLineNumber());
        } 
        return httpRes;
    }
    
    public static HttpResponse makeHttpPostRequest (String endPointPath, String jsonPayload) {
        Sample_App_Info__mdt urlInfo = [SELECT Base_URL__c FROM Sample_App_Info__mdt];
        baseURL = urlInfo.Base_URL__c;
        
        API_Token__c apiToken = [Select Access_Token__c, Realm_ID__c from API_Token__c ORDER BY LastModifiedDate DESC limit 1];
        String accessToken = apiToken.Access_Token__c ;
        String realmId = apiToken.Realm_ID__c;
        
        String errorMessage ='';
        String endPoint = baseURL + realmId + endPointPath;
        HttpRequest httpReq = new HttpRequest();
        HttpResponse httpRes = new HttpResponse();
        Http http = new Http();
        httpReq.setMethod('POST');
        httpReq.setEndPoint(endPoint);
        httpReq.setHeader('Authorization' , 'Bearer ' + accessToken);
        httpReq.setHeader('Accept' , 'application/json');
        httpReq.setHeader('Content-Type' , 'application/json');
        httpReq.setBody(jsonPayload);
        try{
            httpRes = http.send(httpReq);
        }
        catch(System.Exception e){
            System.debug('Exception found in class QB_HelloWorldController method connectToQuickbooks ' + e.getMessage());
            System.debug('Exception found in class QB_HelloWorldController method connectToQuickbooks ' + e.getLineNumber());
        } 
        return httpRes;
    }
}