// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Invalid email or password`
  String get errorInvalidEmailOrPassword {
    return Intl.message(
      'Invalid email or password',
      name: 'errorInvalidEmailOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load data`
  String get errorFailedToLoadData {
    return Intl.message(
      'Failed to load data',
      name: 'errorFailedToLoadData',
      desc: '',
      args: [],
    );
  }

  /// `Failed to pick image`
  String get errorFailedToPickImage {
    return Intl.message(
      'Failed to pick image',
      name: 'errorFailedToPickImage',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update user info`
  String get errorFailedToUpdateUserInfo {
    return Intl.message(
      'Failed to update user info',
      name: 'errorFailedToUpdateUserInfo',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get generalSave {
    return Intl.message('Save', name: 'generalSave', desc: '', args: []);
  }

  /// `Search`
  String get formSearchHint {
    return Intl.message('Search', name: 'formSearchHint', desc: '', args: []);
  }

  /// `Search`
  String get formSearchSemanticLabel {
    return Intl.message(
      'Search',
      name: 'formSearchSemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get formNameHint {
    return Intl.message('Name', name: 'formNameHint', desc: '', args: []);
  }

  /// `Name`
  String get formNameSemanticLabel {
    return Intl.message(
      'Name',
      name: 'formNameSemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get formNameLabel {
    return Intl.message('Name', name: 'formNameLabel', desc: '', args: []);
  }

  /// `Enter your Email`
  String get formEmailHint {
    return Intl.message(
      'Enter your Email',
      name: 'formEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get formEmailSemanticLabel {
    return Intl.message(
      'Email',
      name: 'formEmailSemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get formEmailLabel {
    return Intl.message('Email', name: 'formEmailLabel', desc: '', args: []);
  }

  /// `Farm Name`
  String get formFarmNameHint {
    return Intl.message(
      'Farm Name',
      name: 'formFarmNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Farm Name`
  String get formFarmNameSemanticLabel {
    return Intl.message(
      'Farm Name',
      name: 'formFarmNameSemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `Farm Name`
  String get formFarmNameLabel {
    return Intl.message(
      'Farm Name',
      name: 'formFarmNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get formCountryHint {
    return Intl.message('Country', name: 'formCountryHint', desc: '', args: []);
  }

  /// `Country`
  String get formCountrySemanticLabel {
    return Intl.message(
      'Country',
      name: 'formCountrySemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get formCountryLabel {
    return Intl.message(
      'Country',
      name: 'formCountryLabel',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get formStateHint {
    return Intl.message('State', name: 'formStateHint', desc: '', args: []);
  }

  /// `State`
  String get formStateSemanticLabel {
    return Intl.message(
      'State',
      name: 'formStateSemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get formStateLabel {
    return Intl.message('State', name: 'formStateLabel', desc: '', args: []);
  }

  /// `City`
  String get formCityHint {
    return Intl.message('City', name: 'formCityHint', desc: '', args: []);
  }

  /// `City`
  String get formCitySemanticLabel {
    return Intl.message(
      'City',
      name: 'formCitySemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get formCityLabel {
    return Intl.message('City', name: 'formCityLabel', desc: '', args: []);
  }

  /// `Village`
  String get formVillageHint {
    return Intl.message('Village', name: 'formVillageHint', desc: '', args: []);
  }

  /// `Village`
  String get formVillageSemanticLabel {
    return Intl.message(
      'Village',
      name: 'formVillageSemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `Village`
  String get formVillageLabel {
    return Intl.message(
      'Village',
      name: 'formVillageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Farm Capacity`
  String get formFarmCapacityHint {
    return Intl.message(
      'Farm Capacity',
      name: 'formFarmCapacityHint',
      desc: '',
      args: [],
    );
  }

  /// `Farm Capacity`
  String get formFarmCapacitySemanticLabel {
    return Intl.message(
      'Farm Capacity',
      name: 'formFarmCapacitySemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `Farm Capacity`
  String get formFarmCapacityLabel {
    return Intl.message(
      'Farm Capacity',
      name: 'formFarmCapacityLabel',
      desc: '',
      args: [],
    );
  }

  /// `Farm`
  String get formFarmHint {
    return Intl.message('Farm', name: 'formFarmHint', desc: '', args: []);
  }

  /// `Farm`
  String get formFarmSemanticLabel {
    return Intl.message(
      'Farm',
      name: 'formFarmSemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `Farm`
  String get formFarmLabel {
    return Intl.message('Farm', name: 'formFarmLabel', desc: '', args: []);
  }

  /// `Double tap to interact`
  String get formDropdownSemanticHint {
    return Intl.message(
      'Double tap to interact',
      name: 'formDropdownSemanticHint',
      desc: '',
      args: [],
    );
  }

  /// `Loading items`
  String get formDropdownSemanticLoadingItems {
    return Intl.message(
      'Loading items',
      name: 'formDropdownSemanticLoadingItems',
      desc: '',
      args: [],
    );
  }

  /// `Error loading items. Tap to retry.`
  String get formDropdownSemanticErrorFetchItems {
    return Intl.message(
      'Error loading items. Tap to retry.',
      name: 'formDropdownSemanticErrorFetchItems',
      desc: '',
      args: [],
    );
  }

  /// `Tap to retry`
  String get formDropdownMenuAction {
    return Intl.message(
      'Tap to retry',
      name: 'formDropdownMenuAction',
      desc: '',
      args: [],
    );
  }

  /// `No items found`
  String get formDropdownEmptyDescription {
    return Intl.message(
      'No items found',
      name: 'formDropdownEmptyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Happy Poultry Farm`
  String get homePageTitle {
    return Intl.message(
      'Happy Poultry Farm',
      name: 'homePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sell`
  String get homePageAppBarActionButton {
    return Intl.message(
      'Sell',
      name: 'homePageAppBarActionButton',
      desc: '',
      args: [],
    );
  }

  /// `Today's Rate`
  String get homePageAppBarSubActionButton {
    return Intl.message(
      'Today\'s Rate',
      name: 'homePageAppBarSubActionButton',
      desc: '',
      args: [],
    );
  }

  /// `Popular Category`
  String get homePageBodySubTitle {
    return Intl.message(
      'Popular Category',
      name: 'homePageBodySubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recommendations`
  String get homePageBodyTitle {
    return Intl.message(
      'Recommendations',
      name: 'homePageBodyTitle',
      desc: '',
      args: [],
    );
  }

  /// `What are you selling?`
  String get homeSellPageTitle {
    return Intl.message(
      'What are you selling?',
      name: 'homeSellPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back! Glad to see you, Again!`
  String get loginPageTitle {
    return Intl.message(
      'Welcome back! Glad to see you, Again!',
      name: 'loginPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Or Login with`
  String get loginPageSubTitle {
    return Intl.message(
      'Or Login with',
      name: 'loginPageSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get loginPageFooter {
    return Intl.message(
      'Don\'t have an account?',
      name: 'loginPageFooter',
      desc: '',
      args: [],
    );
  }

  /// `Register Now`
  String get loginPageFooterAction {
    return Intl.message(
      'Register Now',
      name: 'loginPageFooterAction',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginPageLoginButton {
    return Intl.message(
      'Login',
      name: 'loginPageLoginButton',
      desc: '',
      args: [],
    );
  }

  /// `Or Login with`
  String get loginPageInstruction {
    return Intl.message(
      'Or Login with',
      name: 'loginPageInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get loginFormEmailHint {
    return Intl.message(
      'Enter your email',
      name: 'loginFormEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get loginFormEmailSemanticLabel {
    return Intl.message(
      'Email',
      name: 'loginFormEmailSemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get loginFormEmailLabel {
    return Intl.message(
      'Email',
      name: 'loginFormEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Password`
  String get loginFormPasswordHint {
    return Intl.message(
      'Enter your Password',
      name: 'loginFormPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginFormPasswordSemanticLabel {
    return Intl.message(
      'Password',
      name: 'loginFormPasswordSemanticLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginFormPasswordLabel {
    return Intl.message(
      'Password',
      name: 'loginFormPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid Email`
  String get loginFormValidateEmail {
    return Intl.message(
      'Please enter valid Email',
      name: 'loginFormValidateEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid Password`
  String get loginFormValidatePassword {
    return Intl.message(
      'Please enter valid Password',
      name: 'loginFormValidatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Farm Settings`
  String get settingPageTitle {
    return Intl.message(
      'Farm Settings',
      name: 'settingPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `User Information`
  String get settingPageUserInfoTitle {
    return Intl.message(
      'User Information',
      name: 'settingPageUserInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `My Ads`
  String get settingPageMyAdsTitle {
    return Intl.message(
      'My Ads',
      name: 'settingPageMyAdsTitle',
      desc: '',
      args: [],
    );
  }

  /// `FaceBook`
  String get semanticImgFacebook {
    return Intl.message(
      'FaceBook',
      name: 'semanticImgFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Google`
  String get semanticImgGoogle {
    return Intl.message(
      'Google',
      name: 'semanticImgGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Batches`
  String get semanticImgBatches {
    return Intl.message(
      'Batches',
      name: 'semanticImgBatches',
      desc: '',
      args: [],
    );
  }

  /// `Feed Management`
  String get semanticImgFeedManagement {
    return Intl.message(
      'Feed Management',
      name: 'semanticImgFeedManagement',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get semanticImgLogout {
    return Intl.message(
      'Logout',
      name: 'semanticImgLogout',
      desc: '',
      args: [],
    );
  }

  /// `File Upload`
  String get semanticImgFileUpload {
    return Intl.message(
      'File Upload',
      name: 'semanticImgFileUpload',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get semanticImgPhone {
    return Intl.message('Phone', name: 'semanticImgPhone', desc: '', args: []);
  }

  /// `Setting`
  String get semanticImgSetting {
    return Intl.message(
      'Setting',
      name: 'semanticImgSetting',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get semanticImgStore {
    return Intl.message('Store', name: 'semanticImgStore', desc: '', args: []);
  }

  /// `Success Mark`
  String get semanticImgSuccessMark {
    return Intl.message(
      'Success Mark',
      name: 'semanticImgSuccessMark',
      desc: '',
      args: [],
    );
  }

  /// `Three Dots`
  String get semanticImgThreeDots {
    return Intl.message(
      'Three Dots',
      name: 'semanticImgThreeDots',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get semanticImgProfile {
    return Intl.message(
      'Profile',
      name: 'semanticImgProfile',
      desc: '',
      args: [],
    );
  }

  /// `Chicken Farm`
  String get semanticImgChickenFarm {
    return Intl.message(
      'Chicken Farm',
      name: 'semanticImgChickenFarm',
      desc: '',
      args: [],
    );
  }

  /// `Home Poster`
  String get semanticImgHomePoster {
    return Intl.message(
      'Home Poster',
      name: 'semanticImgHomePoster',
      desc: '',
      args: [],
    );
  }

  /// `User Infomation`
  String get userInfomationPageTitle {
    return Intl.message(
      'User Infomation',
      name: 'userInfomationPageTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
