# easygeolocation

A easy way to get the current location of the device;

## Usage

To use this plugin, add geolocator as a dependency in your pubspec.yaml file. For example:

```yaml
dependencies:
  easygeolocation: '^1.0.0'
```

> NOTE: There's a known issue with integrating plugins that use Swift into a Flutter project created with the Objective-C template. See issue Flutter#16049 for help on integration.

## API

### Easygeolocation

getCurrentPosition

```dart
import 'package:easygeolocation/easygeolocation.dart';

Map locationData = await Easygeolocation.getCurrentPosition;
// {latitude: 37.785834, longitude: -122.406417, status: ok}
```

## Permissions

### Android

On Android you'll need to add either the ACCESS_COARSE_LOCATION or the ACCESS_FINE_LOCATION permission to your Android Manifest. Todo so open the AndroidManifest.xml file and one of the following two lines as direct children of the <manifest> tag:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

> **NOTE:** Specifying the `ACCESS_COARSE_LOCATION` permission results in location updates with an accuracy approximately equivalant to a city block. More information can be found [here](https://developer.android.com/training/location/retrieve-current#permissions).

### iOS

On iOS you'll need to add the `NSLocationWhenInUseUsageDescription` to your Info.plist file in order to access the device's location. Simply open your Info.plist file and add the following:

``` xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open.</string>
```