import 'package:flutter/material.dart';

class AreaRetanguloCalculator extends StatefulWidget {
  const AreaRetanguloCalculator({super.key});

  @override
  State<AreaRetanguloCalculator> createState() =>
      _AreaRetanguloCalculatorState();
}

class _AreaRetanguloCalculatorState extends State<AreaRetanguloCalculator> {
  final TextEditingController _larguraController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  double? _area; // Usamos 'double?' para que o valor possa ser nulo inicialmente

  void _calcularArea() {
    // Tenta converter o texto dos campos para double. Se falhar, usa 0.
    final largura = double.tryParse(_larguraController.text) ?? 0;
    final altura = double.tryParse(_alturaController.text) ?? 0;

    // Atualiza o estado com o novo valor da área, o que fará a tela redesenhar
    setState(() {
      _area = largura * altura;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _larguraController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Largura",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _alturaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Altura",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calcularArea,
            child: const Text('Calcular Área'),
          ),
          const SizedBox(height: 20),
          // Exibe o resultado apenas se a área já foi calculada (_area não é nulo)
          if (_area != null)
            Text(
              'A área é: ${_area!.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
        ],
      ),
    );
  }
}