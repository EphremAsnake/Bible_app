import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        "es_ML": ml,
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
  "change_language": "baguhin ang wika sa filipino",
  'no_search_results': "No search result found",
  'info': 'Info',
  'changed_to_amh_1954': "Bible Type Changed To Amharic 1954",
  'changed_to_amh_new': "Bible Type Changed To Amharic New  Translation",
  'changed_to_eng_niv': "Bible Type Changed To English NIV",
  'changed_to_eng_kjv': "Bible Type Changed To English KJV",
  'font_size': "Font Size",
  'share': 'Share',
  'rate': 'Rate App',
  'copy': 'Copy',
  'close': 'Close',
  'compare': 'Compare',
  'theme': "Theme"
};

final Map<String, String> ml = {
  'searchResult': 'Mga Resulta: ',
  'book': "Banal na Bibliya",
  'ot': 'Lumang Tipan',
  'nt': 'Bagong Tipan',
  'chapters': 'Kabanata',
  'search': 'Maghanap',
  'settings': 'Mga Setting',
  'about': "Tungkol sa",
  'privacy_policy': 'Patakaran sa Pagkapribado',
  'all': 'Lahat',
  'every_word': 'Bawat Salita',
  'exactly': 'Tumpak',
  "change_language": "Change Language To English",
  'no_search_results': "Walang natagpuang resulta sa paghahanap",
  'info': 'Impormasyon',
  'changed_to_amh_1954': "Nabago ang Uri ng Bibliya sa Amharic 1954",
  'changed_to_amh_new': "Nabago ang Uri ng Bibliya sa Amharic New Translation",
  'changed_to_eng_niv': "Nabago ang Uri ng Bibliya sa Ingles NIV",
  'changed_to_eng_kjv': "Nabago ang Uri ng Bibliya sa Ingles KJV",
  'font_size': "Laki ng Font",
  'share': 'Ibahagi',
  'rate': 'Rate ang App',
  'copy': 'Kopya',
  'close': 'Isara',
  'compare': 'Ikumpara',
  'theme': "Tema"
};



// final Map<String, String> ml = {
//   'searchResult': 'ഫലങ്ങൾ: ',
//   'book': "പരിശുദ്ധ ബൈബിൾ",
//   'ot': 'പഴയ നിയമം',
//   'nt': 'പുതിയ നിയമം',
//   'chapters': 'അദ്ധ്യായം',
//   'search': 'തിരയൽ',
//   'settings': 'ക്രമീകരണങ്ങൾ',
//   'about': "കുറിപ്പ്",
//   'privacy_policy': 'സ്വകാര്യതാ നീതി',
//   'all': 'എല്ലാം',
//   'every_word': 'ഓരോ വാക്ക്',
//   'exactly': 'എളുപ്പത്തിൽ',
//   "change_language": "Change Language To English",
//   'no_search_results': "തിരയൽ ഫലം ലഭ്യമല്ല",
//   'info': 'വിവരം',
//   'changed_to_amh_1954': "ബൈബിൾ തരം ആമാറ്റി അമ്ഹാരിക് 1954",
//   'changed_to_amh_new': "ബൈബിൾ തരം ആമാറ്റി അമ്ഹാരിക് പുതിയ അനുവാദം",
//   'changed_to_eng_niv': "ബൈബിൾ തരം ആമാറ്റി ഇംഗ്ലീഷ് NIV",
//   'changed_to_eng_kjv': "ബൈബിൾ തരം ആമാറ്റി ഇംഗ്ലീഷ് KJV",
//   'font_size': "അക്ഷര വലിപ്പം",
//   'share': 'പങ്കുവെക്കുക',
//   'rate': 'അപ്ലിക്കേഷൻ റേറ്റ് ചെയ്യുക',
//   'copy': 'നകലിക്കുക',
//   'close': 'അടയ്ക്കുക',
//   'compare': 'പരിശോധിക്കുക',
//   'theme': "രൂപകൽപ്പന"
// };

// final Map<String, String> amh = {
//   'searchResult': 'የተገኙ ዉጤትዎች ብዛት: ',
//   'book': "መጽሐፍ ቅዱስ",
//   'ot': 'ብሉይ ኪዳን',
//   'nt': 'አዲስ ኪዳን',
//   'chapters': "ምዕራፍ",
//   'search': 'ፍልግ',
//   'every_word': 'ሁሉንም ቃላት',
//   'exactly': 'እንቅጩን',
//   'all': 'በሁሉም',
//   'settings': 'መቼት',
//   'about': "ስለ",
//   'privacy_policy': 'ግለሰባዊነት',
//   "change_language": "Change Language To English",
//   'no_search_results': "ምንም የፍለጋ ውጤት አልተገኘም።",
//   'info': 'መረጃ',
//   'changed_to_amh_1954': "የመጽሐፍ ቅዱስ ዓይነት ወደ አማርኛ 1954 ተለወጠ።",
//   'changed_to_amh_new': "የመጽሐፍ ቅዱስ ዓይነት ወደ አማርኛ አዲስ ትርጉም ተለወጠ።",
//   'changed_to_eng_niv': "የመጽሐፍ ቅዱስ ዓይነት ወደ እንግሊዝኛ NIV ተለወጠ።",
//   'changed_to_eng_kjv': "የመጽሐፍ ቅዱስ ዓይነት ወደ እንግሊዝኛ ኪጄቪ ተለወጠ።",
//   'font_size': "የፊደል መጠን",
//   'share': 'አጋራ',
//   'close': 'ዝጋ',
//   'rate': 'ሬት ያድርጉ',
//   'copy': 'ኮፒ',
//   'compare': 'ንጽጽር',
//   'theme': "መልክ"
// };
