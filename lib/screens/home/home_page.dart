import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_item.dart';
import 'package:todo_list/screens/home/new_Page.dart';

import 'new_Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _dio = Dio(BaseOptions(responseType: ResponseType.plain));
  List<TodoItem>? _itemList;
  String? _error;

  void getTodos() async {
    try {
      setState(() {
        _error = null;
      });

      // await Future.delayed(const Duration(seconds: 3), () {});

      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/albums');
      debugPrint(response.data.toString());
      // parse
      List list = jsonDecode(response.data.toString());
      setState(() {
        _itemList = list.map((item) => TodoItem.fromJson(item)).toList();
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
      debugPrint('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_error != null) {
      body = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_error!),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              getTodos();
            },
            child: const Text('RETRY'),
          )
        ],
      );
    } else if (_itemList == null) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      body = Column(
        children: [
          Text(
            "Photo Album",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const newPage()),
                  );
                },
                child: const Text('newPage'),

              )
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _itemList!.length,
                itemBuilder: (context, index) {
                  var todoItem = _itemList![index];
                  return Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(children: [Text(todoItem.title)]),
                      Row(
                        children: [
                          Card(
                            color: Colors.red[200],
                            child: Text("Albums_ID:" + todoItem.id.toString()),
                          ),
                          Card(
                            color: Colors.lightBlueAccent[100],
                            child:
                                Text("User_ID:" + todoItem.userId.toString()),
                          )
                        ],
                      ),
                    ]),
                  ));
                }),
          )
        ],
      );
    }
    return Scaffold(body: body);
  }
}
