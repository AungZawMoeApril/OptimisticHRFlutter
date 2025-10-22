import '../../../../core/error/exceptions.dart';

mixin OnsiteValidationMixin {
	void validateOnsiteRequest({
		required DateTime startDate,
		required DateTime endDate,
		required String location,
		required String reason,
	}) {
		if (endDate.isBefore(startDate)) {
			throw ValidationException('End date must be after start date.');
		}

		if (location.trim().isEmpty) {
			throw ValidationException('Location is required.');
		}

		if (reason.trim().isEmpty) {
			throw ValidationException('Reason is required.');
		}
	}
}
