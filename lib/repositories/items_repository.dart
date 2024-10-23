import 'package:cantwait28/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    return FirebaseFirestore.instance
        .collection('items')
        .orderBy('release_date')
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map(
          (doc) {
            return ItemModel(
              id: doc.id,
              title: doc['title'],
              imageUrl: doc['image_url'],
              releaseDate: (doc['release_date'] as Timestamp).toDate(),
            );
          },
        ).toList();
      },
    );
  }

  Future<void> deleteItem({required String documentID}) async {
    await FirebaseFirestore.instance
        .collection('items')
        .doc(documentID)
        .delete();
  }

  Future<ItemModel> get({required String documentID}) async {
    final doc = await FirebaseFirestore.instance
        .collection('items')
        .doc(documentID)
        .get();
    return ItemModel(
      id: doc.id,
      title: doc['title'],
      imageUrl: doc['image_url'],
      releaseDate: (doc['release_date'] as Timestamp).toDate(),
    );
  }

  Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
  ) async {
    await FirebaseFirestore.instance.collection('items').add(
      {
        'title': title,
        'image_url': imageURL,
        'release_date': releaseDate,
      },
    );
  }
}