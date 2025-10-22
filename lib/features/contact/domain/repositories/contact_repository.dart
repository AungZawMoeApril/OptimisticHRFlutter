import '../entities/contact_staff.dart';

abstract class ContactRepository {
  Future<List<ContactStaff>> getContactStaff(String companyId);
  Future<List<ContactStaff>> searchContactStaff(String query);
}