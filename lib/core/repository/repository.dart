import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_me_to_speak/core/service/customer_service.dart';

class Repository {
  static final Repository _instance = Repository._init();
  static Repository get instance => _instance;
  Repository._init();
  CustomerService customerService =
      CustomerService(FirebaseFirestore.instance.collection('users'));
}
