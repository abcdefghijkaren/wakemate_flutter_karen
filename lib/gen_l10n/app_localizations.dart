import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
    Locale('zh'),
    Locale('zh', 'TW'),
  ];

  /// No description provided for @languageSetting.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSetting;

  /// No description provided for @languageTraditionalChinese.
  ///
  /// In en, this message translates to:
  /// **'Traditional Chinese'**
  String get languageTraditionalChinese;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageIndonesian.
  ///
  /// In en, this message translates to:
  /// **'Bahasa Indonesia'**
  String get languageIndonesian;

  /// No description provided for @languageSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettingsTitle;

  /// No description provided for @selectYourLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Your Language'**
  String get selectYourLanguage;

  /// No description provided for @caffeineIntake.
  ///
  /// In en, this message translates to:
  /// **'Caffeine Intake'**
  String get caffeineIntake;

  /// No description provided for @sleepDuration.
  ///
  /// In en, this message translates to:
  /// **'Sleep Duration'**
  String get sleepDuration;

  /// No description provided for @addRecord.
  ///
  /// In en, this message translates to:
  /// **'Add Record'**
  String get addRecord;

  /// No description provided for @caffeineIntakeToday.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Caffeine Intake'**
  String get caffeineIntakeToday;

  /// No description provided for @sleepDurationToday.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Sleep Duration'**
  String get sleepDurationToday;

  /// No description provided for @unitMg.
  ///
  /// In en, this message translates to:
  /// **' mg'**
  String get unitMg;

  /// No description provided for @unitHours.
  ///
  /// In en, this message translates to:
  /// **' hours'**
  String get unitHours;

  /// No description provided for @wakeTime.
  ///
  /// In en, this message translates to:
  /// **'Target Alertness Period'**
  String get wakeTime;

  /// No description provided for @sleepTime.
  ///
  /// In en, this message translates to:
  /// **'Actual Sleep Period'**
  String get sleepTime;

  /// No description provided for @caffeineLog.
  ///
  /// In en, this message translates to:
  /// **'Caffeine Log'**
  String get caffeineLog;

  /// No description provided for @inputHistory.
  ///
  /// In en, this message translates to:
  /// **'Input History'**
  String get inputHistory;

  /// No description provided for @calculateRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculateRecommendation;

  /// No description provided for @recommendationHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get recommendationHistory;

  /// No description provided for @alertnessTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Alertness Test'**
  String get alertnessTestTitle;

  /// No description provided for @tapToStart.
  ///
  /// In en, this message translates to:
  /// **'When the color changes, tap immediately.'**
  String get tapToStart;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get pleaseWait;

  /// No description provided for @pleaseTap.
  ///
  /// In en, this message translates to:
  /// **'Tap now!'**
  String get pleaseTap;

  /// No description provided for @tapTooSoon.
  ///
  /// In en, this message translates to:
  /// **'❌ Too early! Try again'**
  String get tapTooSoon;

  /// No description provided for @testResult.
  ///
  /// In en, this message translates to:
  /// **'Test Results'**
  String get testResult;

  /// No description provided for @reactionTimesLabel.
  ///
  /// In en, this message translates to:
  /// **'Reaction times:'**
  String get reactionTimesLabel;

  /// No description provided for @reactionTimeTrial.
  ///
  /// In en, this message translates to:
  /// **'Trial {trial}: {milliseconds} ms'**
  String reactionTimeTrial(int trial, int milliseconds);

  /// No description provided for @averageReactionTime.
  ///
  /// In en, this message translates to:
  /// **'Average reaction time: {avg} ms'**
  String averageReactionTime(String avg);

  /// No description provided for @selectKssLevel.
  ///
  /// In en, this message translates to:
  /// **'Select your alertness level:'**
  String get selectKssLevel;

  /// No description provided for @chooseKssScore.
  ///
  /// In en, this message translates to:
  /// **'Select alertness level'**
  String get chooseKssScore;

  /// No description provided for @testAgain.
  ///
  /// In en, this message translates to:
  /// **'Test Again'**
  String get testAgain;

  /// No description provided for @finishAndClose.
  ///
  /// In en, this message translates to:
  /// **'Finish and Close'**
  String get finishAndClose;

  /// No description provided for @dataSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data sent successfully!'**
  String get dataSentSuccess;

  /// No description provided for @submitFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit. Status code: {statusCode}'**
  String submitFailed(int statusCode);

  /// No description provided for @networkErrorCannotSubmit.
  ///
  /// In en, this message translates to:
  /// **'Network error. Unable to submit data'**
  String get networkErrorCannotSubmit;

  /// No description provided for @startTest.
  ///
  /// In en, this message translates to:
  /// **'Start Test'**
  String get startTest;

  /// No description provided for @kssLevel1.
  ///
  /// In en, this message translates to:
  /// **'Extremely alert'**
  String get kssLevel1;

  /// No description provided for @kssLevel2.
  ///
  /// In en, this message translates to:
  /// **'Very alert'**
  String get kssLevel2;

  /// No description provided for @kssLevel3.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get kssLevel3;

  /// No description provided for @kssLevel4.
  ///
  /// In en, this message translates to:
  /// **'Rather alert'**
  String get kssLevel4;

  /// No description provided for @kssLevel5.
  ///
  /// In en, this message translates to:
  /// **'Neither alert nor sleepy'**
  String get kssLevel5;

  /// No description provided for @kssLevel6.
  ///
  /// In en, this message translates to:
  /// **'Some signs of sleepiness'**
  String get kssLevel6;

  /// No description provided for @kssLevel7.
  ///
  /// In en, this message translates to:
  /// **'Sleepy, but no effort needed to keep awake'**
  String get kssLevel7;

  /// No description provided for @kssLevel8.
  ///
  /// In en, this message translates to:
  /// **'Sleepy, some effort to keep awake'**
  String get kssLevel8;

  /// No description provided for @kssLevel9.
  ///
  /// In en, this message translates to:
  /// **'Very sleepy, great effort to keep awake, fighting sleep'**
  String get kssLevel9;

  /// No description provided for @personalBodyData.
  ///
  /// In en, this message translates to:
  /// **'Personal Body Data'**
  String get personalBodyData;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @userDefaultName.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userDefaultName;

  /// No description provided for @enterEmailAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password'**
  String get enterEmailAndPassword;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccess;

  /// No description provided for @loginSuccessButNoUserId.
  ///
  /// In en, this message translates to:
  /// **'Login successful, but failed to retrieve user ID'**
  String get loginSuccessButNoUserId;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed: incorrect email or password'**
  String get loginFailed;

  /// No description provided for @unknownServerError.
  ///
  /// In en, this message translates to:
  /// **'An unknown server error occurred'**
  String get unknownServerError;

  /// No description provided for @loginFailedWithReason.
  ///
  /// In en, this message translates to:
  /// **'Login failed: {errorMsg}'**
  String loginFailedWithReason(String errorMsg);

  /// No description provided for @loginFailedInvalidResponse.
  ///
  /// In en, this message translates to:
  /// **'Login failed: invalid server response'**
  String get loginFailedInvalidResponse;

  /// No description provided for @networkErrorCannotConnectServer.
  ///
  /// In en, this message translates to:
  /// **'Error: Unable to connect to the server'**
  String get networkErrorCannotConnectServer;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginTitle;

  /// No description provided for @loginDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password'**
  String get loginDescription;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get login;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get registerNow;

  /// No description provided for @registerAccount.
  ///
  /// In en, this message translates to:
  /// **'Register Account'**
  String get registerAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get register;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful! Please log in'**
  String get registerSuccess;

  /// No description provided for @emailExists.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered'**
  String get emailExists;

  /// No description provided for @registerFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registerFailed;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get fillAllFields;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmail;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @enterAge.
  ///
  /// In en, this message translates to:
  /// **'Please enter your age'**
  String get enterAge;

  /// No description provided for @ageRequired.
  ///
  /// In en, this message translates to:
  /// **'Age is required'**
  String get ageRequired;

  /// No description provided for @invalidAge.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid age'**
  String get invalidAge;

  /// No description provided for @heightCm.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get heightCm;

  /// No description provided for @enterHeight.
  ///
  /// In en, this message translates to:
  /// **'Please enter your height'**
  String get enterHeight;

  /// No description provided for @heightRequired.
  ///
  /// In en, this message translates to:
  /// **'Height is required'**
  String get heightRequired;

  /// No description provided for @invalidHeight.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid height'**
  String get invalidHeight;

  /// No description provided for @weightKg.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightKg;

  /// No description provided for @enterWeight.
  ///
  /// In en, this message translates to:
  /// **'Please enter your weight'**
  String get enterWeight;

  /// No description provided for @weightRequired.
  ///
  /// In en, this message translates to:
  /// **'Weight is required'**
  String get weightRequired;

  /// No description provided for @invalidWeight.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid weight'**
  String get invalidWeight;

  /// No description provided for @bmi.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get bmi;

  /// No description provided for @autoCalculateBMI.
  ///
  /// In en, this message translates to:
  /// **'Your BMI will be calculated automatically'**
  String get autoCalculateBMI;

  /// No description provided for @saveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get saveSettings;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @saveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get saveSuccess;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save'**
  String get saveFailed;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load data'**
  String get loadFailed;

  /// No description provided for @completeRequiredFieldsAndGender.
  ///
  /// In en, this message translates to:
  /// **'Please complete all required fields and select a gender'**
  String get completeRequiredFieldsAndGender;

  /// No description provided for @errorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorPrefix;

  /// No description provided for @addCaffeineLog.
  ///
  /// In en, this message translates to:
  /// **'Add Caffeine Log'**
  String get addCaffeineLog;

  /// No description provided for @caffeineDescription.
  ///
  /// In en, this message translates to:
  /// **'Record your caffeine intake for personalized recommendations'**
  String get caffeineDescription;

  /// No description provided for @caffeineAmount.
  ///
  /// In en, this message translates to:
  /// **'Caffeine Amount (mg)'**
  String get caffeineAmount;

  /// No description provided for @caffeineExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. 150'**
  String get caffeineExample;

  /// No description provided for @drinkName.
  ///
  /// In en, this message translates to:
  /// **'Drink Name'**
  String get drinkName;

  /// No description provided for @drinkExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Latte'**
  String get drinkExample;

  /// No description provided for @takingTime.
  ///
  /// In en, this message translates to:
  /// **'Intake Time'**
  String get takingTime;

  /// No description provided for @saveCaffeineLog.
  ///
  /// In en, this message translates to:
  /// **'Save Caffeine Log'**
  String get saveCaffeineLog;

  /// No description provided for @invalidCaffeine.
  ///
  /// In en, this message translates to:
  /// **'Caffeine must be a positive number'**
  String get invalidCaffeine;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String errorOccurred(String error);

  /// No description provided for @defaultDrink.
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get defaultDrink;

  /// No description provided for @addActualSleepTime.
  ///
  /// In en, this message translates to:
  /// **'Add Actual Sleep Time'**
  String get addActualSleepTime;

  /// No description provided for @actualSleepTimeDescription.
  ///
  /// In en, this message translates to:
  /// **'Please enter the actual time you fell asleep and the time you woke up to record your full sleep cycle.'**
  String get actualSleepTimeDescription;

  /// No description provided for @sleepStartTimePick.
  ///
  /// In en, this message translates to:
  /// **'Sleep start time (tap to select)'**
  String get sleepStartTimePick;

  /// No description provided for @sleepEndTimePick.
  ///
  /// In en, this message translates to:
  /// **'Sleep end time (tap to select)'**
  String get sleepEndTimePick;

  /// No description provided for @sleepStartExample.
  ///
  /// In en, this message translates to:
  /// **'Example: 2025-11-05 23:00'**
  String get sleepStartExample;

  /// No description provided for @sleepEndExample.
  ///
  /// In en, this message translates to:
  /// **'Example: 2025-11-06 07:00'**
  String get sleepEndExample;

  /// No description provided for @saveSleepCycle.
  ///
  /// In en, this message translates to:
  /// **'Save Sleep Cycle'**
  String get saveSleepCycle;

  /// No description provided for @sleepPleaseSelectStartAndEndTime.
  ///
  /// In en, this message translates to:
  /// **'Please select the sleep start and end times.'**
  String get sleepPleaseSelectStartAndEndTime;

  /// No description provided for @sleepEndCannotBeEarlierThanStart.
  ///
  /// In en, this message translates to:
  /// **'The end time cannot be earlier than the start time. Please check the date and time.'**
  String get sleepEndCannotBeEarlierThanStart;

  /// No description provided for @sleepTooLongOver48Hours.
  ///
  /// In en, this message translates to:
  /// **'Sleep duration is too long (over 48 hours). Please confirm.'**
  String get sleepTooLongOver48Hours;

  /// No description provided for @sleepInvalidTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid time format. Please select again.'**
  String get sleepInvalidTimeFormat;

  /// No description provided for @sleepSaveFailedWithReason.
  ///
  /// In en, this message translates to:
  /// **'Failed to save sleep record: {statusCode}\nResponse: {responseBody}'**
  String sleepSaveFailedWithReason(int statusCode, String responseBody);

  /// No description provided for @sleepSaveSuccessWithDuration.
  ///
  /// In en, this message translates to:
  /// **'Sleep record saved successfully!\n😴 Total duration: {hours} hour(s) {minutes} minute(s)'**
  String sleepSaveSuccessWithDuration(int hours, int minutes);

  /// No description provided for @sleepDurationCalculationFailed.
  ///
  /// In en, this message translates to:
  /// **'Data format error. Unable to calculate or save the duration.'**
  String get sleepDurationCalculationFailed;

  /// No description provided for @noResponseContent.
  ///
  /// In en, this message translates to:
  /// **'No response content'**
  String get noResponseContent;

  /// No description provided for @wakePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Target Alertness Period'**
  String get wakePageTitle;

  /// No description provided for @wakeDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the time periods you want to stay alert.'**
  String get wakeDescription;

  /// No description provided for @wakeFillAllTimeSlots.
  ///
  /// In en, this message translates to:
  /// **'Please fill all time slots.'**
  String get wakeFillAllTimeSlots;

  /// No description provided for @wakeEndBeforeStart.
  ///
  /// In en, this message translates to:
  /// **'End time cannot be earlier than start time.'**
  String get wakeEndBeforeStart;

  /// No description provided for @wakeInvalidTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid time format'**
  String get wakeInvalidTimeFormat;

  /// No description provided for @wakeSingleSlotFailed.
  ///
  /// In en, this message translates to:
  /// **'Slot {index} failed (status: {status})'**
  String wakeSingleSlotFailed(Object index, Object status);

  /// No description provided for @wakeSaveAllSuccess.
  ///
  /// In en, this message translates to:
  /// **'Saved {count} slots successfully'**
  String wakeSaveAllSuccess(Object count);

  /// No description provided for @wakePartialSuccess.
  ///
  /// In en, this message translates to:
  /// **'{success} success, {fail} failed'**
  String wakePartialSuccess(Object fail, Object success);

  /// No description provided for @wakeAllFailed.
  ///
  /// In en, this message translates to:
  /// **'All submissions failed'**
  String get wakeAllFailed;

  /// No description provided for @wakeSlotTitle.
  ///
  /// In en, this message translates to:
  /// **'Target Alertness Period #{index}'**
  String wakeSlotTitle(Object index);

  /// No description provided for @startTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// No description provided for @addTimeSlot.
  ///
  /// In en, this message translates to:
  /// **'Add Slot'**
  String get addTimeSlot;

  /// No description provided for @saveWakeTime.
  ///
  /// In en, this message translates to:
  /// **'Save Target Alertness Period'**
  String get saveWakeTime;

  /// No description provided for @timeExampleStart.
  ///
  /// In en, this message translates to:
  /// **'e.g. 05:00'**
  String get timeExampleStart;

  /// No description provided for @timeExampleEnd.
  ///
  /// In en, this message translates to:
  /// **'e.g. 06:00'**
  String get timeExampleEnd;

  /// No description provided for @userInputHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'{date} Input History'**
  String userInputHistoryTitle(String date);

  /// No description provided for @loadingUserInputData.
  ///
  /// In en, this message translates to:
  /// **'Loading input data for this day...'**
  String get loadingUserInputData;

  /// No description provided for @userInputLoadError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading input history:\n{error}'**
  String userInputLoadError(String error);

  /// No description provided for @returnHomeAndAddRecord.
  ///
  /// In en, this message translates to:
  /// **'Please return to the home page, tap the \"Add Record\" button, and select the corresponding period to record.'**
  String get returnHomeAndAddRecord;

  /// No description provided for @noUserInputOnThisDay.
  ///
  /// In en, this message translates to:
  /// **'There is no input record for this day.'**
  String get noUserInputOnThisDay;

  /// No description provided for @yourInputHistory.
  ///
  /// In en, this message translates to:
  /// **'Your Input History'**
  String get yourInputHistory;

  /// No description provided for @actualSleepCycle.
  ///
  /// In en, this message translates to:
  /// **'Actual Sleep Cycle'**
  String get actualSleepCycle;

  /// No description provided for @noActualSleepRecord.
  ///
  /// In en, this message translates to:
  /// **'No actual sleep record'**
  String get noActualSleepRecord;

  /// No description provided for @targetWakePeriod.
  ///
  /// In en, this message translates to:
  /// **'Target Alertness Period'**
  String get targetWakePeriod;

  /// No description provided for @noTargetWakePeriodRecord.
  ///
  /// In en, this message translates to:
  /// **'No target alertness period recorded'**
  String get noTargetWakePeriodRecord;

  /// No description provided for @noCaffeineIntakeRecord.
  ///
  /// In en, this message translates to:
  /// **'No caffeine intake record'**
  String get noCaffeineIntakeRecord;

  /// No description provided for @totalDuration.
  ///
  /// In en, this message translates to:
  /// **'Total Duration'**
  String get totalDuration;

  /// No description provided for @durationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours} hr {minutes} min'**
  String durationHoursMinutes(int hours, int minutes);

  /// No description provided for @intakeTime.
  ///
  /// In en, this message translates to:
  /// **'Intake Time'**
  String get intakeTime;

  /// No description provided for @contentLabel.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get contentLabel;

  /// No description provided for @unknownDrink.
  ///
  /// In en, this message translates to:
  /// **'Unknown Drink'**
  String get unknownDrink;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailable;

  /// No description provided for @drinkWithAmount.
  ///
  /// In en, this message translates to:
  /// **'{name} ({amount} mg)'**
  String drinkWithAmount(String name, String amount);

  /// No description provided for @caffeineHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'{date} Recommendation'**
  String caffeineHistoryTitle(Object date);

  /// No description provided for @caffeineSuggestionIndex.
  ///
  /// In en, this message translates to:
  /// **'Suggestion #{index}'**
  String caffeineSuggestionIndex(Object index);

  /// No description provided for @activeStatus.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get activeStatus;

  /// No description provided for @expiredStatus.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expiredStatus;

  /// No description provided for @recommendedTime.
  ///
  /// In en, this message translates to:
  /// **'Recommended Time'**
  String get recommendedTime;

  /// No description provided for @recommendedAmount.
  ///
  /// In en, this message translates to:
  /// **'Recommended Amount'**
  String get recommendedAmount;

  /// No description provided for @updatedTime.
  ///
  /// In en, this message translates to:
  /// **'Updated At'**
  String get updatedTime;

  /// No description provided for @noCaffeineHistory.
  ///
  /// In en, this message translates to:
  /// **'No recommendation for {date}'**
  String noCaffeineHistory(Object date);

  /// No description provided for @clickToGenerate.
  ///
  /// In en, this message translates to:
  /// **'Tap below to generate caffeine recommendation'**
  String get clickToGenerate;

  /// No description provided for @recalculate.
  ///
  /// In en, this message translates to:
  /// **'Recalculate'**
  String get recalculate;

  /// No description provided for @formatError.
  ///
  /// In en, this message translates to:
  /// **'Format Error'**
  String get formatError;

  /// No description provided for @amountMg.
  ///
  /// In en, this message translates to:
  /// **'{amount} mg'**
  String amountMg(Object amount);

  /// No description provided for @caffeineRecommendationPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Caffeine Recommendation'**
  String get caffeineRecommendationPageTitle;

  /// No description provided for @recommendationDataFormatError.
  ///
  /// In en, this message translates to:
  /// **'Invalid recommendation format'**
  String get recommendationDataFormatError;

  /// No description provided for @recommendationParseFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to parse recommendation: {error}\nRaw: {raw}'**
  String recommendationParseFailed(Object error, Object raw);

  /// No description provided for @recommendationUpdatedButNotificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Some notifications were not scheduled because the recommended time has passed. Your recommendation is still valid—please follow the on-screen guidance.'**
  String get recommendationUpdatedButNotificationFailed;

  /// No description provided for @noNewRecommendationData.
  ///
  /// In en, this message translates to:
  /// **'No new recommendation available'**
  String get noNewRecommendationData;

  /// No description provided for @noNewRecommendationDataMessage.
  ///
  /// In en, this message translates to:
  /// **'No new recommendation available.'**
  String get noNewRecommendationDataMessage;

  /// No description provided for @calculationFailedWithStatus.
  ///
  /// In en, this message translates to:
  /// **'Calculation failed: {status}'**
  String calculationFailedWithStatus(Object status);

  /// No description provided for @serverErrorWithPreview.
  ///
  /// In en, this message translates to:
  /// **'Server error (Status: {status})\nResponse preview: {preview}'**
  String serverErrorWithPreview(Object status, Object preview);

  /// No description provided for @timeoutCheckNetwork.
  ///
  /// In en, this message translates to:
  /// **'Request timeout. Please check your connection.'**
  String get timeoutCheckNetwork;

  /// No description provided for @connectionTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Please try again.'**
  String get connectionTimedOut;

  /// No description provided for @networkConnectionError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get networkConnectionError;

  /// No description provided for @cannotConnectToServer.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to server.'**
  String get cannotConnectToServer;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error: {error}'**
  String unknownError(Object error);

  /// No description provided for @wakemateRecommendationGenerated.
  ///
  /// In en, this message translates to:
  /// **'WAKEMATE Recommendation Ready'**
  String get wakemateRecommendationGenerated;

  /// No description provided for @recommendationGeneratedBody.
  ///
  /// In en, this message translates to:
  /// **'Take {amount} mg caffeine at {time}'**
  String recommendationGeneratedBody(Object time, Object amount);

  /// No description provided for @wakemateCaffeineReminder.
  ///
  /// In en, this message translates to:
  /// **'WAKEMATE Reminder'**
  String get wakemateCaffeineReminder;

  /// No description provided for @caffeineReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Take {amount} mg caffeine at {time}'**
  String caffeineReminderBody(Object time, Object amount);

  /// No description provided for @analyzingCaffeineData.
  ///
  /// In en, this message translates to:
  /// **'Analyzing caffeine data...'**
  String get analyzingCaffeineData;

  /// No description provided for @thisMayTakeSomeTimePleaseWait.
  ///
  /// In en, this message translates to:
  /// **'This may take a moment, please wait'**
  String get thisMayTakeSomeTimePleaseWait;

  /// No description provided for @oopsCalculationFailed.
  ///
  /// In en, this message translates to:
  /// **'Oops! Calculation failed'**
  String get oopsCalculationFailed;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @backToHomePage.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHomePage;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @deleteRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete record'**
  String get deleteRecordTitle;

  /// No description provided for @deleteRecordMessage.
  ///
  /// In en, this message translates to:
  /// **'This record will be deleted. Do you want to continue?'**
  String get deleteRecordMessage;

  /// No description provided for @editSleepRecord.
  ///
  /// In en, this message translates to:
  /// **'Edit sleep record'**
  String get editSleepRecord;

  /// No description provided for @editWakePeriod.
  ///
  /// In en, this message translates to:
  /// **'Edit Target Alertness Period'**
  String get editWakePeriod;

  /// No description provided for @editCaffeineIntake.
  ///
  /// In en, this message translates to:
  /// **'Edit caffeine intake'**
  String get editCaffeineIntake;

  /// No description provided for @intakeTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Intake time'**
  String get intakeTimeLabel;

  /// No description provided for @drinkNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Drink name'**
  String get drinkNameLabel;

  /// No description provided for @caffeineAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Caffeine amount (mg)'**
  String get caffeineAmountLabel;

  /// No description provided for @dateTimeHint.
  ///
  /// In en, this message translates to:
  /// **'yyyy-MM-dd HH:mm'**
  String get dateTimeHint;

  /// No description provided for @deletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Deleted successfully'**
  String get deletedSuccessfully;

  /// No description provided for @updatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Updated successfully'**
  String get updatedSuccessfully;

  /// No description provided for @deleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed'**
  String get deleteFailed;

  /// No description provided for @updateFailed.
  ///
  /// In en, this message translates to:
  /// **'Update failed'**
  String get updateFailed;

  /// No description provided for @invalidDateTimeFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid datetime format. Use yyyy-MM-dd HH:mm'**
  String get invalidDateTimeFormat;

  /// No description provided for @invalidCaffeineAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid caffeine amount'**
  String get invalidCaffeineAmount;

  /// No description provided for @emptyDrinkName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a drink name'**
  String get emptyDrinkName;

  /// No description provided for @endTimeMustBeLater.
  ///
  /// In en, this message translates to:
  /// **'End time must be later than start time'**
  String get endTimeMustBeLater;

  /// No description provided for @mergedFromRecords.
  ///
  /// In en, this message translates to:
  /// **'Merged from {count} records'**
  String mergedFromRecords(int count);

  /// No description provided for @singleRecordCount.
  ///
  /// In en, this message translates to:
  /// **'1 record'**
  String get singleRecordCount;

  /// No description provided for @originalRecord.
  ///
  /// In en, this message translates to:
  /// **'Original record'**
  String get originalRecord;

  /// No description provided for @pvtKssBaselineTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Please complete a baseline alertness test'**
  String get pvtKssBaselineTestTitle;

  /// No description provided for @pvtKssBaselineTestBody.
  ///
  /// In en, this message translates to:
  /// **'You are scheduled to take caffeine at {time}. Please complete one alertness test before intake.'**
  String pvtKssBaselineTestBody(String time);

  /// No description provided for @pvtKssEffectTestTitle.
  ///
  /// In en, this message translates to:
  /// **'Please complete the post-caffeine test'**
  String get pvtKssEffectTestTitle;

  /// No description provided for @pvtKssEffectTestBody.
  ///
  /// In en, this message translates to:
  /// **'You are now within the caffeine effect window. Please complete one alertness test to evaluate the effect.'**
  String pvtKssEffectTestBody(String time);

  /// No description provided for @avoidCaffeineBeforeSleepWarning.
  ///
  /// In en, this message translates to:
  /// **'To protect your sleep quality, please avoid caffeine within 6 hours before sleep.'**
  String get avoidCaffeineBeforeSleepWarning;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
