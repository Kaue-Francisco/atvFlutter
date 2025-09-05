import 'package:flutter/material.dart';

class DiscountCalculator extends StatefulWidget {
  const DiscountCalculator({super.key});

  @override
  State<DiscountCalculator> createState() => 
    _DiscountCalculorState();
  }

  class _DiscountCalculorState extends State<DiscountCalculator> {
  final TextEditingController _price = TextEditingController();
  final TextEditingController _discount = TextEditingController();
   double? _finalPrice;

   void _calculateDiscount() {
    final price = double.tryParse(_price.text) ?? 0;
    final discount = double.tryParse(_discount.text) ?? 0;

    setState(() {
      _finalPrice = price * (discount / 100);
    });
   }


   @override
   Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _price,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Valor ",
            border: OutlineInputBorder(),
          ),

        ),
        const SizedBox(height: 8),
         TextField(
          controller: _discount,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Desconto ",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _calculateDiscount,
          child: const Text('Calcular desconto'),
        ),
        const SizedBox(height: 16),
        if (_finalPrice != null)
          Text(
            'O desconto é: ${_finalPrice!.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),

      ],
    );
   }
  }