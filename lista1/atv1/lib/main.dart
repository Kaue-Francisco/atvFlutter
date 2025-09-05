// Importa o pacote principal do Flutter para usar os widgets do Material Design.
import 'package:flutter/material.dart';

// A função main() é o ponto de entrada de todo aplicativo Flutter.
// Ela chama runApp() para iniciar a interface do usuário.
void main() {
  runApp(const TemperatureConverterApp());
}

// Este é o widget principal do nosso aplicativo.
// É um StatelessWidget porque seu estado não muda.
class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp é o widget raiz que configura o aplicativo,
    // como o tema e a tela inicial.
    return MaterialApp(
      title: 'Conversor de Temperatura',
      // Define o tema visual do aplicativo.
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Define a tela inicial do aplicativo.
      home: const ConverterScreen(),
      // Remove a faixa de "Debug" no canto da tela.
      debugShowCheckedModeBanner: false,
    );
  }
}

// Esta é a tela principal onde a conversão acontece.
// É um StatefulWidget porque seu conteúdo precisa mudar (o resultado da conversão).
class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

// A classe State contém a lógica e o estado da nossa tela.
class _ConverterScreenState extends State<ConverterScreen> {
  // Controlador para o campo de texto, para que possamos ler o que o usuário digita.
  final TextEditingController _celsiusController = TextEditingController();

  // Variável para armazenar o resultado em Fahrenheit.
  // Usamos double? para indicar que ela pode ser nula (no início, não há resultado).
  double? _fahrenheitResult;

  // Função que realiza o cálculo da conversão.
  void _convertTemperature() {
    // Pega o texto do campo de entrada e tenta convertê-lo para um número (double).
    // Se o campo estiver vazio ou não for um número válido, o resultado é nulo.
    final double? celsius = double.tryParse(_celsiusController.text);

    // Verifica se a conversão para número foi bem-sucedida.
    if (celsius != null) {
      // Aplica a fórmula de conversão.
      final double fahrenheit = (celsius * 9 / 5) + 32;

      // setState() é uma função crucial no Flutter.
      // Ela informa ao framework que o estado mudou e a tela precisa ser redesenhada
      // para mostrar o novo valor de _fahrenheitResult.
      setState(() {
        _fahrenheitResult = fahrenheit;
      });
    } else {
      // Se a entrada for inválida, limpa o resultado anterior.
      setState(() {
        _fahrenheitResult = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold é um layout básico do Material Design. Ele nos dá uma AppBar (barra superior),
    // um body (corpo da tela) e outras funcionalidades.
    return Scaffold(
      appBar: AppBar(
        // O título que aparece na barra superior do aplicativo.
        title: const Text('Conversor Celsius para Fahrenheit'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      // O corpo da nossa tela.
      body: Padding(
        // Adiciona um espaçamento interno (margem) de 16 pixels em todos os lados.
        padding: const EdgeInsets.all(16.0),
        // Column organiza seus filhos (widgets) em uma coluna vertical.
        child: Column(
          // Alinha os widgets no início da coluna.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Campo de texto para o usuário inserir a temperatura.
            TextField(
              controller: _celsiusController,
              // Define o tipo de teclado para numérico, facilitando a entrada.
              keyboardType: TextInputType.number,
              // Adiciona decoração ao campo, como um rótulo e uma borda.
              decoration: const InputDecoration(
                labelText: 'Temperatura em Celsius (°C)',
                border: OutlineInputBorder(),
              ),
            ),
            // Adiciona um espaço vertical de 20 pixels entre os widgets.
            const SizedBox(height: 20.0),
            // Botão que o usuário pressiona para iniciar a conversão.
            ElevatedButton(
              // A função _convertTemperature é chamada quando o botão é pressionado.
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                  foregroundColor: Colors.white,
              ),
              child: const Text('Converter'),
            ),
            const SizedBox(height: 30.0),
            // Exibe o resultado. A estrutura `if` verifica se _fahrenheitResult não é nulo.
            // Se houver um resultado, ele é mostrado.
            if (_fahrenheitResult != null)
              Text(
                // Exibe o resultado formatado com duas casas decimais.
                'Resultado: ${_fahrenheitResult!.toStringAsFixed(2)} °F',
                // Define o estilo do texto para torná-lo maior e mais destacado.
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
