import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.purple[300],
      ),
    );
  }
}
