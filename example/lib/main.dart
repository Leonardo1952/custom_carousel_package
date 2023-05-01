import 'package:custom_carousel/custom_carousel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> items = [
    Container(
      color: Colors.blue,
      child: const Center(child: Text("Item 1")),
    ),
    Container(
      color: Colors.red,
      child: const Center(child: Text("Item 2")),
    ),
    Container(
      color: Colors.green,
      child: const Center(child: Text("Item 3")),
    ),
    Container(
      color: Colors.yellow,
      child: const Center(child: Text("Item 4")),
    ),
    Container(
      color: Colors.grey,
      child: const Center(child: Text("Item 5")),
    ),
    Container(
      color: Colors.orange,
      child: const Center(child: Text("Item 6")),
    ),
    Container(
      color: Colors.pink,
      child: const Center(child: Text("Item 7")),
    ),
    Container(
      color: Colors.purple,
      child: const Center(child: Text("Item 8")),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Carousel'),
      ),
      body: Center(
        child: CustomCarousel(
          items: items,
          transitionAutomatic: true,
          typeTransition: ManualTransition.line,
        ),
      ),
    );
  }
}
