import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../constants/constant.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String? title, description, subject, existingValue, doubtId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  var subjectData = Constant().subjects;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  @override
  void dispose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    super.dispose();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    debugPrint("Download link: " + urlDownload);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.done_outlined),
          ),
          SizedBox(width: 15),
        ],
        title: RichText(
          text: const TextSpan(
              text: "Add Post",
              style: TextStyle(
                  color: Color(0xFF071E22),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Color(0xFF071E22)),
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    if (pickedFile != null)
                      Container(
                        height: 250,
                        color: Colors.blue[100],
                        child: Image.file(
                          File(pickedFile!.path!),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: textEditingController1,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        hintStyle: const TextStyle(
                          color: Color(0xFF071E22),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF071E22),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF071E22),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      maxLength: 500,
                      maxLines: 10,
                      minLines: 3,
                      validator: (val) {
                        return val!.isEmpty ? 'Enter Address' : null;
                      },
                      onSaved: (input) {
                        title = input!;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: textEditingController2,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: const TextStyle(
                          color: Color(0xFF071E22),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF071E22),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF071E22),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      maxLength: 1000,
                      maxLines: 20,
                      minLines: 7,
                      validator: (val) {
                        return val!.isEmpty ? 'Enter Description' : null;
                      },
                      onSaved: (input) {
                        description = input!;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      hint: Text("Category"),
                      value: existingValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          existingValue = newValue!;
                        });
                      },
                      items: subjectData.map((valueItem) {
                        return DropdownMenuItem(
                            value: valueItem, child: Text(valueItem));
                      }).toList(),
                      onSaved: (String? input) {
                        subject = input!;
                      },
                      icon: const Icon(Icons.arrow_drop_down_outlined),
                      validator: (String? val) {
                        return val == null ? "Select a subject" : null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.all(25),
                            ),
                            onPressed: () {
                              selectFile();
                            },
                            child: const Text("Select Image"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.all(25),
                            ),
                            onPressed: () {
                              uploadFile();
                            },
                            child: const Text("Upload Image"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
