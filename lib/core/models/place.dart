/// Represents a place with location information and details
class Place {
  const Place({
    required this.latLng,
    this.name,
    this.address,
    this.placeId,
    this.city,
    this.state,
    this.country,
    this.zipCode,
  });

  final LatLng latLng;
  final String? name;
  final String? address;
  final String? placeId;
  final String? city;
  final String? state;
  final String? country;
  final String? zipCode;

  @override
  String toString() => '''Place(
    latLng: $latLng,
    name: $name,
    address: $address,
    placeId: $placeId,
    city: $city,
    state: $state,
    country: $country,
    zipCode: $zipCode
  )''';

  Map<String, dynamic> toMap() => {
    'latLng': latLng.toMap(),
    'name': name,
    'address': address,
    'placeId': placeId,
    'city': city,
    'state': state,
    'country': country,
    'zipCode': zipCode,
  };

  static Place? fromMap(Map<String, dynamic>? data) =>
    data == null
      ? null
      : Place(
          latLng: LatLng.fromMap(data['latLng'] as Map<String, dynamic>)!,
          name: data['name'] as String?,
          address: data['address'] as String?,
          placeId: data['placeId'] as String?,
          city: data['city'] as String?,
          state: data['state'] as String?,
          country: data['country'] as String?,
          zipCode: data['zipCode'] as String?,
        );
}

/// Location model representing latitude and longitude coordinates
class LatLng {
  const LatLng(this.latitude, this.longitude);

  final double latitude;
  final double longitude;

  @override
  String toString() => '($latitude, $longitude)';

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