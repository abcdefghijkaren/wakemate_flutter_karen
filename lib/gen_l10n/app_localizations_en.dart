// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get languageSetting => 'Language';

  @override
  String get languageTraditionalChinese => 'Traditional Chinese';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageIndonesian => 'Bahasa Indonesia';

  @override
  String get languageSettingsTitle => 'Language Settings';

  @override
  String get selectYourLanguage => 'Select Your Language';

  @override
  String get caffeineIntake => 'Caffeine Intake';

  @override
  String get sleepDuration => 'Sleep Duration';

  @override
  String get addRecord => 'Add Record';

  @override
  String get caffeineIntakeToday => 'Today\'s Caffeine Intake';

  @override
  String get sleepDurationToday => 'Today\'s Sleep Duration';

  @override
  String get unitMg => ' mg';

  @override
  String get unitHours => ' hours';

  @override
  String get wakeTime => 'Wake Time';

  @override
  String get sleepTime => 'Sleep Time';

  @override
  String get caffeineLog => 'Caffeine Log';

  @override
  String get inputHistory => 'Input History';

  @override
  String get calculateRecommendation => 'Calculate';

  @override
  String get recommendationHistory => 'History';

  @override
  String get alertnessTestTitle => 'Alertness Test';

  @override
  String get tapToStart => 'Tap to Start';

  @override
  String get pleaseWait => 'Please wait...';

  @override
  String get pleaseTap => 'Tap now!';

  @override
  String get tapTooSoon => '❌ Too early! Try again';

  @override
  String get testResult => 'Test Results';

  @override
  String get reactionTimesLabel => 'Reaction times:';

  @override
  String reactionTimeTrial(int trial, int milliseconds) {
    return 'Trial $trial: $milliseconds ms';
  }

  @override
  String averageReactionTime(String avg) {
    return 'Average reaction time: $avg ms';
  }

  @override
  String get selectKssLevel => 'Select your alertness level (KSS):';

  @override
  String get chooseKssScore => 'Select KSS score';

  @override
  String get testAgain => 'Test Again';

  @override
  String get finishAndClose => 'Finish and Close';

  @override
  String get dataSentSuccess => 'Data sent successfully!';

  @override
  String submitFailed(int statusCode) {
    return 'Failed to submit. Status code: $statusCode';
  }

  @override
  String get networkErrorCannotSubmit => 'Network error. Unable to submit data';

  @override
  String get tapHere => 'Tap Here';

  @override
  String get startTest => 'Start Test';

  @override
  String get kssLevel1 => 'Extremely alert';

  @override
  String get kssLevel2 => 'Very alert';

  @override
  String get kssLevel3 => 'Alert';

  @override
  String get kssLevel4 => 'Rather alert';

  @override
  String get kssLevel5 => 'Neither alert nor sleepy';

  @override
  String get kssLevel6 => 'Some signs of sleepiness';

  @override
  String get kssLevel7 => 'Sleepy, but no effort needed to keep awake';

  @override
  String get kssLevel8 => 'Sleepy, some effort to keep awake';

  @override
  String get kssLevel9 =>
      'Very sleepy, great effort to keep awake, fighting sleep';

  @override
  String get personalBodyData => 'Personal Body Data';

  @override
  String get logout => 'Log Out';

  @override
  String get userDefaultName => 'User';

  @override
  String get enterEmailAndPassword => 'Please enter your email and password';

  @override
  String get loginSuccess => 'Login successful!';

  @override
  String get loginSuccessButNoUserId =>
      'Login successful, but failed to retrieve user ID';

  @override
  String get loginFailed => 'Login failed: incorrect email or password';

  @override
  String get unknownServerError => 'An unknown server error occurred';

  @override
  String loginFailedWithReason(String errorMsg) {
    return 'Login failed: $errorMsg';
  }

  @override
  String get loginFailedInvalidResponse =>
      'Login failed: invalid server response';

  @override
  String get networkErrorCannotConnectServer =>
      'Error: Unable to connect to the server';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get loginTitle => 'Sign In';

  @override
  String get loginDescription => 'Please enter your email and password';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Log In';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get registerNow => 'Sign up';

  @override
  String get registerAccount => 'Register Account';

  @override
  String get createAccount => 'Create Account';

  @override
  String get register => 'Sign Up';

  @override
  String get registerSuccess => 'Registration successful! Please log in';

  @override
  String get emailExists => 'This email is already registered';

  @override
  String get registerFailed => 'Registration failed';

  @override
  String get name => 'Name';

  @override
  String get fillAllFields => 'Please fill in all fields';

  @override
  String get invalidEmail => 'Invalid email format';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get age => 'Age';

  @override
  String get enterAge => 'Please enter your age';

  @override
  String get ageRequired => 'Age is required';

  @override
  String get invalidAge => 'Please enter a valid age';

  @override
  String get heightCm => 'Height (cm)';

  @override
  String get enterHeight => 'Please enter your height';

  @override
  String get heightRequired => 'Height is required';

  @override
  String get invalidHeight => 'Please enter a valid height';

  @override
  String get weightKg => 'Weight (kg)';

  @override
  String get enterWeight => 'Please enter your weight';

  @override
  String get weightRequired => 'Weight is required';

  @override
  String get invalidWeight => 'Please enter a valid weight';

  @override
  String get bmi => 'BMI';

  @override
  String get autoCalculateBMI => 'Your BMI will be calculated automatically';

  @override
  String get saveSettings => 'Save Settings';

  @override
  String get saving => 'Saving...';

  @override
  String get saveSuccess => 'Saved successfully';

  @override
  String get saveFailed => 'Failed to save';

  @override
  String get loadFailed => 'Failed to load data';

  @override
  String get completeRequiredFieldsAndGender =>
      'Please complete all required fields and select a gender';

  @override
  String get errorPrefix => 'Error';

  @override
  String get addCaffeineLog => 'Add Caffeine Log';

  @override
  String get caffeineDescription =>
      'Record your caffeine intake for personalized recommendations';

  @override
  String get caffeineAmount => 'Caffeine Amount (mg)';

  @override
  String get caffeineExample => 'e.g. 150';

  @override
  String get drinkName => 'Drink Name';

  @override
  String get drinkExample => 'e.g. Latte';

  @override
  String get takingTime => 'Intake Time';

  @override
  String get saveCaffeineLog => 'Save Caffeine Log';

  @override
  String get invalidCaffeine => 'Caffeine must be a positive number';

  @override
  String errorOccurred(String error) {
    return 'An error occurred: $error';
  }

  @override
  String get defaultDrink => 'Coffee';

  @override
  String get addActualSleepTime => 'Add Actual Sleep Time';

  @override
  String get actualSleepTimeDescription =>
      'Please enter the actual time you fell asleep and the time you woke up to record your full sleep cycle.';

  @override
  String get sleepStartTimePick => 'Sleep start time (tap to select)';

  @override
  String get sleepEndTimePick => 'Sleep end time (tap to select)';

  @override
  String get sleepStartExample => 'Example: 2025-11-05 23:00';

  @override
  String get sleepEndExample => 'Example: 2025-11-06 07:00';

  @override
  String get saveSleepCycle => 'Save Sleep Cycle';

  @override
  String get sleepPleaseSelectStartAndEndTime =>
      'Please select the sleep start and end times.';

  @override
  String get sleepEndCannotBeEarlierThanStart =>
      'The end time cannot be earlier than the start time. Please check the date and time.';

  @override
  String get sleepTooLongOver48Hours =>
      'Sleep duration is too long (over 48 hours). Please confirm.';

  @override
  String get sleepInvalidTimeFormat =>
      'Invalid time format. Please select again.';

  @override
  String sleepSaveFailedWithReason(int statusCode, String responseBody) {
    return 'Failed to save sleep record: $statusCode\nResponse: $responseBody';
  }

  @override
  String sleepSaveSuccessWithDuration(int hours, int minutes) {
    return 'Sleep record saved successfully!\n😴 Total duration: $hours hour(s) $minutes minute(s)';
  }

  @override
  String get sleepDurationCalculationFailed =>
      'Data format error. Unable to calculate or save the duration.';

  @override
  String get noResponseContent => 'No response content';

  @override
  String get wakePageTitle => 'Set Target Wake Period';

  @override
  String get wakeDescription =>
      'Enter the time periods you want to stay alert.';

  @override
  String get wakeFillAllTimeSlots => 'Please fill all time slots.';

  @override
  String get wakeEndBeforeStart =>
      'End time cannot be earlier than start time.';

  @override
  String get wakeInvalidTimeFormat => 'Invalid time format';

  @override
  String wakeSingleSlotFailed(Object index, Object status) {
    return 'Slot $index failed (status: $status)';
  }

  @override
  String wakeSaveAllSuccess(Object count) {
    return 'Saved $count slots successfully';
  }

  @override
  String wakePartialSuccess(Object fail, Object success) {
    return '$success success, $fail failed';
  }

  @override
  String get wakeAllFailed => 'All submissions failed';

  @override
  String wakeSlotTitle(Object index) {
    return 'Wake Slot #$index';
  }

  @override
  String get startTime => 'Start Time';

  @override
  String get endTime => 'End Time';

  @override
  String get addTimeSlot => 'Add Slot';

  @override
  String get saveWakeTime => 'Save Wake Period';

  @override
  String get timeExampleStart => 'e.g. 05:00';

  @override
  String get timeExampleEnd => 'e.g. 06:00';

  @override
  String userInputHistoryTitle(String date) {
    return '$date Input History';
  }

  @override
  String get loadingUserInputData => 'Loading input data for this day...';

  @override
  String userInputLoadError(String error) {
    return 'An error occurred while loading input history:\n$error';
  }

  @override
  String get returnHomeAndAddRecord =>
      'Please return to the home page, tap the \"Add Record\" button, and select the corresponding period to record.';

  @override
  String get noUserInputOnThisDay => 'There is no input record for this day.';

  @override
  String get yourInputHistory => 'Your Input History';

  @override
  String get actualSleepCycle => 'Actual Sleep Cycle';

  @override
  String get noActualSleepRecord => 'No actual sleep record';

  @override
  String get targetWakePeriod => 'Target Wake Period';

  @override
  String get noTargetWakePeriodRecord => 'No target wake period record';

  @override
  String get noCaffeineIntakeRecord => 'No caffeine intake record';

  @override
  String get totalDuration => 'Total Duration';

  @override
  String durationHoursMinutes(int hours, int minutes) {
    return '$hours hr $minutes min';
  }

  @override
  String get intakeTime => 'Intake Time';

  @override
  String get contentLabel => 'Content';

  @override
  String get unknownDrink => 'Unknown Drink';

  @override
  String get notAvailable => 'N/A';

  @override
  String drinkWithAmount(String name, String amount) {
    return '$name ($amount mg)';
  }

  @override
  String caffeineHistoryTitle(Object date) {
    return '$date Recommendation';
  }

  @override
  String caffeineSuggestionIndex(Object index) {
    return 'Suggestion #$index';
  }

  @override
  String get activeStatus => 'Active';

  @override
  String get expiredStatus => 'Expired';

  @override
  String get recommendedTime => 'Recommended Time';

  @override
  String get recommendedAmount => 'Recommended Amount';

  @override
  String get updatedTime => 'Updated At';

  @override
  String noCaffeineHistory(Object date) {
    return 'No recommendation for $date';
  }

  @override
  String get clickToGenerate => 'Tap below to generate caffeine recommendation';

  @override
  String get recalculate => 'Recalculate';

  @override
  String get formatError => 'Format Error';

  @override
  String amountMg(Object amount) {
    return '$amount mg';
  }

  @override
  String get caffeineRecommendationPageTitle => 'Caffeine Recommendation';

  @override
  String get recommendationDataFormatError => 'Invalid recommendation format';

  @override
  String recommendationParseFailed(Object error, Object raw) {
    return 'Failed to parse recommendation: $error\nRaw: $raw';
  }

  @override
  String get recommendationUpdatedButNotificationFailed =>
      'Recommendation updated but notification scheduling failed';

  @override
  String get noNewRecommendationData => 'No new recommendation available';

  @override
  String get noNewRecommendationDataMessage =>
      'No new recommendation available.';

  @override
  String calculationFailedWithStatus(Object status) {
    return 'Calculation failed: $status';
  }

  @override
  String serverErrorWithPreview(Object status, Object preview) {
    return 'Server error (Status: $status)\nResponse preview: $preview';
  }

  @override
  String get timeoutCheckNetwork =>
      'Request timeout. Please check your connection.';

  @override
  String get connectionTimedOut => 'Connection timed out. Please try again.';

  @override
  String get networkConnectionError =>
      'Network error. Please check your connection.';

  @override
  String get cannotConnectToServer => 'Unable to connect to server.';

  @override
  String unknownError(Object error) {
    return 'Unknown error: $error';
  }

  @override
  String get wakemateRecommendationGenerated => 'WAKEMATE Recommendation Ready';

  @override
  String recommendationGeneratedBody(Object time, Object amount) {
    return 'Take $amount mg caffeine at $time';
  }

  @override
  String get wakemateCaffeineReminder => 'WAKEMATE Reminder';

  @override
  String caffeineReminderBody(Object time, Object amount) {
    return 'Take $amount mg caffeine at $time';
  }

  @override
  String get analyzingCaffeineData => 'Analyzing caffeine data...';

  @override
  String get thisMayTakeSomeTimePleaseWait =>
      'This may take a moment, please wait';

  @override
  String get oopsCalculationFailed => 'Oops! Calculation failed';

  @override
  String get retry => 'Retry';

  @override
  String get backToHomePage => 'Back to Home';
}
