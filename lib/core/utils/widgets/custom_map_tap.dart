// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';;
import '../core/utils/app_utils.dart';;
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:hr_app/core/utils/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:hr_app/core/models/lat_lng.dart'; // FlutterFlow's LatLng
import 'package:geolocator/geolocator.dart'; // Geolocator

class CustomMapTap extends StatefulWidget {
  const CustomMapTap({
    super.key,
    this.width,
    this.height,
    this.onMarkerMoved,
    this.distanceThreshold,
    this.onInitialPositionSet,
    this.addresstimeInterval,
    this.checkinpinstatus,
    this.locstatus,
  });

  final double? width;
  final double? height;
  final Future Function(LatLng? moveMarker)? onMarkerMoved;
  final String? distanceThreshold;
  final Future Function(LatLng? initialLocation)? onInitialPositionSet;
  final int? addresstimeInterval;
  final bool? checkinpinstatus;
  final Future Function(bool? distancestatus)? locstatus;

  @override
  State<CustomMapTap> createState() => _CustomMapTapState();
}

class _CustomMapTapState extends State<CustomMapTap> {
  gmap.GoogleMapController? _mapController;
  late gmap.LatLng _centerPosition;
  late gmap.LatLng _markerPosition;
  Timer? _tapHoldTimer;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _centerPosition = const gmap.LatLng(0.0, 0.0);
    _markerPosition = _centerPosition;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentLocation();
      widget.locstatus?.call(false);
    });
  }

  void _onMapCreated(gmap.GoogleMapController controller) {
    _mapController = controller;
    if (_centerPosition.latitude == 0.0 && _centerPosition.longitude == 0.0) {
      _getCurrentLocation();
    } else {
      _moveCameraToPosition(_centerPosition);
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() => _isLoadingLocation = true);

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        setState(() => _isLoadingLocation = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permission denied.');
          setState(() => _isLoadingLocation = false);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        print('Location permission permanently denied.');
        setState(() => _isLoadingLocation = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      gmap.LatLng currentLatLng =
          gmap.LatLng(position.latitude, position.longitude);

      setState(() {
        _centerPosition = currentLatLng;
        _markerPosition = currentLatLng;
        _isLoadingLocation = false;
      });

      widget.onInitialPositionSet
          ?.call(LatLng(currentLatLng.latitude, currentLatLng.longitude));
      _moveCameraToPosition(currentLatLng);

      widget.locstatus?.call(false);
    } catch (e) {
      print('Error getting location: $e');
      setState(() => _isLoadingLocation = false);
    }
  }

  void _moveCameraToPosition(gmap.LatLng position) {
    _mapController?.animateCamera(
      gmap.CameraUpdate.newLatLngZoom(position, 16),
    );
  }

  void _onMapTapped(gmap.LatLng tappedPosition) {
    _tapHoldTimer?.cancel();

    setState(() {
      _markerPosition = tappedPosition;
    });

    _moveCameraToPosition(tappedPosition);

    // Immediately check distance without delay
    double distanceThreshold =
        double.tryParse(widget.distanceThreshold ?? '') ?? 100;

    double distance = Geolocator.distanceBetween(
      tappedPosition.latitude,
      tappedPosition.longitude,
      _centerPosition.latitude,
      _centerPosition.longitude,
    );

    bool status = distance > distanceThreshold;

    widget.onMarkerMoved?.call(
      LatLng(tappedPosition.latitude, tappedPosition.longitude),
    );
    widget.locstatus?.call(status);

    print('Marker moved, status: $status');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          child: gmap.GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: gmap.CameraPosition(
              target: _centerPosition,
              zoom: 16,
            ),
            mapType: gmap.MapType.normal,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: !(widget.checkinpinstatus ?? false),
            zoomGesturesEnabled: !(widget.checkinpinstatus ?? false),
            scrollGesturesEnabled: !(widget.checkinpinstatus ?? false),
            rotateGesturesEnabled: !(widget.checkinpinstatus ?? false),
            tiltGesturesEnabled: !(widget.checkinpinstatus ?? false),
            mapToolbarEnabled: false,
            onTap: (widget.checkinpinstatus ?? false) ? null : _onMapTapped,
            markers: {
              gmap.Marker(
                markerId: const gmap.MarkerId("current_marker"),
                position: _markerPosition,
                draggable: false,
              ),
            },
          ),
        ),
        if (_isLoadingLocation)
          const Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        Positioned(
          top: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: _getCurrentLocation,
            backgroundColor: Colors.white,
            mini: true,
            child: const Icon(
              Icons.my_location,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _tapHoldTimer?.cancel();
    super.dispose();
  }
}
