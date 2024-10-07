import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'dart:math'; // Importando a biblioteca dart:math
import 'package:intl/intl.dart'; // Importando a biblioteca intl

void main() => runApp(const MyApp());

/// Classe principal da aplicação que configura o MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Flutter Minimalist Calculator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
          brightness: Brightness.dark,
        ).copyWith(
          secondary: Colors.tealAccent,
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

/// Widget principal da aplicação que mantém o estado da calculadora
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String displayText = "0"; // Texto exibido no display da calculadora
  String storedValue = ""; // Valor armazenado
  bool isValueStored = false; // Indica se há um valor armazenado

  /// Atualiza o texto do display com o texto do botão pressionado
  void _updateDisplayText(String buttonText) {
    setState(() {
      if (displayText == '0') {
        displayText = buttonText;
      } else {
        displayText += buttonText;
      }
    });
  }

  /// Calcula o resultado da expressão no display
  void _calculateResult() {
    String sanitizedText = displayText.replaceAll(',', ''); // Remover vírgulas
    Expression exp = Expression(sanitizedText);
    setState(() {
      String result = exp.eval().toString();
      displayText = _formatNumber(result);
    });
  }

  /// Calcula a raiz quadrada do valor no display
  void _calculateSquareRoot() {
    String sanitizedText = displayText.replaceAll(',', ''); // Remover vírgulas
    setState(() {
      double value = double.tryParse(sanitizedText) ?? 0;
      String result = (value >= 0) ? sqrt(value).toString() : "Erro";
      displayText = _formatNumber(result);
    });
  }

  /// Formata o número com separadores de milhar
  String _formatNumber(String number) {
    double value = double.tryParse(number) ?? 0;
    return NumberFormat("#,##0.###", "en_US").format(value);
  }

  /// Armazena o valor atual do display
  void _storeValue() {
    setState(() {
      storedValue = displayText;
      isValueStored = true;
    });
  }

  /// Insere o valor armazenado no display
  void _insertStoredValue() {
    setState(() {
      if (isValueStored) {
        if (displayText == '0') {
          displayText = storedValue;
        } else {
          displayText += storedValue;
        }
      }
    });
  }

  /// Limpa o valor armazenado
  void _clearStoredValue() {
    setState(() {
      storedValue = "";
      isValueStored = false;
    });
  }

  /// Cria um botão com o texto e callback fornecidos
  Widget _buildButton(String buttonText, VoidCallback callback,
      {Color? color, double? height, double fontSize = 24}) {
    return ElevatedButton(
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20),
        minimumSize: Size(0, height ?? 60), // Define a altura mínima do botão
      ),
      onPressed: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e0d0d),
      body: Stack(
        children: [
          Column(
            children: [
              // Container para exibir o texto do display com cor de fundo
              Container(
                padding: const EdgeInsets.only(
                    top: 8, right: 20, left: 20, bottom: 5),
                alignment: Alignment.centerRight,
                color: Colors.grey[900], // Cor de fundo do display
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    displayText,
                    style: const TextStyle(fontSize: 64, color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              // GridView para os botões da calculadora
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  primary: false,
                  shrinkWrap: true,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 10,
                  padding: const EdgeInsets.all(22),
                  children: [
                    _buildButton('AC', () {
                      setState(() {
                        displayText = "0";
                      });
                    }),
                    _buildButton('x²', () => _updateDisplayText('^2')),
                    _buildButton('√', _calculateSquareRoot),
                    _buildButton('÷', () => _updateDisplayText('/')),
                    _buildButton('7', () => _updateDisplayText('7')),
                    _buildButton('8', () => _updateDisplayText('8')),
                    _buildButton('9', () => _updateDisplayText('9')),
                    _buildButton('×', () => _updateDisplayText('*')),
                    _buildButton('4', () => _updateDisplayText('4')),
                    _buildButton('5', () => _updateDisplayText('5')),
                    _buildButton('6', () => _updateDisplayText('6')),
                    _buildButton('−', () => _updateDisplayText('-')),
                    _buildButton('1', () => _updateDisplayText('1')),
                    _buildButton('2', () => _updateDisplayText('2')),
                    _buildButton('3', () => _updateDisplayText('3')),
                    _buildButton('+', () => _updateDisplayText('+')),
                    _buildButton('0', () => _updateDisplayText('0')),
                    _buildButton(',', () => _updateDisplayText('.')),
                    _buildButton('⌫', () {
                      setState(() {
                        if (displayText.length > 1) {
                          displayText =
                              displayText.substring(0, displayText.length - 1);
                        } else {
                          displayText = "0";
                        }
                      });
                    }),
                    _buildButton('=', _calculateResult,
                        color: Colors.teal,
                        height: 80), // Aumenta a altura do botão "="
                    _buildButton('M+', _storeValue,
                        color: Colors.yellow[800],
                        height: 40,
                        fontSize: 18), // Botão M+ para armazenar valor
                    _buildButton('MR', _insertStoredValue,
                        color: Colors.blue[800],
                        height: 40,
                        fontSize: 18), // Botão MR para inserir valor armazenado
                    _buildButton('MC', _clearStoredValue,
                        color: Colors.red[800],
                        height: 40,
                        fontSize: 18), // Botão MC para limpar valor armazenado
                  ],
                ),
              ),
            ],
          ),
          // Texto de rodapé fixo na parte inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Calculadora 🔢 MARCELO',
                style: TextStyle(fontSize: 15, color: Colors.tealAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
