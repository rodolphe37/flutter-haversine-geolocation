import 'dart:math';

/// Fonction Haversine : distance en mètres entre deux points GPS
double getDistanceInMeters(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371000; // Rayon de la Terre en mètres
  final dLat = (lat2 - lat1) * pi / 180;
  final dLon = (lon2 - lon1) * pi / 180;

  final a =
      pow(sin(dLat / 2), 2) +
      cos(lat1 * pi / 180) * cos(lat2 * pi / 180) * pow(sin(dLon / 2), 2);

  final c = 2 * atan2(sqrt(a), sqrt(1 - (a)));

  return R * c;
}
