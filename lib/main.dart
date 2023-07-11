import 'package:app/bloc/service_bloc.dart';
import 'package:app/data/data_source.dart';
import 'package:app/widget.dart';
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
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Descubra sua Opinião Política'),
        ),
        body: Center(
          child: BlocProvider(
            create: (context) => ServiceBloc(
              dataSource: DataSource(),
            ),
            child: const SomeWidget(),
          ),
        ),
      ),
    );
  }
}
