# SuperSaaSApiClient

An iOS/OSX appointment scheduling and reservation booking calendar API for [SuperSaaS](https://www.supersaas.com).


Register now and start using SuperSaaS for free at [https://www.supersaas.com/accounts/new](https://www.supersaas.com/accounts/new). When registering you'll receive the account and user information necessary to access your data through the API.

## Developer Documentation

The client adheres to the online developer documentation. For more information see:

[https://www.supersaas.com/info/dev](https://www.supersaas.com/info/dev)

The client uses the AFNetworking library for RESTful HTTP operations, and UICKeyChainStore for securely storing authentication credentials.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. The example app provides forms demonstrating the full range of API requests and responses.

## Requirements

+ iOS 7+ or OSX 10.9+
+ Cocoapods
+ AFNetworking (dependency)
+ UICKeyChainStore (dependency)

## Installation

SuperSaaSApiClient is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    ruby
    pod "SuperSaaSApiClient"

#### Example App

The ./Example folder contains a demo project with form views for every API method allowing a user to input parameters, submit the API request, and view the JSON response data. This gives a comprehensive demonstration of how the client's API methods work.

## Useage

The SuperSaaS API is used through static helper methods available in the `SSApiClient` class.

### Notes

+ Authentication is required for a user + account combination, and credentials are stored in the user's KeyChain for subsequent requests. Calling API methods without first authenticating with the `Login` method will result in an API error.

+ To switch account users logout and login again with a different `username` parameter.

+ The client returns `NSDictionary` objects coresponding to the JSON response data from the API. There are no "RESTful resource" classes.

+ The HTTP success and failure callbacks are easily defined inline using Completion Block syntax.

### API Methods

The following methods for managing account calendars are supported.

#### Login
#### Logout
#### Read User
#### Create User
#### Update User
#### Delete User
#### Read Forms
#### Read Recent Changes
#### Read Agenda
#### Read Free
#### Create Booking
#### Update Booking
#### Read Booking
#### Delete Booking

### Utility Methods

The following utility methods are available.

#### Is Authenticated
#### Set Debug

## Calendar UI

The SuperSaaSApiClient is a programmatic API for interacting with SuperSaaS calendar and booking data, and does not provide any UI components. There are, however, a number of other excellent Cocoapods projects that provide calendaring UI and  easily integrate with SuperSaaS. The following companion libraries are recommended:  

+ [JTAppleCalendar](https://cocoapods.org/pods/JTAppleCalendar)
+ [CVCalendar](https://cocoapods.org/pods/CVCalendar)
+ [FSCalendar](https://cocoapods.org/pods/FSCalendar)
+ [JTCalendar](https://cocoapods.org/pods/JTCalendar)
+ [MJCalendar](https://cocoapods.org/pods/MJCalendar)

## Contact

Email: [support@supersaas.com](support@supersaas.com)
Twitter: [https://twitter.com/supersaas](https://twitter.com/supersaas)
Web: [https://www.supersaas.com/info/feedback](https://www.supersaas.com/info/feedback)

## License

SuperSaaSApiClient is available under the MIT license. See the LICENSE file for more info.
