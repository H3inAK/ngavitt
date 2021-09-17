import 'package:flutter/material.dart';

class ChartData {
  final String name;
  final double percent;
  final Color color;

  ChartData({this.name, this.percent, this.color});
}

class Category {
  final String id;
  final String title;
  final Color color;
  final String image;

  const Category({
    this.id,
    this.title,
    this.color,
    this.image,
  });
}

Map<String, dynamic> languages = {
  'en': AppLanguage.enLang,
  'my': AppLanguage.myLang,
  'ch': AppLanguage.chLang,
  'ru': AppLanguage.ruLang,
  'vn': AppLanguage.vnLang,
  'th': AppLanguage.thLang,
};

class AppLanguage {
  static const Map<String, Object> enLang = {
    'testing': "Testing",
    'code': "en",
    'name': "english",
    'image': "assets/images/en.png",
    'title': "NGAVITT",
    'totalcases': "Total Cases",
    'todaycases': "Today Cases",
    'totalrecovered': "Total Recovered",
    'todayrecovered': "Today Recovered",
    'totaldeath': "Total Death",
    'todaydeath': "Today Death",
    'activecases': "Active Cases",
    'criticalcases': "Critical Cases",
    'refreshcases': "Refresh Cases",
    'seeallcountries': "See All Countries",
    'allcountries': "All Countries",
    'sortbyName': "Sort by name",
    'sortbytotalcases': "Sort by total case",
    'sortbyactivecases': "Sort by active case",
    'bydescending': "By descending",
    'byascending': "By ascending",
    'seeallstatus': "See all status",
    'preventions': "Preventions",
    'globalpiechart': "Global PieChart",
    'contactme': "Contact Me",
    'countries': "Countries",
    'continents': "Continents",
    'people': "People",
    'changelanguage': "Change Language",
    'asia': "Asia",
    'africa': "Africa",
    'europe': "Europe",
    'northamerica': "North America",
    'southamerica': "South America",
    'australia': "Australia/Oceania",
    'searchcountrybyname': "search country by name ...",
    'nocountriesfounded': "No Countries Founded!",
    'preventionsWays': {
      'title': 'Preventions',
      'dail': 'Dial 999 for \nMedical Help!\n',
      'symptoms': 'If any symptoms appear',
      'washHands': 'Wash Hands',
      'wearMasks': 'Wear Masks',
      'cleaning': 'Clean Disinfect',
    },
    'globalPieChart': {
      'title': "Global Chart Status",
      'active': "Active Percentage",
      'recovered': "Recovered Percentage",
      'comfirmed': "Comfirmed Percentage",
    }
  };

