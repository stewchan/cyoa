import 'package:cyoa/openai/completions_api.dart';
import 'package:cyoa/openai/completions_response.dart';
import 'package:flutter/material.dart';
import 'openai/prompts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adventure Story',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: HomePage(title: 'Adventure Story')),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var prompt = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("What animal do you want to name?"),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() => prompt = Prompts.createPrompt('bear'));
                },
                child: const Text('Bear'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() => prompt = Prompts.createPrompt('bunny'));
                },
                child: const Text('Bunny'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() => prompt = Prompts.begin());
                },
                child: const Text('Begin'),
              ),
            ],
          ),
          const SizedBox(height: 50),
          if (prompt != '')
            FutureBuilder(
              future: CompletionsApi.fetchCompletion(prompt: prompt),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  CompletionsResponse completionsResponse = snapshot.data!;
                  return Text(completionsResponse.firstCompletion!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasError) {
                  print("error");
                }
                return const CircularProgressIndicator();
              }),
            )
        ],
      ),
    );
  }
}
