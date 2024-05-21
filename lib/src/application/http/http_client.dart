import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final httpClient = Provider<http.Client>((ref) {
  return http.Client();
});