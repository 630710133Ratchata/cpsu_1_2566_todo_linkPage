import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/screens/home/home_page.dart';

class newPage extends StatelessWidget {
  const newPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  kpage(),
    );
  }
}
class kpage extends StatelessWidget {
  const kpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      Row(
        children: [
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: const Text('back'),

          )
        ],
      ),
    ],
    ),);
  }
}

