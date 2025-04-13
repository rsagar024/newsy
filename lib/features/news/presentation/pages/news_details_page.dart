import 'package:flutter/material.dart';
import 'package:newsy_app/core/utilities/date_formatter.dart';
import 'package:newsy_app/features/news/domain/entities/news_entity.dart';
import 'package:newsy_app/features/news/presentation/widgets/metadata_item_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsDetailsPage extends StatelessWidget {
  final NewsEntity newsEntity;

  const NewsDetailsPage({super.key, required this.newsEntity});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: const Text(
            'NEWSY',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Stack(
            children: [
              Container(
                height: 240,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(newsEntity.urlToImage ?? 'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ='),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListView(
                children: [
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.6,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(top: 220),
                    padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                newsEntity.title ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const Icon(Icons.bookmark_border, size: 30, color: Colors.red),
                          ],
                        ),
                        MetadataItemWidget(
                          label: 'Author',
                          value: newsEntity.author ?? '',
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        Text(
                          '${newsEntity.description ?? ''} ${newsEntity.content ?? ''}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                        MetadataItemWidget(label: 'Published By', value: newsEntity.source?.name ?? 'Not Found'),
                        MetadataItemWidget(
                          label: 'Published At',
                          value: DateFormatter().formatDate(newsEntity.publishedAt ?? DateTime.now().toString()),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        const Text(
                          'For more details check this link',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () => _launchUrl(newsEntity.url ?? ''),
                          child: Text(
                            newsEntity.url ?? '',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}
