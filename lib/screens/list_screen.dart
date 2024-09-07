import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemListPage extends StatelessWidget {
  final String listId;
  final Future<void> Function(String) onAddItem;

  ItemListPage({required this.listId, required this.onAddItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              onAddItem(listId);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('shoppingLists')
            .doc(listId)
            .collection('items')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No items available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var itemData = snapshot.data!.docs[index];
              return ListTile(
                title: Text(itemData['itemName']),
                subtitle:
                    Text('${itemData['quantity']} (${itemData['category']})'),
                trailing: Checkbox(
                  value: itemData['purchased'],
                  onChanged: (bool? value) async {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('shoppingLists')
                        .doc(listId)
                        .collection('items')
                        .doc(itemData.id)
                        .update({'purchased': value});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
