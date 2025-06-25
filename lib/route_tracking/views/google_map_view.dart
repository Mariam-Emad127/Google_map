import 'package:flutter/material.dart';
import 'package:flutter_map_application/route_tracking/route_location_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();

}

class _GoogleMapViewState extends State<GoogleMapView> {
    late CameraPosition initalCameraPoistion;
      late GoogleMapController googleMapController;

late LocationService locationService;
  @override
  void initState() {
 initalCameraPoistion=const CameraPosition(target: LatLng(0, 0));
 locationService=LocationService();
 locationService.getLocation();
     super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition:initalCameraPoistion,
    onMapCreated:(controller){
googleMapController=controller;
updateCurrentLocation();

    } ,
    
    );
  }
   void updateCurrentLocation()async {
    try{
var locationData=await locationService.getLocation();
//CameraPosition currentCameraPosition
CameraPosition currentCameraPosition= CameraPosition(target: LatLng(locationData.latitude!, locationData.longitude!),zoom: 16);
googleMapController.animateCamera(CameraUpdate.newCameraPosition(currentCameraPosition));
    }on LocationServiceException catch(e){
 

    }on LocationPermissionException catch(e){


    }catch(e){}
   }
}