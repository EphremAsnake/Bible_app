import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        "amh_ET": amh,
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
  "change_language": "ቋንቋ ወደ አማርኛ ቀይር",
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

final Map<String, String> amh = {
  'searchResult': 'የተገኙ ዉጤትዎች ብዛት: ',
  'book': "መጽሐፍ ቅዱስ",
  'ot': 'ብሉይ ኪዳን',
  'nt': 'አዲስ ኪዳን',
  'chapters': "ምዕራፍ",
  'search': 'ፍልግ',
  'every_word': 'ሁሉንም ቃላት',
  'exactly': 'እንቅጩን',
  'all': 'በሁሉም',
  'settings': 'መቼት',
  'about': "ስለ",
  'privacy_policy': 'ግለሰባዊነት',
  "change_language": "Change Language To English",
  'no_search_results': "ምንም የፍለጋ ውጤት አልተገኘም።",
  'info': 'መረጃ',
  'changed_to_amh_1954': "የመጽሐፍ ቅዱስ ዓይነት ወደ አማርኛ 1954 ተለወጠ።",
  'changed_to_amh_new': "የመጽሐፍ ቅዱስ ዓይነት ወደ አማርኛ አዲስ ትርጉም ተለወጠ።",
  'changed_to_eng_niv': "የመጽሐፍ ቅዱስ ዓይነት ወደ እንግሊዝኛ NIV ተለወጠ።",
  'changed_to_eng_kjv': "የመጽሐፍ ቅዱስ ዓይነት ወደ እንግሊዝኛ ኪጄቪ ተለወጠ።",
  'font_size': "የፊደል መጠን",
  'share': 'አጋራ',
  'close': 'ዝጋ',
  'rate': 'ሬት ያድርጉ',
  'copy': 'ኮፒ',
  'compare': 'ንጽጽር',
  'theme': "መልክ"
};
