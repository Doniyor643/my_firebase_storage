
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_storage/services/add_services.dart';


class PostsList extends StatefulWidget {
  static const String id = 'posts_list';
  const PostsList({Key? key}) : super(key: key);

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {


  Query query = FirebaseDatabase.instance.ref('Davron').child('CarWashCenter').child('Services');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(50, 65, 85, 0.5),
        title: const Text("Firebase & Database"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, AddServices.id);
            },
            icon: const Icon(Icons.add))
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: FirebaseAnimatedList(
          query: query,
          itemBuilder: (
              BuildContext context,
              DataSnapshot snapshot,
              Animation<double> animation,
              int index){
            Map? contact = snapshot.value as Map?;
            return buildContactItem(service: contact);
          },
        ),
      ),
    );
  }

  Widget buildContactItem({Map? service}) {
    return Container(
      height: 300,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(service!['url'].toString()),
          fit: BoxFit.cover
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: 75,
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: Center(
                        child: Text(service['name'],
                          style: const TextStyle(
                              color: Colors.cyanAccent,
                              fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),),
                      ),
                    ),
                    Expanded(
                      flex:1,
                      child: Text("Narxi: "+service['price']+" so'm",
                        style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 20,
                        ),),
                    ),
                  ],
                ),
                Text(service['text'],
                  style: const TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 16,
                  ),),
              ],
            ))
      ],),
    );




  }



}
