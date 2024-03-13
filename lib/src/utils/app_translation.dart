import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        "ln_OL": ln,
      };
}

final Map<String, String> en = {
  'searchResult': 'Results: ',
  'book': "Holy Bible",
  'ot': 'Old Testament',
  'nt': 'New Testament',
  'chapters': 'Chapter',
  'search': 'Search',
  'settings': 'Settings',
  'about': "About",
  'privacy_policy': 'Privacy Policy',
  'all': 'All',
  'every_word': 'Every Word',
  'exactly': 'Exactly',
  "change_language": "Change Language to Spanish",
  'no_search_results': "No search result found",
  'info': 'Info',
  'font_size': "Font Size",
  'share': 'Share',
  'rate': 'Rate App',
  'theme': 'Theme',
};

final Map<String, String> ln = {
  'searchResult': 'Resultados: ',
  'book': "Santa Biblia",
  'ot': 'Antiguo Testamento',
  'nt': 'Nuevo Testamento',
  'chapters': 'Capítulo',
  'search': 'Buscar',
  'settings': 'Ajustes',
  'about': "Acerca de",
  'privacy_policy': 'Política de Privacidad',
  'all': 'Todos',
  'every_word': 'Cada Palabra',
  'exactly': 'Exactamente',
  "change_language": "Change Language to English",
  'no_search_results': "No se encontraron resultados de búsqueda",
  'info': 'Información',
  'font_size': "Tamaño de Fuente",
  'share': 'Compartir',
  'rate': 'Calificar App',
  'theme': 'Theme',
};
