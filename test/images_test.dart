import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:procrastinator/src/shared/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.patratii).existsSync(), isTrue);
    expect(File(Images.lutzLogotypePng).existsSync(), isTrue);
    expect(File(Images.userPhoto).existsSync(), isTrue);
  });
}
