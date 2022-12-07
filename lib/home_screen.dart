import 'dart:convert';

import 'package:api_app/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

  List<model> postList =[];
  

  Future<List<model>>getpostapi()async{
    final response=await http.get(Uri.https('jsonplaceholder.typicode.com','posts'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(var i in data){
        postList.add(model.fromJson(i));
      }
      return postList;

    }
    else{
      return postList;

    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API app"),
      ),
      body: Column(
        children: [
         
          Expanded(
            child: FutureBuilder(
               future:getpostapi(),
              builder: ((context, snapshot){
                if(!snapshot.hasData){
                  return Text("loading");
                }
                else{
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context,index){
                      
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text('Title\n'+postList[index].title.toString()),
                          Text('Description\n'+postList[index].body.toString()),
                          ],
                        ),
                      ),
                    );

                     }
                  );
                }
          
            }
            )
            ),
          ),

        ],
      ),
    );
  }
}