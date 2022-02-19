
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({ Key? key }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> { 
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  String? singleImage;
  final firebase = FirebaseFirestore.instance;

  create() async{
    try{
      await firebase.collection("new")
      .doc(name.text).set({"name": name.text,"email":email.text});

    }catch(e){
      print(e);
    }
  }

  update() async{
    try{
      await firebase.collection("new")
      .doc(name.text)
      .update({"name": name.text,"email": email.text});
    }catch(e){
      print(e);
    }
  }

  delete() async{
    try{
      firebase.collection("new").doc(name.text).delete();
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [

            Center(
              heightFactor: 1.3,
              child: GestureDetector(
                onTap: () async{
                          XFile? _image = await singleImagePick();
                          if(_image != null && _image.path.isNotEmpty){
                            singleImage = await uploadImage(_image);
                            setState(() {
                            });                           
                          }
                        },
              child:ClipOval(              
                child: Container(
                  width: size.width/2.7,
                  height: size.height/4.5,
                  color: Colors.black12,
                  child: singleImage != null  && singleImage!.isNotEmpty 
                ? Image.network(singleImage!,fit: BoxFit.fill,)
                : Icon(Icons.add_a_photo,size: 50,),
                ))),
            ),

            Container(margin: EdgeInsets.only(top: 200,left: 30,right: 30),
              height: size.height/15,
              width: size.width,
              //color: Colors.amberAccent, 
                child: Text("Change Profile Picture",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,fontWeight: FontWeight.bold,),)
                  
                ),
              
            Container(
              margin: EdgeInsets.only(top: 260,left: 30,right:30),
              height: size.height/15,
              width: size.width,
              //color: Colors.amber,
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "Username",               
              ),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    
            ),

            Container(
              margin: EdgeInsets.only(top: 320,left: 30,right: 30),
              height: size.height/15,
              width: size.width ,
              //color: Colors.black54,
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20))),
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,),
            ),

            Container(
              margin: EdgeInsets.only(top: 400,left: 30,right: 30),
              height: size.height/15,
              width: size.width ,
              child: ElevatedButton(
                onPressed: () {   
                  create();
                  name.clear();
                  email.clear();  
                },
                child: Text("Submit",style: TextStyle(fontSize: 20),),
              ),),

              Container(
              margin: EdgeInsets.only(top: 460,left: 30,right: 30),
              height: size.height/15,
              width: size.width ,
              child: ElevatedButton(
                onPressed: () {   
                  update();
                  name.clear();
                  email.clear();  
                },
                child: Text("Update",style: TextStyle(fontSize: 20),),
              ),),

              Container(
              margin: EdgeInsets.only(top: 520,left: 30,right: 30),
              height: size.height/15,
              width: size.width ,
              child: ElevatedButton(
                onPressed: () {   
                  delete();
                  name.clear();
                  email.clear();  
                },
                child: Text("Delete",style: TextStyle(fontSize: 20),),
              ),),



         ],
        ),
      ),
    );
  }
}

Future<XFile?> singleImagePick() async{
  return await ImagePicker().pickImage(source: ImageSource.gallery);  
}

Future<String> uploadImage(XFile image) async{
  Reference db = FirebaseStorage.instance.ref('test/${getImageName(image)}');
  await db.putFile(File(image.path));
  return await db.getDownloadURL();
}

String getImageName(XFile image){
  return image.path.split("/").last;
}



