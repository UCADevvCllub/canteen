import 'package:flutter/material.dart';
import 'package:canteen/features/schedule/presentation/widgets/status_button.dart';

class StatusWidget extends StatefulWidget {
  final String statusText;
  final ValueChanged<String> onStatusChange;

  const StatusWidget({
    super.key,
    required this.statusText,
    required this.onStatusChange,
  });

  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  bool _isExpanded = false;

  void _updateStatus(String newStatus) {
    widget.onStatusChange(newStatus);
    setState(() => _isExpanded = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 60),
            padding: EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Image.asset('assets/icons/linesforschedule.png', width: 20, height: 20),
                ),
                SizedBox(width: 8),
                Text(
                  widget.statusText,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Column(
            children: [
              SizedBox(height: 16),
              StatusButton(text: "Break", color: Colors.orange, onPressed: () => _updateStatus("Break")),
              SizedBox(height: 16),
              StatusButton(text: "Closed", color: Colors.red, onPressed: () => _updateStatus("Closed")),
            ],
          ),
      ],
    );
  }
}
