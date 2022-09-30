import 'package:flutter/material.dart';

class CarouselWidgetImage extends StatelessWidget {
  final String? imageUrl;
  const CarouselWidgetImage({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: 250,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              spreadRadius: 1,
              blurRadius: 15,
            )
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
