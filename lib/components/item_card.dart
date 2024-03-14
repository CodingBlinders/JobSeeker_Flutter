import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemCard extends StatefulWidget {
  bool isBookmarked = false;
  ItemCard({super.key});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    

    void bookmarked() {
      setState(() {
        widget.isBookmarked = !widget.isBookmarked;
      });
    }

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/send-cv'),
      child: Card(
        elevation: 4.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        clipBehavior: Clip.none,
        child: Container(
          width: 280,
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 10,
            bottom: 5,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                    icon: widget.isBookmarked
                        ? const Icon(Icons.bookmark)
                        : const Icon(Icons.bookmark_outline),
                    onPressed: bookmarked,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
