import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton/core/util/app_integer.dart';
import 'package:zetaton/core/util/shared_component/custom_app_bar.dart';
import 'package:zetaton/modules/details/photo_details_provider.dart';

class PhotoDetailsPage extends StatelessWidget {
  final String url;

  const PhotoDetailsPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final detailsProvider = Provider.of<PhotoDetailsProvider>(context);

    return Scaffold(
      appBar: customAppBar('Wallpaper Details', context),
      body: Padding(
        padding: defaultPaddingOfViews,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width, // Adjust as needed
                height: MediaQuery.of(context).size.width / 2 -
                    15, // Adjust as needed
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        String imageUrl = url;
                        print(url);
                        detailsProvider.downloadAndSaveImage(imageUrl);
                      },
                      child: const Row(
                        children: [Icon(Icons.download), Text('Download')],
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Provider.of<PhotoDetailsProvider>(context,
                                listen: false)
                            .addFavoriteWallpaper(url);
                        log(Provider.of<PhotoDetailsProvider>(context,
                                listen: false)
                            .favoriteWallpapers
                            .toString());
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.favorite),
                          Text('Add to favorites')
                        ],
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
