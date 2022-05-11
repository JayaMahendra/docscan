// To parse this JSON data, do
//
//     final documentt = documenttFromJson(jsonString);

// import 'dart:convert';

// Documentt documenttFromJson(String str) => Documentt.fromJson(json.decode(str));

// String documenttToJson(Documentt data) => json.encode(data.toJson());

// class Documentt {
//   String? error;

//   Documentt({
//     required this.message,
//     required this.data,
//   });

  
//   // Document.withError(String errorMessage) {
//   //   error = errorMessage;
//   // }

//   String message;
//   List<Dcmn> data;

//   factory Documentt.fromJson(Map<String, dynamic> json) => Documentt(
//         message: json["message"],
//         data: List<Dcmn>.from(json["data"].map((x) => Dcmn.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

class Dcmn {
  Dcmn({
    required this.id,
    required this.idUser,
    required this.nama,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int idUser;
  String nama;
  String description;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory Dcmn.fromJson(Map<String, dynamic> json) {
   return Dcmn(
        id: json["id"],
        idUser: json["idUser"],
        nama: json["nama"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
  );}
  // factory Dcmn.fromJson(Map<String, dynamic> json) => Dcmn(
  //       id: json["id"],
  //       idUser: json["idUser"],
  //       nama: json["nama"],
  //       description: json["description"],
  //       image: json["image"],
  //       createdAt: DateTime.parse(json["created_at"]),
  //       updatedAt: DateTime.parse(json["updated_at"]),
  //     );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "nama": nama,
        "description": description,
        "image": image,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