  static const myLang = {
    'testing': "စမ္းသပ္မွူ",
    'code': "my",
    'name': "myanmar",
    'image': "assets/images/my.png",
    'title': "ငဗစ်",
    'totalcases': "စုစုပေါင်းဖြစ်စဉ်",
    'todaycases': "ယနေ့ဖြစ်စဉ်",
    'totalrecovered': "ပျောက်ကင်းပေါင်း",
    'todayrecovered': "ယနေ့ပျောက်ကင်း",
    'totaldeath': "စုစုပေါင်းသေဆုံး",
    'todaydeath': "ယနေ့သေဆုံး",
    'activecases': "လက်ကျန်လူနာ",
    'criticalcases': "အရေးကြီးလူနာ",
    'refreshcases': "ပြန်စစ်မယ်",
    'seeallcountries': "နိုင်ငံအားလုံးကြည့်မယ်",
    'allcountries': "နိုင်ငံအားလုံး",
    'sortbyName': "နာမည်အလိုက်စီမယ်",
    'sortbytotalcases': "ဖြစ်စဉ်အလိုက်စီမယ်",
    'sortbyactivecases': "လက်ကျန်အလိုက်စီမယ်",
    'bydescending': "ပြောင်းပြန်လိုက်",
    'byascending': "အတည့်တိုင်း",
    'seeallstatus': "အားလုံး ကြည့်မယ်",
    'preventions': "ကာကွယ်နည်းများ",
    'globalpiechart': "ကမ္ဘာ့အခြေအနေ",
    'contactme': "ကျနေ့ာကိုဆယ်သွယ်",
    'countries': "နိုင်ငံအလိုက်",
    'continents': "တိုက်ကြီးအလိုက်",
    'people': "ယောက်",
    'changelanguage': "ဘာသာစကားပြောင်းမယ်",
    'asia': "အာရှ",
    'africa': "အာဖရိက",
    'europe': "ဥရောပ",
    'northamerica': "မြောက်အမေရိက",
    'southamerica': "တောင်အမေရိက",
    'australia': "ဩစတေးလျ",
    'searchcountrybyname': "နိုင်ငံကိုနာမည်ရိုက် ရှာဖွေပါ ...",
    'nocountriesfounded': "ဘယ်နိုင်ငံမှ ရှာမတွေ့ပါ!",
    'preventionsWays': {
      'title': 'Preventions',
      'dail': 'အကူညီလိုရင်\n ၉၉၉ ကို\n',
      'symptoms': 'ဆက်သွယ်လိုက်ပါ',
      'washHands': 'mask ဆေးပါ',
      'wearMasks': 'လက်တပ်ပါ',
      'cleaning': 'သန့်ရှင်းရေးလုပ်ပါ',
    },
    'globalPieChart': {
      'title': "ကမ္ဘာ့အခြေအနေ",
      'active': "လက်ရှိလူနာရာခိုင်နှုန်း",
      'recovered': "ပျောက်ကင်းသူရာခိုင်နှုန်း",
      'comfirmed': "စုစုပေါင်းရာခိုင်နှုန်း",
    }
  };

  static const chLang = {
    'testing': "Testing",
    'code': "ch",
    'name': "china",
    'image': "assets/images/ch.jpg",
    'title': "NGAVITT",
    'totalcases': "Total Cases",
    'todaycases': "Today Cases",
    'totalrecovered': "Total Recovered",
    'todayrecovered': "Today Recovered",
    'totaldeath': "Total Death",
    'todaydeath': "Today Death",
    'activecases': "Active Cases",
    'criticalcases': "Critical Cases",
    'refreshcases': "Refresh Cases",
    'seeallcountries': "See All Countries",
    'allcountries': "All Countries",
    'sortbyName': "Sort by name",
    'sortbytotalcases': "Sort by total case",
    'sortbyactivecases': "Sort by active case",
    'bydescending': "By descending",
    'byascending': "By ascending",
    'seeallstatus': "See all status",
    'preventions': "Preventions",
    'globalpiechart': "Global PieChart",
    'contactme': "Contact Me",
    'countries': "Countries",
    'continents': "Continents",
    'people': "People",
    'changelanguage': "Change Language",
    'asia': "Asia",
    'africa': "Africa",
    'europe': "Europe",
    'northamerica': "North America",
    'southamerica': "South America",
    'australia': "Australia/Oceania",
    'searchcountrybyname': "search country by name ...",
    'nocountriesfounded': "No Countries Founded!",
    'preventionsWays': {
      'title': 'Preventions',
      'dail': 'Dial 999 for \nMedical Help!\n',
      'symptoms': 'If any symptoms appear',
      'washHands': 'Wash Hands',
      'wearMasks': 'Wear Masks',
      'cleaning': 'Clean Disinfect',
    },
    'globalPieChart': {
      'title': "Global Chart Status",
      'active': "Active Percentage",
      'recovered': "Recovered Percentage",
      'comfirmed': "Comfirmed Percentage",
    }
  };

