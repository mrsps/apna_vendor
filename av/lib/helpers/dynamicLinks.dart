import 'package:av/dao/userStore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLink with ChangeNotifier {
  // Identify if app opened using any of the deepLinks
  Future<void> dynamicLinks(String leaderId) async {
    String? vendorId;
    FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;
      if (deepLink != null) {
        // Linking vendor to leader
        vendorId = deepLink.queryParameters['vendorId'];
        if (vendorId != null) await UserStore().addVendor(vendorId!, leaderId);
      }
    }, onError: (OnLinkErrorException? e) async {
      throw (e!.message!);
    });

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      // Linking vendor to leader
      vendorId = deepLink.queryParameters['vendorId'];
      if (vendorId != null) await UserStore().addVendor(vendorId!, leaderId);
    }
  }

  // Create a dynamic link to share to add a vendor
  Future<void> createDynamicLink(String vendorId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://apnavendor.page.link/',
      link: Uri.parse('https://apnavendor-21d75.web.app/?' + Uri(queryParameters: {'vendorId': vendorId}).query),
      androidParameters: AndroidParameters(
        packageName: 'com.udaan.apnavendor',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    Share.share(
      'Click to add a vendor\n' + shortLink.shortUrl.toString(),
      subject: 'Adding a vendor',
    );
  }

  // Sharing leader catalogue with all linked vendors
  void shareLeaderCatalogue(String leaderId) {
    String link = 'https://apnavendor-21d75.web.app/?' + Uri(queryParameters: {'leaderId': leaderId}).query;
    Share.share(
      'Click to create an order\n' + link,
      subject: 'Order from leader catalogue',
    );
  }

  // Sharing leader catalogue with a specific vendor
  void shareVendorCatalogue(String leaderId, String vendorId) {
    String link = 'https://apnavendor-21d75.web.app/?' +
        Uri(queryParameters: {'leaderId': leaderId}).query +
        '&' +
        Uri(queryParameters: {'vendorId': vendorId}).query;
    Share.share(
      'Click to create an order\n' + link,
      subject: 'Order from vendor catalogue',
    );
  }
}
