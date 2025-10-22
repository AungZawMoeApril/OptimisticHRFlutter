import '../../domain/entities/contact_staff.dart';
import '../../domain/repositories/contact_repository.dart';
import '../models/contact_staff_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactRepositoryImpl implements ContactRepository {
  final http.Client client;

  ContactRepositoryImpl({required this.client});

  @override
  Future<List<ContactStaff>> getContactStaff(String companyId) async {
    final response = await client.get(
      Uri.parse('YOUR_API_ENDPOINT/contact-staff/$companyId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ContactStaffModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load contact staff');
    }
  }

  @override
  Future<List<ContactStaff>> searchContactStaff(String query) async {
    // Implement the search functionality
    // You can either call a search API endpoint or filter the local list
    throw UnimplementedError();
  }
}