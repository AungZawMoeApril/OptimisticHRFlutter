import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Location model representing latitude and longitude coordinates
class LatLng {
  const LatLng(this.latitude, this.longitude);

  final double latitude;
  final double longitude;

  /// Convert to Google Maps LatLng
  LatLng toGoogleMaps() => LatLng(latitude, longitude);

  /// Create from Google Maps LatLng
  static LatLng fromGoogleMaps(LatLng latLng) => 
    LatLng(latLng.latitude, latLng.longitude);

  @override
  String toString() => '($latitude, $longitude)';

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is LatLng &&
      other.latitude == latitude &&
      other.longitude == longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  Map<String, dynamic> toMap() => {
    'latitude': latitude,
    'longitude': longitude,
  };

  static LatLng? fromMap(Map<String, dynamic>? data) =>
    data == null
      ? null
      : LatLng(
          data['latitude'] as double,
          data['longitude'] as double,
        );
}