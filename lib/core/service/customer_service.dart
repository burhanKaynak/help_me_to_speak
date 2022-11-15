import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';

class CustomerService {
  final AuthService _auth = AuthService.instance;
  final CollectionReference _ref;
  CustomerService(this._ref);

  // Future<Bool> signIn() async {
  //   AuthService.instance
  //       .signInWithEmailAndPassword(email: email, password: password);
  //   var ss = await _ref.doc(_auth.currentUser!.uid).get();
  //   AuthService.instance.setCustomer();
  //   _customer =
  //       await DatabaseService.instance.getCustomer(_auth.currentUser!.uid);
  // }
}
