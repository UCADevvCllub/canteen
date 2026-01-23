import 'package:flutter/material.dart';

/// Виджет редактора баланса с кнопками + и -
class BalanceEditor extends StatefulWidget {
  final double initialBalance;
  final Function(double) onBalanceChanged;
  final bool isUpdating;

  const BalanceEditor({
    Key? key,
    required this.initialBalance,
    required this.onBalanceChanged,
    this.isUpdating = false,
  }) : super(key: key);

  @override
  State<BalanceEditor> createState() => _BalanceEditorState();
}

class _BalanceEditorState extends State<BalanceEditor> {
  late TextEditingController _balanceController;
  late double _currentBalance;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _currentBalance = widget.initialBalance;
    _balanceController = TextEditingController(
      text: _currentBalance.toStringAsFixed(0),
    );
  }

  @override
  void didUpdateWidget(BalanceEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialBalance != widget.initialBalance) {
      _currentBalance = widget.initialBalance;
      _balanceController.text = _currentBalance.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _balanceController.dispose();
    super.dispose();
  }

  void _incrementBalance() {
    final newBalance = _currentBalance + 1;
    _updateBalance(newBalance);
  }

  void _decrementBalance() {
    final newBalance = _currentBalance - 1;
    _updateBalance(newBalance);
  }

  void _updateBalance(double newBalance) {
    setState(() {
      _currentBalance = newBalance;
      _balanceController.text = newBalance.toStringAsFixed(0);
      _isEditing = false;
    });
    widget.onBalanceChanged(newBalance);
  }

  void _saveBalance() {
    final text = _balanceController.text.trim();
    if (text.isEmpty) {
      _balanceController.text = _currentBalance.toStringAsFixed(0);
      setState(() {
        _isEditing = false;
      });
      return;
    }

    final newBalance = double.tryParse(text);
    if (newBalance != null) {
      _updateBalance(newBalance);
    } else {
      _balanceController.text = _currentBalance.toStringAsFixed(0);
      setState(() {
        _isEditing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Кнопка минус
        Container(
          decoration: BoxDecoration(
            color: Colors.red[400],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.remove, color: Colors.white),
            onPressed: widget.isUpdating ? null : _decrementBalance,
          ),
        ),
        SizedBox(width: 20),
        // Сумма баланса (редактируемая)
        GestureDetector(
          onTap: () {
            setState(() {
              _isEditing = true;
            });
          },
          child: _isEditing
              ? Container(
                  width: 120,
                  child: TextField(
                    controller: _balanceController,
                    keyboardType: TextInputType.numberWithOptions(signed: true, decimal: false),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: _currentBalance < 0 ? Colors.red[400] : Colors.green[400],
                    ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: _currentBalance < 0 ? Colors.red[400]! : Colors.green[400]!,
                          width: 2,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: _currentBalance < 0 ? Colors.red[400]! : Colors.green[400]!,
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: _currentBalance < 0 ? Colors.red[400]! : Colors.green[400]!,
                          width: 2,
                        ),
                      ),
                    ),
                    onSubmitted: (_) => _saveBalance(),
                    onEditingComplete: _saveBalance,
                    autofocus: true,
                  ),
                )
              : Text(
                  _currentBalance.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: _currentBalance < 0 ? Colors.red[400] : Colors.green[400],
                  ),
                ),
        ),
        SizedBox(width: 20),
        // Кнопка плюс
        Container(
          decoration: BoxDecoration(
            color: Colors.green[400],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: widget.isUpdating ? null : _incrementBalance,
          ),
        ),
      ],
    );
  }
}

