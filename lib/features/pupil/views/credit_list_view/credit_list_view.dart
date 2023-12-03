import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';

import 'package:schuldaten_hub/features/pupil/views/credit_list_view/controller/credit_list_controller.dart';
import 'package:schuldaten_hub/features/pupil/views/credit_list_view/widgets/credit_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/views/credit_list_view/widgets/credit_list_card.dart';
import 'package:schuldaten_hub/features/pupil/views/credit_list_view/widgets/credit_list_view_bottom_navbar.dart';
import 'package:watch_it/watch_it.dart';

class CreditListView extends WatchingWidget {
  final CreditListController controller;
  final int userCredit;
  final bool filtersOn;
  final List<Pupil> pupils;
  const CreditListView(
      this.controller, this.userCredit, this.filtersOn, this.pupils,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debug.info('Widget Build started!');

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.money),
            const Gap(10),
            Text('Guthaben: $userCredit'),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().getAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 15.0, right: 10.00),
                  child: Row(
                    children: [
                      const Text(
                        'Gesamt:',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        pupils.length.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(15),
                      const Text(
                        'BIP:',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        controller.totalGeneratedCredit(pupils).toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(15),
                      const Text(
                        'in Umlauf: ',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        controller.totalFluidCredit(pupils).toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: searchTextField(
                              'Schüler/in suchen',
                              controller,
                              locator<PupilFilterManager>()
                                  .refreshFilteredPupils)),
                      InkWell(
                        onTap: () => showCreditFilterBottomSheet(context),
                        onLongPress: () =>
                            locator<PupilFilterManager>().resetFilters(),
                        // onPressed: () => showBottomSheetFilters(context),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.filter_list,
                            color: filtersOn ? Colors.deepOrange : Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pupils.isEmpty
                    ? const Center(
                        child: Text('Keine Ergebnisse'),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: pupils.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CreditListCard(controller, pupils[index]);
                            })),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: creditListViewBottomNavBar(context, filtersOn),
    );
  }
}
