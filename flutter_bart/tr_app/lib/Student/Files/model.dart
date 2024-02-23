// To parse this JSON data, do
//
//     final modelFile = modelFileFromJson(jsonString);

import 'dart:convert';

List<ModelFile> modelFileFromJson(String str) =>
    List<ModelFile>.from(json.decode(str).map((x) => ModelFile.fromJson(x)));

String modelFileToJson(List<ModelFile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelFile {
  ModelFile({
    required this.id,
    required this.fileName,
    required this.file,
    required this.size,
    required this.employeeId,
    required this.createdAt,
  });

  int id;
  String fileName;
  String file;
  String size;
  int employeeId;
  DateTime createdAt;

  factory ModelFile.fromJson(Map<String, dynamic> json) => ModelFile(
        id: json["id"],
        fileName: json["file_name"],
        file: json["file"],
        size: json["size"],
        employeeId: json["employee_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_name": fileName,
        "file": file,
        "size": size,
        "employee_id": employeeId,
        "created_at": createdAt.toIso8601String(),
      };
}
