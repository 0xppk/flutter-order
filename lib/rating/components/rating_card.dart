import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:order/common/const/colors.dart';
import 'package:order/rating/model/rating_model.dart';

class RatingCard extends StatelessWidget {
  final ImageProvider avatarImage;
  final List<Image> images;
  final int rating;
  final String email;
  final String content;

  const RatingCard({
    super.key,
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
  });

  factory RatingCard.fromModel({
    required RatingModel model,
  }) {
    return RatingCard(
      avatarImage: NetworkImage(
        model.user.imageUrl,
      ),
      images: model.imgUrls.map((e) => Image.network(e)).toList(),
      rating: model.rating,
      email: model.user.username,
      content: model.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _Header(
            avatarImage: avatarImage,
            email: email,
            rating: rating,
          ),
          const SizedBox(
            height: 8,
          ),
          _Body(content: content),
          if (images.isNotEmpty)
            SizedBox(
              height: 100,
              child: _Images(images: images),
            ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final int rating;
  final String email;

  const _Header({
    required this.avatarImage,
    required this.rating,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: avatarImage,
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? Icons.star : Icons.star_border_outlined,
            color: PRIMARY_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Flexible(
            child: Text(
              content,
              style: const TextStyle(
                color: BODY_TEXT_COLOR,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;

  const _Images({
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images
          .mapIndexed(
            (i, e) => Padding(
              padding: EdgeInsets.only(
                right: i == images.length - 1 ? 0 : 16,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: e,
              ),
            ),
          )
          .toList(),
    );
  }
}
