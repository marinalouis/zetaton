import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton/core/util/app_integer.dart';
import 'package:zetaton/core/util/services/service_locator.dart';
import 'package:zetaton/modules/home/domain/entities/get_images.dart';
import 'package:zetaton/modules/search/presentation/controllers/search_provider.dart';
import 'package:zetaton/modules/home/data/models/get_images_model.dart';
import 'package:zetaton/routes/app_pages.dart';

class HomeViewSearch extends SearchDelegate<GetImagesModel?> {
  // final sessionToken;

  HomeViewSearch();

  @override
  String get searchFieldLabel => 'Search';
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        elevation: 2.0,
        // ignore: deprecated_member_use
        // brightness: colorScheme.brightness,
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
        toolbarTextStyle: theme.textTheme.bodyMedium,

        titleTextStyle: theme.textTheme.titleLarge,
      ),
      textSelectionTheme: const TextSelectionThemeData(),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  loadPhotosFunction(BuildContext context) {
    final SearchProvider searchProvider = Provider.of<SearchProvider>(context);

    return Padding(
      padding: defaultPaddingOfViews,
      child: FutureBuilder<GetImages?>(
          future:
              query == "" ? null : searchProvider.fetchWallpapers(query: query),
          builder: (context, snapshot) {
            if (query == "") {
              return Container();
            } else if (!snapshot.hasData ||
                snapshot.data == [] ||
                searchProvider.getImages?.urlImages == [] ||
                snapshot.data?.urlImages?.isEmpty == true) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ChangeNotifierProvider(
                create: (context) => SearchProvider(sl()),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: Provider.of<SearchProvider>(context, listen: false)
                      .getImages
                      ?.urlImages
                      ?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.DETAILS,
                            arguments:
                                searchProvider.getImages!.urlImages![index]);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) =>
                        //         PhotoDetailsPage(url: wallpaper.src.original),
                        //   ),
                        // );
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
                            searchProvider.getImages!.urlImages![index],
                            // Provider.of<SearchProvider>(context, listen: false)
                            //         .getImages
                            //         ?.urlImages?[index] ,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    final SearchProvider searchProvider = Provider.of<SearchProvider>(context);

    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          searchProvider.getImages?.urlImages?.clear();
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    final SearchProvider searchProvider = Provider.of<SearchProvider>(context);

    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        searchProvider.getImages?.urlImages?.clear();
        FocusScope.of(context).unfocus();

        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return loadPhotosFunction(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // return Container();
    return loadPhotosFunction(context);
  }
}
