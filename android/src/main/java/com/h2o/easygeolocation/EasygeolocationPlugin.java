package com.h2o.easygeolocation;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.content.Intent;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationManager;
import android.location.LocationListener;
import android.support.v4.app.ActivityCompat;
//import android.support.v7.app.AppCompatActivity;
import android.widget.Toast;


import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.HashMap;
import java.util.Map;

/** EasygeolocationPlugin */
public class EasygeolocationPlugin {
  /** Plugin registration. */
  static public final int REQUEST_LOCATION = 1;
  public static void registerWith(Registrar registrar) {
    final Activity activity = registrar.activity();
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "easygeolocation");
    channel.setMethodCallHandler(new MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, final Result result) {
        if (call.method.equals("getCurrentPosition")) {
          // Acquire a reference to the system Location Manager
//      Context cont;
          if (ActivityCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(activity, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            Map rst = new HashMap();
            rst.put("status", "notDetermined");
            result.success(rst);
            ActivityCompat.requestPermissions(activity, new String[]{Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION}, REQUEST_LOCATION);
          } else {
//            Map rst = new HashMap();
//            rst.put("status", "ok");
//            rst.put("latitude", 0);
//            rst.put("longitude", 0);
//            result.success(rst);
            LocationManager locationManager = (LocationManager) activity.getSystemService(Context.LOCATION_SERVICE);
//
            Location loc = locationManager.getLastKnownLocation(LocationManager.NETWORK_PROVIDER);
            Map rst = new HashMap();
            rst.put("status", "ok");
            rst.put("latitude", loc.getLatitude());
            rst.put("longitude", loc.getLongitude());
//            rst.put("loc", loc);
            result.success(rst);
//            Map rst = new HashMap();
//            rst.put("status", "ok");
//            rst.put("latitude", loc.getLatitude());
//            rst.put("longitude", loc.getLongitude());
//            result.success(rst);

// Define a listener that responds to location updates

//            LocationListener locationListener = new LocationListener() {
//              public void onLocationChanged(Location location) {
//                // Called when a new location is found by the network location provider.
//                Toast.makeText( activity, "~~~~~~", Toast.LENGTH_SHORT).show();
//                Map rst = new HashMap();
//                rst.put("status", "ok");
//                rst.put("latitude", location.getLatitude());
//                rst.put("longitude", location.getLongitude());
//                result.success(rst);
//              }
//
//              public void onStatusChanged(String provider, int status, Bundle extras) {}
//
//              public void onProviderEnabled(String provider) {}
//
//              public void onProviderDisabled(String provider) {}
//            };
//            locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, locationListener);
//            String locationProvider = LocationManager.NETWORK_PROVIDER;
            // Register the listener with the Location Manager to receive location updates

          }
        } else {
          result.notImplemented();
        }
      }
    });

  }


}
