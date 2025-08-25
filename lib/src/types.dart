class TCoords {
  final double accuracy;
  final double altitude;
  final double altitudeAccuracy;
  final double heading;
  final double latitude;
  final double longitude;
  final double speed;

  const TCoords({
    required this.accuracy,
    required this.altitude,
    required this.altitudeAccuracy,
    required this.heading,
    required this.latitude,
    required this.longitude,
    required this.speed,
  });

  Map<String, dynamic> toJson() => {
    'accuracy': accuracy,
    'altitude': altitude,
    'altitudeAccuracy': altitudeAccuracy,
    'heading': heading,
    'latitude': latitude,
    'longitude': longitude,
    'speed': speed,
  };

  factory TCoords.fromJson(Map<String, dynamic> json) => TCoords(
    accuracy: (json['accuracy'] as num).toDouble(),
    altitude: (json['altitude'] as num).toDouble(),
    altitudeAccuracy: (json['altitudeAccuracy'] as num).toDouble(),
    heading: (json['heading'] as num).toDouble(),
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    speed: (json['speed'] as num).toDouble(),
  );
}

class TLocation {
  final TCoords coords;
  final bool mocked;
  DateTime timestamp;

  TLocation({
    required this.coords,
    required this.mocked,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'coords': coords.toJson(),
    'mocked': mocked,
    'timestamp': timestamp.millisecondsSinceEpoch,
  };

  factory TLocation.fromJson(Map<String, dynamic> json) => TLocation(
    coords: TCoords.fromJson(json['coords']),
    mocked: json['mocked'] as bool,
    timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
  );
}

class TLocationHistory {
  final List<TLocation> locations;

  TLocationHistory({List<TLocation>? locations}) : locations = locations ?? [];

  Map<String, dynamic> toJson() => {
    'locations': locations.map((loc) => loc.toJson()).toList(),
  };

  factory TLocationHistory.fromJson(Map<String, dynamic> json) =>
      TLocationHistory(
        locations: (json['locations'] as List<dynamic>)
            .map((e) => TLocation.fromJson(e))
            .toList(),
      );
}

/// Options pour configurer le gestionnaire
class GeolocationOptions {
  final int distanceThreshold;
  final Future<TLocationHistory?> Function() loadHistory;
  final Future<void> Function(TLocationHistory) saveHistory;

  GeolocationOptions({
    this.distanceThreshold = 100,
    required this.loadHistory,
    required this.saveHistory,
  });
}
