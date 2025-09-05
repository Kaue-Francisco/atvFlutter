// Importa o pacote principal do Flutter para usar os widgets do Material Design.
import 'package:flutter/material.dart';

// A função main() é o ponto de entrada de todo aplicativo Flutter.
void main() {
  runApp(const AverageCalculatorApp());
}

// Widget principal do aplicativo.
class AverageCalculatorApp extends StatelessWidget {
  const AverageCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Média',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Define a tela inicial do aplicativo.
      home: const CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Tela principal onde o cálculo acontece.
// É um StatefulWidget porque seu estado (o resultado da média) precisa mudar.
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

// A classe State que contém a lógica e a interface da nossa tela.
class _CalculatorScreenState extends State<CalculatorScreen> {
  // Criamos três controladores, um para cada campo de nota.
  final TextEditingController _nota1Controller = TextEditingController();
  final TextEditingController _nota2Controller = TextEditingController();
  final TextEditingController _nota3Controller = TextEditingController();

  // Variável para armazenar o resultado da média.
  double? _mediaResult;
  String? _statusMessage;

  // Função que realiza o cálculo da média.
  void _calculateAverage() {
    // Tenta converter o texto de cada campo para um número (double).
    final double? nota1 = double.tryParse(_nota1Controller.text);
    final double? nota2 = double.tryParse(_nota2Controller.text);
    final double? nota3 = double.tryParse(_nota3Controller.text);

    // Verifica se todos os campos foram preenchidos com números válidos.
    if (nota1 != null && nota2 != null && nota3 != null) {
      // Aplica a fórmula da média.
      final double media = (nota1 + nota2 + nota3) / 3;

      // setState() avisa ao Flutter para redesenhar a tela com os novos valores.
      setState(() {
        _mediaResult = media;
        // Define uma mensagem de status (Aprovado/Reprovado)
        if (media >= 6.0) {
          _statusMessage = "Aprovado!";
        } else {
          _statusMessage = "Reprovado.";
        }
      });
    } else {
      // Se algum campo for inválido, limpa o resultado anterior.
      setState(() {
        _mediaResult = null;
        _statusMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Média Aritmética'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Usamos um SingleChildScrollView para evitar que o teclado
        // cubra os campos de texto em telas menores.
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Campo de texto para a primeira nota.
              TextField(
                controller: _nota1Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nota 1',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),

              // Campo de texto para a segunda nota.
              TextField(
                controller: _nota2Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nota 2',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),

              // Campo de texto para a terceira nota.
              TextField(
                controller: _nota3Controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nota 3',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24.0),

              // Botão para executar o cálculo.
              ElevatedButton(
                onPressed: _calculateAverage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Calcular Média'),
              ),
              const SizedBox(height: 30.0),

              // Se houver um resultado, exibe a média e o status.
              if (_mediaResult != null)
                Column(
                  children: [
                    Text(
                      'Média: ${_mediaResult!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _statusMessage!,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        // A cor muda dependendo se foi aprovado ou reprovado.
                        color: _mediaResult! >= 6.0 ? Colors.green[700] : Colors.red[700],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
