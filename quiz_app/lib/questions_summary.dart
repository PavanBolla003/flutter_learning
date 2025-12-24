import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData,{super.key});
  final List<Map<String, Object>> summaryData;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Row(
              children: [
                Text(((data['question_index'] as int) + 1).toString()),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['question'] as String,style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5),
                      Text('Your answer: ${data['chosen_answer']}',style: const TextStyle(color: Colors.redAccent,fontSize: 14),),
                      Text('Correct answer: ${data['correct_answer']}',style: const TextStyle(color: Colors.greenAccent,fontSize: 14),),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
