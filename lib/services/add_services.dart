import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddServices extends StatefulWidget {
  static const String id = 'add_services';
  const AddServices({Key? key}) : super(key: key);

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {

  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Davron');
  final Reference _ref = FirebaseStorage.instance.ref().child('PictureService');

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance.ref().child('PictureService').storage;

  final ImagePicker _picker = ImagePicker();
  late XFile _selectedFile;
  String _selectedFileName = '';
  String _upLoadedPath = 'No Data';
  String downloadUrl = '';
  //String urlAddress = '';
  bool _isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController sumController = TextEditingController();
  TextEditingController textController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  bool variant = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(50, 65, 85, 0.5),
        title: const Text("Add Service",style: TextStyle(color: Colors.cyanAccent),),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
              labelText: "Name",
            labelStyle: TextStyle(color: Colors.cyanAccent),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.cyan, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.cyanAccent,width: 2),
            ),
          ),
        ),
          const SizedBox(height: 20,),
          TextFormField(
            controller: sumController,
            decoration: const InputDecoration(
              labelText: "Price",
              labelStyle: TextStyle(color: Colors.cyanAccent),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.cyan, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.cyanAccent,width: 2),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          TextFormField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: "Text",
              labelStyle: TextStyle(color: Colors.cyanAccent),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.cyan, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.cyanAccent,width: 2),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            child: variant
                ?
            TextFormField(
              controller: photoController,
              decoration: const InputDecoration(
                labelText: "Photo URL address",
                labelStyle: TextStyle(color: Colors.cyanAccent),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.cyan, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.cyanAccent,width: 2),
                ),
              ),
            )
                :
            SizedBox(
              height: 59,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    funSelectFile();
                  },
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.image,color: Colors.white,size: 30,),
                      SizedBox(width: 10,),
                      Text("Add photo in gallery"),
                    ],
                  )),
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 55,
            width: double.infinity,
            child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    variant = !variant;
                  });
                },
                child: Row(
                  children: [
                    const Icon(Icons.image,color: Colors.white,size: 30,),
                    const SizedBox(width: 10,),
                    variant
                        ?
                    const Text("Photo in gallery")
                        :
                    const Text("Photo in URL address"),
                  ],
                )),
          ),
          const SizedBox(height: 50,),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){

                uploadFile2(_selectedFile).then((value) {
                  createData(
                    name: nameController.text.trim(),
                    price: sumController.text.trim(),
                    text: textController.text.trim(),
                    url: variant ? photoController.text.trim() : value,
                  );
                });


              },
              child: const Text("Add Services")),
          )
      ]),
    );
  }

  void createData({name, price, text, url}){
    String? key = databaseRef.child('CarWashCenter').child('Services').push().key;
    databaseRef.child('CarWashCenter').child('Services').push().set({
      'id':key,
      'name':name,
      'price':price,
      'text':text,
      'url':url
    });
    nameController.clear();
    sumController.clear();
    textController.clear();
    photoController.clear();
  }

  // Galereyadan o'qish
  Future<void> funSelectFile()async{
    final img = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedFile = img as XFile;
      _selectedFileName = img.name.toString();
    });
  }

  // Serverga jo'natish 2 - usul Jo'natilgan rasm nomi o'zgarib boradi
  Future<String> uploadFile2(XFile xFile)async{
    String fileNameHour = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = _firebaseStorage
        .ref()
        .child('PictureService')
        .child(fileNameHour);
    UploadTask uploadTask = reference.putFile(File(xFile.path));
    uploadTask.snapshotEvents.listen((event) {
      setState(() {
        _isLoading = true;
      });
    });

    await uploadTask.whenComplete(() async {
      _upLoadedPath = await uploadTask.snapshot.ref.getDownloadURL();
      print(_upLoadedPath);
      setState(() {
        _isLoading = false;
      });
    });
    return _upLoadedPath;
  }


}


