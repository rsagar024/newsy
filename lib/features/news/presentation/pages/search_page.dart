import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsy_app/core/di/di.dart';
import 'package:newsy_app/core/enums/app_enum/page_state_enum.dart';
import 'package:newsy_app/core/resources/common/image_resources.dart';
import 'package:newsy_app/features/news/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:newsy_app/features/news/presentation/pages/news_details_page.dart';
import 'package:newsy_app/features/news/presentation/widgets/empty_state_widget.dart';
import 'package:newsy_app/features/news/presentation/widgets/news_item_widget.dart';
import 'package:newsy_app/features/news/presentation/widgets/no_results_widget.dart';
import 'package:newsy_app/features/news/presentation/widgets/recent_searches_section_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchBloc = getIt<SearchBloc>();
  late ScrollController _controller;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _searchFocusNode = FocusNode();
    _controller.addListener(() => searchBloc.add(ScrolledEvent(_controller)));
    searchBloc.initializeController();
    searchBloc.add(InitialSearchEvent());
    searchBloc.add(LoadRecentSearchesEvent());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }

  @override
  void dispose() {
    searchBloc.disposeController();
    _controller.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    searchBloc.searchController!.text = query;
    searchBloc.add(NewsSearchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          centerTitle: true,
          title: const Text(
            'Search',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: searchBloc.searchController,
                    focusNode: _searchFocusNode,
                    autofocus: true,
                    cursorColor: const Color(0xFFB20909),
                    maxLines: 1,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        _performSearch(query);
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      fillColor: const Color.fromRGBO(73, 79, 86, 0.4),
                      filled: true,
                      hintText: 'Search for news...',
                      hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                      ),
                      suffixIcon: searchBloc.searchController!.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey, size: 20),
                              onPressed: () {
                                searchBloc.add(InitialSearchEvent());
                                searchBloc.add(LoadRecentSearchesEvent());
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                ImageResources.iconSearch,
                                height: 20,
                                colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                              ),
                            ),
                    ),
                    onChanged: (value) {
                      searchBloc.add(NewsSearchEvent());
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (state.pageState != PageState.loading && state.pageState != PageState.success && state.recentSearches.isNotEmpty) RecentSearchesSectionWidget(state: state, callback: _performSearch),
                if (state.pageState == PageState.loading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(color: Color(0xFFB20909), strokeWidth: 2),
                    ),
                  ),
                if (state.pageState == PageState.failure)
                  Expanded(
                    child: Center(
                      child: Text(
                        state.errorMessage ?? 'An error occurred',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ),
                if (state.pageState == PageState.success)
                  state.news.isNotEmpty
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: RefreshIndicator(
                              color: const Color(0xFFB20909),
                              onRefresh: () async {
                                searchBloc.add(RefreshEvent());
                              },
                              child: ListView.builder(
                                controller: _controller,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 8, bottom: 16),
                                itemCount: state.loadMore ? state.news.length + 1 : state.news.length,
                                itemBuilder: (context, index) {
                                  if (index < state.news.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewsDetailsPage(
                                              newsEntity: state.news[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: NewsItemWidget(newsEntity: state.news[index]),
                                      ),
                                    );
                                  } else {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(
                                        child: CircularProgressIndicator(color: Color(0xFFB20909), strokeWidth: 2),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                      : const NoResultsWidget(),
                if (state.pageState == PageState.initial && state.recentSearches.isEmpty) const EmptyStateWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
