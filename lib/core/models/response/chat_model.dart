import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_me_to_speak/core/models/response/customer_model.dart';

class Chat {
  final String conversationId;
  final Customer customer;
  final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;
  Chat(this.customer, this.snapshot, this.conversationId);
}
