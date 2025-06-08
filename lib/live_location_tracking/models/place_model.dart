import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}
List<PlaceModel> places = [
  PlaceModel(
      id: 1,
      name: 'كافيه ومطعم بابلو',
      latLng: const LatLng(30.315732297932698, 31.73647235848125)),
  PlaceModel(
      id: 3,
      name: 'مستشفي الهدايا',
      latLng: const LatLng(30.307828614079703, 31.714272864402577)),
  PlaceModel(
      id: 2,
      name: 'الهندسه للحاويات',
      latLng: const LatLng(30.289323716980782, 31.747908084450803))
];