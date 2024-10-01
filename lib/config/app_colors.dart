import 'package:educately_chat/config/app_sp_man.dart';
import 'package:flutter/material.dart';

/// This is an interface for all the colors used in the application.
/// You can use this interface to implement theme changes independantly
class AppColors {
  static const _text = Colors.black;
  static const _textDark = Colors.white;

  static const _msgBubbleMeLight = Color(0xffE1FFC7);
  static const _msgBubbleMeDark = Color(0xff8F47FE);
  static const _msgBubbleOtherLight = Color(0xffffffff);
  static const _msgBubbleOtherDark = Color(0xff31252B);

  static const _iconLight = Color(0xff808080);
  static const _iconDark = Color(0xff808080);

  static const _scaffold = Colors.white;
  static const _scaffoldDark = Colors.black;

  static const _subtext = Colors.black;
  static final _subtextDark = Colors.white.withOpacity(0.5);

  static const _appBar = Color(0xffC8C7CB);
  static final _appBarDark = Colors.black.withOpacity(0.2);

  static const _background = Color(0xffB2B2B2);
  static const _backgroundDark = Color(0xff3B3B43);

  static Brightness _brightness = Brightness.dark;

  static Color get text => isDarkMode ? _textDark : _text;

  static Color message(isSent) {
    if (isDarkMode) {
      return isSent ? _msgBubbleMeDark : _msgBubbleOtherDark;
    }
    return isSent ? _msgBubbleMeLight : _msgBubbleOtherLight;
  }

  static Color get icon => isDarkMode ? _iconDark : _iconLight;
  static Color get scaffold => isDarkMode ? _scaffoldDark : _scaffold;

  static Color get subtext => isDarkMode ? _subtextDark : _subtext;
  static Color get appBar => isDarkMode ? _appBarDark : _appBar;

  static Color get background => isDarkMode ? _backgroundDark : _background;

  static Brightness get brightness => _brightness;
  static set birghtness(Brightness bright) => _brightness = bright;

  static bool get isDarkMode => AppSpMan.isDarkMode.get() ?? true;
}
