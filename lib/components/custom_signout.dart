import 'package:flutter/material.dart';

class CustomSignOut extends StatefulWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomSignOut({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  _CustomSignOutState createState() => _CustomSignOutState();
}

class _CustomSignOutState extends State<CustomSignOut> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF826754),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isProcessing ? null : widget.onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(widget.cancelText),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isProcessing
                        ? null
                        : () async {
                            setState(() {
                              _isProcessing = true;
                            });

                            await Future.delayed(Duration(milliseconds: 200));

                            widget.onConfirm();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isProcessing
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(widget.confirmText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
