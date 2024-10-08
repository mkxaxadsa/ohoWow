import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ojo/core/constants/app_icons.dart';
import 'package:ojo/data/models/article_model.dart';

class Scnren extends StatefulWidget {
  final String njfkds;
  final String njfkads;
  final String mkda;

  Scnren({
    required this.njfkds,
    required this.njfkads,
    required this.mkda,
  });

  @override
  State<Scnren> createState() => _ScnrenState();
}

class _ScnrenState extends State<Scnren> {
  late AppsflyerSdk _appsflyerSdk;
  String adId = '';
  String paramsFirst = '';
  String paramsSecond = '';
  Map _deepLinkData = {};
  Map _gcd = {};
  bool _isFirstLaunch = false;
  String _afStatus = '';
  String _campaign = '';
  String _campaignId = '';

  @override
  void initState() {
    super.initState();
    getTracking();
    afStart();
  }

  Future<void> getTracking() async {
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    print(status);
  }

  Future<void> fetchData() async {
    adId = await AppTrackingTransparency.getAdvertisingIdentifier();
  }

  void afStart() async {
    final AppsFlyerOptions options = AppsFlyerOptions(
      showDebug: false,
      afDevKey: 'EjB2oxnrzjoLfcdgoJtWFh',
      appId: '6657977925',
      timeToWaitForATTUserAuthorization: 15,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
      manualStart: true,
    );
    _appsflyerSdk = AppsflyerSdk(options);

    await _appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    _appsflyerSdk.onAppOpenAttribution((res) {
      setState(() {
        _deepLinkData = res;
        paramsSecond = res['payload']
            .entries
            .where((e) => ![
                  'install_time',
                  'click_time',
                  'af_status',
                  'is_first_launch'
                ].contains(e.key))
            .map((e) => '&${e.key}=${e.value}')
            .join();
        // Extract media source and campaign name
        _campaign = res['campaign'] ?? '';
        _campaignId = res['media_source'] ?? '';
      });
    });

    _appsflyerSdk.onInstallConversionData((res) {
      print(res);
      setState(() {
        _gcd = res;
        _isFirstLaunch = res['payload']['is_first_launch'];
        _afStatus = res['payload']['af_status'];
        paramsFirst = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
        // Extract media source and campaign name
        _campaign = res['campaign'] ?? '';
        _campaignId = res['media_source'] ?? '';
      });
    });

    _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print(dp.deepLink?.toString());
          print("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          print("deep link not found");
          break;
        case Status.ERROR:
          print("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("deep link status parsing error");
          break;
      }
      print("onDeepLinking res: " + dp.toString());
      setState(() {
        _deepLinkData = dp.toJson();
      });
    });

    _appsflyerSdk.startSDK(
      onSuccess: () {
        print("AppsFlyer SDK initialized successfully.");
      },
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final String ajx =
        '${widget.njfkds}&appsflyer_id=${widget.njfkads}${widget.mkda}&media_source=$_campaignId&campaign=$_campaign';
    print(ajx);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(ajx),
          ),
        ),
      ),
    );
  }
}

const articles = [
  ArticleModel(
    title: "Catan",
    icon: AppIcons.catan,
    text:
        """Catan is a strategic board game where players collect resources and use them to build roads, settlements, and cities on the island of Catan. 

Players must trade and manage resources like wood, brick, sheep, wheat, and ore. The aim is to reach 10 victory points by expanding their settlements and cities. 

The game combines luck, strategy, and negotiation. 

Every game is different, thanks to a modular board that changes with each setup.""",
  ),
  ArticleModel(
    title: "Ticket to Ride",
    icon: AppIcons.ticketToRide,
    text:
        """In Ticket to Ride, players collect train cards to claim railway routes on a map. 

The objective is to complete destination tickets by connecting specific cities across the country. 

The longer the route, the more points it earns. Players must balance between building long routes and completing their tickets while blocking opponents. 

It’s a game of planning, strategy, and sometimes daring risks.""",
  ),
  ArticleModel(
    title: "Carcassonne",
    icon: AppIcons.carcassonne,
    text:
        """Carcassonne is a tile-placement game where players build a medieval landscape with cities, roads, monasteries, and fields. 

Players take turns drawing tiles and placing them on the board to extend the existing terrain. 

They can also deploy followers, known as "meeples," to claim areas for points. 

The game is easy to learn but offers deep strategic choices, especially in how players compete for control of different regions.""",
  ),
  ArticleModel(
    title: "Pandemic",
    icon: AppIcons.pandemic,
    text:
        """Pandemic is a cooperative board game where players work together to stop four deadly diseases from spreading across the globe. 

Each player assumes a role with special abilities, such as a medic or scientist. The team must travel the world, treating infections and researching cures. 

Players must coordinate their actions to prevent outbreaks and keep the diseases under control. The game is tense, challenging, and promotes teamwork.""",
  ),
  ArticleModel(
    title: "Splendor",
    icon: AppIcons.splendor,
    text:
        """Splendor is a fast-paced card game where players take on the role of Renaissance merchants. 

They collect gems and use them to purchase development cards, which provide prestige points and bonuses for future purchases. 

The goal is to be the first to reach 15 prestige points. 

The game is simple to learn but requires careful planning and resource management. It’s a blend of strategy, tactics, and a little bit of luck.""",
  ),
  ArticleModel(
    title: "7 Wonders",
    icon: AppIcons.wonders,
    text:
        """7 Wonders is a civilization-building game where players develop their city-state through three ages. 

Each turn, players select cards that represent military, science, commerce, or culture, and pass the remaining cards to the next player. 

The game is played over three rounds, with players building wonders, amassing resources, and developing their civilization. It’s a highly strategic game with simultaneous play, making it fast-paced and engaging.""",
  ),
  ArticleModel(
    title: "Azul",
    icon: AppIcons.azul,
    text:
        """Azul is a beautifully designed tile-drafting game where players take turns selecting colored tiles from a central market to complete patterns on their personal boards. 

The aim is to score points by creating specific patterns and completing rows and columns. 

Players must plan carefully, as unused tiles result in penalties. 

The game combines aesthetic appeal with strategic depth, making it a hit among casual and experienced gamers alike.""",
  ),
  ArticleModel(
    title: "Betrayal at House on the Hill",
    icon: AppIcons.betrayal,
    text:
        """Betrayal at House on the Hill is a cooperative-turned-competitive horror-themed game. 

Players explore a haunted mansion, uncovering rooms and encountering spooky events. 

Halfway through the game, one player turns traitor, and the game shifts to a battle between the heroes and the traitor. 

The game features dozens of different scenarios, each offering a unique story and set of objectives. It’s a thrilling game of suspense, strategy, and survival.""",
  ),
  ArticleModel(
    title: "Dominion",
    icon: AppIcons.dominion,
    text:
        """Dominion is a deck-building game where players start with a small deck of cards and gradually build it up by purchasing new cards from a shared supply. 

The goal is to create the most efficient deck and accumulate victory points. Each card offers different abilities, from drawing more cards to gaining extra actions or buying power. 

The game offers endless replayability with different card combinations, making each game unique.""",
  ),
  ArticleModel(
    title: "Scythe",
    icon: AppIcons.scythe,
    text:
        """Scythe is a strategy game set in an alternate-history 1920s Europe. 

Players control factions vying for dominance by exploring territories, gathering resources, and building structures. 

The game features a blend of combat, area control, and resource management, with each faction having unique abilities. 

Scythe also includes a strong economic component, where players must balance military power with resource production. 

The game is known for its deep strategy, stunning artwork, and intricate gameplay.""",
  ),
];
