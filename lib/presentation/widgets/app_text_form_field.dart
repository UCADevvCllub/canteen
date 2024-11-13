import 'package:flutter/material.dart';
// Импортирует пакет Material, который предоставляет виджеты и функции для создания пользовательского интерфейса

class AppTextFormField extends StatefulWidget {
  // Определяет виджет AppTextFormField, являющийся StatefulWidget, так как он должен
  // управлять изменяющимся состоянием (например, показывать/скрывать текст пароля).
  const AppTextFormField({
      // Конструктор, который инициализирует параметры виджета
    super.key,
    // Передает уникальный ключ в родительский StatefulWidget
    required this.hintText,
    // Задает, что hintText и controller являются обязательными параметрами.
    required this.controller,

    this.icon,
     // Необязательный параметр для иконки слева от поля ввода
    this.validator,
     // Необязательная функция для валидации текста.
    this.height,
    //Необязательная высота контейнера, который оборачивает текстовое поле.
    this.isPassword = false,
    //Необязательный параметр, указывающий, является ли поле паролем (по умолчанию false).
    this.maxLines = 1,
     //Необязательный параметр, определяющий количество строк в поле ввода (по умолчанию одна строка).
  });

  final String hintText; //Объявляет поля для каждого параметра, делая их доступными внутри состояния виджета.
  final TextEditingController controller;
  final IconData? icon;
  final String? Function(String?)? validator;
  final double? height;
  final bool isPassword;
  final int maxLines;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
} //Переопределяет метод createState, чтобы создать экземпляр _AppTextFormFieldState,
// который будет управлять состоянием виджета.

class _AppTextFormFieldState extends State<AppTextFormField> {
  //Определяет класс _AppTextFormFieldState, в котором строится пользовательский интерфейс виджета
  // и определяется его поведение.
  bool _obscureText = true;
  //Объявляет переменную _obscureText для отслеживания, должно ли текст быть скрытым (true) или видимым (false).
  // Используется, если isPassword установлено в true.
  @override
  Widget build(BuildContext context) {
    //Метод build создает пользовательский интерфейс для виджета, возвращая дерево Widget,
    // которое определяет его внешний вид и поведение.
    return Container( //Этот Container оборачивает TextFormField, устанавливая его высоту
      // (по умолчанию 55, если не указана) и применяя белый цвет фона с округлыми углами радиусом 30 пикселей.
      height: widget.height ?? 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: widget.controller, //Управляет текстом внутри поля, позволяя доступ к нему и модификацию вне виджета.
        obscureText: widget.isPassword ? _obscureText : false, // Скрывает текст, если isPassword равно true и
        // _obscureText тоже true (например, для пароля).
        validator: widget.validator, //Необязательная функция, которая может проверять текст на корректность.
        decoration: InputDecoration( //настраивает внешний вид текстового поля.
          hintText: widget.hintText, // Показывает текст-заполнитель, заданный widget.hintText.
          hintStyle: TextStyle(
            //Устанавливает серый цвет для текста-заполнителя.

            color: Colors.grey[600],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          //Добавляет внутренние отступы вокруг текста для визуального пространства.
          border: OutlineInputBorder(
            //Применяет границу с закругленными углами (радиус 30), с невидимой границей благодаря BorderSide.none.
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          prefixIcon: widget.icon != null ? Icon(widget.icon, color: Colors.grey[600]) : null,
          //Добавляет иконку слева, если она указана, с серым цветом.
          suffixIcon: widget.isPassword
          //Добавляет кнопку для управления видимостью текста в поле пароля.
          // При нажатии вызывает setState, переключая значение _obscureText,
          // чтобы показать/скрыть текст.
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
        ),
        maxLines: widget.maxLines, //Устанавливает максимальное количество строк для текстового поля (по умолчанию 1).
      ),
    );
  }
}
