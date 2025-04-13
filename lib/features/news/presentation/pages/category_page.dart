import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsy_app/features/news/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:newsy_app/features/news/presentation/widgets/circular_category_widget.dart';
import 'package:single_child_two_dimensional_scroll_view/single_child_two_dimensional_scroll_view.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late ScrollController verController;
  late ScrollController horController;

  @override
  void initState() {
    super.initState();
    verController = ScrollController();
    horController = ScrollController();
    bool firstCall = true;
    Timer? timer;

    timer = Timer(const Duration(microseconds: 5), () {
      if (firstCall) {
        firstCall = false;
        initial();
      } else {
        timer?.cancel();
      }
    });
  }

  void initial() {
    if (horController.hasClients) {
      horController.jumpTo(100);
      // horController.animateTo(100, duration: Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Choose your ',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'topics',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Color(0xFFB20909),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 640.45,
                  child: SingleChildTwoDimensionalScrollView(
                    verticalController: verController,
                    horizontalController: horController,
                    child: Container(
                      height: 640.45,
                      width: 630,
                      color: const Color(0xFF0F0C0C),
                      child: Stack(
                        children: context.read<CategoryBloc>().categoryItems.map((item) => CircularCategoryWidget(category: item)).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

/*Widget getCircularAvatar({required CategoryItem category}) {
    return Positioned(
      top: category.top,
      bottom: category.bottom,
      left: category.left,
      right: category.right,
      child: Container(
        height: category.radius,
        width: category.radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          image: DecorationImage(
            image: CachedNetworkImageProvider(category.image!),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          category.text,
          style: TextStyle(
            fontSize: category.textSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            shadows: const [
              Shadow(
                color: Color(0xFF0F0C0C),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}
