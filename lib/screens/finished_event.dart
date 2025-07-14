import 'package:dicoding_event/models/event.dart';
import 'package:dicoding_event/screens/event_detail.dart';
import 'package:dicoding_event/services/finished_event_service.dart';
import 'package:flutter/material.dart';

class FinishedEvent extends StatefulWidget {
  const FinishedEvent({super.key});

  @override
  State<FinishedEvent> createState() => _FinishedEventState();
}

class _FinishedEventState extends State<FinishedEvent> {
  List<Event> _events = [];
  bool _isLoading = true;

  void _fetchFinishedEvent() async {
    _isLoading = true;
    final result = await FinishedEventService.fatchFinishedEvents();
    _events = result;
    setState(() {});
    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _fetchFinishedEvent();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _events.length,
            itemBuilder: (context, index) {
              final event = _events[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetail(eventId: event.id),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(event.summary),
                        const SizedBox(height: 8),
                        Image.network(event.imageLogo),
                        const SizedBox(height: 8),
                        Text('Date: ${event.beginTime} - ${event.endTime}'),
                        const SizedBox(height: 8),
                        Text('Location: ${event.cityName}'),
                        const SizedBox(height: 8),
                        Text(
                            'Registrants: ${event.registrants} / ${event.quota}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
