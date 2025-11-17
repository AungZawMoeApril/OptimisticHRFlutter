import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:h_r_optimistic_mobile/core/error/failures.dart';
import 'package:h_r_optimistic_mobile/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:h_r_optimistic_mobile/features/announcement/presentation/viewmodels/announcement_viewmodel.dart';
import 'package:h_r_optimistic_mobile/features/announcement/domain/entities/announcement.dart';
import 'announcement_viewmodel_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AnnouncementRepository>()])
// Mock file is manually created above instead of generated with build_runner

void main() {
  late AnnouncementViewModel viewModel;
  late MockAnnouncementRepository mockRepository;

  setUp(() {
    mockRepository = MockAnnouncementRepository();
    viewModel = AnnouncementViewModel(mockRepository);
  });

  group('AnnouncementViewModel Tests', () {
    final testAnnouncement = Announcement(
      id: '1',
      title: 'Test Announcement',
      description: 'Test Description',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isRead: false,
    );

    test('loadAnnouncements success should update announcements list', () async {
      // Arrange
      when(mockRepository.getAnnouncements())
          .thenAnswer((_) async => Right([testAnnouncement]));

      // Act
      await viewModel.loadAnnouncements();

      // Assert
      expect(viewModel.announcements.length, equals(1));
      expect(viewModel.announcements.first, equals(testAnnouncement));
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.isBusy, isFalse);
      verify(mockRepository.getAnnouncements()).called(1);
    });

    test('loadAnnouncements failure should set error message', () async {
      // Arrange
      when(mockRepository.getAnnouncements())
          .thenAnswer((_) async => Left(ServerFailure()));

      // Act
      await viewModel.loadAnnouncements();

      // Assert
      expect(viewModel.announcements, isEmpty);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.isBusy, isFalse);
      verify(mockRepository.getAnnouncements()).called(1);
    });

    test('markAsRead success should update announcement read status', () async {
      // Arrange
      // First load announcements
      when(mockRepository.getAnnouncements())
          .thenAnswer((_) async => Right([testAnnouncement]));
      await viewModel.loadAnnouncements();
      
      when(mockRepository.markAnnouncementAsRead(testAnnouncement.id))
          .thenAnswer((_) async => const Right(null));

      // Act
      await viewModel.markAsRead(testAnnouncement.id);

      // Assert
      expect(viewModel.announcements.first.isRead, isTrue);
      expect(viewModel.errorMessage, isNull);
      verify(mockRepository.markAnnouncementAsRead(testAnnouncement.id)).called(1);
    });

    test('markAsRead failure should set error message', () async {
      // Arrange
      // First load announcements
      when(mockRepository.getAnnouncements())
          .thenAnswer((_) async => Right([testAnnouncement]));
      await viewModel.loadAnnouncements();
      
      when(mockRepository.markAnnouncementAsRead(testAnnouncement.id))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Act
      await viewModel.markAsRead(testAnnouncement.id);

      // Assert
      expect(viewModel.announcements.first.isRead, isFalse);
      expect(viewModel.errorMessage, isNotNull);
      verify(mockRepository.markAnnouncementAsRead(testAnnouncement.id)).called(1);
    });

    test('refreshAnnouncements should reload announcements', () async {
      // Arrange
      when(mockRepository.getAnnouncements())
          .thenAnswer((_) async => Right([testAnnouncement]));

      // Act
      await viewModel.refreshAnnouncements();

      // Assert
      expect(viewModel.announcements.length, equals(1));
      expect(viewModel.announcements.first, equals(testAnnouncement));
      verify(mockRepository.getAnnouncements()).called(1);
    });
  });
}