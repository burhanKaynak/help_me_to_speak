import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_me_to_speak/core/converter/document_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Customer {
  final String? uid, email, displayName, photoUrl;

  @DocumentConverter()
  final DocumentReference? nativeLanguage;
  final int? phoneNumber, type;

  Customer(this.uid,
      {required this.email,
      this.nativeLanguage,
      required this.displayName,
      required this.photoUrl,
      required this.phoneNumber,
      required this.type});

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
