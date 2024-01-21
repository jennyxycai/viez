import 'package:viez/core/data/repository/user_repository.dart';
import 'package:viez/core/domain/entity/user_entity.dart';

class GetUserUsecase {
  final UserRepository userRepository;

  GetUserUsecase(this.userRepository);

  Future<UserEntity> getUserData() async {
    return await userRepository.getUserData();
  }

  Future<bool> hasUserData() async {
    return await userRepository.hasUserData();
  }
}
