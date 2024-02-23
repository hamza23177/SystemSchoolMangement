// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  Employee(
      {required this.id,
      required this.fName,
      required this.mName,
      required this.lName,
      required this.active,
      required this.fullName,
      required this.addressId,
      required this.birthday,
      required this.phone,
      required this.email,
      required this.image,
      required this.jobType,
      required this.eduDegree,
      required this.startDate,
      required this.endDate});

  int id;
  String fName;
  String mName;
  String lName;
  int active;
  String fullName;
  int addressId;
  String birthday;
  String phone;
  String email;
  String image;
  String jobType;
  String eduDegree;
  String startDate;
  String endDate;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
      id: json["id"],
      fName: json["f_name"],
      mName: json["m_name"],
      lName: json["l_name"],
      active: json["active"],
      fullName: json["full_name"],
      addressId: json["address_id"],
      birthday: json["birthday"],
      phone: json["phone"],
      email: json["email"],
      image: json["image"],
      jobType: json["job_type"],
      eduDegree: json["edu_degree"],
      startDate: json["start_date"],
      endDate: json["end_date"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "m_name": mName,
        "l_name": lName,
        "active": active,
        "full_name": fullName,
        "address_id": addressId,
        "birthday": birthday,
        "phone": phone,
        "email": email,
        "image": image,
        "job_type": jobType,
        "edu_degree": eduDegree,
        "start_date": startDate,
        "end_date": endDate
      };
}
