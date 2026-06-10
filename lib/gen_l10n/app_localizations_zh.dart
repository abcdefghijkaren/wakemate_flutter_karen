// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get languageSetting => 'Language';

  @override
  String get languageTraditionalChinese => 'Traditional Chinese';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageIndonesian => 'Bahasa Indonesia';

  @override
  String get languageSettingsTitle => '语言设定';

  @override
  String get selectYourLanguage => '选择您的偏好语言';

  @override
  String get caffeineIntake => '咖啡因摄取量';

  @override
  String get sleepDuration => '睡眠时数';

  @override
  String get addRecord => '新增纪录';

  @override
  String get caffeineIntakeToday => '今日咖啡因摄取量';

  @override
  String get sleepDurationToday => '今日睡眠时数';

  @override
  String get unitMg => ' 毫克';

  @override
  String get unitHours => ' 小时';

  @override
  String get wakeTime => '清醒时段';

  @override
  String get sleepTime => '睡眠时段';

  @override
  String get caffeineLog => '咖啡因纪录';

  @override
  String get inputHistory => '输入历史';

  @override
  String get calculateRecommendation => '计算推荐';

  @override
  String get recommendationHistory => '推荐结果';

  @override
  String get alertnessTestTitle => 'Alertness Test';

  @override
  String get tapToStart => 'When the color changes, tap immediately.';

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
  String get selectKssLevel => 'Select your alertness level:';

  @override
  String get chooseKssScore => 'Select alertness level';

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
  String get wakePageTitle => 'Set Target Alertness Period';

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
    return 'Target Alertness Period #$index';
  }

  @override
  String get startTime => 'Start Time';

  @override
  String get endTime => 'End Time';

  @override
  String get addTimeSlot => 'Add Slot';

  @override
  String get saveWakeTime => 'Save Target Alertness Period';

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
  String get targetWakePeriod => 'Target Alertness Period';

  @override
  String get noTargetWakePeriodRecord => 'No target alertness period recorded';

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
      'Some notifications were not scheduled because the recommended time has passed. Your recommendation is still valid—please follow the on-screen guidance.';

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

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get deleteRecordTitle => 'Delete record';

  @override
  String get deleteRecordMessage =>
      'This record will be deleted. Do you want to continue?';

  @override
  String get editSleepRecord => 'Edit sleep record';

  @override
  String get editWakePeriod => 'Edit Target Alertness Period';

  @override
  String get editCaffeineIntake => 'Edit caffeine intake';

  @override
  String get intakeTimeLabel => 'Intake time';

  @override
  String get drinkNameLabel => 'Drink name';

  @override
  String get caffeineAmountLabel => 'Caffeine amount (mg)';

  @override
  String get dateTimeHint => 'yyyy-MM-dd HH:mm';

  @override
  String get deletedSuccessfully => 'Deleted successfully';

  @override
  String get updatedSuccessfully => 'Updated successfully';

  @override
  String get deleteFailed => 'Delete failed';

  @override
  String get updateFailed => 'Update failed';

  @override
  String get invalidDateTimeFormat =>
      'Invalid datetime format. Use yyyy-MM-dd HH:mm';

  @override
  String get invalidCaffeineAmount => 'Please enter a valid caffeine amount';

  @override
  String get emptyDrinkName => 'Please enter a drink name';

  @override
  String get endTimeMustBeLater => 'End time must be later than start time';

  @override
  String mergedFromRecords(int count) {
    return 'Merged from $count records';
  }

  @override
  String get singleRecordCount => '1 record';

  @override
  String get originalRecord => 'Original record';

  @override
  String get pvtKssBaselineTestTitle =>
      'Please complete a baseline alertness test';

  @override
  String pvtKssBaselineTestBody(String time) {
    return 'You are scheduled to take caffeine at $time. Please complete one alertness test before intake.';
  }

  @override
  String get pvtKssEffectTestTitle => 'Please complete the post-caffeine test';

  @override
  String pvtKssEffectTestBody(String time) {
    return 'You are now within the caffeine effect window. Please complete one alertness test to evaluate the effect.';
  }

  @override
  String get avoidCaffeineBeforeSleepWarning =>
      'To protect your sleep quality, please avoid caffeine within 6 hours before sleep.';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get languageSetting => '語言';

  @override
  String get languageTraditionalChinese => '繁體中文';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageIndonesian => 'Bahasa Indonesia';

  @override
  String get languageSettingsTitle => '語言設定';

  @override
  String get selectYourLanguage => '選擇您的偏好語言';

  @override
  String get caffeineIntake => '咖啡因攝取';

  @override
  String get sleepDuration => '睡眠時數';

  @override
  String get addRecord => '新增紀錄';

  @override
  String get caffeineIntakeToday => '今日咖啡因攝取量';

  @override
  String get sleepDurationToday => '今日睡眠時數';

  @override
  String get unitMg => ' 毫克';

  @override
  String get unitHours => ' 小時';

  @override
  String get wakeTime => '目標專注時段';

  @override
  String get sleepTime => '實際睡眠時段';

  @override
  String get caffeineLog => '咖啡因紀錄';

  @override
  String get inputHistory => '輸入歷史';

  @override
  String get calculateRecommendation => '計算推薦';

  @override
  String get recommendationHistory => '推薦結果';

  @override
  String get alertnessTestTitle => '清醒度測試';

  @override
  String get tapToStart => '當色塊變色時，請立即點擊';

  @override
  String get pleaseWait => '請等待...';

  @override
  String get pleaseTap => '請點擊！';

  @override
  String get tapTooSoon => '❌ 點太快了！重來';

  @override
  String get testResult => '測試結果';

  @override
  String get reactionTimesLabel => '每次反應時間：';

  @override
  String reactionTimeTrial(int trial, int milliseconds) {
    return '第$trial次：$milliseconds 毫秒';
  }

  @override
  String averageReactionTime(String avg) {
    return '平均反應時間：$avg 毫秒';
  }

  @override
  String get selectKssLevel => '選擇您覺得的清醒程度:';

  @override
  String get chooseKssScore => '選擇清醒程度';

  @override
  String get testAgain => '再測一次';

  @override
  String get finishAndClose => '完成並關閉';

  @override
  String get dataSentSuccess => '數據已成功送出！';

  @override
  String submitFailed(int statusCode) {
    return '送出失敗，狀態碼：$statusCode';
  }

  @override
  String get networkErrorCannotSubmit => '網路錯誤，無法送出數據';

  @override
  String get startTest => '開始測試';

  @override
  String get kssLevel1 => '極度清醒';

  @override
  String get kssLevel2 => '非常清醒';

  @override
  String get kssLevel3 => '清醒';

  @override
  String get kssLevel4 => '比較清醒';

  @override
  String get kssLevel5 => '不太清醒但也無睏意';

  @override
  String get kssLevel6 => '有一些睏意傾向';

  @override
  String get kssLevel7 => '有睏意，但是不需要努力保持清醒';

  @override
  String get kssLevel8 => '有睏意，且需要一定的努力保持清醒';

  @override
  String get kssLevel9 => '非常睏倦，需要極大的努力保持清醒，幾乎入睡';

  @override
  String get personalBodyData => '個人身體數據';

  @override
  String get logout => '登出';

  @override
  String get userDefaultName => '用戶';

  @override
  String get enterEmailAndPassword => '請輸入 Email 與密碼';

  @override
  String get loginSuccess => '登入成功！';

  @override
  String get loginSuccessButNoUserId => '登入成功，但無法取得使用者 ID';

  @override
  String get loginFailed => '登入失敗：Email 或密碼不正確';

  @override
  String get unknownServerError => '伺服器發生未知錯誤';

  @override
  String loginFailedWithReason(String errorMsg) {
    return '登入失敗：$errorMsg';
  }

  @override
  String get loginFailedInvalidResponse => '登入失敗：伺服器回傳了無效的回應';

  @override
  String get networkErrorCannotConnectServer => '錯誤：無法連線到伺服器';

  @override
  String get welcomeBack => '歡迎回來';

  @override
  String get loginTitle => '帳號登入';

  @override
  String get loginDescription => '請輸入您的 Email 與密碼';

  @override
  String get email => 'Email';

  @override
  String get password => '密碼';

  @override
  String get login => '登入';

  @override
  String get noAccount => '還沒有帳號？';

  @override
  String get registerNow => '點此註冊';

  @override
  String get registerAccount => '註冊新帳號';

  @override
  String get createAccount => '創建新帳號';

  @override
  String get register => '註冊';

  @override
  String get registerSuccess => '註冊成功！請登入';

  @override
  String get emailExists => '此 Email 已被註冊';

  @override
  String get registerFailed => '註冊失敗';

  @override
  String get name => '名稱';

  @override
  String get fillAllFields => '請填寫所有欄位';

  @override
  String get invalidEmail => 'Email 格式不正確';

  @override
  String get gender => '性別';

  @override
  String get male => '男';

  @override
  String get female => '女';

  @override
  String get age => '年齡';

  @override
  String get enterAge => '請輸入您的年齡';

  @override
  String get ageRequired => '年齡為必填項';

  @override
  String get invalidAge => '請輸入有效的年齡';

  @override
  String get heightCm => '身高 (cm)';

  @override
  String get enterHeight => '請輸入您的身高';

  @override
  String get heightRequired => '身高為必填項';

  @override
  String get invalidHeight => '請輸入有效身高';

  @override
  String get weightKg => '體重 (kg)';

  @override
  String get enterWeight => '請輸入您的體重';

  @override
  String get weightRequired => '體重為必填項';

  @override
  String get invalidWeight => '請輸入有效體重';

  @override
  String get bmi => 'BMI';

  @override
  String get autoCalculateBMI => '將自動計算您的 BMI';

  @override
  String get saveSettings => '保存設定';

  @override
  String get saving => '保存中...';

  @override
  String get saveSuccess => '儲存成功';

  @override
  String get saveFailed => '儲存失敗';

  @override
  String get loadFailed => '讀取資料失敗';

  @override
  String get completeRequiredFieldsAndGender => '請完整填寫所有必填資料並選擇性別';

  @override
  String get errorPrefix => '錯誤';

  @override
  String get addCaffeineLog => '新增咖啡因紀錄';

  @override
  String get caffeineDescription => '記錄您的咖啡因攝取，以提供個人化建議';

  @override
  String get caffeineAmount => '咖啡因含量 (毫克)';

  @override
  String get caffeineExample => '例如：150';

  @override
  String get drinkName => '飲料名稱';

  @override
  String get drinkExample => '例如：拿鐵';

  @override
  String get takingTime => '飲用時間';

  @override
  String get saveCaffeineLog => '儲存咖啡因紀錄';

  @override
  String get invalidCaffeine => '咖啡因含量必須為正整數';

  @override
  String errorOccurred(String error) {
    return '發生錯誤：$error';
  }

  @override
  String get defaultDrink => '咖啡';

  @override
  String get addActualSleepTime => '新增實際睡眠時間';

  @override
  String get actualSleepTimeDescription => '請輸入您實際開始睡覺的時間與結束睡眠的時間，以記錄完整的睡眠週期。';

  @override
  String get sleepStartTimePick => '開始睡覺時間（點擊選擇）';

  @override
  String get sleepEndTimePick => '結束睡眠時間（點擊選擇）';

  @override
  String get sleepStartExample => '例如：2025-11-05 23:00';

  @override
  String get sleepEndExample => '例如：2025-11-06 07:00';

  @override
  String get saveSleepCycle => '儲存睡眠週期';

  @override
  String get sleepPleaseSelectStartAndEndTime => '請選擇睡眠的開始時間與結束時間。';

  @override
  String get sleepEndCannotBeEarlierThanStart => '結束時間不能早於開始時間，請檢查日期和時間。';

  @override
  String get sleepTooLongOver48Hours => '睡眠時間過長（超過48小時），請確認。';

  @override
  String get sleepInvalidTimeFormat => '時間格式錯誤，請重新選擇。';

  @override
  String sleepSaveFailedWithReason(int statusCode, String responseBody) {
    return '睡眠紀錄儲存失敗：$statusCode\n回應：$responseBody';
  }

  @override
  String sleepSaveSuccessWithDuration(int hours, int minutes) {
    return '睡眠紀錄儲存成功！\n😴 總時長：$hours小時 $minutes分鐘';
  }

  @override
  String get sleepDurationCalculationFailed => '資料格式錯誤，無法計算或儲存時長。';

  @override
  String get noResponseContent => '無回應內容';

  @override
  String get wakePageTitle => '設定目標專注時段';

  @override
  String get wakeDescription => '請輸入您希望保持清醒或專注的特定時段。';

  @override
  String get wakeFillAllTimeSlots => '請填寫所有時段的開始與結束時間。';

  @override
  String get wakeEndBeforeStart => '結束時間早於開始時間，請修正。';

  @override
  String get wakeInvalidTimeFormat => '時間格式錯誤';

  @override
  String wakeSingleSlotFailed(Object index, Object status) {
    return '第 $index 個時段提交失敗 (狀態碼: $status)';
  }

  @override
  String wakeSaveAllSuccess(Object count) {
    return '成功儲存 $count 個時段';
  }

  @override
  String wakePartialSuccess(Object fail, Object success) {
    return '成功 $success 個，失敗 $fail 個';
  }

  @override
  String get wakeAllFailed => '全部提交失敗';

  @override
  String wakeSlotTitle(Object index) {
    return '目標專注時段 #$index';
  }

  @override
  String get startTime => '開始時間';

  @override
  String get endTime => '結束時間';

  @override
  String get addTimeSlot => '新增時段';

  @override
  String get saveWakeTime => '儲存目標專注時段';

  @override
  String get timeExampleStart => '例如：05:00';

  @override
  String get timeExampleEnd => '例如：06:00';

  @override
  String userInputHistoryTitle(String date) {
    return '$date 輸入歷史';
  }

  @override
  String get loadingUserInputData => '正在載入該日輸入數據...';

  @override
  String userInputLoadError(String error) {
    return '載入輸入歷史時發生錯誤：\n$error';
  }

  @override
  String get returnHomeAndAddRecord => '請返回首頁，點擊「新增紀錄」按鈕，選擇對應時段進行記錄。';

  @override
  String get noUserInputOnThisDay => '該日無任何輸入記錄。';

  @override
  String get yourInputHistory => '您的輸入歷史';

  @override
  String get actualSleepCycle => '實際睡眠週期';

  @override
  String get noActualSleepRecord => '無實際睡眠記錄';

  @override
  String get targetWakePeriod => '目標專注時段';

  @override
  String get noTargetWakePeriodRecord => '無目標專注時段記錄';

  @override
  String get noCaffeineIntakeRecord => '無咖啡因攝取記錄';

  @override
  String get totalDuration => '總時長';

  @override
  String durationHoursMinutes(int hours, int minutes) {
    return '$hours小時 $minutes分鐘';
  }

  @override
  String get intakeTime => '飲用時間';

  @override
  String get contentLabel => '內容';

  @override
  String get unknownDrink => '未知飲料';

  @override
  String get notAvailable => 'N/A';

  @override
  String drinkWithAmount(String name, String amount) {
    return '$name ($amount 毫克)';
  }

  @override
  String caffeineHistoryTitle(Object date) {
    return '$date 建議結果';
  }

  @override
  String caffeineSuggestionIndex(Object index) {
    return '咖啡因建議 #$index';
  }

  @override
  String get activeStatus => '目前有效';

  @override
  String get expiredStatus => '已過期';

  @override
  String get recommendedTime => '建議攝取時間';

  @override
  String get recommendedAmount => '建議攝取量';

  @override
  String get updatedTime => '更新時間';

  @override
  String noCaffeineHistory(Object date) {
    return '$date 無建議紀錄';
  }

  @override
  String get clickToGenerate => '點擊下方按鈕可計算此日期的咖啡因建議。';

  @override
  String get recalculate => '重新計算並生成最新建議';

  @override
  String get formatError => '格式錯誤';

  @override
  String amountMg(Object amount) {
    return '$amount 毫克';
  }

  @override
  String get caffeineRecommendationPageTitle => '咖啡因建議';

  @override
  String get recommendationDataFormatError => '推薦資料格式錯誤';

  @override
  String recommendationParseFailed(Object error, Object raw) {
    return '推薦資料解析失敗：$error\n原始內容：$raw';
  }

  @override
  String get recommendationUpdatedButNotificationFailed =>
      '部分通知未建立，因為建議攝取時間已經過了。不影響本次推薦結果，請直接依畫面上的建議執行。';

  @override
  String get noNewRecommendationData => '目前沒有新的推薦資料';

  @override
  String get noNewRecommendationDataMessage => '目前沒有新的推薦資料。';

  @override
  String calculationFailedWithStatus(Object status) {
    return '計算失敗：$status';
  }

  @override
  String serverErrorWithPreview(Object status, Object preview) {
    return '伺服器錯誤 (Status: $status)\n回應內容預覽: $preview';
  }

  @override
  String get timeoutCheckNetwork => '錯誤：請求逾時，請檢查您的網路連線。';

  @override
  String get connectionTimedOut => '連線逾時。請檢查網路後重試。';

  @override
  String get networkConnectionError => '網路連線錯誤，請檢查您的網路。';

  @override
  String get cannotConnectToServer => '無法連線到伺服器。請檢查網路。';

  @override
  String unknownError(Object error) {
    return '發生未知錯誤：$error';
  }

  @override
  String get wakemateRecommendationGenerated => 'WAKEMATE 推薦已產生';

  @override
  String recommendationGeneratedBody(Object time, Object amount) {
    return '請於 $time 攝取 $amount mg 咖啡因';
  }

  @override
  String get wakemateCaffeineReminder => 'WAKEMATE 咖啡因提醒';

  @override
  String caffeineReminderBody(Object time, Object amount) {
    return '請於 $time 攝取 $amount mg 咖啡因';
  }

  @override
  String get analyzingCaffeineData => '正在為您分析咖啡因數據...';

  @override
  String get thisMayTakeSomeTimePleaseWait => '這可能需要一點時間，請耐心等候';

  @override
  String get oopsCalculationFailed => '哎呀！計算失敗了...';

  @override
  String get retry => '重新嘗試';

  @override
  String get backToHomePage => '返回主頁';

  @override
  String get edit => '編輯';

  @override
  String get delete => '刪除';

  @override
  String get cancel => '取消';

  @override
  String get save => '儲存';

  @override
  String get deleteRecordTitle => '刪除紀錄';

  @override
  String get deleteRecordMessage => '此筆紀錄將被刪除，確定要繼續嗎？';

  @override
  String get editSleepRecord => '編輯睡眠紀錄';

  @override
  String get editWakePeriod => '編輯目標專注時段';

  @override
  String get editCaffeineIntake => '編輯咖啡因攝取紀錄';

  @override
  String get intakeTimeLabel => '攝取時間';

  @override
  String get drinkNameLabel => '飲料名稱';

  @override
  String get caffeineAmountLabel => '咖啡因含量（毫克）';

  @override
  String get dateTimeHint => 'yyyy-MM-dd HH:mm';

  @override
  String get deletedSuccessfully => '刪除成功';

  @override
  String get updatedSuccessfully => '更新成功';

  @override
  String get deleteFailed => '刪除失敗';

  @override
  String get updateFailed => '更新失敗';

  @override
  String get invalidDateTimeFormat => '時間格式錯誤，請使用 yyyy-MM-dd HH:mm';

  @override
  String get invalidCaffeineAmount => '請輸入有效的咖啡因含量';

  @override
  String get emptyDrinkName => '請輸入飲料名稱';

  @override
  String get endTimeMustBeLater => '結束時間必須晚於開始時間';

  @override
  String mergedFromRecords(int count) {
    return '由 $count 筆紀錄合併';
  }

  @override
  String get singleRecordCount => '1 筆紀錄';

  @override
  String get originalRecord => '原始紀錄';

  @override
  String get pvtKssBaselineTestTitle => '請先完成清醒度測驗';

  @override
  String pvtKssBaselineTestBody(String time) {
    return '您即將於 $time 攝取咖啡因，請先在攝取前完成一次清醒度測驗。';
  }

  @override
  String get pvtKssEffectTestTitle => '請完成咖啡因後測';

  @override
  String pvtKssEffectTestBody(String time) {
    return '您已接近咖啡因作用期間，請於現在完成一次清醒度測驗，以評估效果。';
  }

  @override
  String get avoidCaffeineBeforeSleepWarning => '為保障您的睡眠品質，睡前 6 小時請避免攝取咖啡因。';
}
