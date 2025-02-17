import 'package:flutter/material.dart';
import 'package:librecamera/src/utils/preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimerButton extends StatefulWidget {
  const TimerButton({Key? key}) : super(key: key);

  @override
  State<TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  List<Duration> durations = [
    const Duration(seconds: 1),
    const Duration(seconds: 2),
    const Duration(seconds: 3),
    const Duration(seconds: 5),
    const Duration(seconds: 10),
    const Duration(seconds: 15),
    const Duration(seconds: 30),
    const Duration(minutes: 1),
    const Duration(minutes: 2),
    const Duration(minutes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      menuMaxHeight: 384.0,
      icon: const Icon(Icons.av_timer),
      iconEnabledColor: Colors.blue,
      value: Duration(seconds: Preferences.getTimerDuration()),
      items: durations.map(
        (duration) {
          final name = duration.inSeconds < 60
              ? '${duration.inSeconds}s'
              : '${duration.inMinutes}m';

          return DropdownMenuItem(
            value: duration,
            onTap: () {
              setState(() {
                Preferences.setTimerDuration(duration.inSeconds);
              });
            },
            child: Text(
              name,
              style: const TextStyle(color: Colors.blue),
            ),
          );
        },
      ).toList()
        ..insert(
          0,
          DropdownMenuItem<Duration>(
            value: const Duration(),
            onTap: () {
              setState(() {
                Preferences.setTimerDuration(0);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                AppLocalizations.of(context)!.off,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ),
      onChanged: (_) {},
    );
  }
}
