import 'package:dibug/main.dart';

void main() {
  dibug(null);
  dibug('hello world');
  dibug(1);
  dibug(2.5);
  dibug(false);
  dibug([null]);
  dibug({
    'test': 'testing'
  });
}