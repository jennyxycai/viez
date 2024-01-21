import 'package:viez/core/data/repository/physical_activity_repository.dart';
import 'package:viez/core/domain/entity/physical_activity_entity.dart';

class GetPhysicalActivityUsecase {
  final PhysicalActivityRepository _physicalActivityRepository;

  GetPhysicalActivityUsecase(this._physicalActivityRepository);

  Future<List<PhysicalActivityEntity>> getAllPhysicalActivities() async {
    return await _physicalActivityRepository.getAllPhysicalActivities();
  }
}
