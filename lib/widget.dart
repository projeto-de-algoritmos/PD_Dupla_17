import 'package:app/bloc/service_bloc.dart';
import 'package:app/politician_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SomeWidget extends StatefulWidget {
  const SomeWidget({super.key});

  @override
  State<SomeWidget> createState() => _SomeWidgetState();
}

class _SomeWidgetState extends State<SomeWidget> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image(image: AssetImage('assets/wizard.jpg')),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Seja bem vindo ao app que pode descobrir sua opinião politica! \n \nBasta inserir alguma frase que você acredita e o app irá te dizer se você é de direita, esquerda ou centro! \n\nA Ideia é Deixar Você livre para errar o texto, não precisa se focar em escrever certo, apenas escreva o que você acredita!\n\nSe Quiser pode escrever de olhos fechados que conseguimos descobrir sua opinião! :D",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Insira sua frase',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text.isEmpty) return;
                  context
                      .read<ServiceBloc>()
                      .add(SendTextEvent(text: _controller.text));
                },
                child: state is ServiceLoading
                    ? const CircularProgressIndicator()
                    : const Text('Descobrir'),
              ),
              state is ServiceLoaded
                  ? Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        convertPositionToString(state.option),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 30),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}

String convertPositionToString(PoliticianOption politicianOption) {
  switch (politicianOption) {
    case PoliticianOption.centro:
      return "Me parece que você é de Centro";
    case PoliticianOption.direita:
      return "Me parece que você é de Direita";
    case PoliticianOption.esquerda:
      return "Me parece que você é de Esquerda";
  }
}
