import 'package:quick_actions/quick_actions.dart';

class AppBannerActions {
  static AppBannerActions instance;
  static QuickActions quickActions;

  const AppBannerActions._();

  static void init() {
    instance = AppBannerActions._();
    quickActions = QuickActions();

    quickActions.setShortcutItems([
      ShortcutItem(
        type: 'global',
        localizedTitle: 'Global Chart',
        icon: 'icon_chart',
      ),
      ShortcutItem(
        type: 'countries',
        localizedTitle: 'All Countries',
        icon: 'icon_list',
      ),
      ShortcutItem(
        type: 'search',
        localizedTitle: 'Search Countries',
        icon: 'icon_search',
      ),
    ]);
  }
}
