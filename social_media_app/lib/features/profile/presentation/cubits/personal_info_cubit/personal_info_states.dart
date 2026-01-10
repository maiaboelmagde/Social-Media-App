class PersonalInfoStates {}

class PersonalInfoInitialState extends PersonalInfoStates {} 
class PersonalInfoLoadingState extends PersonalInfoStates {}
class PersonalInfoSuccessState extends PersonalInfoStates {}
class PersonalInfoFailureState extends PersonalInfoStates {
  final String errorMessage;
  PersonalInfoFailureState(this.errorMessage);
}
