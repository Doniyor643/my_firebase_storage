
import 'package:flutter/material.dart';

import '../posts/posts.dart';
import '../services/auth_services.dart';

final _posts = <Posts>[
  Posts(title: 'this is title1', author: 'this is author1', description: 'this is description1', level: 'Beginner'),
  Posts(title: 'this is title2', author: 'this is author2', description: 'this is description2', level: 'Intermediate'),
  Posts(title: 'this is title3', author: 'this is author3', description: 'this is description3', level: 'Advanced'),
  Posts(title: 'this is title4', author: 'this is author4', description: 'this is description4', level: 'Beginner'),
];


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromRGBO(50, 65, 85, 0.5),
      title: const Text("Firebase & Database"),
      actions: [
        IconButton(
            onPressed: (){
              AuthServices().logOut();
            },
            icon: const Icon(Icons.camera))
      ],
    ),
    backgroundColor: Theme.of(context).primaryColor,
    body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index){
          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(50, 65, 85, 0.9)
              ),
              child: ListTile(
                title: Text(_posts[index].title),
                subtitle: subTitle(context,_posts[index]),
              ),
            ),
          );
        }),
  );
}
Widget subTitle(BuildContext context, Posts posts){
  Color color = Colors.grey;
  double indicatorLevel = 0;

  switch(posts.level){
    case 'Beginner': color = Colors.green; indicatorLevel = 0.33; break;
    case 'Intermediate': color = Colors.yellow; indicatorLevel = 0.66; break;
    case 'Advanced': color = Colors.red; indicatorLevel = 1; break;
  }
  return Row(children: [
    Expanded(
        flex: 1,
        child: LinearProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation(color),
          value: indicatorLevel,
        )
    ),
    const SizedBox(width: 10,),
    Expanded(
        flex: 3,
        child: Text(posts.level,style: const TextStyle(color: Colors.cyanAccent),)
    ),
  ]);
}