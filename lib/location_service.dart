 import 'package:location/location.dart';

class LocationService {
   Location location = Location();

 Future <bool> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    print("nnnnnnnnnnnnnnnn$isServiceEnabled");
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();

      if (!isServiceEnabled) {
        return false;
      }
    }
      return true;
   }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    }

    return true;
  }

/*
 Future< bool> checkAndRequestLocationPermission() async {
    var permissionState = await location.hasPermission();
    if (permissionState== PermissionStatus.deniedForever) {
    print("111111111111111111111");
        return false;
      }       
    if (permissionState == PermissionStatus.denied) {
      permissionState = await location.requestPermission();
         print("11222222111");

      return  permissionState == PermissionStatus.granted; 
    }
             print("333333333311");

  return true;
  }
*/
    void getRealTimeLocationData(void Function(LocationData)? onData ) {
      location.changeSettings(
        distanceFilter: 2
      );
    location.onLocationChanged.listen( onData);
   
    }




}