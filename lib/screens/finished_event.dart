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
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchFinishedEvent();
  }

  Future<void> _fetchFinishedEvent() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final events = await FinishedEventService.fatchFinishedEvents();
      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
        _events = [];
      });
    }
  }

  void _navigateToEventDetail(Event event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetail(eventId: event.id),
      ),
    );
  }

  Widget _buildEventCard(Event event) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _navigateToEventDetail(event),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEventImage(event),
            _buildEventContent(event),
          ],
        ),
      ),
    );
  }

  Widget _buildEventImage(Event event) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Image.network(
        event.mediaCover,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            color: Colors.grey[300],
            child: const Icon(Icons.image_not_supported, size: 50),
          );
        },
      ),
    );
  }

  Widget _buildEventContent(Event event) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventTitle(event),
          const SizedBox(height: 8),
          _buildEventSummary(event),
          const SizedBox(height: 12),
          _buildEventLocationAndCategory(event),
          const SizedBox(height: 8),
          _buildEventParticipants(event),
        ],
      ),
    );
  }

  Widget _buildEventTitle(Event event) {
    return Text(
      event.name,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildEventSummary(Event event) {
    return Text(
      event.summary,
      style: const TextStyle(
        fontSize: 14,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildEventLocationAndCategory(Event event) {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 16),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            event.cityName,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        _buildCategoryChip(event),
      ],
    );
  }

  Widget _buildCategoryChip(Event event) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        event.category,
        style: TextStyle(
          color: Colors.blue[800],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildEventParticipants(Event event) {
    return Row(
      children: [
        const Icon(Icons.people, size: 16),
        const SizedBox(width: 4),
        Text(
          '${event.registrants}/${event.quota} peserta',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Terjadi Kesalahan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _fetchFinishedEvent,
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_busy, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Tidak Ada Event Mendatang',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Belum ada event yang akan datang saat ini',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return _buildErrorState();
    }

    if (_events.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _fetchFinishedEvent,
      child: ListView.builder(
        itemCount: _events.length,
        itemBuilder: (context, index) {
          return _buildEventCard(_events[index]);
        },
      ),
    );
  }
}
