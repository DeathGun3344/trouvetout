import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  List<String> listImage =  [
    'https://img.freepik.com/free-photo/assorted-work-tools-wood-background_93675-130092.jpg',
    'https://img.freepik.com/free-photo/laptop-shopping-bags-online-shopping-concept_1423-189.jpg',
    'https://img.freepik.com/free-vector/isometric-e-commerce-concept_52683-39811.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 300,
          viewportFraction: 1.0,
          autoPlay: true,
          enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: listImage.map((e) => CachedNetworkImage(imageUrl: e, fit: BoxFit.cover,)).toList(),
    );
  }
}
