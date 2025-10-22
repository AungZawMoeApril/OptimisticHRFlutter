import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

import '../providers/check_in_out_provider.dart';
import '../../../../core/providers/app_state_provider.dart';
import '../widgets/attendance_stats_card.dart';
import '../widgets/attendance_history_list.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool _isLoading = false;
  Position? _currentPosition;
  String? _currentAddress;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final employeeId = context.read<AppStateProvider>().employeeId;
    if (employeeId == null) return;

    final provider = context.read<CheckInOutProvider>();
    await provider.getCurrentDayRecord(employeeId);
    
    // Load last month's attendance history
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month - 1, 1);
    final endDate = DateTime(now.year, now.month, 0);
    
    await provider.getAttendanceHistory(
      employeeId: employeeId,
      startDate: startDate,
      endDate: endDate,
    );
    
    await provider.getAttendanceStats(
      employeeId: employeeId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Request permission
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }

      // Get current position
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates using Geocoding service
      // TODO: Implement reverse geocoding to get address

      setState(() {
        _isLoading = false;
        _currentAddress = 'Mock Location Address'; // TODO: Replace with actual address
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  Future<void> _handleCheckInOut() async {
    if (_currentPosition == null) {
      await _getCurrentLocation();
      if (_currentPosition == null) return;
    }

    final provider = context.read<CheckInOutProvider>();
    final employeeId = context.read<AppStateProvider>().employeeId;
    if (employeeId == null) return;

    try {
      setState(() => _isLoading = true);

      if (!provider.isCheckedIn) {
        // Check in
        await provider.checkIn(
          employeeId: employeeId,
          location: _currentAddress ?? 'Unknown',
          latitude: _currentPosition!.latitude,
          longitude: _currentPosition!.longitude,
        );
      } else if (provider.canCheckOut) {
        // Check out
        await provider.checkOut(
          recordId: provider.currentDayRecord!.id,
          location: _currentAddress ?? 'Unknown',
          latitude: _currentPosition!.latitude,
          longitude: _currentPosition!.longitude,
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: Consumer<CheckInOutProvider>(
        builder: (context, provider, child) {
          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${provider.error}',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadInitialData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadInitialData,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Current status card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        if (provider.currentDayRecord != null) ...[
                          ListTile(
                            leading: const Icon(Icons.login),
                            title: const Text('Check In'),
                            subtitle: Text(
                              DateFormat.jm().format(
                                provider.currentDayRecord!.checkInTime,
                              ),
                            ),
                          ),
                          if (provider.currentDayRecord!.checkOutTime != null)
                            ListTile(
                              leading: const Icon(Icons.logout),
                              title: const Text('Check Out'),
                              subtitle: Text(
                                DateFormat.jm().format(
                                  provider.currentDayRecord!.checkOutTime!,
                                ),
                              ),
                            ),
                        ],
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleCheckInOut,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    provider.canCheckOut
                                        ? 'Check Out'
                                        : 'Check In',
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Attendance stats
                if (provider.stats != null)
                  AttendanceStatsCard(stats: provider.stats!),
                const SizedBox(height: 16),

                // Attendance history
                Text(
                  'Attendance History',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                AttendanceHistoryList(
                  records: provider.attendanceHistory,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}