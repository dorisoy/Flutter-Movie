import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SettingPageAction {
  action,
  adultCellTapped,
  adultValueUpadte,
  cleanCached,
  cachedSizeUpdate,
  profileEdit,
  userUpdate,
  openPhotoPicker,
  userPanelPhotoUrlUpdate,
  uploading,
}

class SettingPageActionCreator {
  static Action onAction() {
    return const Action(SettingPageAction.action);
  }

  static Action adultCellTapped() {
    return Action(SettingPageAction.adultCellTapped);
  }

  static Action adultValueUpadte(bool b) {
    return Action(SettingPageAction.adultValueUpadte, payload: b);
  }

  static Action cleanCached() {
    return Action(SettingPageAction.cleanCached);
  }

  static Action cacheSizeUpdate(double d) {
    return Action(SettingPageAction.cachedSizeUpdate, payload: d);
  }

  static Action profileEdit() {
    return Action(SettingPageAction.profileEdit);
  }

  static Action userUpadate(FirebaseUser user) {
    return Action(SettingPageAction.userUpdate, payload: user);
  }

  static Action openPhotoPicker() {
    return const Action(SettingPageAction.openPhotoPicker);
  }

  static Action userPanelPhotoUrlUpdate(String url) {
    return Action(SettingPageAction.userPanelPhotoUrlUpdate, payload: url);
  }

  static Action onUploading(bool isUploading) {
    return Action(SettingPageAction.uploading, payload: isUploading);
  }
}