@isTest
private class QB_OAuthRedirectControllerTest {
	
	@isTest static void testGetAccessToken () {
		PageReference pageRef = QB_OAuthRedirectController.getAccessToken();
		Sample_App_Info__mdt metadataInfo = [SELECT App_URL__c FROM Sample_App_Info__mdt];
        String appUrl = metadataInfo.App_URL__c;
		System.assert(pageRef.getUrl().startsWith(appUrl));

	}
	
}