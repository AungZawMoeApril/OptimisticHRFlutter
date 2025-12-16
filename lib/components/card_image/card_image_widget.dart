import 'package:flutter/material.dart';
import 'card_image_model.dart';

export 'card_image_model.dart';

/// Stub widget for CardImage
class CardImageWidget extends StatefulWidget {
  const CardImageWidget({super.key, this.image});

  final String? image;

  @override
  State<CardImageWidget> createState() => _CardImageWidgetState();
}

class _CardImageWidgetState extends State<CardImageWidget> {
  late CardImageModel _model;

  @override
  void initState() {
    super.initState();
    _model = CardImageModel();
    _model.initState(context);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
