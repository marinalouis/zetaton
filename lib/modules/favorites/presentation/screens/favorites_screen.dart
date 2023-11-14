import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton/core/util/app_integer.dart';
import 'package:zetaton/core/util/shared_component/custom_app_bar.dart';
import 'package:zetaton/modules/favorites/presentation/controllers/favorites_provider.dart';

import 'package:zetaton/routes/app_pages.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return SafeArea(
        child: Scaffold(
      appBar: customAppBar('Favorites', context),
      body: Padding(
        padding: defaultPaddingOfViews,
        child: Column(children: [
          Expanded(
            child: FutureBuilder<List<String>>(
              future: favoritesProvider.getFavoriteWallpapers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loader while waiting for the data
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  // Show an error message if an error occurred
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  // Display the grid view once the data is available
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final wallpaper = snapshot.data?[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.DETAILS,
                              arguments: wallpaper);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width / 2 - 15,
                          height: MediaQuery.of(context).size.width / 2 - 15,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              wallpaper ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ]),
      ),
    ));
  }
}