  static const ruLang = {
    'testing': "စမ္းသပ္မွူ",
    'code': "ru",
    'name': "russia",
    'image': "assets/images/ru.png",
    'title': "ငဗစ်",
    'totalcases': "စုစုပေါင်းဖြစ်စဉ်",
    'todaycases': "ယနေ့ဖြစ်စဉ်",
    'totalrecovered': "ပျောက်ကင်းပေါင်း",
    'todayrecovered': "ယနေ့ပျောက်ကင်း",
    'totaldeath': "စုစုပေါင်းသေဆုံး",
    'todaydeath': "ယနေ့သေဆုံး",
    'activecases': "လက်ကျန်လူနာ",
    'criticalcases': "အရေးကြီးလူနာ",
    'refreshcases': "ပြန်စစ်မယ်",
    'seeallcountries': "နိုင်ငံအားလုံးကြည့်မယ်",
    'allcountries': "နိုင်ငံအားလုံး",
    'sortbyName': "နာမည်အလိုက်စီမယ်",
    'sortbytotalcases': "ဖြစ်စဉ်အလိုက်စီမယ်",
    'sortbyactivecases': "လက်ကျန်အလိုက်စီမယ်",
    'bydescending': "ပြောင်းပြန်လိုက်",
    'byascending': "အတည့်တိုင်း",
    'seeallstatus': "အားလုံး ကြည့်မယ်",
    'preventions': "ကာကွယ်နည်းများ",
    'globalpiechart': "ကမ္ဘာ့အခြေအနေ",
    'contactme': "ကျနေ့ာကိုဆယ်သွယ်",
    'countries': "နိုင်ငံအလိုက်",
    'continents': "တိုက်ကြီးအလိုက်",
    'people': "ယောက်",
    'changelanguage': "ဘာသာစကားပြောင်းမယ်",
    'asia': "အာရှ",
    'africa': "အာဖရိက",
    'europe': "ဥရောပ",
    'northamerica': "မြောက်အမေရိက",
    'southamerica': "တောင်အမေရိက",
    'australia': "ဩစတေးလျ",
    'searchcountrybyname': "နိုင်ငံကိုနာမည်ရိုက် ရှာဖွေပါ ...",
    'nocountriesfounded': "ဘယ်နိုင်ငံမှ ရှာမတွေ့ပါ!",
    'preventionsWays': {
      'title': 'Preventions',
      'dail': 'အကူညီလိုရင်\n ၉၉၉ ကို\n',
      'symptoms': 'ဆက်သွယ်လိုက်ပါ',
      'washHands': 'mask ဆေးပါ',
      'wearMasks': 'လက်တပ်ပါ',
      'cleaning': 'သန့်ရှင်းရေးလုပ်ပါ',
    },
    'globalPieChart': {
      'title': "ကမ္ဘာ့အခြေအနေ",
      'active': "လက်ရှိလူနာရာခိုင်နှုန်း",
      'recovered': "ပျောက်ကင်းသူရာခိုင်နှုန်း",
      'comfirmed': "စုစုပေါင်းရာခိုင်နှုန်း",
    }
  };

  static const vnLang = {
    'testing': "Testing",
    'code': "vn",
    'name': "vietnam",
    'image': "assets/images/vn.png",
    'title': "NGAVITT",
    'totalcases': "Total Cases",
    'todaycases': "Today Cases",
    'totalrecovered': "Total Recovered",
    'todayrecovered': "Today Recovered",
    'totaldeath': "Total Death",
    'todaydeath': "Today Death",
    'activecases': "Active Cases",
    'criticalcases': "Critical Cases",
    'refreshcases': "Refresh Cases",
    'seeallcountries': "See All Countries",
    'allcountries': "All Countries",
    'sortbyName': "Sort by name",
    'sortbytotalcases': "Sort by total case",
    'sortbyactivecases': "Sort by active case",
    'bydescending': "By descending",
    'byascending': "By ascending",
    'seeallstatus': "See all status",
    'preventions': "Preventions",
    'globalpiechart': "Global PieChart",
    'contactme': "Contact Me",
    'countries': "Countries",
    'continents': "Continents",
    'people': "People",
    'changelanguage': "Change Language",
    'asia': "Asia",
    'africa': "Africa",
    'europe': "Europe",
    'northamerica': "North America",
    'southamerica': "South America",
    'australia': "Australia/Oceania",
    'searchcountrybyname': "search country by name ...",
    'nocountriesfounded': "No Countries Founded!",
    'preventionsWays': {
      'title': 'Preventions',
      'dail': 'Dial 999 for \nMedical Help!\n',
      'symptoms': 'If any symptoms appear',
      'washHands': 'Wash Hands',
      'wearMasks': 'Wear Masks',
      'cleaning': 'Clean Disinfect',
    },
    'globalPieChart': {
      'title': "Global Chart Status",
      'active': "Active Percentage",
      'recovered': "Recovered Percentage",
      'comfirmed': "Comfirmed Percentage",
    }
  };

