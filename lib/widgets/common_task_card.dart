import 'package:flutter/material.dart';

class CommontaskCard extends StatelessWidget {
  const CommontaskCard({
    super.key,
    required this.cardBody,
    this.onTap,
  });

  final Widget cardBody;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
            border: Border.all(
              color: Colors.green.shade500,
              width: 2,
            ),
          ),
          child: cardBody,
        ),
      ),
    );
  }
}
