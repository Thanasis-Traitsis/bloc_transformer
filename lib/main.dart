import 'package:bloc_transformer/bloc/transformer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TransformerBloc(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Transformers'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "The output after the event is called:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            BlocBuilder<TransformerBloc, TransformerState>(
              builder: (context, state) {
                return SizedBox(
                  height: 50,
                  child: Text(
                    "${state.count}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TransformerBloc>().add(IncrementPressed());
              },
              child: const Text('Increment +'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TransformerBloc>().add(DecrementPressed());
              },
              child: const Text('Decrement -'),
            )
          ],
        ),
      ),
    );
  }
}
