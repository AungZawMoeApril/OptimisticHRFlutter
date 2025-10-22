import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/onsite_entities.dart';
import '../models/onsite_models.dart';

/// Simple local data source using GetStorage for caching onsite requests.
class OnsiteLocalDataSource {
	final GetStorage _box;

	static const _cacheKey = 'onsite_requests_cache';

	OnsiteLocalDataSource({GetStorage? box}) : _box = box ?? GetStorage();

		Future<void> cacheOnsiteRequests(List<OnsiteRequest> requests) async {
		try {
				final jsonList = requests
						.map((r) => r is OnsiteRequestModel ? r.toJson() : OnsiteRequestModel(
									id: r.id,
									employeeId: r.employeeId,
									startDate: r.startDate,
									endDate: r.endDate,
									startTime: r.startTime,
									endTime: r.endTime,
									type: r.type,
									location: r.location,
									reason: r.reason,
									status: r.status,
									approverNote: r.approverNote,
									createdAt: r.createdAt,
									updatedAt: r.updatedAt,
								).toJson())
						.toList();
			await _box.write(_cacheKey, jsonEncode(jsonList));
		} catch (e) {
			throw CacheException();
		}
	}

		Future<List<OnsiteRequest>> getCachedOnsiteRequests() async {
		try {
				final raw = _box.read<String>(_cacheKey);
				if (raw == null) return [];
				final List<dynamic> jsonList = jsonDecode(raw);
				return jsonList
						.map((j) => OnsiteRequestModel.fromJson(j as Map<String, dynamic>))
						.toList();
		} catch (e) {
			throw CacheException();
		}
	}
}
