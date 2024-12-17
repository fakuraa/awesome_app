import 'package:awesome_app/model/picture.dart';
import 'package:awesome_app/utils/widgets/colored_status_bar.dart';
import 'package:awesome_app/utils/widgets/image_load.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(this.data, {super.key});
  static const String route = "/detail";
  final Picture data;

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageLoad(
                    src: data.src?.original,
                    heroTag: 'image_${data.id}',
                    borderRadius: BorderRadius.circular(16),
                    fit: BoxFit.fitWidth,
                  ).marginAll(6),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "taken by",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color:
                                          Colors.black.withValues(alpha: 0.5)),
                            ),
                            RichText(
                              text: TextSpan(
                                text: data.photographer ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Colors.blueGrey.shade900,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _launchURL,
                              ),
                            ),
                            SizedBox(height: 6),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await Share.share(
                                "look the cool image I just found ${data.src?.large}");
                          },
                          icon: Icon(Icons.share))
                    ],
                  ).marginSymmetric(horizontal: 24),
                  SizedBox(height: 12),
                  Text(
                    data.alt ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                  ).marginSymmetric(horizontal: 24),
                ],
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: BackButton(color: Colors.white),
            )
          ],
        ),
      ).marginOnly(top: 0),
    );
  }

  Future<void> _launchURL() async {
    if (data.photographerUrl != null &&
        await canLaunchUrl(Uri.parse(data.photographerUrl!))) {
      await launchUrl(Uri.parse(data.photographerUrl!),
          mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch URL: ${data.photographerUrl}");
    }
  }
}
