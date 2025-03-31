import 'package:flutter/material.dart';
import 'status_button.dart';

class ExpandableStatusSelector extends StatefulWidget {
  final String currentStatus;
  final ValueChanged<String> onStatusChanged;

  const ExpandableStatusSelector({
    super.key,
    required this.currentStatus,
    required this.onStatusChanged,
  });

  @override
  State<ExpandableStatusSelector> createState() => _ExpandableStatusSelectorState();
}

class _ExpandableStatusSelectorState extends State<ExpandableStatusSelector> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 60),
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Image.asset(
                    'assets/icons/linesforschedule.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.currentStatus,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Column(
            children: [
              const SizedBox(height: 16),
              StatusButton(
                text: "Break",
                color: Colors.orange,
                onPressed: () {
                  widget.onStatusChanged("Break");
                  setState(() => _isExpanded = false);
                },
              ),
              const SizedBox(height: 16),
              StatusButton(
                text: "Closed",
                color: Colors.red,
                onPressed: () {
                  widget.onStatusChanged("Closed");
                  setState(() => _isExpanded = false);
                },
              ),
            ],
          ),
      ],
    );
  }
}