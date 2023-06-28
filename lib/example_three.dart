import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Models/UserModel.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {

  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi ()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }

      return userList;

    }else{
      return userList;
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Example three"),

      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
              if(!snapshot.hasData){
                return Text("Loading");
              }else{
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: Column(
                          children: [
                            ReusableRow(title: "Name", value: snapshot.data![index].name.toString()),
                            ReusableRow(title: "UserName", value: snapshot.data![index].username.toString()),
                            ReusableRow(title: "Email", value: snapshot.data![index].email.toString()),
                            ReusableRow(title: "Adress", value: snapshot.data![index].address!.street.toString()+', '+snapshot.data![index].address!.city.toString()),
                          ],
                        ),
                      );
                    });
              }
            },
          ))
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


