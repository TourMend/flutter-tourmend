import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class EventService {
  static Future<String> live(
      String address, String description, String eventType) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/liveEventForm.php";
      final response = await http.post(url, body: {
        "eventAddress": address,
        "eventDesc": description,
        "eventType": "live",
      });

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return 'Logging in failed due to server error!';
      }
    } catch (e) {
      return ('Error' + e.toString());
    }
  }

  static Future<String> regular(String eventName, String eventAddress,
      String eventDesc, String from, String to) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/regularEventForm.php";
      final response = await http.post(url, body: {
        "eventName": eventName,
        "eventAddress": eventAddress,
        "eventDesc": eventDesc,
        "eventType": "regular",
        "from": from,
        "to": to,
      });

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return 'Logging in failed due to server error!';
      }
    } catch (e) {
      return ('Error' + e.toString());
    }
  }
}
