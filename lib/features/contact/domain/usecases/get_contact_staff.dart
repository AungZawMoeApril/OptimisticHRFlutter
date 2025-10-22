import '../entities/contact_staff.dart';
import '../repositories/contact_repository.dart';

class GetContactStaff {
  final ContactRepository repository;

  GetContactStaff(this.repository);

  Future<List<ContactStaff>> call(String companyId) {
    return repository.getContactStaff(companyId);
  }
}