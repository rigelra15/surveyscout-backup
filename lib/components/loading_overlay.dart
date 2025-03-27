import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingOverlay extends StatefulWidget {
  final String message;
  final bool showLongLoadingMessage;

  const LoadingOverlay({
    super.key,
    this.message = "Sedang memproses...",
    this.showLongLoadingMessage = false,
  });

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 60,
                ),
                const SizedBox(height: 20),
                Text(
                  widget.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.showLongLoadingMessage) ...[
                  const SizedBox(height: 12),
                  const Text(
                    "Ini mungkin memakan waktu sedikit lebih lama dari biasanya...",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
