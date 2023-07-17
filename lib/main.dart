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

  Future fetchImages(String text) async{
    Response response = await Dio().get('https://pixabay.com/api/?key=38280410-0ed723b2ac1997dd0c9bd6fb7&q=$text&image_type=photo&per_page=100');
    hits = response.data['hits'];
    setState(() {});
  }

  @override
    void initState() {
      super.initState();
      fetchImages('月');
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          ///最初の検索ワードの設定
          initialValue: '月',
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
          ),
          onFieldSubmitted: (text) {
            fetchImages(text);
          },
        ),
      ),
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
