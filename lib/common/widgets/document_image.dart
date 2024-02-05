import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/widgets/download_decrypt_image.dart';
import 'package:widget_zoom/widget_zoom.dart';

Widget documentImage(String? documentUrl, String? documentTag, double size) {
  return SizedBox(
    width: size,
    height: size,
    child: Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: documentUrl != null
              ? WidgetZoom(
                  heroAnimationTag: documentTag!,
                  zoomWidget: FutureBuilder<Widget>(
                    future: downloadAndDecryptImage(documentUrl, documentTag),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Display a loading indicator while the future is not complete
                        return const CircularProgressIndicator(
                          strokeWidth: 8,
                          color: backgroundColor,
                        );
                      } else if (snapshot.hasError) {
                        // Display an error message if the future encounters an error
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Display the result when the future is complete
                        return snapshot.data!;
                      }
                    },
                  ),
                )
              : const Icon(Icons.camera_alt_rounded)),
    ),
  );
}
