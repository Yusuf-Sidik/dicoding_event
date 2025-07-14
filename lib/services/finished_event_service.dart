import 'dart:convert';
import 'package:dicoding_event/models/event.dart';
import 'package:http/http.dart' as http;

class FinishedEventService {
  static const String _baseUrl = 'https://event-api.dicoding.dev/events';
  static Future<List<Event>> fatchFinishedEvents() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?active=0'));

      if (response.statusCode == 200) {
        final data = response.body;
        final result = jsonDecode(data);
        final List<Event> events = List<Event>.from(
          result['listEvents'].map((event) => Event.fromJson(event)),
        );
        return events;
      } else {
        throw Exception('Failed to load finished events');
      }
    } catch (e) {
      throw Exception('Failed to load finished events: $e');
    }
  }
}
