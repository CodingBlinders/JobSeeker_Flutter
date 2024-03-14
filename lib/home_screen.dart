import 'package:flutter/material.dart';
import 'package:jobseeker_madhack/components/filter_chip.dart';
import 'package:jobseeker_madhack/components/item_card.dart';
import 'package:jobseeker_madhack/components/scroll_cards.dart';
import 'package:jobseeker_madhack/components/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> widgetCards = [
    ItemCard(),
    ItemCard(),
    ItemCard(),
    ItemCard(),
  ];

  List<String> categories = [
    'All',
    'Design & Development',
    'Web Developement',
    'DataScience',
    'Technical lead',
    'Buisness analyst'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.rotate_right_sharp),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(25),
              child: CustomSearchBar(),
            ),
            const SizedBox(
              height: 40,
            ),
            ScrollCardWidget(
              childrenList: widgetCards,
            ),
            ScrollCardWidget(
              childrenList: categories
                  .map(
                    (title) => FilterChipWidget(title: title),
                  )
                  .toList(),
            ),
            Expanded(
              child: ScrollCardWidget(
                childrenList: widgetCards,
                dir: Axis.vertical,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
