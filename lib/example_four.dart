import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {

  var data;
  Future<void> getUserApi ()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){

    }else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("API Learn"),
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context,snapshot){
            if(snapshot.connectionState== ConnectionState.waiting){
              return Text("Loading");
            }else{
              return ListView.builder(
                itemCount: data.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: Column(
                        children: [
                          ReusableRow(title: 'Name: ', value: data[index]['name'].toString(),),
                          ReusableRow(title: 'Username: ', value: data[index]['username'].toString(),),
                        ],
                      ),
                    );
                  }
              );
            }

          },
          ),
          ),
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key,required this.title , required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

