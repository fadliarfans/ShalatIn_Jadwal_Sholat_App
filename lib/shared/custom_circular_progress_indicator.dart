import 'package:flutter/material.dart';
import '../theme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: green,
      strokeWidth: 4,
    );
  }
}
