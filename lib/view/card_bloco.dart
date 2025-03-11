import 'package:flutter/material.dart';

class CardBloco extends StatefulWidget {
  const CardBloco({super.key});

  @override
  State<CardBloco> createState() => _CardBlocoState();
}

class _CardBlocoState extends State<CardBloco> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,   
      height: MediaQuery.of(context).size.height / 6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: const Row(
        children: [
          Text("data")
        ],
      )
    );
  }
}