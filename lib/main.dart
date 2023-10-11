import 'package:flutter/material.dart';
import 'package:usb_thermal_printer_web/usb_thermal_printer_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'USB Thermal Printer TestApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'USB Thermal Printer TestApp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WebThermalPrinter _printer = WebThermalPrinter();

  void printReceiptTest() async {
    //Pairing Device is required.
    await _printer.pairDevice(vendorId: 0x6868, productId: 0x0200);

    await _printer.printText('DKT Mart', bold: true, centerAlign: true);
    await _printer.printEmptyLine();

    await _printer.printRow("Products", "Sale");
    await _printer.printEmptyLine();

    for (int i = 0; i < 10; i++) {
      await _printer.printRow(
          'A big title very big title ${i + 1}', '${(i + 1) * 510}.00 AED');
      await _printer.printEmptyLine();
    }

    await _printer.printDottedLine();
    await _printer.printEmptyLine();

    await _printer.printBarcode('123456');
    await _printer.printEmptyLine();

    await _printer.printEmptyLine();
    await _printer.closePrinter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: printReceiptTest,
              child: const Text('Print'),
            ),
          ],
        ),
      ),
    );
  }
}
