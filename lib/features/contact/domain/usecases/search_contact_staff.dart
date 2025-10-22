import '../entities/contact_staff.dart';
import '../repositories/contact_repository.dart';

class SearchContactStaff {
  final ContactRepository repository;

  SearchContactStaff(this.repository);

  Future<List<ContactStaff>> call(String query) {
    return repository.searchContactStaff(query);
  }
}