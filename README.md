# RMErrors
[![Build Status](https://travis-ci.org/ride/RMErrors.svg?branch=master)](https://travis-ci.org/ride/RMErrors)

> Powerful Error Handling for **iOS** and **OSX** apps

RMErrors describes instances `NSError` and returns friendly messages following rules set in a simple property list.

## How it Works

The following example RMErrors.plist will setup RMErrors to:

* NSError with domain `NSURLErrorDomain` and code between `-1003` and `-1009` will be described with friendly message `the connection failed because the device is not connected to the internet`.
* NSError with domain `NSURLErrorDomain` and code `-1001` will be described with friendly message `The connection timed out, please make sure you&apos;re connected to the internet and try again`.
* NSError with domain `NSURLErrorDomain` and other codes not included by any of the previous rules will be described with friendly message `Network issue`
* NSError with domain other than `NSURLErrorDomain` will be described with friendly message `Oopss, something went wrong`.


```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>(default)</key>
	<dict>
		<key>code</key>
		<integer>-1</integer>
		<key>friendlyMessage</key>
		<string>Oopss, something went wrong</string>
	</dict>
	<key>domains</key>
	<dict>
		<key>NSURLErrorDomain</key>
		<dict>
			<key>(default)</key>
			<dict>
				<key>transient</key>
				<true/>
				<key>friendlyMessage</key>
				<string>Network issue</string>
			</dict>
			<key>codes</key>
			<dict>
				<key>-1009..-1003</key>
				<dict>
					<key>transient</key>
					<true/>
					<key>friendlyMessage</key>
					<string>the connection failed because the device is not connected to the internet</string>
				</dict>
				<key>-1001</key>
				<dict>
					<key>transient</key>
					<true/>
					<key>friendlyMessage</key>
					<string>The connection timed out, please make sure you&apos;re connected to the internet and try again</string>
				</dict>
			</dict>
		</dict>
	</dict>
</dict>
</plist>

```


## Usage

### Install from Cocoapods

```rb
pod 'RMErrors'
```

```bash
$ pod install
```

### Prepare configuration file

Create a new property list file in your project and make sure it's included in all the Xcode targets you intent to use from.

### Initialize

```obj-c
RMErrors *errors = [[RMErrors alloc] init];
[errors loadPropertyList]; //loads from RMErrors.plist in main bundle.
```

### Describing Errors

```obj-c
RMErrorDescription *description = [errors describe:[NSError errorWithDomain:@"com.foo.bar.oopsie" code:500 userInfo:nil]];
NSLog(@"Friendly Message: %@", description.friendlyMessage);
```

Outputs:

    "Oopss, something went wrong"

## Test & Enhance

```bash
$ cd Tests && pod install
$ open RMErrors.xcworkspace
```
