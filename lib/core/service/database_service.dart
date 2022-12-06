import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_me_to_speak/core/models/response/customer_model.dart';
import 'package:help_me_to_speak/core/models/response/language_model.dart';
import 'package:help_me_to_speak/core/models/response/rezervation_model.dart';
import 'package:help_me_to_speak/core/repository/repository.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';

class DatabaseService {
  static final instance = DatabaseService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> register({required User user}) async {
    Repository.instance.customerService;
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
        .set({'file_paths': storagePath})
        .then((value) => status = true)
        .onError((error, stackTrace) => status = false);

    await _db
        .collection('customers')
        .doc(AuthService.instance.currentUser!.uid)
        .update({'is_approved': false})
        .then((value) => status = true)
        .onError((error, stackTrace) => status = false);

    return status;
  }

  Future<List<Customer>> getTranslators() async {
    var result = await _db
        .collection('customers')
        .where('type', isEqualTo: 1)
        .where('is_approved', isEqualTo: true)
        .get();

    List<Customer> customers = List<Customer>.from(
        result.docs.map((e) => Customer.fromJson(e.data())));
    return customers;
  }

  Future<Customer> getCustomer(String uid) async {
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

  Future<List<Language>> getTranslatorSupportLanguages(uid) async {
    List<Language> languages = [];
    var result = await _db
        .collection('customers')
        .doc(uid)
        .collection('support_languages')
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

  Future<bool> createConversation(currentUid, reciverUid) async {
    var status = false;
    var ref = _db.collection('conversations');
    var result = await ref.add({
      'members': [currentUid, reciverUid]
    });

    result
        .collection('messages')
        .add({
          'is_file': false,
          'file_path': null,
          'is_seens': false,
          'message': 'hello',
          'sender_id': currentUid,
          'timestamp': DateTime.now()
        })
        .then((value) => status = true)
        .onError((error, stackTrace) => status = false);
    return status;
  }

  Future<bool> deleteConversation(currentUid, reciverUid) async {
    var status = false;
    final batch = _db.batch();

    var collection = await _db
        .collection('conversations')
        .where('members', arrayContainsAny: [currentUid, reciverUid]).get();

    var messages =
        await collection.docs.first.reference.collection('messages').get();

    for (final doc in messages.docs) {
      batch.delete(doc.reference);
    }
    batch.delete(collection.docs.first.reference);

    batch.commit();
    status = true;
    return status;
  }

  Future<List<Map<String, dynamic>>> getConversations() async {
    var members = <Map<String, dynamic>>[];
    var result = await _db
        .collection('conversations')
        .where('members', arrayContains: AuthService.instance.currentUser!.uid)
        .get();

    for (var element in result.docs) {
      members.add({
        'conversationId': element.id,
        'members': (element.data()['members'] as List).where((e) {
          return e != AuthService.instance.currentUser!.uid;
        }).toList()
      });
    }

    return members;
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getConversationSnapShoot(
      reciverUid) {
    return _db
        .collection('conversations')
        .where('members', arrayContains: reciverUid)
        .get()
        .then((value) => value.docChanges.first.doc.reference
            .collection('messages')
            .snapshots());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getHasConversation(reciverUid) {
    return _db
        .collection('conversations')
        .where('members', arrayContains: reciverUid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(conversationId) {
    return _db
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .snapshots();
  }

  Future<bool> putMessage(
      conversationId, message, bool isFile, String? filePath) {
    return _db
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .add({
          'is_seens': false,
          'is_file': isFile,
          'file_path': filePath,
          'message': !isFile ? message : filePath?.split('/').last,
          'sender_id': AuthService.instance.currentUser!.uid,
          'timestamp': DateTime.now()
        })
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  Future<Rezervation> getRezervation(translatorId) async {
    var ref = _db.collection('rezervations').doc(translatorId);
    var doc = await ref.get();
    var subCollection = await ref.collection('rezervation_dates').get();

    Map<String, dynamic>? busyDates = doc.data();
    var items = subCollection.docs.map((e) {
      return e.data()['rezervation_date'];
    });

    for (var item in items) {
      if (busyDates!.containsKey('rezervation_date')) {
        busyDates['rezervation_date'].addAll(item);
      } else {
        busyDates.putIfAbsent('rezervation_date', () => item);
      }
    }

    var data = Rezervation.fromJson(busyDates!);
    return data;
  }

  Future<bool> setRezervation(
      translatorId, List<DateTime> rezervationDates) async {
    var result = await _db
        .collection('rezervations')
        .doc(translatorId)
        .collection('rezervation_dates')
        .add({
          'customer_id': AuthService.instance.currentUser!.uid,
          'rezervation_date': rezervationDates
        })
        .then((value) => true)
        .onError((error, stackTrace) => false);

    return result;
  }

  Future<List<Language>> getLanguages() async {
    var result = await _db.collection('languages').get();
    List<Language> languages = result.docs.map((e) {
      var params = e.data();
      params.putIfAbsent('doc_id', () => e.id);

      return Language.fromJson(params);
    }).toList();
    return languages;
  }

  Future<List<Language>> getLanguagesFromRef(
      List<DocumentReference>? refs) async {
    var list = <Language>[];

    for (var ref in refs!) {
      var doc = await ref.get();
      var params = doc.data() as Map<String, dynamic>;
      params.putIfAbsent('doc_id', () => doc.id);

      list.add(Language.fromJson(params));
    }

    return list;
  }

  Future<bool> setCountryAndLanguages({
    required Language country,
    required List<Language> languages,
    required List<Language> supportLanguages,
  }) async {
    var referance =
        _db.collection('customers').doc(AuthService.instance.currentUser!.uid);

    await referance.update({
      'country': FieldValue.delete(),
      'native_languages': FieldValue.delete(),
      'support_languages': FieldValue.delete()
    });

    var result = await referance
        .update({
          'country': _db.collection('languages').doc(country.docId),
          'native_languages': languages
              .map((e) => _db.collection('languages').doc(e.docId))
              .toList(),
          'support_languages': supportLanguages
              .map((e) => _db.collection('languages').doc(e.docId))
              .toList(),
        })
        .then((value) => true)
        .onError((error, stackTrace) => false);

    await AuthService.instance.setCustomer();

    return result;
  }
}
