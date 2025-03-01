import 'package:canteen/presentation/pages/schedule/domain/models/schedule_model.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
    required this.schedule,
  });

  final ScheduleModel schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors
            .grey[200], // Один цвет для всех дней (например, светло-серый)
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Название дня недели с иконкой
          Row(
            children: [
              // Иконка (слева в начале)
              Image.asset(
                'assets/icons/scheduleday.png',
                width: 24, // Размер иконки
                height: 24,
              ),
              SizedBox(width: 16), // Расстояние между иконкой и текстом
              // Название дня недели (по центру относительно всей строки)
              Expanded(
                child: Center(
                  child: Text(
                    schedule.day == "Shop Schedule"
                        ? "Shop Schedule"
                        : schedule.day,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: schedule.day == "Shop Schedule"
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16), // Отступ между названием дня и датой
          // Дата и время работы
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Дата
              Text(
                schedule.date,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // Время работы (если не выходной)
              if (!schedule.day.contains("Saturday") &&
                  !schedule.day.contains("Sunday"))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildTimeDetail('Open', schedule.status),
                    _buildTimeDetail('Break', schedule.status),
                    _buildTimeDetail('Closed', schedule.status),
                  ],
                ),
              // Выходные
              if (schedule.day.contains("Saturday") ||
                  schedule.day.contains("Sunday"))
                Text(
                  'Days off',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDetail(String status, String time) {
    return Row(
      children: [
        Text(
          status,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Text(
          time,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
