
# HelloWorld-Salesforce
The [Intuit Developer team](https://developer.intuit.com) has written this starter app in the Salesforce platform with Apex controllers and Visualforce pages to provide working examples of OAuth 2.0 concepts, and how to integrate with Intuit endpoints.
 
This sample app is meant to provide working examples of how to integrate your app with the Intuit Small Business ecosystem. Specifically, this sample application demonstrates the following:
* Connecting to Quickbooks via OAuth 2.0
* Sample GET/POST requests to CompanyInfo and Account entities

Please note that while these examples work, features not called out above are not intended to be taken and used in production business applications. In other words, this is not a seed project to be taken cart blanche and deployed to your production environment.
For example, certain concerns are not addressed at all in our samples (e.g. security, privacy, scalability). In our sample apps, we strive to strike a balance between clarity, maintainability, and performance where we can. However, clarity is ultimately the most important quality in a sample app.
Therefore there are certain instances where we might forgo a more complicated implementation (e.g. caching a frequently used value, robust error handling, more generic domain model structure) in favor of code that is easier to read. In that light, we welcome any feedback that makes our samples apps easier to learn from.

## Requirements
In order to successfully run this sample app you need a few things:
* A Salesforce org sandbox
* A [developer.intuit.com](http://developer.intuit.com) account
* An app on [developer.intuit.com](http://developer.intuit.com) and the associated client id and client secret.
 
## Configuration
The files in this repository includes all the custom code, and metadata files for remote site settings and custom metadata types. A brief explanation of the code and configuration steps is provided below. You can either use the unmanaged package or clone this github project and add the files to your org manually.
 
### Code Structure
This project contains 3 Visualforce pages and controllers which will handle auth and a few sample API calls.
 
1.    QB_HelloWorld :
This is the home page or landing page for your Salesforce app. In this sample, this page only contains a button for the user to connect to Quickbooks. On clicking this button, we invoke the Intuit app center, passing the credentials, scope, and redirect URL. This returns the auth pop-up from Intuit and on successful connection, it will redirect to the URL specified in your app settings.

2.    QB_OAuth2Redirect:
This is the redirect URL specified in the Intuit Developer site settings. This page load happens behind the scenes were it gets the code from Intuit and makes a callout to fetch the access token and refresh token.

3.    QB_ConnectedPage:
After the previous step is complete, the user is redirected to this page where the main actions of the application take place. In this page, we’ve demonstrated 3 API calls:
·      Read CompanyInfo
·      Create Account
·      Read Account by ID
 
These classes and pages are included in the unmanaged package. 

### Remote Site Settings
To allow Salesforce to be able to invoke external sites, we need to whitelist the Intuit oAuth platform and QB sandbox site. These sites are listed in: Setup -> Security -> Remote Site Settings -> Click on ‘New Remote Site’. The URLs are:
* https://oauth.platform.intuit.com
* https://sandbox-quickbooks.api.intuit.com
 
These settings are included in the unmanaged package. 
 
### Custom Metadata Types
All the URLs & credentials being accessed in this sample app can be stored as custom metadata in your SF org. The project contains a custom metadata type called ‘Sample App Info’. The following fields are created:
* App URL: Link to your SF app home page
* Auth URL: Intuit’s app center i.e. https://appcenter.intuit.com/connect/oauth2
* Base URL: Quickbooks Online API base URL (for sandbox) i.e. https://sandbox-quickbooks.api.intuit.com/v3/company/
* Callback URL: Link to your SF redirect page. This URL is the same as what is configured in the Intuit Developer site -> OAuth2.0 keys -> Redirect URI section.
* Token URL: Intuit’s oAuth platform i.e. https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer
* Client ID: Client ID from Intuit Developer site
* Client Secret: Client Secret from Intuit Developer site
 
These settings are included in the unmanaged package. 

### Custom Objects
A custom object has been created to store the access token and refresh token. The object is API_Token__c and contains long text fields Access_Token__c and Refresh_Token__c. During the process of authorization, a record of API_Token__c is created/updated.
 
These objects are included in the unmanaged package. 

## Using the Unmanaged Package
The code has been packaged and is available at:

https://login.salesforce.com/packaging/installPackage.apexp?p0=04t0f000000onsp

Note: If you are installing into a sandbox organization you must replace the initial portion of the URL with http://test.salesforce.com.
The package is compatible with Winter 19 and later. Once the installation is complete, make the following config changes:
* Navigate to Setup -> Custom Metadata Types -> ‘Sample App Info’ -> Manage Records
* Update the Client ID and Client Secret with your client ID and client secret from the Intuit Developer site.
* Replace <your_org_url> with the base URL to your sandbox org in the following fields:
* App URL
* Callback URL
* Example: after replacing <your_org> the URLs would look like:
    * https://na85.salesforce.com/apex/QB_ConnectedPage
    * https://na85.salesforce.com/apex/QB_OAuth2Redirect
* List the callback URL configured above as a redirect URI on the Intuit Developer site. After logging in, navigate to My Apps -> open app -> Keys -> Redirect URIs. 
* Open webpage: https://<your_org>/apex/QB_HelloWorld to launch the Hello World application. 

