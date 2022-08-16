import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/app/extensions/extension_build_context.dart';

import '../../../app/components/my_text.dart';
import '../../../app/const.dart';
import '../../../app/di.dart';
import '../../../main.dart';

class SettingBottomSheet extends StatelessWidget {
  const SettingBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.back();
        Scaffold.of(context).showBottomSheet(
          (context) => Container(
            color: ColorManager.secColor,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.back();
                    },
                    icon:
                        const Icon(Icons.close, size: 30, color: Colors.white),
                  ),
                ],
              ),
              ListTile(
                title: const MyText(text: 'Dark Theme'),
                trailing: Switch(
                  value: isDark ?? false,
                  onChanged: (value) {
                    isDark = value;
                    di<GetStorage>().write('isDark', value);
                    Phoenix.rebirth(context);
                    context.back();
                  },
                ),
              ),
            ]),
          ),
        );
      },
      icon: const Icon(
        Icons.settings,
        size: 30,
      ),
    );
  }
}
