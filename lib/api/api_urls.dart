class ApiUrls {
  static const String apiVersion = "v1";

  // Base URLs
  static const String rootApiUrl = "http://192.168.0.105:5000/api/$apiVersion";
  // static const String rootApiUrl = "https://rukyah-server.vercel.app/api/$apiVersion";
  static const String websiteUrl = "https://sunnahcurebd.com/";
  static const String yaqeenTechSolutionsPlayStoreUrl = "https://play.google.com/store/apps/developer?id=Yaqeen+Tech+Solutions";
  static const String reportProblemGoogleForm = "https://forms.gle/zB2kCortFX6xEL1K9";

  // Play Store
  static const String playStoreAppLink = 'https://play.google.com/store/apps/details?id=com.sunnahcurebd.rukiyah_and_ayat';

  // Endpoints
  static const String appConfigApiUrl = "$rootApiUrl/config";

  // Categories
  static const String getAllCategory = "$rootApiUrl/categories";
  static const String getVersesByCategory = "$rootApiUrl/verses";

  // Articles
  static const String getAllArticles = "$rootApiUrl/articles";

  // Hijama
  static const String getAllHijamaArticles = "$rootApiUrl/hijama";

  // Masnun Dua
  static const String getAllMasnunDuas = "$rootApiUrl/masnun-dua";
  static const String getAllMasnunDuaCategories = "$rootApiUrl/masnun-dua-categories";

  // Nirapottar Dua
  static const String getAllNirapottarDuas = "$rootApiUrl/nirapottar-dua";

  // Audio
  static const String getAllAudios = "$rootApiUrl/audio";
}
