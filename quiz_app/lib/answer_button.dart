import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton( {super.key,required this.answerText, required this.onTap});
  final String answerText;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 107, 30, 120),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),        
      ),
      child: Text(answerText,textAlign: TextAlign.center,),
    );
  }
}
