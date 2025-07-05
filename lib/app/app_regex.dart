import 'package:flutter/services.dart';

FilteringTextInputFormatter englishOnlyFormatter = FilteringTextInputFormatter(
  RegExp(r'[a-zA-Z0-9!@#$%^&*(),.?":{}|<>]'),
  allow: true,
);

FilteringTextInputFormatter digitsOnly = FilteringTextInputFormatter(
  RegExp(r'[0-9]'),
  allow: true,
);

FilteringTextInputFormatter digitsAmountOnly = FilteringTextInputFormatter(
  RegExp(r'[0-9.,]+'),
  allow: true,
);
