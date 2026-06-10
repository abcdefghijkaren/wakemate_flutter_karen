// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get languageSetting => 'Bahasa';

  @override
  String get languageTraditionalChinese => 'Mandarin Tradisional';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageIndonesian => 'Bahasa Indonesia';

  @override
  String get languageSettingsTitle => 'Pengaturan Bahasa';

  @override
  String get selectYourLanguage => 'Pilih Bahasa Anda';

  @override
  String get caffeineIntake => 'Asupan Kafein';

  @override
  String get sleepDuration => 'Durasi Tidur';

  @override
  String get addRecord => 'Tambah Catatan';

  @override
  String get caffeineIntakeToday => 'Asupan Kafein Hari Ini';

  @override
  String get sleepDurationToday => 'Durasi Tidur Hari Ini';

  @override
  String get unitMg => ' mg';

  @override
  String get unitHours => ' jam';

  @override
  String get wakeTime => 'Periode Target Tetap Terjaga';

  @override
  String get sleepTime => 'Periode Tidur Aktual';

  @override
  String get caffeineLog => 'Catatan Kafein';

  @override
  String get inputHistory => 'Riwayat Input';

  @override
  String get calculateRecommendation => 'Hitung Rekomendasi';

  @override
  String get recommendationHistory => 'Riwayat Rekomendasi';

  @override
  String get alertnessTestTitle => 'Tes Kewaspadaan';

  @override
  String get tapToStart => 'Ketika warna berubah, segera ketuk layar.';

  @override
  String get pleaseWait => 'Silakan tunggu...';

  @override
  String get pleaseTap => 'Ketuk sekarang!';

  @override
  String get tapTooSoon => '❌ Terlalu cepat! Coba lagi';

  @override
  String get testResult => 'Hasil Tes';

  @override
  String get reactionTimesLabel => 'Waktu reaksi:';

  @override
  String reactionTimeTrial(int trial, int milliseconds) {
    return 'Percobaan $trial: $milliseconds ms';
  }

  @override
  String averageReactionTime(String avg) {
    return 'Rata-rata waktu reaksi: $avg ms';
  }

  @override
  String get selectKssLevel => 'Pilih tingkat kewaspadaan Anda:';

  @override
  String get chooseKssScore => 'Pilih tingkat kewaspadaan Anda';

  @override
  String get testAgain => 'Tes Lagi';

  @override
  String get finishAndClose => 'Selesai dan Tutup';

  @override
  String get dataSentSuccess => 'Data berhasil dikirim!';

  @override
  String submitFailed(int statusCode) {
    return 'Gagal mengirim. Kode status: $statusCode';
  }

  @override
  String get networkErrorCannotSubmit =>
      'Kesalahan jaringan, tidak dapat mengirim data';

  @override
  String get startTest => 'Mulai Tes';

  @override
  String get kssLevel1 => 'Sangat waspada';

  @override
  String get kssLevel2 => 'Sangat terjaga';

  @override
  String get kssLevel3 => 'Terjaga';

  @override
  String get kssLevel4 => 'Cukup terjaga';

  @override
  String get kssLevel5 => 'Tidak terjaga maupun mengantuk';

  @override
  String get kssLevel6 => 'Mulai muncul tanda-tanda kantuk';

  @override
  String get kssLevel7 =>
      'Mengantuk, tetapi tidak perlu usaha untuk tetap terjaga';

  @override
  String get kssLevel8 => 'Mengantuk, perlu sedikit usaha untuk tetap terjaga';

  @override
  String get kssLevel9 =>
      'Sangat mengantuk, perlu usaha besar untuk tetap terjaga, hampir tertidur';

  @override
  String get personalBodyData => 'Data Tubuh Pribadi';

  @override
  String get logout => 'Keluar';

  @override
  String get userDefaultName => 'Pengguna';

  @override
  String get enterEmailAndPassword =>
      'Silakan masukkan email dan kata sandi Anda';

  @override
  String get loginSuccess => 'Berhasil masuk!';

  @override
  String get loginSuccessButNoUserId =>
      'Berhasil masuk, tetapi gagal mendapatkan ID pengguna';

  @override
  String get loginFailed => 'Gagal masuk: email atau kata sandi salah';

  @override
  String get unknownServerError =>
      'Terjadi kesalahan server yang tidak diketahui';

  @override
  String loginFailedWithReason(String errorMsg) {
    return 'Gagal masuk: $errorMsg';
  }

  @override
  String get loginFailedInvalidResponse =>
      'Gagal masuk: respons server tidak valid';

  @override
  String get networkErrorCannotConnectServer =>
      'Kesalahan: tidak dapat terhubung ke server';

  @override
  String get welcomeBack => 'Selamat datang kembali';

  @override
  String get loginTitle => 'Masuk';

  @override
  String get loginDescription => 'Silakan masukkan email dan kata sandi Anda';

  @override
  String get email => 'Email';

  @override
  String get password => 'Kata Sandi';

  @override
  String get login => 'Masuk';

  @override
  String get noAccount => 'Belum punya akun?';

  @override
  String get registerNow => 'Daftar';

  @override
  String get registerAccount => 'Daftar Akun';

  @override
  String get createAccount => 'Buat Akun';

  @override
  String get register => 'Daftar';

  @override
  String get registerSuccess => 'Pendaftaran berhasil! Silakan masuk';

  @override
  String get emailExists => 'Email ini sudah terdaftar';

  @override
  String get registerFailed => 'Pendaftaran gagal';

  @override
  String get name => 'Nama';

  @override
  String get fillAllFields => 'Harap isi semua kolom';

  @override
  String get invalidEmail => 'Format email tidak valid';

  @override
  String get gender => 'Jenis Kelamin';

  @override
  String get male => 'Laki-laki';

  @override
  String get female => 'Perempuan';

  @override
  String get age => 'Usia';

  @override
  String get enterAge => 'Silakan masukkan usia Anda';

  @override
  String get ageRequired => 'Usia wajib diisi';

  @override
  String get invalidAge => 'Silakan masukkan usia yang valid';

  @override
  String get heightCm => 'Tinggi (cm)';

  @override
  String get enterHeight => 'Silakan masukkan tinggi Anda';

  @override
  String get heightRequired => 'Tinggi wajib diisi';

  @override
  String get invalidHeight => 'Silakan masukkan tinggi yang valid';

  @override
  String get weightKg => 'Berat (kg)';

  @override
  String get enterWeight => 'Silakan masukkan berat Anda';

  @override
  String get weightRequired => 'Berat wajib diisi';

  @override
  String get invalidWeight => 'Silakan masukkan berat yang valid';

  @override
  String get bmi => 'BMI';

  @override
  String get autoCalculateBMI => 'BMI Anda akan dihitung secara otomatis';

  @override
  String get saveSettings => 'Simpan Pengaturan';

  @override
  String get saving => 'Menyimpan...';

  @override
  String get saveSuccess => 'Berhasil disimpan';

  @override
  String get saveFailed => 'Gagal menyimpan';

  @override
  String get loadFailed => 'Gagal memuat data';

  @override
  String get completeRequiredFieldsAndGender =>
      'Silakan lengkapi semua kolom wajib dan pilih jenis kelamin';

  @override
  String get errorPrefix => 'Kesalahan';

  @override
  String get addCaffeineLog => 'Tambah Catatan Kafein';

  @override
  String get caffeineDescription =>
      'Catat konsumsi kafein untuk rekomendasi yang dipersonalisasi';

  @override
  String get caffeineAmount => 'Jumlah Kafein (mg)';

  @override
  String get caffeineExample => 'contoh: 150';

  @override
  String get drinkName => 'Nama Minuman';

  @override
  String get drinkExample => 'contoh: Latte';

  @override
  String get takingTime => 'Waktu Konsumsi';

  @override
  String get saveCaffeineLog => 'Simpan Catatan Kafein';

  @override
  String get invalidCaffeine => 'Jumlah kafein harus angka positif';

  @override
  String errorOccurred(String error) {
    return 'Terjadi kesalahan: $error';
  }

  @override
  String get defaultDrink => 'Kopi';

  @override
  String get addActualSleepTime => 'Tambahkan Waktu Tidur Sebenarnya';

  @override
  String get actualSleepTimeDescription =>
      'Silakan masukkan waktu sebenarnya saat Anda mulai tidur dan bangun untuk mencatat seluruh siklus tidur Anda.';

  @override
  String get sleepStartTimePick => 'Waktu mulai tidur (ketuk untuk memilih)';

  @override
  String get sleepEndTimePick => 'Waktu selesai tidur (ketuk untuk memilih)';

  @override
  String get sleepStartExample => 'Contoh: 2025-11-05 23:00';

  @override
  String get sleepEndExample => 'Contoh: 2025-11-06 07:00';

  @override
  String get saveSleepCycle => 'Simpan Siklus Tidur';

  @override
  String get sleepPleaseSelectStartAndEndTime =>
      'Silakan pilih waktu mulai dan selesai tidur.';

  @override
  String get sleepEndCannotBeEarlierThanStart =>
      'Waktu selesai tidak boleh lebih awal dari waktu mulai. Silakan periksa tanggal dan waktunya.';

  @override
  String get sleepTooLongOver48Hours =>
      'Durasi tidur terlalu lama (lebih dari 48 jam). Mohon periksa kembali.';

  @override
  String get sleepInvalidTimeFormat =>
      'Format waktu tidak valid. Silakan pilih lagi.';

  @override
  String sleepSaveFailedWithReason(int statusCode, String responseBody) {
    return 'Gagal menyimpan catatan tidur: $statusCode\nRespons: $responseBody';
  }

  @override
  String sleepSaveSuccessWithDuration(int hours, int minutes) {
    return 'Catatan tidur berhasil disimpan!\n😴 Total durasi: $hours jam $minutes menit';
  }

  @override
  String get sleepDurationCalculationFailed =>
      'Format data salah, durasi tidak dapat dihitung atau disimpan.';

  @override
  String get noResponseContent => 'Tidak ada isi respons';

  @override
  String get wakePageTitle => 'Atur Periode Target Tetap Terjaga';

  @override
  String get wakeDescription =>
      'Masukkan periode waktu Anda ingin tetap terjaga.';

  @override
  String get wakeFillAllTimeSlots => 'Harap isi semua waktu.';

  @override
  String get wakeEndBeforeStart => 'Waktu selesai tidak boleh lebih awal.';

  @override
  String get wakeInvalidTimeFormat => 'Format waktu tidak valid';

  @override
  String wakeSingleSlotFailed(Object index, Object status) {
    return 'Slot $index gagal (status: $status)';
  }

  @override
  String wakeSaveAllSuccess(Object count) {
    return 'Berhasil menyimpan $count slot';
  }

  @override
  String wakePartialSuccess(Object fail, Object success) {
    return '$success berhasil, $fail gagal';
  }

  @override
  String get wakeAllFailed => 'Semua gagal';

  @override
  String wakeSlotTitle(Object index) {
    return 'Periode Target Tetap Terjaga #$index';
  }

  @override
  String get startTime => 'Waktu Mulai';

  @override
  String get endTime => 'Waktu Selesai';

  @override
  String get addTimeSlot => 'Tambah Slot';

  @override
  String get saveWakeTime => 'Simpan Periode Target Tetap Terjaga';

  @override
  String get timeExampleStart => 'contoh: 05:00';

  @override
  String get timeExampleEnd => 'contoh: 06:00';

  @override
  String userInputHistoryTitle(String date) {
    return 'Riwayat Input $date';
  }

  @override
  String get loadingUserInputData => 'Sedang memuat data input hari ini...';

  @override
  String userInputLoadError(String error) {
    return 'Terjadi kesalahan saat memuat riwayat input:\n$error';
  }

  @override
  String get returnHomeAndAddRecord =>
      'Silakan kembali ke halaman utama, tekan tombol \"Tambah Catatan\", lalu pilih periode yang sesuai untuk dicatat.';

  @override
  String get noUserInputOnThisDay => 'Tidak ada catatan input pada hari ini.';

  @override
  String get yourInputHistory => 'Riwayat Input Anda';

  @override
  String get actualSleepCycle => 'Siklus Tidur Aktual';

  @override
  String get noActualSleepRecord => 'Tidak ada catatan tidur aktual';

  @override
  String get targetWakePeriod => 'Periode Target Tetap Terjaga';

  @override
  String get noTargetWakePeriodRecord =>
      'Belum ada catatan periode target tetap terjaga';

  @override
  String get noCaffeineIntakeRecord => 'Tidak ada catatan asupan kafein';

  @override
  String get totalDuration => 'Total Durasi';

  @override
  String durationHoursMinutes(int hours, int minutes) {
    return '$hours jam $minutes menit';
  }

  @override
  String get intakeTime => 'Waktu Konsumsi';

  @override
  String get contentLabel => 'Isi';

  @override
  String get unknownDrink => 'Minuman Tidak Diketahui';

  @override
  String get notAvailable => 'N/A';

  @override
  String drinkWithAmount(String name, String amount) {
    return '$name ($amount mg)';
  }

  @override
  String caffeineHistoryTitle(Object date) {
    return 'Rekomendasi $date';
  }

  @override
  String caffeineSuggestionIndex(Object index) {
    return 'Rekomendasi #$index';
  }

  @override
  String get activeStatus => 'Aktif';

  @override
  String get expiredStatus => 'Kedaluwarsa';

  @override
  String get recommendedTime => 'Waktu Rekomendasi';

  @override
  String get recommendedAmount => 'Jumlah Rekomendasi';

  @override
  String get updatedTime => 'Waktu Update';

  @override
  String noCaffeineHistory(Object date) {
    return 'Tidak ada rekomendasi untuk $date';
  }

  @override
  String get clickToGenerate =>
      'Tekan tombol di bawah untuk menghasilkan rekomendasi';

  @override
  String get recalculate => 'Hitung Ulang';

  @override
  String get formatError => 'Format salah';

  @override
  String amountMg(Object amount) {
    return '$amount mg';
  }

  @override
  String get caffeineRecommendationPageTitle => 'Rekomendasi Kafein';

  @override
  String get recommendationDataFormatError => 'Format rekomendasi tidak valid';

  @override
  String recommendationParseFailed(Object error, Object raw) {
    return 'Gagal parsing rekomendasi: $error\nData: $raw';
  }

  @override
  String get recommendationUpdatedButNotificationFailed =>
      'Beberapa notifikasi tidak dibuat karena waktu yang direkomendasikan sudah lewat. Rekomendasi tetap berlaku—silakan ikuti petunjuk di layar.';

  @override
  String get noNewRecommendationData => 'Tidak ada rekomendasi baru';

  @override
  String get noNewRecommendationDataMessage => 'Tidak ada rekomendasi baru.';

  @override
  String calculationFailedWithStatus(Object status) {
    return 'Perhitungan gagal: $status';
  }

  @override
  String serverErrorWithPreview(Object status, Object preview) {
    return 'Kesalahan server (Status: $status)\nPreview: $preview';
  }

  @override
  String get timeoutCheckNetwork => 'Permintaan timeout, periksa koneksi Anda';

  @override
  String get connectionTimedOut => 'Koneksi timeout, silakan coba lagi';

  @override
  String get networkConnectionError => 'Kesalahan jaringan';

  @override
  String get cannotConnectToServer => 'Tidak dapat terhubung ke server';

  @override
  String unknownError(Object error) {
    return 'Kesalahan tidak diketahui: $error';
  }

  @override
  String get wakemateRecommendationGenerated => 'Rekomendasi WAKEMATE siap';

  @override
  String recommendationGeneratedBody(Object time, Object amount) {
    return 'Konsumsi $amount mg kafein pada $time';
  }

  @override
  String get wakemateCaffeineReminder => 'Pengingat WAKEMATE';

  @override
  String caffeineReminderBody(Object time, Object amount) {
    return 'Konsumsi $amount mg kafein pada $time';
  }

  @override
  String get analyzingCaffeineData => 'Sedang menganalisis data kafein...';

  @override
  String get thisMayTakeSomeTimePleaseWait =>
      'Ini mungkin membutuhkan waktu, mohon tunggu';

  @override
  String get oopsCalculationFailed => 'Oops! Perhitungan gagal';

  @override
  String get retry => 'Coba lagi';

  @override
  String get backToHomePage => 'Kembali';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Hapus';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get deleteRecordTitle => 'Hapus catatan';

  @override
  String get deleteRecordMessage =>
      'Catatan ini akan dihapus. Apakah Anda ingin melanjutkan?';

  @override
  String get editSleepRecord => 'Edit catatan tidur';

  @override
  String get editWakePeriod => 'Edit Periode Target Tetap Terjaga';

  @override
  String get editCaffeineIntake => 'Edit asupan kafein';

  @override
  String get intakeTimeLabel => 'Waktu konsumsi';

  @override
  String get drinkNameLabel => 'Nama minuman';

  @override
  String get caffeineAmountLabel => 'Jumlah kafein (mg)';

  @override
  String get dateTimeHint => 'yyyy-MM-dd HH:mm';

  @override
  String get deletedSuccessfully => 'Berhasil dihapus';

  @override
  String get updatedSuccessfully => 'Berhasil diperbarui';

  @override
  String get deleteFailed => 'Gagal menghapus';

  @override
  String get updateFailed => 'Gagal memperbarui';

  @override
  String get invalidDateTimeFormat =>
      'Format waktu tidak valid. Gunakan yyyy-MM-dd HH:mm';

  @override
  String get invalidCaffeineAmount => 'Masukkan jumlah kafein yang valid';

  @override
  String get emptyDrinkName => 'Masukkan nama minuman';

  @override
  String get endTimeMustBeLater =>
      'Waktu selesai harus lebih lambat dari waktu mulai';

  @override
  String mergedFromRecords(int count) {
    return 'Digabung dari $count catatan';
  }

  @override
  String get singleRecordCount => '1 catatan';

  @override
  String get originalRecord => 'Catatan asli';

  @override
  String get pvtKssBaselineTestTitle => 'Silakan lakukan tes kewaspadaan awal';

  @override
  String pvtKssBaselineTestBody(String time) {
    return 'Anda dijadwalkan mengonsumsi kafein pada $time. Silakan lakukan satu tes kewaspadaan sebelum mengonsumsi.';
  }

  @override
  String get pvtKssEffectTestTitle =>
      'Silakan lakukan tes setelah konsumsi kafein';

  @override
  String pvtKssEffectTestBody(String time) {
    return 'Anda sekarang berada dalam periode efek kafein. Silakan lakukan satu tes kewaspadaan untuk mengevaluasi efeknya.';
  }

  @override
  String get avoidCaffeineBeforeSleepWarning =>
      'Untuk menjaga kualitas tidur Anda, hindari konsumsi kafein dalam 6 jam sebelum tidur.';
}
