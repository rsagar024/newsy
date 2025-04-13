import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsy_app/core/di/di.dart';
import 'package:newsy_app/core/enums/app_enum/page_state_enum.dart';
import 'package:newsy_app/core/enums/category_enum.dart';
import 'package:newsy_app/core/resources/common/image_resources.dart';
import 'package:newsy_app/features/news/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:newsy_app/features/news/presentation/pages/news_details_page.dart';
import 'package:newsy_app/features/news/presentation/pages/search_page.dart';
import 'package:newsy_app/features/news/presentation/widgets/news_category_widget.dart';
import 'package:newsy_app/features/news/presentation/widgets/news_item_widget.dart';
import 'package:newsy_app/features/news/presentation/widgets/top_news_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeBloc = getIt<HomeBloc>();
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() => homeBloc.add(ScrolledEvent(_controller)));
    homeBloc.add(InitialHomeEvent());
    homeBloc.add(ToggleCategoryEvent(Category.values[0].description));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'NEWSY',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
                    },
                    child: SvgPicture.asset(
                      ImageResources.iconSearch,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Container(
                        height: 25,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Category.values.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => homeBloc.add(ToggleCategoryEvent(Category.values[index].description)),
                              child: NewsCategoryWidget(
                                title: Category.values[index].description,
                                selected: state.category == Category.values[index].description.toLowerCase(),
                              ),
                            );
                          },
                        ),
                      ),
                      if (state.pageState == PageState.loading)
                        const Expanded(child: Center(child: CircularProgressIndicator(color: Colors.white)))
                      else if (state.pageState == PageState.failure)
                        Expanded(
                          child: Center(
                            child: Text(
                              state.errorMessage ?? 'Error Occurs',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        )
                      else if (state.pageState == PageState.success)
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async => homeBloc.add(RefreshEvent()),
                            child: ListView(
                              controller: _controller,
                              children: [
                                if (state.news.isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailsPage(newsEntity: state.news.first)));
                                    },
                                    child: TopNewsCardWidget(newsEntity: state.news.first),
                                  ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Latest',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                                  ),
                                ),
                                if (state.news.isNotEmpty)
                                  Wrap(
                                    children: List.generate(
                                      state.loadMore ? state.news.length : state.news.length - 1,
                                      (index) {
                                        if (index + 1 < state.news.length) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailsPage(newsEntity: state.news[index + 1])));
                                            },
                                            child: NewsItemWidget(newsEntity: state.news[index + 1]),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )
                      else
                        const Center(child: CircularProgressIndicator(color: Colors.white)),
                    ],
                  ),
                ),
                // child: CategoryListScreen(),
              );
            },
          ),
        ],
      ),
    );
  }
}
