import 'package:bloc_example/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('description', () {

    late UserRepository userRepository;

    setUp(() {
      userRepository=UserRepository();
    }
    );

    test('description', () async{
    await userRepository.getUsers();

    });
   });
}