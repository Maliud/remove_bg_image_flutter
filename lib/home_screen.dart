import 'dart:io';
import 'dart:typed_data';


import 'package:before_after/before_after.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remove_bg_image_main/api.dart';
import 'package:remove_bg_image_main/dashed_border.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var value = 0.5;

  var loaded = false;
  var removedBg = false;
  var isLoading = false;

  Uint8List? image;
  String imagePath = '';

  pickImage() async {
    final img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      );
    if (img != null) {
      imagePath = img.path;
      loaded = true;
      setState(() {
        
      });
    }else {

    }  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.sort_rounded),
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Arka Plan Temizleyici',
        style: TextStyle(
          fontSize: 16.0
        ),),
      ),
      body: Center(
        child: removedBg 
        ? BeforeAfter(
            value: value,
            before: Image.file(File(imagePath)), 
            after: Image.memory(image!),
            onValueChanged: (value) {
              setState(() => this.value = value);
            },
            ) 
        : loaded 
            ? GestureDetector(
              onTap: () {
                pickImage();
              },
          child: Image.file(
            File(imagePath)
          ),
        ) 
        :  
        DashedBorder(
          padding: const EdgeInsets.all(40),
          color: Colors.grey,
          radius: 12,
          child: 
          SizedBox(
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
            onPressed: (){
              pickImage();
            }, 
            child: const Text('Arka Planı Temizle',
            style: TextStyle(
              color: Colors.orange
            ),),
            ),
        ),),
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
          ),
          onPressed: loaded ? () async {

            setState(() {
              isLoading = true;
            });

            image = await Api.removeBg(imagePath);
            if (image != null) {
              removedBg = true;
              isLoading = false;
              setState(() {});
            }
          } : null, 
          child: isLoading ? const  CircularProgressIndicator() :  const Text('Arka Planı Temizle',
          style: TextStyle(
            color: Colors.orange
          ),),
          ),
      ),
    );
  }
}