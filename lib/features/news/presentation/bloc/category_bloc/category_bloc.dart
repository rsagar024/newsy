import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:newsy_app/features/news/presentation/items/category_item.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<CategoryItem> categoryItems = [
    CategoryItem(
      text: 'Business',
      textSize: 27,
      radius: 140,
      left: 160,
      top: 50,
      image:
      'https://images.pexels.com/photos/2422289/pexels-photo-2422289.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 0
    CategoryItem(
      text: 'Crime',
      textSize: 29,
      radius: 100,
      left: 190,
      bottom: 200,
      image:
      'https://images.pexels.com/photos/6069351/pexels-photo-6069351.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 1
    CategoryItem(
      text: 'Domestic',
      textSize: 26,
      radius: 130,
      right: 20,
      top: 10,
      image:
      'https://images.pexels.com/photos/4554387/pexels-photo-4554387.jpeg',
    ), // 2
    CategoryItem(
      text: 'Education',
      textSize: 24,
      radius: 130,
      right: 200,
      bottom: 110,
      image:
      'https://images.pexels.com/photos/1205651/pexels-photo-1205651.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 3
    CategoryItem(
      text: 'Entertainment',
      textSize: 20,
      radius: 140,
      left: 20,
      bottom: 210,
      image:
      'https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 4
    CategoryItem(
      text: 'Environment',
      textSize: 22,
      radius: 140,
      left: 140,
      bottom: 50,
      image:
      'https://images.pexels.com/photos/709552/pexels-photo-709552.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 5
    CategoryItem(
      text: 'Food',
      textSize: 27,
      radius: 90,
      right: 260,
      bottom: 20,
      image:
      'https://images.pexels.com/photos/842571/pexels-photo-842571.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 6
    CategoryItem(
      text: 'Health',
      textSize: 27,
      radius: 100,
      left: 290,
      top: 160,
      image:
      'https://images.pexels.com/photos/347134/pexels-photo-347134.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 7
    CategoryItem(
      text: 'Technology',
      textSize: 26,
      radius: 160,
      right: 50,
      top: 150,
      image:
      'https://images.pexels.com/photos/3861969/pexels-photo-3861969.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 8
    CategoryItem(
      text: 'Lifestyle',
      textSize: 28,
      radius: 140,
      right: 60,
      bottom: 40,
      image:
      'https://images.pexels.com/photos/1251862/pexels-photo-1251862.jpeg',
    ), // 9
    CategoryItem(
      text: 'Politics',
      textSize: 27,
      radius: 120,
      left: 20,
      top: 150,
      image:
      'https://images.pexels.com/photos/1464223/pexels-photo-1464223.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 10
    CategoryItem(
      text: 'Science',
      textSize: 18,
      radius: 90,
      left: 50,
      top: 30,
      image:
      'https://images.pexels.com/photos/3825527/pexels-photo-3825527.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 11
    CategoryItem(
      text: 'Sports',
      textSize: 29,
      radius: 120,
      right: 170,
      top: 30,
      image:
      'https://images.pexels.com/photos/2834917/pexels-photo-2834917.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 12
    CategoryItem(
      text: 'Other',
      textSize: 27,
      radius: 110,
      left: 160,
      top: 210,
      image:
      'https://images.pexels.com/photos/97050/pexels-photo-97050.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 13
    CategoryItem(
      text: 'Top',
      textSize: 30,
      radius: 100,
      left: 20,
      bottom: 90,
      image:
      'https://images.pexels.com/photos/980859/pexels-photo-980859.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 14
    CategoryItem(
      text: 'Tourism',
      textSize: 27,
      radius: 130,
      right: 60,
      bottom: 190,
      image:
      'https://images.pexels.com/photos/1004584/pexels-photo-1004584.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 15
    CategoryItem(
      text: 'World',
      textSize: 30,
      radius: 120,
      right: 200,
      bottom: 250,
      image:
      'https://images.pexels.com/photos/269724/pexels-photo-269724.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    ), // 16
  ];
  CategoryBloc() : super(CategoryState()) {
    on<CategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
