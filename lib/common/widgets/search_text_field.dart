import 'package:flutter/material.dart';

TextField searchTextField(
  String hintText,
  controller,
  Function refreshFunction,
) {
  return TextField(
    focusNode: controller.focusNode,
    controller: controller.searchController,
    textInputAction: TextInputAction.search,
    onChanged: controller.onSearchEnter,
    decoration: InputDecoration(
      fillColor: const Color.fromARGB(255, 237, 237, 237),
      filled: true,
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      prefixIcon: controller.isSearchMode
          ? IconButton(
              // tooltip:
              //     L10n.of(context)!.cancel,
              icon: const Icon(
                Icons.close_outlined,
              ),
              onPressed: controller.cancelSearch,
              color: Colors.black45,
            )
          : IconButton(
              onPressed: () => refreshFunction,
              icon: const Icon(
                Icons.search_outlined,
                color: Colors.black45,
              ),
            ),
      suffixIcon: controller.isSearchMode
          ? controller.isSearching
              ? const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 12,
                  ),
                  child: SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 2,
                    ),
                  ),
                )
              : const SizedBox.shrink()
          : const SizedBox(
              width: 0,
            ),
    ),
    // decoration: InputDecoration(
    //     filled: true,
    //     fillColor: Colors.white,
    //     contentPadding: const EdgeInsets.only(
    //         left: 15.0,
    //         right: 10.0,
    //         top: 10.0,
    //         bottom: 10.0),
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(7),
    //   borderSide:
    //       BorderSide(color: backgroundColor),
    // // ),
    // labelText: 'Suche',
    // suffixIcon: Icon(Icons.search)),
  );
}