import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton/core/util/app_integer.dart';
import 'package:zetaton/core/util/app_strings.dart';
import 'package:zetaton/core/util/shared_component/custom_app_bar.dart';
import 'package:zetaton/modules/home/presentation/controllers/home_provider.dart';
import 'package:zetaton/modules/search/presentation/screens/search/search_view.dart';
import 'package:zetaton/modules/home/data/models/get_images_model.dart';
import 'package:zetaton/routes/app_pages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallpaperProvider = Provider.of<WallpaperProvider>(context);

    return Scaffold(
      appBar: customAppBar(AppStrings.homeTitle, context),
      body: Padding(
        padding: defaultPaddingOfViews,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20.0), // Adjust the radius as needed
                border: Border.all(
                    color: Colors.blue, width: 2.0), // Set the border color
                color: Colors.grey.shade100,
              ),
              child: Padding(
                padding: defaultPaddingOfViews,
                child: TextFormField(
                  onTap: () async {
                    // ignore: unused_local_variable
                    final GetImagesModel? result =
                        await showSearch<GetImagesModel?>(
                      context: context,
                      delegate: HomeViewSearch(),
                    );
                  },
                  textAlign: TextAlign.start,
                  // controller: searchController.textFieldController,
                  decoration: InputDecoration(
                    prefixIcon: Transform.scale(
                      scale: 1.2,
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.search_rounded,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    contentPadding:
                        const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 15.0,
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            wallpaperProvider.getImages?.urlImages != null &&
                    wallpaperProvider.getImages!.urlImages!
                        .isNotEmpty // Check if wallpapers have been fetched
                ? Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: wallpaperProvider.getImages!.urlImages!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.DETAILS,
                                arguments: wallpaperProvider.getImages!
                                    .urlImages![index] // MaterialPageRoute(

                                );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width / 2 -
                                15, // Adjust as needed
                            height: MediaQuery.of(context).size.width / 2 -
                                15, // Adjust as needed
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                wallpaperProvider.getImages!.urlImages![index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: FutureBuilder<void>(
                      future: wallpaperProvider.fetchWallpapers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          return Container(); // Show an empty container if wallpapers haven't been fetched yet
                        }
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
