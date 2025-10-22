import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:h_r_optimistic_mobile/core/error/failures.dart';
import 'package:h_r_optimistic_mobile/features/announcement/domain/repositories/announcement_repository.dart';
import 'package:h_r_optimistic_mobile/features/announcement/presentation/viewmodels/announcement_viewmodel.dart';
import 'package:h_r_optimistic_mobile/features/announcement/domain/entities/announcement.dart';

@GenerateNiceMocks([MockSpec<AnnouncementRepository>()])
part 'announcement_viewmodel_test.mocks.dart';

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
      const errorMessage = 'Failed to load announcements';
      when(mockRepository.getAnnouncements())
          .thenAnswer((_) async => Left(ServerFailure(errorMessage)));

      // Act
      await viewModel.loadAnnouncements();

      // Assert
      expect(viewModel.announcements, isEmpty);
      expect(viewModel.errorMessage, equals(errorMessage));
      expect(viewModel.isBusy, isFalse);
      verify(mockRepository.getAnnouncements()).called(1);
    });

    test('markAsRead success should update announcement read status', () async {
      // Arrange
      viewModel.announcements = [testAnnouncement];
      when(mockRepository.markAsRead(testAnnouncement.id))
          .thenAnswer((_) async => const Right(true));

      // Act
      await viewModel.markAsRead(testAnnouncement.id);

      // Assert
      expect(viewModel.announcements.first.isRead, isTrue);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.isBusy, isFalse);
      verify(mockRepository.markAsRead(testAnnouncement.id)).called(1);
    });

    test('markAsRead failure should set error message', () async {
      // Arrange
      const errorMessage = 'Failed to mark as read';
      viewModel.announcements = [testAnnouncement];
      when(mockRepository.markAsRead(testAnnouncement.id))
          .thenAnswer((_) async => Left(ServerFailure(errorMessage)));

      // Act
      await viewModel.markAsRead(testAnnouncement.id);

      // Assert
      expect(viewModel.announcements.first.isRead, isFalse);
      expect(viewModel.errorMessage, equals(errorMessage));
      verify(mockRepository.markAsRead(testAnnouncement.id)).called(1);
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