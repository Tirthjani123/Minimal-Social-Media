
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase{
  //Current user who is logged in
  User? user = FirebaseAuth.instance.currentUser;

  // Get collection of post from the FireBase Firestore
  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  // method to add the posts
  Future<void> addPost(String msg){
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage':msg,
      'Timestamp()': Timestamp.now(),
    });
  }
  Stream<QuerySnapshot> getPosts(){
    final postsStream = FirebaseFirestore.instance.collection('posts').orderBy('Timestamp()',descending:true).snapshots();
    return postsStream;
  }
}