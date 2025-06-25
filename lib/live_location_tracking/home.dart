import 'package:flutter/material.dart';
import 'package:flutter_map_application/live_location_tracking/location_service.dart';
import 'package:flutter_map_application/live_location_tracking/models/place_model.dart';
  import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late LocationService locationService;

  @override
  void initState() {
    locationService = LocationService();
    updateMyLocation();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController;
    super.dispose();
  }

  bool isFirst = true;
  GoogleMapController? googleMapController;
 //late Location location;
  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
    
      GoogleMap(
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
          },
          //   cameraTargetBounds: CameraTargetBounds(LatLng),
          initialCameraPosition: CameraPosition(
              target: LatLng(31.187084851056554, 29.928110526889437
                  //31.415395310317678, 31.814447624495624
                  ),
              zoom: 13)),
      
      ElevatedButton(
          onPressed: () async{
            googleMapController!.animateCamera(CameraUpdate.newLatLng(
               LatLng(20, 50))); //newCameraPosition(NewL LatLng(50, 20)))
/*
try {
  List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
  print(placemarks.first);
} catch (e) {
  print("Error: $e");
}*/
          },
          child: Text("click Here"))
    ]));
  }

  void initMarker() async {
    var markerIcon = await BitmapDescriptor.asset(
      ImageConfiguration(),
      "assets/picture.png",
    );

    var myMarker = places.map(
      (e) {
        return Marker(
            markerId: MarkerId(e.id.toString()),
            position: e.latLng,
            infoWindow: InfoWindow(title: e.name),
            icon: markerIcon);
      },
    ).toSet();
    //Marker(markerId: MarkerId("1"),position: LatLng(30.315732297932698, 31.73647235848125));
    markers.addAll(myMarker);
    setState(() {});
  }

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission =
        await locationService.checkAndRequestLocationPermission();

    if (hasPermission) {
      locationService.getRealTimeLocationData((locationData) {
        setMyLocationMarker(locationData);
        setMyCameraPosition(locationData);
        setState(() {});
      });
//getRealTimeLocationData( );
    } else {}
  }

  void setMyCameraPosition(LocationData locationData) {
    if (isFirst) {
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
          zoom: 5);

      googleMapController?.animateCamera(CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!)));
      isFirst = false;
    } else {
      googleMapController?.animateCamera(CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!)));
    }
  }

  void setMyLocationMarker(LocationData locationData) {
    var myLocationMarker = Marker(
        markerId: MarkerId("zzzzzzz"),
        position: LatLng(locationData.latitude!, locationData.longitude!));

    markers.add(myLocationMarker);
    setState(() {});
  }
/*
    void getRealTimeLocationData( ) {
      location.changeSettings(
        distanceFilter: 2
      );
    location.onLocationChanged.listen( (locationData){
      var cameraPosition=CameraPosition(target: LatLng(locationData.longitude!, locationData.latitude!),zoom: 10);
     var myLocationMarker=Marker(markerId:MarkerId("zzzzzzz"),position: LatLng(locationData.longitude!, locationData.latitude!) );
     markers.add(myLocationMarker);
     setState(() {
       
     });
          googleMapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    });
  }
*/
}
