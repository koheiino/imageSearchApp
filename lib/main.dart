import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Pixabay()
    );
  }
}

class Pixabay extends StatefulWidget {
  const Pixabay({ Key? key }) : super(key: key);

  @override
  State<Pixabay> createState() => _PixabayState();
}

class _PixabayState extends State<Pixabay> {

  /// 初期値空
  List hits = [];

  Future fetchImages() async{
    Response response = await Dio().get('https://pixabay.com/api/?key=38280410-0ed723b2ac1997dd0c9bd6fb7&q=yellow+flowers&image_type=photo');
    hits = response.data['hits'];
    setState(() {});
  }

  @override
    void initState() {
      super.initState();
      fetchImages();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: hits.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> hit = hits[index];
          return Image.network(hit['previewURL']); // ここで適切なウィジェットを返す必要があります。
        },
      ),
    );
  }
}
