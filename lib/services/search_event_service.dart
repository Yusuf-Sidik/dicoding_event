import 'dart:convert';
import 'package:dicoding_event/models/event.dart';
import 'package:http/http.dart' as http;

class SearchEventService {
  static const String _baseUrl = 'https://event-api.dicoding.dev/events';

  static Future<List<Event>> searchEvents(String query) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?active=-1&q=$query'));

      if (response.statusCode == 200) {
        final data = response.body;
        final result = jsonDecode(data);
        final List<Event> events = List<Event>.from(
          result['listEvents'].map((event) => Event.fromJson(event)),
        );
        return events;
      } else {
        throw Exception('Failed to search events');
      }
    } catch (e) {
      throw Exception('Failed to search events: $e');
    }
  }

  static Future<Event> getEventById(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id'));

      if (response.statusCode == 200) {
        final data = response.body;
        final result = jsonDecode(data);
        return Event.fromJson(result['event']);
      } else {
        throw Exception('Failed to load event details');
      }
    } catch (e) {
      throw Exception('Failed to load event details: $e');
    }
  }
}