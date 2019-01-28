@isTest
private class QB_ConnectedControllerTest {
	
	@isTest static void testApiCallouts() {
		API_Token__c apiToken = new API_Token__c (Access_Token__c = 'XXXXXXXX', Realm_ID__c = '111111111');
		insert apiToken;
		QB_ConnectedController.getCompanyInfo();
		QB_ConnectedController.createAccount();
		QB_ConnectedController.getAccountById();
	}
	
}