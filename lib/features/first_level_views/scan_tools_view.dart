import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/scanner.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/features/pupil/services/pupilbase_manager.dart';
import 'package:watch_it/watch_it.dart';

class QrToolsView extends WatchingWidget {
  const QrToolsView({super.key});
  importFileWithWindows(String function) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      String rawTextResult = await file.readAsString();
      if (function == 'schild') {
        locator.get<PupilBaseManager>().importPupilsFromTxt(rawTextResult);
      } else if (function == 'pupilbase') {
        locator.get<PupilBaseManager>().addNewPupilBase(rawTextResult);
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text('Scan-Tools'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Spacer(),
                Platform.isWindows
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[800],
                            minimumSize: const Size.fromHeight(90)),
                        onPressed: () => importFileWithWindows('schild'),
                        child: const Text(
                          'Daten aus SchiLD-Export importieren',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      )
                    : const SizedBox.shrink(),
                Platform.isWindows ? const Gap(20) : const SizedBox.shrink(),
                Platform.isWindows
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[800],
                            minimumSize: const Size.fromHeight(90)),
                        onPressed: () => importFileWithWindows('pupilbase'),
                        child: const Text(
                          'ID-Liste importieren',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ))
                    : Container(
                        height: 90,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: FloatingActionButton.extended(
                          heroTag: 'tag',
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          backgroundColor: accentColor,
                          foregroundColor: Colors.white,
                          onPressed: () async {
                            final String? scanResult = await scanner(context);
                            if (scanResult != null) {
                              locator
                                  .get<PupilBaseManager>()
                                  .addNewPupilBase(scanResult);
                            } else {
                              if (context.mounted) {
                                snackbarWarning(
                                    context, 'Scanvorgang abgebrochen');
                              }
                              return;
                            }
                          },
                          label: const Text(
                            'Kinder-IDs',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          icon: const Icon(Icons.note_add),
                        ),
                      ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
