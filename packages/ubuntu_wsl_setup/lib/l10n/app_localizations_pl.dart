


import 'app_localizations.dart';

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Ubuntu WSL';

  @override
  String get windowTitle => 'Ubuntu WSL';

  @override
  String get exitButton => 'Wyjdź';

  @override
  String get finishButton => 'Zakończ';

  @override
  String get saveButton => 'Zapisz';

  @override
  String get setupButton => 'Konfiguracja';

  @override
  String get selectLanguageTitle => 'Wybierz swój język';

  @override
  String get profileSetupTitle => 'Konfiguracja profilu';

  @override
  String get profileSetupHeader => 'Utwórz domyślne konto użytkownika systemu UNIX. Aby uzyskać więcej informacji, odwiedź: <a href=\"https://aka.ms/wslusers\">https://aka.ms/wslusers</a>';

  @override
  String get profileSetupRealnameLabel => 'Twoje imię i nazwisko';

  @override
  String get profileSetupRealnameRequired => 'Wymagane jest podanie imienia i nazwiska';

  @override
  String get profileSetupUsernameHint => 'Wybierz nazwę użytkownika';

  @override
  String get profileSetupUsernameHelper => 'Nazwa użytkownika nie musi być zgodna z nazwą użytkownika systemu Windows.';

  @override
  String get profileSetupPasswordHint => 'Wybierz hasło';

  @override
  String get profileSetupConfirmPasswordHint => 'Potwierdź swoje hasło';

  @override
  String get profileSetupShowAdvancedOptions => 'Pokaż opcje zaawansowane na następnej stronie';

  @override
  String get profileSetupPasswordMismatch => 'Hasła nie są zgodne';

  @override
  String get profileSetupUsernameRequired => 'Wymagane jest podanie nazwy użytkownika';

  @override
  String get profileSetupUsernameInvalid => 'Nazwa użytkownika jest nieprawidłowa';

  @override
  String get profileSetupPasswordRequired => 'Wymagane jest podanie hasła';

  @override
  String get advancedSetupTitle => 'Konfiguracja zaawansowana';

  @override
  String get advancedSetupHeader => 'Na tej stronie możesz dostosować Ubuntu WSL do swoich potrzeb.';

  @override
  String get advancedSetupMountLocationHint => 'Położenie montowania';

  @override
  String get advancedSetupMountLocationHelper => 'Położenie automatycznego montowania';

  @override
  String get advancedSetupMountLocationInvalid => 'Położenie jest nieprawidłowe';

  @override
  String get advancedSetupMountOptionHint => 'Opcja montowania';

  @override
  String get advancedSetupMountOptionHelper => 'Opcja montowania przekazana automatycznemu montowaniu';

  @override
  String get advancedSetupHostGenerationTitle => 'Włącz generowanie pliku hosts';

  @override
  String get advancedSetupHostGenerationSubtitle => 'Wybór włącza ponowne generowanie /etc/hosts przy każdym uruchomieniu.';

  @override
  String get advancedSetupResolvConfGenerationTitle => 'Włącz generowanie pliku resolv.conf';

  @override
  String get advancedSetupResolvConfGenerationSubtitle => 'Wybór włącza ponowne generowanie /etc/resolv.conf przy każdym uruchomieniu.';

  @override
  String get advancedSetupGUIIntegrationTitle => 'Integracja interfejsu graficznego';

  @override
  String get advancedSetupGUIIntegrationSubtitle => 'Wybór włącza automatyczną konfigurację środowiska DISPLAY. Wymagany jest serwer X innego dostawcy.';

  @override
  String get configurationUITitle => 'Interfejs konfiguracji Ubuntu WSL (eksperymentalny)';

  @override
  String get configurationUIInteroperabilityHeader => 'Interoperacyjność';

  @override
  String get configurationUIInteroperabilityTitle => 'Enabled';

  @override
  String get configurationUIInteroperabilitySubtitle => 'Whether the Interoperability is enabled.';

  @override
  String get configurationUIInteropAppendWindowsPathTitle => 'Append Windows Path';

  @override
  String get configurationUIInteropAppendWindowsPathSubtitle => 'Whether Windows Path will be append in the PATH environment variable in WSL';

  @override
  String get configurationUIAutoMountHeader => 'Automatyczne montowanie';

  @override
  String get configurationUIAutoMountTitle => 'Włączone';

  @override
  String get configurationUIAutoMountSubtitle => 'Określa, czy funkcja automatycznego montowania jest włączona. Ta funkcja umożliwia montowanie napędu Windows w WSL.';

  @override
  String get configurationUIMountFstabTitle => 'Montuj /etc/fstab';

  @override
  String get configurationUIMountFstabSubtitle => 'Określa, czy plik /etc/fstab będzie montowany. Plik konfiguracyjny /etc/fstab zawiera ???';

  @override
  String get configurationUISystemdHeader => 'EXPERIMENTAL - Systemd';

  @override
  String get configurationUISystemdTitle => 'Enabled';

  @override
  String get configurationUISystemdSubtitle => 'Whether systemd should be activated at boot time. CAUTION: This is an experimental feature.';

  @override
  String get setupCompleteTitle => 'Konfiguracja zakończona';

  @override
  String setupCompleteHeader(Object user) {
    return 'Cześć, $user!\nPomyślnie zakończono konfigurację.';
  }

  @override
  String get setupCompleteUpdate => 'Sugerowane jest uruchomienie następującego polecenia, aby zaktualizować system Ubuntu do najnowszej wersji:';

  @override
  String get setupCompleteManage => 'Możesz użyć wbudowanego polecenia ubuntuwsl do zarządzania ustawieniami WSL:';

  @override
  String get setupCompleteRestart => '* Wszystkie ustawienia zaczną obowiązywać po ponownym uruchomieniu systemu Ubuntu.';
}
