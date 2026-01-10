import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/use_cases/update_personal_info_use_case.dart';
import 'package:social_media_app/features/profile/presentation/cubits/personal_info_cubit/personal_info_states.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoStates> {
  PersonalInfoCubit({required this.updatePersonalInfoUseCase})
    : super(PersonalInfoInitialState());
  final UpdatePersonalInfoUseCase updatePersonalInfoUseCase;

  Future<void> updatePersonalInfo({
    required String userId,
    required String name,
    required String bio,
  }) async {
    emit(PersonalInfoLoadingState());
    try {
      await updatePersonalInfoUseCase.call(
        userId: userId,
        name: name,
        bio: bio,
      );

      emit(PersonalInfoSuccessState());
    } catch (e) {
      emit(PersonalInfoFailureState(e.toString()));
    }
  }
}