  static const thLang = {
    'testing': "စမ္းသပ္မွူ",
    'code': "th",
    'name': "thailand",
    'image': "assets/images/th.jpeg",
    'title': "ငဗစ်",
    'totalcases': "စုစုပေါင်းဖြစ်စဉ်",
    'todaycases': "ယနေ့ဖြစ်စဉ်",
    'totalrecovered': "ပျောက်ကင်းပေါင်း",
    'todayrecovered': "ယနေ့ပျောက်ကင်း",
    'totaldeath': "စုစုပေါင်းသေဆုံး",
    'todaydeath': "ယနေ့သေဆုံး",
    'activecases': "လက်ကျန်လူနာ",
    'criticalcases': "အရေးကြီးလူနာ",
    'refreshcases': "ပြန်စစ်မယ်",
    'seeallcountries': "နိုင်ငံအားလုံးကြည့်မယ်",
    'allcountries': "နိုင်ငံအားလုံး",
    'sortbyName': "နာမည်အလိုက်စီမယ်",
    'sortbytotalcases': "ဖြစ်စဉ်အလိုက်စီမယ်",
    'sortbyactivecases': "လက်ကျန်အလိုက်စီမယ်",
    'bydescending': "ပြောင်းပြန်လိုက်",
    'byascending': "အတည့်တိုင်း",
    'seeallstatus': "အားလုံး ကြည့်မယ်",
    'preventions': "ကာကွယ်နည်းများ",
    'globalpiechart': "ကမ္ဘာ့အခြေအနေ",
    'contactme': "ကျနေ့ာကိုဆယ်သွယ်",
    'countries': "နိုင်ငံအလိုက်",
    'continents': "တိုက်ကြီးအလိုက်",
    'people': "ယောက်",
    'changelanguage': "ဘာသာစကားပြောင်းမယ်",
    'asia': "အာရှ",
    'africa': "အာဖရိက",
    'europe': "ဥရောပ",
    'northamerica': "မြောက်အမေရိက",
    'southamerica': "တောင်အမေရိက",
    'australia': "ဩစတေးလျ",
    'searchcountrybyname': "နိုင်ငံကိုနာမည်ရိုက် ရှာဖွေပါ ...",
    'nocountriesfounded': "ဘယ်နိုင်ငံမှ ရှာမတွေ့ပါ!",
    'preventionsWays': {
      'title': 'Preventions',
      'dail': 'အကူညီလိုရင်\n ၉၉၉ ကို\n',
      'symptoms': 'ဆက်သွယ်လိုက်ပါ',
      'washHands': 'mask ဆေးပါ',
      'wearMasks': 'လက်တပ်ပါ',
      'cleaning': 'သန့်ရှင်းရေးလုပ်ပါ',
    },
    'globalPieChart': {
      'title': "ကမ္ဘာ့အခြေအနေ",
      'active': "လက်ရှိလူနာရာခိုင်နှုန်း",
      'recovered': "ပျောက်ကင်းသူရာခိုင်နှုန်း",
      'comfirmed': "စုစုပေါင်းရာခိုင်နှုန်း",
    }
  };
}
