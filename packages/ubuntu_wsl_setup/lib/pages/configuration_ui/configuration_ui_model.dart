import 'package:flutter/foundation.dart';
import 'package:subiquity_client/subiquity_client.dart';
import 'package:ubuntu_wizard/utils.dart';

/// Implements the business logic of the WSL Configuration UI page.
///
/// See also:
///  * [ConfigurationUIPage]
class ConfigurationUIModel extends ChangeNotifier {
  /// Creates a advanced setup model.
  ConfigurationUIModel(this._client) {
    _conf.addListener(notifyListeners);
  }

  final SubiquityClient _client;
  final _conf = ValueNotifier(const WSLConfigurationAdvanced());

  /// Whether the Windows Path will be appended in the PATH environment in WSL.
  bool get interopAppendwindowspath =>
      _conf.value.interopAppendwindowspath ?? true;
  set interopAppendwindowspath(bool value) {
    _conf.value = _conf.value.copyWith(interopAppendwindowspath: value);
  }

  /// Whether the interoperability is enabled.
  bool get interopEnabled => _conf.value.interopEnabled ?? true;
  set interopEnabled(bool value) {
    _conf.value = _conf.value.copyWith(interopEnabled: value);
  }

  /// Whether automountEnabled is enabled.
  bool get automountEnabled => _conf.value.automountEnabled ?? true;
  set automountEnabled(bool value) {
    _conf.value = _conf.value.copyWith(automountEnabled: value);
  }

  /// Whether `/etc/fstab` will be mounted.
  bool get automountMountfstab => _conf.value.automountMountfstab ?? true;
  set automountMountfstab(bool value) {
    _conf.value = _conf.value.copyWith(automountMountfstab: value);
  }

  /// Whether systemd experimental support is enabled.
  bool get systemdEnabled => _conf.value.systemdEnabled ?? false;
  set systemdEnabled(bool value) {
    _conf.value = _conf.value.copyWith(systemdEnabled: value);
  }

  /// Whether the current input is valid.
  bool get isValid => true;

  /// Loads the UI configuration.
  Future<void> loadConfiguration() async {
    return _client
        .wslConfigurationAdvanced()
        .then((conf) => _conf.value = conf);
  }

  /// Saves the UI configuration.
  Future<void> saveConfiguration() async {
    return _client
        .setWslConfigurationAdvanced(_conf.value)
        .then((_) => closeWindow());
  }
}
