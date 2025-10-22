import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/locale_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale;

    return DropdownButton<String>(
      value: currentLocale.languageCode,
      items: const [
        DropdownMenuItem(
          value: 'en',
          child: Text('English'),
        ),
        DropdownMenuItem(
          value: 'my',
          child: Text('မြန်မာ'),
        ),
      ],
      onChanged: (String? languageCode) {
        if (languageCode != null) {
          localeProvider.setLocale(Locale(languageCode));
        }
      },
    );
  }
}