class AppSettings {
  // Шрифты/размеры (используем потом в Viewer)
  static const defaultFontSize = 11;
  static const defaultFontName = 'monospace';

  // Нельзя const из-за .toString(); делаем final
  static final List<String> allFontSizes = [
    for (var i = 9; i <= 27; i++) i.toString(),
  ];

  static const allFontNames = [
    'FantasqueSansM Nerd Font Mono',
    'Cascadia Code',
    'Consolas',
    'Courier',
  ];

  // Лимит размера файла: 2**25 + 1 (как в PySide)
  static const int maxFileSize = (1 << 25) + 1;

  // Имя файла для сохранения выборок
  static const String selectionsFile = 'selections.json';
}
