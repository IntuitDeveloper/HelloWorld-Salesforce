public class QB_ConnectedController {
    public static String companyInfo {
        get { return companyInfo; }
        set { companyInfo = value; }
    }
    public static String statusMessage {
        get { return statusMessage; }
        set { statusMessage = value; }
    }
    
    public static String statusMessageAccount {
        get { return statusMessageAccount; }
        set { statusMessageAccount = value; }
    }
    
    public static String accountInfo {
        get { return accountInfo; }
        set { accountInfo = value; }
    }
    
    public static String accountNameInput {
        get { return accountNameInput; }
        set { accountNameInput = value; }
    }
    
     public static String accountIdInput {
        get { return accountIdInput; }
        set { accountIdInput = value; }
    }
    
    public static void getCompanyInfo() {
        try{
            API_Token__c apiToken = [Select Access_Token__c, Realm_ID__c from API_Token__c ORDER BY LastModifiedDate DESC limit 1];
            String accessToken = apiToken.Access_Token__c ;
            String realmId = apiToken.Realm_ID__c;
            String endPoint = '/companyinfo/'+realmId;
            HttpResponse httpResponse = new HttpResponse();
            httpResponse = QB_HelloWorldController.makeHttpGetRequest(endPoint);
            statusMessage = 'API Callout Status : ' + httpResponse.getStatus();
            if(httpResponse.getStatusCode() == 200){
                companyInfo = httpResponse.getBody();
            }
            companyInfo = httpResponse.getBody(); //TODO - handle error status codes
        }
        catch(System.Exception e){
            System.debug('Exception found in class QB_ConnectedController method getCompanyInfo ' + e.getMessage());
            System.debug('Exception found in class QB_ConnectedController method getCompanyInfo ' + e.getLineNumber());
            statusMessage = 'Exception: ' + e.getMessage();
        }
    } 
    
    public static void createAccount () {
        try {
            AccountEntity obj = new AccountEntity();
            obj.Name = accountNameInput;
            obj.AccountType = 'Accounts Receivable';
            String endPoint = '/account';
            String reqBody = JSON.serialize(obj);
            HttpResponse httpResponse = new HttpResponse();
            httpResponse = QB_HelloWorldController.makeHttpPostRequest(endPoint, reqBody);
            statusMessageAccount = 'API Callout Status : ' + httpResponse.getStatusCode() + ' : ' + httpResponse.getStatus();
            if(httpResponse.getStatusCode() == 200){
                accountInfo = httpResponse.getBody();
            }
            accountInfo = httpResponse.getBody(); //TODO - handle error status codes
        }
        catch(System.Exception e){
            System.debug('Exception found in class QB_ConnectedController method createAccount ' + e.getMessage());
            System.debug('Exception found in class QB_ConnectedController method createAccount ' + e.getLineNumber());
            statusMessageAccount = 'Exception: ' + e.getMessage();
        } 
    }
    
    public static void getAccountById() {
        try{
            API_Token__c apiToken = [Select Access_Token__c, Realm_ID__c from API_Token__c ORDER BY LastModifiedDate DESC limit 1];
            String accessToken = apiToken.Access_Token__c ;
            String endPoint = '/account/'+accountIdInput;
            HttpResponse httpResponse = new HttpResponse();
            httpResponse = QB_HelloWorldController.makeHttpGetRequest(endPoint);
            statusMessageAccount = 'API Callout Status : ' + httpResponse.getStatus();
            if(httpResponse.getStatusCode() == 200){
                accountInfo = httpResponse.getBody();
            }
            //TODO - handle error status codes
        }
        catch(System.Exception e){
            System.debug('Exception found in class QB_ConnectedController method getCompanyInfo ' + e.getMessage());
            System.debug('Exception found in class QB_ConnectedController method getCompanyInfo ' + e.getLineNumber());
            statusMessageAccount = 'Exception: ' + e.getMessage();
        }
    } 
}