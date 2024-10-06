# Calc_flutter
Trabalho Acadêmico.
## Resumo das Funções

- **MyApp**: Configura o `MaterialApp`, definindo o tema, título e tela inicial.
- **MyHomePage**: Widget principal que mantém o estado da calculadora.
- **_incrementCounter**: Incrementa um contador (não utilizado no momento).
- **_updateDisplayText**: Atualiza o texto do display com o texto do botão pressionado.
- **_calculateResult**: Calcula o resultado da expressão no display, removendo vírgulas antes de avaliar.
- **_calculateSquareRoot**: Calcula a raiz quadrada do valor no display, removendo vírgulas antes de avaliar.
- **_formatNumber**: Formata o número com separadores de milhar.
- **_buildButton**: Cria um botão com o texto e callback fornecidos.



```markdown
# Documentação da Calculadora em Flutter

## Visão Geral
Este projeto é uma calculadora simples desenvolvida em Flutter. A calculadora permite realizar operações básicas, como adição, subtração, multiplicação, divisão e cálculo de raiz quadrada. Além disso, formata os números com separadores de milhar para melhor legibilidade.

## Estrutura do Código

### Importações
```dart
import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
```
- **`eval_ex`**: Biblioteca para avaliar expressões matemáticas.
- **`flutter/material.dart`**: Biblioteca principal do Flutter para construir a interface do usuário.
- **`dart:math`**: Biblioteca para funções matemáticas.
- **`intl`**: Biblioteca para formatação de números.

### Função Principal
```dart
void main() => runApp(const MyApp());
```
- **`main`**: Função principal que inicia a aplicação Flutter.

### Classe `MyApp`
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Flutter Stateful Clicker Counter';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}
```
- **`MyApp`**: Configura o `MaterialApp`, definindo o tema, título e tela inicial (`MyHomePage`).

### Classe `MyHomePage`
```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
```
- **`MyHomePage`**: Widget principal que mantém o estado da calculadora.

### Classe `_MyHomePageState`
```dart
class _MyHomePageState extends State<MyHomePage> {
  String displayText = "0";
```
- **`displayText`**: Texto exibido no display da calculadora.

#### Métodos da Classe `_MyHomePageState`

##### `_updateDisplayText`
```dart
void _updateDisplayText(String buttonText) {
  setState(() {
    if (displayText == '0') {
      displayText = buttonText;
    } else {
      displayText += buttonText;
    }
  });
}
```
- Atualiza o texto do display com o texto do botão pressionado.

##### `_calculateResult`
```dart
void _calculateResult() {
  String sanitizedText = displayText.replaceAll(',', '');
  Expression exp = Expression(sanitizedText);
  setState(() {
    String result = exp.eval().toString();
    displayText = _formatNumber(result);
  });
}
```
- Calcula o resultado da expressão no display, removendo vírgulas antes de avaliar.

##### `_calculateSquareRoot`
```dart
void _calculateSquareRoot() {
  String sanitizedText = displayText.replaceAll(',', '');
  setState(() {
    double value = double.tryParse(sanitizedText) ?? 0;
    String result = (value >= 0) ? sqrt(value).toString() : "Erro";
    displayText = _formatNumber(result);
  });
}
```
- Calcula a raiz quadrada do valor no display, removendo vírgulas antes de avaliar.

##### `_formatNumber`
```dart
String _formatNumber(String number) {
  double value = double.tryParse(number) ?? 0;
  return NumberFormat("#,##0.###", "en_US").format(value);
}
```
- Formata o número com separadores de milhar.

##### `_buildButton`
```dart
Widget _buildButton(String buttonText, VoidCallback callback) {
  return TextButton(
    child: Text(
      buttonText,
      style: const TextStyle(
        fontSize: 48,
        color: Color(0xff6254b0),
      ),
    ),
    onPressed: callback,
  );
}
```
- Cria um botão com o texto e callback fornecidos.

### Método `build`
```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('BY MARCELO'),
    ),
    body: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, right: 10),
          alignment: Alignment.centerRight,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              displayText,
              style: const TextStyle(fontSize: 55),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        GridView.count(
          crossAxisCount: 4,
          primary: false,
          shrinkWrap: true,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _buildButton('AC', () {
              setState(() {
                displayText = "0";
              });
            }),
            _buildButton('x²', () => _updateDisplayText('^2')),
            _buildButton('√', _calculateSquareRoot),
            _buildButton('➗', () => _updateDisplayText('/')),
            _buildButton('7', () => _updateDisplayText('7')),
            _buildButton('8', () => _updateDisplayText('8')),
            _buildButton('9', () => _updateDisplayText('9')),
            _buildButton('✖️', () => _updateDisplayText('*')),
            _buildButton('4', () => _updateDisplayText('4')),
            _buildButton('5', () => _updateDisplayText('5')),
            _buildButton('6', () => _updateDisplayText('6')),
            _buildButton('➖', () => _updateDisplayText('-')),
            _buildButton('1', () => _updateDisplayText('1')),
            _buildButton('2', () => _updateDisplayText('2')),
            _buildButton('3', () => _updateDisplayText('3')),
            _buildButton('➕', () => _updateDisplayText('+')),
            _buildButton('0', () => _updateDisplayText('0')),
            _buildButton(',', () => _updateDisplayText('.')),
            _buildButton('⌫', () {
              setState(() {
                if (displayText.length > 1) {
                  displayText = displayText.substring(0, displayText.length - 1);
                } else {
                  displayText = "0";
                }
              });
            }),
            _buildButton('=', _calculateResult),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            '🧮 Calculadora ® MARCELO',
            style: TextStyle(fontSize: 15, color: Color(0xffb94d4d)),
          ),
        ),
      ],
    ),
  );
}
```
- Constrói a interface do usuário, incluindo o display e os botões da calculadora.

---
