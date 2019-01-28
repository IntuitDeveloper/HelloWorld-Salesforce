@isTest
private class QB_HelloWorldControllerTest {
	
	@isTest static void testConnectToQuickbooks() {
		PageReference pageRef = QB_HelloWorldController.connectToQuickbooks();
		String baseUrl = 'https://appcenter.intuit.com/connect/oauth2';
		System.assert(pageRef.getUrl().startsWith(baseUrl));
	}
	
}

