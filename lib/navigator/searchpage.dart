
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceproject/const/appcolor.dart';
import 'package:ecommerceproject/const/textfile.dart';
import 'package:ecommerceproject/ui/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //

  CollectionReference firestoreDocs =
      FirebaseFirestore.instance.collection('products');

  TextEditingController searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Search',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchControler,
                  decoration: textfilesStyle('search').copyWith(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          searchControler.clear();
                        });
                      },
                      icon:
                          const Icon(Icons.close, color: Colors.blue),
                    ),
                  ),
                ),
                getSearch()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded getSearch() {
    return Expanded(
      child: StreamBuilder(
        stream: firestoreDocs.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          if (searchControler.text.isEmpty) {
            return const Text('No search result',
                style: TextStyle(fontSize: 16));
          } else {
            return ListView(
              children: [
                ...snapshot.data!.docs
                    .where(
                  (QueryDocumentSnapshot<Object> element) =>
                      element["product_name"].toString().toLowerCase().contains(
                            searchControler.text.toLowerCase(),
                          ),
                )
                    .map(
                  (QueryDocumentSnapshot<Object> data) {
                    final name = data["product_name"];
                    final img = data["pimg"][0];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      //color: AppColors.deep_orange,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 10,
                        ),
                        child: ListTile(
                          // onTap: () => Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => ProductDetails(data),
                          //   ),
                          // ),
                          title: Text(
                            name,
                            style: TextStyle(fontSize: 20),
                          ),
                          leading: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(img),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }
}