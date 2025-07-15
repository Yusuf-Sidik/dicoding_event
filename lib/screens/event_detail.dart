import 'package:dicoding_event/models/event.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class EventDetail extends StatefulWidget {
  final int eventId;

  const EventDetail({super.key, required this.eventId});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  late Future<Event> _event;

  @override
  void initState() {
    super.initState();
    _event = _fetchEvent();
  }

  Future<Event> _fetchEvent() async {
    final response = await http.get(
        Uri.parse('https://event-api.dicoding.dev/events/${widget.eventId}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Event.fromJson(data['event']);
    } else {
      throw Exception('Failed to load event');
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Detail'),
      ),
      body: FutureBuilder<Event>(
        future: _event,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final event = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.network(event.mediaCover),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      event.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Html(
                      data: event.description,
                      onLinkTap: (url, _, __) {
                        if (url != null) {
                          _launchUrl(url);
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
