# Calculadora

A new Flutter project created with FlutLab - https://flutlab.io

## Getting Started

A few resources to get you started if this is your first Flutter project:

- https://flutter.dev/docs/get-started/codelab
- https://flutter.dev/docs/cookbook

For help getting started with Flutter, view our
https://flutter.dev/docs, which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Getting Started: FlutLab - Flutter Online IDE

- How to use FlutLab? Please, view our https://flutlab.io/docs
- Join the discussion and conversation on https://flutlab.io/residents


```markdown
# Flutter Minimalist Calculator

## Visão Geral

Esta aplicação é uma calculadora minimalista desenvolvida em Flutter.
Ela permite realizar operações matemáticas básicas, calcular raízes quadradas, armazenar valores na memória, e limpar ou recuperar esses valores.
A interface é simples e intuitiva, com botões claramente definidos para cada função.

## Funcionalidades

- **Operações Básicas**: Adição, subtração, multiplicação e divisão.
- **Raiz Quadrada**: Calcula a raiz quadrada do valor no display.
- **Potência ao Quadrado**: Adiciona o operador de potência ao quadrado.
- **Memória**: Armazena, recupera e limpa valores.
- **Formatação de Números**: Números são formatados com separadores de milhar para facilitar a leitura.

## Capturas de Tela

![Calculadora](https://github.com/MarceloC2/flutter-minimalist-calculator/blob/main/Captura%20de%20tela.png)

## Como Usar

1. Clone este repositório:
    ```bash
    git clone https://github.com/MarceloC2/flutter-minimalist-calculator.git
    ```
2. Navegue até o diretório do projeto:
    ```bash
    cd flutter-minimalist-calculator
    ```
3. Instale as dependências:
    ```bash
    flutter pub get
    ```
4. Execute a aplicação:
    ```bash
    flutter run
    ```

## Estrutura do Projeto

### Arquivos Principais

- `main.dart`: Contém o código principal da aplicação.

### Dependências

- `eval_ex`: Biblioteca para avaliar expressões matemáticas.
- `intl_util`: Biblioteca para formatação de números.

## Código Fonte

### Importações

```dart
import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
```

### Função Principal

```dart
void main() => runApp(const MyApp());
```

### Classe MyApp

```dart
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
```

### Classe MyHomePage

```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
```

### Estado da MyHomePage

```dart
class _MyHomePageState extends State<MyHomePage> {
  String displayText = "0";
  String storedValue = "";
  bool isValueStored = false;

  void _updateDisplayText(String buttonText) {
    setState(() {
      if (displayText == '0') {
        displayText = buttonText;
      } else {
        displayText += buttonText;
      }
    });
  }

  void _calculateResult() {
    String sanitizedText = displayText.replaceAll(',', '');
    Expression exp = Expression(sanitizedText);
    setState(() {
      String result = exp.eval().toString();
      displayText = _formatNumber(result);
    });
  }

  void _calculateSquareRoot() {
    String sanitizedText = displayText.replaceAll(',', '');
    setState(() {
      double value = double.tryParse(sanitizedText) ?? 0;
      String result = (value >= 0) ? sqrt(value).toString() : "Erro";
      displayText = _formatNumber(result);
    });
  }

  String _formatNumber(String number) {
    double value = double.tryParse(number) ?? 0;
    return NumberFormat("#,##0.###", "en_US").format(value);
  }

  void _storeValue() {
    setState(() {
      storedValue = displayText;
      isValueStored = true;
    });
  }

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

  void _clearStoredValue() {
    setState(() {
      storedValue = "";
      isValueStored = false;
    });
  }

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
        minimumSize: Size(0, height ?? 60),
      ),
      onPressed: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 8, right: 20, left: 20, bottom: 5),
                alignment: Alignment.centerRight,
                color: Colors.grey[900],
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    displayText,
                    style: const TextStyle(fontSize: 64, color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
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
                    _buildButton('=', _calculateResult, color: Colors.teal, height: 80),
                    _buildButton('M+', _storeValue,
                        color: Colors.yellow[800],
                        height: 40,
                        fontSize: 18),
                    _buildButton('MR', _insertStoredValue,
                        color: Colors.blue[800],
                        height: 40,
                        fontSize: 18),
                    _buildButton('MC', _clearStoredValue,
                        color: Colors.red[800],
                        height: 40,
                        fontSize: 18),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                '🧮 Calculadora ® MARCELO',
                style: TextStyle(fontSize: 15, color: Colors.tealAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

## Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---


