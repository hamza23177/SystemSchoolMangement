// To parse required this JSON data, do
//
//     final modelStudents = modelStudentsFromJson(jsonString);

import 'dart:convert';

List<ValuationModel> modelStudentsFromJson(String str) =>
    List<ValuationModel>.from(
        json.decode(str).map((x) => ValuationModel.fromJson(x)));

String modelStudentsToJson(List<ValuationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


String classidToJson(Class_id data) => json.encode(data.toJson());


class Class_id {
  Class_id({
    required this.classroomid,
  });

  String classroomid;

  Map<String, dynamic> toJson() => {"classroom_id": classroomid};
}



class ValuationModel {
  ValuationModel({
    required this.id,
    required this.fName,
    required this.mName,
    required this.lName,
    required this.fullName,
    required this.motherName,
    required this.image,
    required this.addressId,
    required this.birthday,
    required this.phone,
    required this.email,
    required this.parentPhone,
    required this.classRoomId,
  });

  int id;
  String fName;
  String mName;
  String lName;
  String fullName;
  String motherName;
  dynamic image;
  int addressId;
  String birthday;
  String phone;
  dynamic email;
  String parentPhone;
  int classRoomId;

  factory ValuationModel.fromJson(Map<String, dynamic> json) => ValuationModel(
      id: json["id"],
      fName: json["f_name"],
      mName: json["m_name"],
      lName: json["l_name"],
      fullName: json["full_name"],
      motherName: json["mother_name"],
      image: json["image"],
      addressId: json["address_id"],
      birthday: json["birthday"],
      phone: json["phone"],
      email: json["email"],
      parentPhone: json["parent_phone"],
      classRoomId: json["class_room_id"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "m_name": mName,
        "l_name": lName,
        "full_name": fullName,
        "mother_name": motherName,
        "image": image,
        "address_id": addressId,
        "birthday": birthday,
        "phone": phone,
        "email": email,
        "parent_phone": parentPhone,
        "class_room_id": classRoomId
      };
}





// class ValuationModel {
//   int? id;
//   String? description;
//   String? lecture;
//   String? subject;
//   int? teacherId;
//   int? studentId;
//   String? createdAt;
//   String? updatedAt;

//   ValuationModel(
//       {this.id,
//       this.description,
//       this.lecture,
//       this.subject,
//       this.teacherId,
//       this.studentId,
//       this.createdAt,
//       this.updatedAt});

//   ValuationModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     description = json['description'];
//     lecture = json['lecture'];
//     subject = json['subject'];
//     teacherId = json['teacher_id'];
//     studentId = json['student_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['description'] = description;
//     data['lecture'] = lecture;
//     data['subject'] = subject;
//     data['student_id'] = studentId;
//     return data;
//   }
// }
