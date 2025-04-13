import 'package:newsy_app/core/resources/common/image_resources.dart';

enum Category {
  business(0, 'Business', ImageResources.iconBusiness),
  crime(1, 'Crime', ImageResources.iconCrime),
  domestic(2, 'Domestic', ImageResources.iconDomestic),
  education(3, 'Education', ImageResources.iconEducation),
  entertainment(4, 'Entertainment', ImageResources.iconEntertainment),
  environment(5, 'Environment', ImageResources.iconEnvironment),
  food(6, 'Food', ImageResources.iconFood),
  health(7, 'Health', ImageResources.iconHealth),
  technology(8, 'Technology', ImageResources.iconTechnology),
  lifestyle(9, 'Lifestyle', ImageResources.iconLifestyle),
  politics(10, 'Politics', ImageResources.iconPolitics),
  science(11, 'Science', ImageResources.iconScience),
  sports(12, 'Sports', ImageResources.iconSports),
  other(13, 'Other', ImageResources.iconOther),
  top(14, 'Top', ImageResources.iconTop),
  tourism(15, 'Tourism', ImageResources.iconTourism),
  world(16, 'World', ImageResources.iconWorld);

  final int value;
  final String description;
  final String icon;

  const Category(this.value, this.description, this.icon);
}
