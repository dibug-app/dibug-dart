import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stack_trace/stack_trace.dart';

Future<void> dibug(dynamic data, {String host = '127.0.0.1'}) async {
  try {
    Trace trace = Trace.from(StackTrace.current);
    Frame file = trace.frames.where((element) => !element.isCore).last;
    String stackTraceString = trace.original.toString();

    await http.post(
      Uri.parse('http://$host:33285'),
      body: jsonEncode({
        'type': 'info',
        'data': data,
        'file': {
          'name': file.uri.pathSegments.last,
          'line': file.line,
          'path': file.uri.replace(scheme: '').toString()
        },
        'trace': stackTraceString.split('\n')
      }),
      headers: {'content-type': 'application/json'},
    );
  } catch (exception) {
    if (String.fromEnvironment('DIBUG_THROW_ERRORS', defaultValue: '') == 'true') {
      rethrow;
    }
  }
}
