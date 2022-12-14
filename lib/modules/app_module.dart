import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jadu_ride_driver/core/helpers/storage.dart';
import 'package:jadu_ride_driver/core/helpers/validator.dart';
import 'package:jadu_ride_driver/core/repository/aadhar_number_repository.dart';
import 'package:jadu_ride_driver/core/repository/add_all_details_repository.dart';
import 'package:jadu_ride_driver/core/repository/add_vehicle_repository.dart';
import 'package:jadu_ride_driver/core/repository/batch_call_repository.dart';
import 'package:jadu_ride_driver/core/repository/car_inside_repository.dart';
import 'package:jadu_ride_driver/core/repository/change_app_language_repository.dart';
import 'package:jadu_ride_driver/core/repository/chasis_number_repository.dart';
import 'package:jadu_ride_driver/core/repository/driver_bookings_repository.dart';
import 'package:jadu_ride_driver/core/repository/driver_duty_repository.dart';
import 'package:jadu_ride_driver/core/repository/driver_license_repository.dart';
import 'package:jadu_ride_driver/core/repository/identify_details_repository.dart';
import 'package:jadu_ride_driver/core/repository/left_side_exterior_repository.dart';
import 'package:jadu_ride_driver/core/repository/number_input_repository.dart';
import 'package:jadu_ride_driver/core/repository/pan_card_repository.dart';
import 'package:jadu_ride_driver/core/repository/payment_details_repository.dart';
import 'package:jadu_ride_driver/core/repository/profile_picture_repository.dart';
import 'package:jadu_ride_driver/core/repository/registration_certificate_repository.dart';
import 'package:jadu_ride_driver/core/repository/right_side_exterior_repository.dart';
import 'package:jadu_ride_driver/core/repository/splash_repository.dart';
import 'package:jadu_ride_driver/core/repository/vehicle_audit_repository.dart';
import 'package:jadu_ride_driver/core/repository/vehicle_insurance_repository.dart';
import 'package:jadu_ride_driver/core/repository/vehicle_number_plate_repository.dart';
import 'package:jadu_ride_driver/core/repository/vehicle_permit_repository.dart';
import 'package:jadu_ride_driver/core/repository/vehicle_pollution_repository.dart';
import 'package:jadu_ride_driver/core/repository/verify_otp_repository.dart';
import 'package:jadu_ride_driver/core/repository/welcome_jadu_ride_repository.dart';
import 'package:jadu_ride_driver/helpers_impls/storage_impl.dart';
import 'package:jadu_ride_driver/helpers_impls/validator_impl.dart';
import 'package:jadu_ride_driver/repository_impls/aadhar_number_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/add_all_details_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/add_vehicle_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/batch_call_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/car_inside_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/change_app_language_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/chasis_number_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/driver_bookings_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/driver_duty_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/driver_license_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/identify_details_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/left_side_exterior_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/number_input_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/pan_card_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/payment_details_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/profile_picture_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/registration_certificate_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/right_side_exterior_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/splash_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/vehicle_audit_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/vehicle_insurance_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/vehicle_number_plate_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/vehicle_permit_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/vehicle_pollution_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/verify_otp_repository_impl.dart';
import 'package:jadu_ride_driver/repository_impls/welcome_jadu_ride_repository_impl.dart';
import 'package:jadu_ride_driver/utills/api_client_configuration.dart';
import 'package:jadu_ride_driver/utills/environment.dart';
import 'package:jadu_ride_driver/utills/global.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dependency = GetIt.instance;

class AppModule {
  AppModule._();

  static final alice = Alice(
    showNotification: true,
    showInspectorOnShake: true,
    darkTheme: false,
  );

  static init() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    dependency.registerLazySingleton<Storage>(() => StorageImpl(sharedPrefs));

    final imagePicker = ImagePicker();
    final cropper = ImageCropper();
    final env = Environment();
    await env.init();
    await ApiClientConfiguration.init(env.apiKey, env.staticBaseUrl);
    final dio = Dio(ApiClientConfiguration.initialConfiguration);
    dio.interceptors.add(alice.getDioInterceptor());

    dependency.registerLazySingleton<ImagePicker>(() => imagePicker);

    dependency.registerLazySingleton<ImageCropper>(() => cropper);

    dependency.registerLazySingleton<SplashRepository>(
        () => SplashRepositoryImpl(dio));

    dependency.registerLazySingleton<BatchCallRepository>(
        () => BatchCallRepositoryImpl(dio));

    dependency.registerLazySingleton<NumberInputRepository>(
        () => NumberInputRepositoryImpl(dio));

    dependency.registerLazySingleton<VerifyOtpRepository>(
        () => VerifyOtpRepositoryImpl(dio));

    dependency.registerLazySingleton<ChangeAppLanguageRepository>(
        () => ChangeAppLanguageRepositoryImpl(dio));

    dependency.registerLazySingleton<WelcomeJaduRideRepository>(
        () => WelcomeJaduRideRepositoryImpl(dio));

    dependency.registerLazySingleton<AddVehicleRepository>(
        () => AddVehicleRepositoryImpl(dio));

    dependency.registerLazySingleton<AddAllDetailsRepository>(
        () => AddAllDetailsRepositoryImpl(dio));

    dependency.registerLazySingleton<ProfilePictureRepository>(
        () => ProfilePictureRepositoryImpl(dio));

    dependency.registerLazySingleton<DriverLicenseRepository>(
        () => DriverLicenseRepositoryImpl(dio));

    dependency.registerLazySingleton<AadharNumberRepository>(
        () => AadharNumberRepositoryImpl(dio));

    dependency.registerLazySingleton<Validator>(() => ValidatorImpl());

    dependency.registerLazySingleton<VehicleInsuranceRepository>(
        () => VehicleInsuranceRepositoryImpl(dio));

    dependency.registerLazySingleton<RegistrationCertificateRepository>(
        () => RegistrationCeritificateRepositoryImpl(dio));

    dependency.registerLazySingleton<PanCardRepository>(
        () => PanCardRepositoryImpl(dio));

    dependency.registerLazySingleton<VehiclePermitRepository>(
        () => VehiclePermitRepositoryImpl(dio));

    dependency.registerLazySingleton<VehicleAuditRepository>(
        () => VehicleAuditRepositoryImpl());

    dependency.registerLazySingleton<ChasisNumberRepository>(
        () => ChasisNumberRepositoryImpl());

    dependency.registerLazySingleton<VehicleNumberPlateRepository>(
        () => VehicleNumberPlateRepositoryImpl());

    dependency.registerLazySingleton<LeftSideExteriorRepository>(
        () => LeftSideExteriorRepositoryImpl());

    dependency.registerLazySingleton<RightSideExteriorRepository>(
        () => RightSideExteriorRepositoryImpl());

    dependency.registerLazySingleton<CarInsideRepository>(
        () => CarInsideRepositoryImpl());

    dependency.registerLazySingleton<VehiclePollutionRepository>(
        () => VehiclePollutionRepositoryImpl());

    dependency.registerLazySingleton<IdentifyDetailsRepository>(
        () => IdentifyDetailsRepositoryImpl(dio));

    dependency.registerLazySingleton<PaymentDetailsRepository>(
        () => PaymentDetailsRepositoryImpl(dio));

    dependency.registerLazySingleton<DriverDutyRepository>(() => DriverDutyRepositoryImpl());

    dependency.registerLazySingleton<DriverBookingsRepository>(() => DriverBookingsRepositoryImpl());
  }
}
