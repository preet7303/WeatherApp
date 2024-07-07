//In this model.dart I've written whole API code in dart format from json by converting
//it into dart from json which helps me to know about every variable and element of api
//Data from API is also fetched in this page only

import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherDetails {
  final String location;
  final double temperature;
  final String condition;
  final double windspeed;
  final int humidity;

  WeatherDetails({
    required this.location,
    required this.temperature,
    required this.condition,
    required this.windspeed,
    required this.humidity,
  });

  factory WeatherDetails.fromJson(Map<String, dynamic> json) {
    return WeatherDetails(
      location: json['location']['name'] ?? 'Unknown location',
      temperature: (json['current']['temp_c'] ?? 0.0).toDouble(),
      condition: json['current']['condition']['text'] ?? 'Unknown condition',
      windspeed: (json['current']['wind_kph'] ?? 0.0).toDouble(),
      humidity: (json['current']['humidity'] ?? 0).toInt(),
    );
  }
}

//Fetching data from api
Future<WeatherDetails> fetchWeather(String location) async {
  final response = await http.get(Uri.parse(
      'http://api.weatherapi.com/v1/current.json?key=5da4bc34dd394160a56211128240307&q=$location&aqi=no'));
//Error Handling
  if (response.statusCode == 200) {
    try {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return WeatherDetails.fromJson(data);
    } catch (e) {
      throw FormatException('Error parsing weather data: $e');
    }
  } else {
    throw Exception('Failed to load weather data');
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  String? tzId;
  int? localtimeEpoch;
  String? localtime;

  Location(
      {this.name,
      this.region,
      this.country,
      this.lat,
      this.lon,
      this.tzId,
      this.localtimeEpoch,
      this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    tzId = json['tz_id'];
    localtimeEpoch = json['localtime_epoch'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['region'] = this.region;
    data['country'] = this.country;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['tz_id'] = this.tzId;
    data['localtime_epoch'] = this.localtimeEpoch;
    data['localtime'] = this.localtime;
    return data;
  }
}

class Current {
  int? lastUpdatedEpoch;
  String? lastUpdated;
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windMph;
  double? windKph;
  int? windDegree;
  String? windDir;
  double? pressureMb;
  double? pressureIn;
  double? precipMm;
  double? precipIn;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  double? windchillC;
  double? windchillF;
  double? heatindexC;
  double? heatindexF;
  double? dewpointC;
  double? dewpointF;
  double? visKm;
  double? visMiles;
  double? uv;
  double? gustMph;
  double? gustKph;

  Current(
      {this.lastUpdatedEpoch,
      this.lastUpdated,
      this.tempC,
      this.tempF,
      this.isDay,
      this.condition,
      this.windMph,
      this.windKph,
      this.windDegree,
      this.windDir,
      this.pressureMb,
      this.pressureIn,
      this.precipMm,
      this.precipIn,
      this.humidity,
      this.cloud,
      this.feelslikeC,
      this.feelslikeF,
      this.windchillC,
      this.windchillF,
      this.heatindexC,
      this.heatindexF,
      this.dewpointC,
      this.dewpointF,
      this.visKm,
      this.visMiles,
      this.uv,
      this.gustMph,
      this.gustKph});

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdatedEpoch = json['last_updated_epoch'];
    lastUpdated = json['last_updated'];
    tempC = json['temp_c']?.toDouble();
    tempF = json['temp_f']?.toDouble();
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    windMph = json['wind_mph']?.toDouble();
    windKph = json['wind_kph']?.toDouble();
    windDegree = json['wind_degree'];
    windDir = json['wind_dir'];
    pressureMb = json['pressure_mb']?.toDouble();
    pressureIn = json['pressure_in']?.toDouble();
    precipMm = json['precip_mm']?.toDouble();
    precipIn = json['precip_in']?.toDouble();
    humidity = json['humidity'];
    cloud = json['cloud'];
    feelslikeC = json['feelslike_c']?.toDouble();
    feelslikeF = json['feelslike_f']?.toDouble();
    windchillC = json['windchill_c']?.toDouble();
    windchillF = json['windchill_f']?.toDouble();
    heatindexC = json['heatindex_c']?.toDouble();
    heatindexF = json['heatindex_f']?.toDouble();
    dewpointC = json['dewpoint_c']?.toDouble();
    dewpointF = json['dewpoint_f']?.toDouble();
    visKm = json['vis_km']?.toDouble();
    visMiles = json['vis_miles']?.toDouble();
    uv = json['uv']?.toDouble();
    gustMph = json['gust_mph']?.toDouble();
    gustKph = json['gust_kph']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_updated_epoch'] = this.lastUpdatedEpoch;
    data['last_updated'] = this.lastUpdated;
    data['temp_c'] = this.tempC;
    data['temp_f'] = this.tempF;
    data['is_day'] = this.isDay;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['wind_mph'] = this.windMph;
    data['wind_kph'] = this.windKph;
    data['wind_degree'] = this.windDegree;
    data['wind_dir'] = this.windDir;
    data['pressure_mb'] = this.pressureMb;
    data['pressure_in'] = this.pressureIn;
    data['precip_mm'] = this.precipMm;
    data['precip_in'] = this.precipIn;
    data['humidity'] = this.humidity;
    data['cloud'] = this.cloud;
    data['feelslike_c'] = this.feelslikeC;
    data['feelslike_f'] = this.feelslikeF;
    data['windchill_c'] = this.windchillC;
    data['windchill_f'] = this.windchillF;
    data['heatindex_c'] = this.heatindexC;
    data['heatindex_f'] = this.heatindexF;
    data['dewpoint_c'] = this.dewpointC;
    data['dewpoint_f'] = this.dewpointF;
    data['vis_km'] = this.visKm;
    data['vis_miles'] = this.visMiles;
    data['uv'] = this.uv;
    data['gust_mph'] = this.gustMph;
    data['gust_kph'] = this.gustKph;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['icon'] = this.icon;
    data['code'] = this.code;
    return data;
  }
}
