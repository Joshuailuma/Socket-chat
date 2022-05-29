import 'package:http/http.dart' as http;
import 'dart:convert';

class InternetManager {
//   Future<Weather> getWeather() async {
//     String url = 'http://localhost:300';

//     final response = await http.post(Uri.parse(url));

//     if (response.statusCode == 200) {
//       var jsonString = response.body; //Raw data

//       var ourMap = json.decode(jsonString);
//       //Has been converted to map

//       var weatherModel = Weather.fromJson(
//           ourMap); //So we can assign the real data from the internet into the models created

//       return weatherModel;
//     } else {
//       throw Exception(Exception);
//     }
//   }
// }

  Future<String> fetchData(String name, email, password) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/v1/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        print('200');
        var jsonString = response.body; //Raw data

        Map<String, dynamic> ourMap = json.decode(jsonString);
        // var name = ourMap['user']['name'];
        String loginToken = ourMap['token'];
        return loginToken;
//       /Has been converted to map
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        // return InternetModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        print('401');
        var jsonString = response.body; //Raw data

        Map<String, dynamic> ourMap = json.decode(jsonString);
        String error = ourMap['msg'];
        return error;
      } else {
        print('Failed to login');
        return 'Failed to login';
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to login.');
      }
    } on Exception catch (_) {
      return 'A problem occured';
    }
  }

  Future<String> fetchLoginAuth() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5000/'));

      if (response.statusCode == 200) {
        print('200');
        var jsonString = response.body; //Raw data

        Map<String, dynamic> ourMap = json.decode(jsonString);
        // var name = ourMap['user']['name'];
        print(jsonString);
        String message = ourMap['msg'];
        return message;
//       /Has been converted to map
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        // return InternetModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        print('401');
        var jsonString = response.body; //Raw data

        Map<String, dynamic> ourMap = json.decode(jsonString);
        String error = ourMap['msg'];
        return error;
      } else {
        print('Failed to login');
        return 'Failed to login';
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to login.');
      }
    } on Exception catch (_) {
      return 'A problem occured';
    }
  }
}
