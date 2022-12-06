import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_me_to_speak/core/converter/document_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Customer {
  final String? uid, email, displayName;
  String? photoUrl;

  @DocumentConverter()
  final List<DocumentReference>? nativeLanguages, supportLanguages;
  @DocumentConverter()
  final DocumentReference? country;

  final int? phoneNumber, type;
  final bool? isApproved;

  Customer(
      {required this.email,
      required this.uid,
      this.country,
      this.supportLanguages,
      this.isApproved,
      this.nativeLanguages,
      required this.displayName,
      required this.photoUrl,
      required this.phoneNumber,
      required this.type});

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
