import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/services/snack_bar_service.dart';
import 'package:todo_app/core/utils.dart';
import 'package:todo_app/model/task_model.dart';

class FirebaseUtils {
  static CollectionReference<TaskModel> getCollectionRef() {
    return FirebaseFirestore.instance
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromJSON(snapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson());
  }

  static Future<void> addTaskToFirestore(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Future<List<TaskModel>> getOnTimeReadFromFirestore(
      DateTime selectedDate) async {
    var collectionRef = getCollectionRef().where("selectedDate",
        isEqualTo: extractDate(selectedDate).millisecondsSinceEpoch);
    // var data = await collectionRef.get();
    QuerySnapshot<TaskModel> data = await collectionRef.get();
    var taskList = data.docs.map((e) => e.data()).toList();
    return taskList;
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeDateFromFirestore(
      DateTime selectedDate) {
    var collectionRef = getCollectionRef().where("selectedDate",
        isEqualTo: extractDate(selectedDate).millisecondsSinceEpoch);
    return collectionRef.snapshots();
  }

  static Future<void> deleteTask(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.delete();
    // return collectionRef.get().then((QuerySnapshot<TaskModel> snapshot) {
    //   snapshot.docs.forEach((doc) => doc.reference.delete());
    // });
  }

  static Future<void> updateTask(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(taskModel.id);
    taskModel.isDone = true;
    return docRef.update(
      taskModel.toJson(),
    );
  }

  static Future<void> updateAllTask(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.update(
      taskModel.toJson(),
    );
  }

  static Future<bool> createAccount(
      String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user?.uid);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage("The password provided is too weak");
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage(
            "The account already exists for that email.");
        return Future.value(false);
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
      return Future.value(false);
    }
    return Future.value(false);
  }

  static Future<bool> signAccount(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      // EasyLoading.show();
      print(credential.credential?.token);
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage("No user found for that email.");
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        // EasyLoading.dismiss();
        print('Wrong password provided for that user.');
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage(
            "Wrong password provided for that user.");
        return Future.value(false);
      }
      // return Future.value(false);
    }
    return Future.value(false);
  }

  static logout() {
    FirebaseAuth.instance.signOut();
  }
}
