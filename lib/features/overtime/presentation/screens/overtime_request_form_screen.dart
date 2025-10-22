import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/overtime_provider.dart';
import '../forms/overtime_request_form.dart';
import '../../domain/entities/overtime_entities.dart';
import '../../../../core/widgets/loading_overlay.dart';

class OvertimeRequestFormScreen extends StatefulWidget {
  final String employeeId;

  const OvertimeRequestFormScreen({
    Key? key,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<OvertimeRequestFormScreen> createState() =>
      _OvertimeRequestFormScreenState();
}

class _OvertimeRequestFormScreenState extends State<OvertimeRequestFormScreen> {
  final _form = OvertimeRequestForm();
  final Map<String, String?> _errors = {};

  @override
  Widget build(BuildContext context) {
    return Consumer<OvertimeProvider>(
      builder: (context, provider, child) {
        return LoadingOverlay(
          isLoading: provider.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('New Overtime Request'),
              actions: [
                TextButton(
                  onPressed: _submitForm,
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDatePicker(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildStartTimePicker()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildEndTimePicker()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTypeDropdown(),
                  const SizedBox(height: 16),
                  _buildReasonField(),
                  if (provider.error != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      provider.error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _form.date ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 30)),
        );
        if (date != null) {
          setState(() {
            _form.date = date;
            _validateField('date');
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Date',
          errorText: _errors['date'],
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          _form.date == null
              ? 'Select Date'
              : '${_form.date!.year}-${_form.date!.month.toString().padLeft(2, '0')}-${_form.date!.day.toString().padLeft(2, '0')}',
        ),
      ),
    );
  }

  Widget _buildStartTimePicker() {
    return InkWell(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: _form.startTime ?? TimeOfDay.now(),
        );
        if (time != null) {
          setState(() {
            _form.startTime = time;
            _validateField('startTime');
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Start Time',
          errorText: _errors['startTime'],
          suffixIcon: const Icon(Icons.access_time),
        ),
        child: Text(
          _form.startTime == null
              ? 'Select Time'
              : '${_form.startTime!.hour.toString().padLeft(2, '0')}:${_form.startTime!.minute.toString().padLeft(2, '0')}',
        ),
      ),
    );
  }

  Widget _buildEndTimePicker() {
    return InkWell(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: _form.endTime ?? TimeOfDay.now(),
        );
        if (time != null) {
          setState(() {
            _form.endTime = time;
            _validateField('endTime');
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'End Time',
          errorText: _errors['endTime'],
          suffixIcon: const Icon(Icons.access_time),
        ),
        child: Text(
          _form.endTime == null
              ? 'Select Time'
              : '${_form.endTime!.hour.toString().padLeft(2, '0')}:${_form.endTime!.minute.toString().padLeft(2, '0')}',
        ),
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<OvertimeType>(
      value: _form.type,
      decoration: InputDecoration(
        labelText: 'Overtime Type',
        errorText: _errors['type'],
      ),
      items: OvertimeType.values.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type.toString().split('.').last.toUpperCase()),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _form.type = value;
          _validateField('type');
        });
      },
    );
  }

  Widget _buildReasonField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Reason',
        errorText: _errors['reason'],
        hintText: 'Enter the reason for overtime',
      ),
      maxLines: 3,
      onChanged: (value) {
        _form.reason = value;
        _validateField('reason');
      },
    );
  }

  void _validateField(String field) {
    final errors = _form.validate();
    setState(() {
      _errors[field] = errors[field];
    });
  }

  Future<void> _submitForm() async {
    final errors = _form.validate();
    setState(() {
      _errors.clear();
      _errors.addAll(errors);
    });

    if (errors.isEmpty) {
      final provider = context.read<OvertimeProvider>();
      try {
        await provider.createRequest(
          employeeId: widget.employeeId,
          date: _form.date!,
          startTime: _form.startTime!,
          endTime: _form.endTime!,
          type: _form.type!,
          reason: _form.reason,
        );
        if (!mounted) return;
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}