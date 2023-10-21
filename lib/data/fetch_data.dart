import 'dart:convert';
import 'dart:developer';
import 'package:airqualityapp/data/data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

Future<AirQuality?> fetchData() async {
  // ----------------- Location / Position ------------------- //
  try {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();

    // ------------------------ API -------------------------- //

    var url = Uri.parse(
      'http://api.openweathermap.org/data/2.5/air_pollution?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey',
    );
    var response = await http.get(url);

    if (response.statusCode == 200) {
      AirQuality airQuality = AirQuality.fromJson(jsonDecode(response.body));

      switch (airQuality.aqi) {
        case 1:
          airQuality.message = 'Good';
          airQuality.emoji = 'assets/starred_eyes_emoji.png';
          break;
        case 2:
          airQuality.message = 'Fair';
          airQuality.emoji = 'assets/smile_emoji.png';
          break;
        case 3:
          airQuality.message = 'Moderate';
          airQuality.emoji = 'assets/emotionless_emoji.png';
          break;
        case 4:
          airQuality.message = 'Poor';
          airQuality.emoji = 'assets/sad_emoji.png';
          break;
        case 5:
          airQuality.message = 'Very Poor';
          airQuality.emoji = 'assets/shock_emoji.png';
          break;
        default:
      }

      print(airQuality);
      return airQuality;
    } else {
      return null;
    }
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}
