import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsy_app/features/news/presentation/bloc/search_bloc/search_bloc.dart';

class RecentSearchesSectionWidget extends StatelessWidget {
  final SearchState state;
  final Function(String) callback;

  const RecentSearchesSectionWidget({super.key, required this.state, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
              ),
              TextButton(
                onPressed: () => context.read<SearchBloc>().add(ClearRecentSearchesEvent()),
                child: const Text(
                  'Clear all',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: state.recentSearches
                .map((search) => GestureDetector(
                      onTap: () => callback(search),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(73, 79, 86, 0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                search,
                                maxLines: 2,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => context.read<SearchBloc>().add(RemoveRecentSearchEvent(search)),
                              child: const Icon(Icons.close, size: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
