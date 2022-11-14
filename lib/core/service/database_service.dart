import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_me_to_speak/core/models/response/customer_model.dart';
import 'package:help_me_to_speak/core/models/response/language_model.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';

class DatabaseService {
  static final instance = DatabaseService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> register({required User user}) async {
    var status = false;
    var params = {
      'email': user.email,
      'phone_number': user.phoneNumber,
      'display_name': user.displayName,
      'photo_url': user.photoURL,
      'uid': user.uid,
    };
    await _db
        .collection('customers')
        .doc(user.uid)
        .set(params)
        .then((value) => status = true)
        .onError((error, stackTrace) => status = false);
    return status;
  }

  Future<bool> updateUserType(int type) async {
    var status = false;
    await _db
        .collection('customers')
        .doc(AuthService.instance.currentUser!.uid)
        .update({'type': type})
        .then((value) => status = true)
        .onError((error, stackTrace) => status = false);
    return status;
  }

  Future<bool> setTranslatorDocuments(List<String> storagePath) async {
    var status = false;
    await _db
        .collection('customers')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('documents')
        .doc('translator_certificate')
        .set({'file_paths': storagePath, 'is_confirmed': false});
    return status;
  }

  Future<List<Customer>> getTranslators() async {
    var result =
        await _db.collection('customers').where('type', isEqualTo: 1).get();
    List<Customer> customers = List<Customer>.from(
        result.docs.map((e) => Customer.fromJson(e.data())));
    return customers;
  }

  Future<Customer> getCustomer(uid) async {
    var result = await _db.collection('customers').doc(uid).get();
    Customer customers = Customer.fromJson(result.data()!);
    return customers;
  }

  Future<Language> getCustomerNativeLanguage(DocumentReference ref) async {
    var result = await ref.get();
    Language language =
        Language.fromJson((result.data() as Map<String, dynamic>));
    return language;
  }

  Future<List<Language>> getTranslatorSupportedLanguages() async {
    List<Language> languages = [];
    var result = await _db
        .collection('customers')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('supported_languages')
        .where("isActive", isEqualTo: true)
        .get();

    for (var item in result.docs) {
      var ref = await item.get('language') as DocumentReference;
      var getDocument = await ref.get();

      languages
          .add(Language.fromJson((getDocument.data() as Map<String, dynamic>)));
    }

    return languages;
  }
}
