import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class DocumentConverter implements JsonConverter<DocumentReference, Object> {
  const DocumentConverter();

  @override
  DocumentReference<Object?> fromJson(Object json) {
    DocumentReference<Map<String, dynamic>> doc =
        (json as DocumentReference<Map<String, dynamic>>);
    return doc;
  }

  @override
  Object toJson(DocumentReference<Object?> object) {
    return Object();
  }
}
