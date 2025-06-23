part of 'personal_info_cubit.dart';

enum PersonalInfoStatus {
  initial,
  loading,
  success,
  failure,
  saveSuccess,
}

class PersonalInfoState extends Equatable {
  final PersonalInfoStatus status;
  final String? errorMessage;

  final PfNameInput name;
  final PfEmailInput email;
  final PfFarmNameInput farmName;
  final PfCountryInput country;
  final PfStateInput state;
  final PfCityInput city;
  final PfVillageInput village;
  final PfFarmCapacityInput farmCapacity;
  final PfFarmInput farm;
  final List<String> farmTypes;
  final String? selectedFarm;
  final File? avartarImg;

  const PersonalInfoState({
    this.status = PersonalInfoStatus.initial,
    this.name = const PfNameInput.pure(),
    this.email = const PfEmailInput.pure(),
    this.farmName = const PfFarmNameInput.pure(),
    this.country = const PfCountryInput.pure(),
    this.state = const PfStateInput.pure(),
    this.city = const PfCityInput.pure(),
    this.village = const PfVillageInput.pure(),
    this.farmCapacity = const PfFarmCapacityInput.pure(),
    this.farm = const PfFarmInput.pure(),
    this.farmTypes = const [],
    this.errorMessage,
    this.selectedFarm,
    this.avartarImg,
  });

  PersonalInfoState copyWith({
    PersonalInfoStatus? status,
    String? errorMessage,
    PfNameInput? name,
    PfEmailInput? email,
    PfFarmNameInput? farmName,
    PfCountryInput? country,
    PfStateInput? state,
    PfCityInput? city,
    PfVillageInput? village,
    PfFarmCapacityInput? farmCapacity,
    PfFarmInput? farm,
    List<String>? farmTypes,
    String? selectedFarm,
    File? avartarImg,
  }) {
    return PersonalInfoState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      name: name ?? this.name,
      email: email ?? this.email,
      farmName: farmName ?? this.farmName,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      village: village ?? this.village,
      farmCapacity: farmCapacity ?? this.farmCapacity,
      farm: farm ?? this.farm,
      farmTypes: farmTypes ?? this.farmTypes,
      selectedFarm: selectedFarm ?? this.selectedFarm,
      avartarImg: avartarImg ?? this.avartarImg,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        name,
        email,
        farmName,
        country,
        state,
        city,
        village,
        farmCapacity,
        farm,
        farmTypes,
        selectedFarm,
        avartarImg,
      ];
}
