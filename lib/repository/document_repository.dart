import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:docscan/model/document_model.dart';

class DocumentRepository {
  final _baseUrl = 'http://127.0.0.1:8000/api/scanner';
  Future getData() async {
    final response = await http.get(Uri.parse(_baseUrl));
    try {
      if (response.statusCode == 200) {
        // final json = "[" + response.body + "]";
        // Iterable it = jsonDecode(json);
        // List<Dcmn> docsans = it.map((e) => Dcmn.fromJson(e)).toList();
        // return jsonEncode(response.body);
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        final docsans = jsonResponse.map((e) => Dcmn.fromJson(e)).toList();
        return docsans;
      }
    } catch (e) {
      print(e.toString());
    }
  // Future<List<Dcmn>> getData() async {
  //   try {
  //     final response = await http.get(Uri.parse(_baseUrl));
  //     if (response.statusCode == 200) {
  //       final jeson = jsonDecode(response.body) as List;
  //       final docsans = jeson.map((e) => Dcmn.fromJson(e)).toList();
  //       return docsans;
  //     } else {
  //       throw Exception("Failed to load Documents!");
  //     }
  //     // Iterable documentsList = jsonDecode(response.body);
  //     // List<Dcmn> documents =
  //     //     documentsList.map((document) => Dcmn.fromJson(document)).toList();
  //     //     print(documentsList);
  //     // return documents;
  //   } catch (e) {
  //     rethrow;
  //   }

// Future getData() async {
//     final response = await http.get(Uri.parse(_baseUrl));
//     Iterable DocsList = jsonDecode(response.body);
//     List docs = DocsList.map((docs) => Dcmn.fromJson(docs)).toList();
//     return docs;
//   }
  }




// import 'package:flutter_bloc_example/models/user.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class UserRepository {
//   static const String baseUrl =
//       "https://api.mlab.com/api/1/databases/<MY-DB>/collections";
//   static const String apiKey = "apiKey=<PLACE_API_KEY_HERE>";

//   Future<List<User>> getAllUsers() async {
//     var response = await http.get("$baseUrl/users?$apiKey");
//     Iterable userList = json.decode(response.body);
//     List<User> users = userList.map((user) => User.fromJson(user)).toList();
//     return users;
//   }

//   Future<User> getUserById(String id) async {
//     var response = await http.get("$baseUrl/users/$id?$apiKey");
//     var jsonUser = json.decode(response.body);
//     User user = User.fromJson(jsonUser);
//     return user;
//   }

//   Future<bool> createUser(User user) async {
//     var response = await http.post(
//       "$baseUrl/users?$apiKey",
//       headers: {"Content-Type": "application/json"},
//       body: json.encode(
//         user.toJson(),
//       ),
//     );
//     return response.statusCode == 200;
//   }

//   Future<bool> updateUser(User user) async {
//     var response = await http.put(
//       "$baseUrl/users/${user.id}?$apiKey",
//       headers: {"Content-Type": "application/json"},
//       body: json.encode(user.toJson()),
//     );
//     return response.statusCode == 200;
//   }

//   Future<bool> deleteUser(String id) async {
//     var response = await http.delete("$baseUrl/users/$id?$apiKey");
//     return response.statusCode == 200;
//   }
}