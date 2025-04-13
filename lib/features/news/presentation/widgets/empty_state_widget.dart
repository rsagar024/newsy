import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsy_app/core/resources/common/image_resources.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageResources.iconSearch,
              height: 80,
              colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.5), BlendMode.srcIn),
            ),
            const SizedBox(height: 24),
            const Text(
              'Search for news articles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Enter keywords to find news articles. Your recent searches will appear here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
