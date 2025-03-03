import 'package:flutter/material.dart';

void showFilterBottomSheet(
    BuildContext context, String initialFilter, Function(String) onConfirm) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) => CustomSortBottomSheet(
      initialFilter: initialFilter,
      onConfirm: onConfirm,
    ),
  );
}

class CustomSortBottomSheet extends StatefulWidget {
  final String initialFilter;
  final Function(String) onConfirm;

  const CustomSortBottomSheet({
    super.key,
    required this.initialFilter,
    required this.onConfirm,
  });

  @override
  _CustomSortBottomSheetState createState() =>
      _CustomSortBottomSheetState();
}

class _CustomSortBottomSheetState extends State<CustomSortBottomSheet> {
  String? selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF826754),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                "Pilih Filter",
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
            child: Column(
              children: [
                _buildRadioOption("Tenggat Pengerjaan Terdekat"),
                _buildRadioOption("Tenggat Pengerjaan Terjauh"),
                _buildRadioOption("Tanggal Unggah Terbaru"),
                _buildRadioOption("Tanggal Unggah Terlama"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Batal"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedFilter != null) {
                        widget.onConfirm(selectedFilter!);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF826754),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Terapkan"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String label) {
    return RadioListTile<String>(
      title: Text(label, style: const TextStyle(fontSize: 16)),
      value: label,
      groupValue: selectedFilter,
      onChanged: (value) {
        setState(() {
          selectedFilter = value;
        });
      },
      activeColor: const Color(0xFF826754),
    );
  }
}
