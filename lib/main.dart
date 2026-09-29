import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ================= LICENSE (same keys as keygen.html) =================

class Lic {
  static const secret = 'MU55-9XKD-2026-QP3M-7VCM';
  static const _kExp = 'muss_exp';

  static String sha8(String s) => sha256
      .convert(utf8.encode(s))
      .bytes
      .sublist(0, 4)
      .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
      .join();

  static Future<String> deviceId() async {
    try {
      final di = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        return (await di.androidInfo).id.toUpperCase();
      }
      if (Platform.isIOS) {
        return ((await di.iosInfo).identifierForVendor ?? 'UNKNOWN')
            .replaceAll('-', '')
            .toUpperCase();
      }
    } catch (_) {}
    return 'UNKNOWN';
  }

  static Future<double> getExpiry() async =>
      (await SharedPreferences.getInstance()).getDouble(_kExp) ?? 0;

  static Future<bool> isLicensed() async =>
      (await getExpiry()) > DateTime.now().millisecondsSinceEpoch / 1000;

  static Future<void> saveLicense(double exp) async =>
      (await SharedPreferences.getInstance()).setDouble(_kExp, exp);

  static Future<double> verifyKey(String key, String devId) async {
    final k = key.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');
    if (k.length != 24) return 0;
    final payload = k.substring(0, 8);
    final dev = k.substring(8, 16);
    final sig = k.substring(16);
    if (dev != sha8('$secret|$devId')) return 0;
    if (sig != sha8(secret + payload + dev)) return 0;
    final exp = int.tryParse(payload, radix: 16) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return exp > now ? exp.toDouble() : 0;
  }
}

// ================= AD BLOCKING =================

class AdBlock {
  static const hosts = [
  "adXXX.com",
  "adform.net",
  "adlightning.com",
  "adnium.com",
  "adnxs.com",
  "adocean.pl",
  "adotmob.com",
  "adriver.ru",
  "adroll.com",
  "ads.brazzers.com",
  "ads.ero-advertising.com",
  "ads.exoclick.com",
  "ads.keep2share.cc",
  "ads.pornhub.com",
  "ads.porntube.com",
  "ads.redtube.com",
  "ads.spankwire.com",
  "ads.tube8.com",
  "ads.xhamster.com",
  "ads.xvideos.com",
  "ads.youporn.com",
  "ads2.contentabc.com",
  "adsco.re",
  "adservice.google.com",
  "adsfac.eu",
  "adsfac.net",
  "adskeeper.co.uk",
  "adskeeper.com",
  "adspirit.de",
  "adsrvr.org",
  "adsupply.com",
  "adswizz.com",
  "adsymptotic.com",
  "adtdp.com",
  "adtech.de",
  "adtechus.com",
  "adtng.com",
  "adtraction.com",
  "adtrue.com",
  "adunity.com",
  "adv-adserver.com",
  "advertising.com",
  "adx1.com",
  "adyoulike.com",
  "adzerk.net",
  "aerserv.com",
  "agkn.com",
  "amazon-adsystem.com",
  "aniview.com",
  "appflood.com",
  "appia.com",
  "appier.com",
  "appnexus.com",
  "apsalar.com",
  "aralego.com",
  "atwola.com",
  "audience2media.com",
  "avazu.net",
  "avocet.io",
  "awemdia.com",
  "awempire.com",
  "axonix.com",
  "bannerbank.ru",
  "betweendigital.com",
  "bidswitch.net",
  "bluekai.com",
  "bngpt.com",
  "bongacams.com",
  "brealtime.com",
  "brightcom.com",
  "burstnet.com",
  "casalemedia.com",
  "cdn.contentabc.com",
  "chartbeat.com",
  "chartboost.com",
  "chaturbate.com",
  "clickfuse.com",
  "clickonometrics.pl",
  "clksite.com",
  "comscore.com",
  "connatix.com",
  "contentabc.com",
  "contextweb.com",
  "cpx.to",
  "criteo.com",
  "criteo.net",
  "crwdcntrl.net",
  "deepintent.com",
  "demdex.net",
  "districtm.io",
  "dotomi.com",
  "doubleclick.net",
  "dsp.io",
  "dynsrvtbg.com",
  "dynsrvwer.com",
  "dyntrk.com",
  "effectivemeasure.net",
  "emxdgt.com",
  "ero-advertising.com",
  "eroadvertising.com",
  "eroadvertising.tv",
  "everesttech.net",
  "exdynsrv.com",
  "exelator.com",
  "exoclick.com",
  "exosrv.com",
  "exponential.com",
  "fastclick.net",
  "flurry.com",
  "freewheel.tv",
  "fuseplatform.net",
  "genieessp.com",
  "getpublica.com",
  "googleadservices.com",
  "googlesyndication.com",
  "gumgum.com",
  "hilltopads.net",
  "histats.com",
  "hitslink.com",
  "hotjar.com",
  "imrworldwide.com",
  "infolinks.com",
  "inmobi.com",
  "innity.com",
  "insticator.com",
  "intentiq.com",
  "ipinyou.com",
  "jads.co",
  "juicyads.com",
  "kantarmedia.com",
  "kargo.com",
  "komoona.com",
  "krxd.net",
  "lijit.com",
  "livejasmin.com",
  "lkqd.com",
  "lkqd.net",
  "lockerdome.com",
  "logly.co.jp",
  "loopme.com",
  "madadsmedia.com",
  "marfeel.com",
  "marketgid.com",
  "mathtag.com",
  "media.net",
  "media6degrees.com",
  "mediamath.com",
  "mediaplex.com",
  "mediavine.com",
  "meetrics.net",
  "mgid.com",
  "microad.jp",
  "mixpanel.com",
  "moatads.com",
  "mobfox.com",
  "momagic.com",
  "mxpnl.com",
  "myads.com",
  "myvisualiq.net",
  "netmining.com",
  "netmng.com",
  "newtention.net",
  "nexage.com",
  "noktagr.com",
  "ntv.io",
  "omtrdc.net",
  "onclickads.net",
  "onetag-sys.com",
  "openx.net",
  "outbrain.com",
  "owneriq.net",
  "p-td.com",
  "pagead2.googlesyndication.com",
  "pages04.net",
  "parsely.com",
  "performanceadexchange.com",
  "permutive.com",
  "playwire.com",
  "pointroll.com",
  "popads.net",
  "popcash.net",
  "popmyads.net",
  "popunder.net",
  "propellerads.com",
  "pubmatic.com",
  "puhtml.com",
  "puserving.com",
  "q1connect.com",
  "q1media.com",
  "quantcast.com",
  "quantserve.com",
  "radiumone.com",
  "reachlocal.com",
  "redillumed.com",
  "redmas.net",
  "revcontent.com",
  "revenuehits.com",
  "rfihub.com",
  "rlcdn.com",
  "rtk.io",
  "ru4.com",
  "rubiconproject.com",
  "runative-syndicate.com",
  "s-onetag.com",
  "saymedia.com",
  "scorecardresearch.com",
  "sekindo.com",
  "serving-sys.com",
  "sharethrough.com",
  "simpli.fi",
  "sitescout.com",
  "smaato.net",
  "smartadserver.com",
  "smilewanted.com",
  "sniperlog.com",
  "socialsynergy.com",
  "sojern.com",
  "sonobi.com",
  "specificmedia.com",
  "spot.im",
  "spotxchange.com",
  "springserve.com",
  "stackadapt.com",
  "statcounter.com",
  "static.contentabc.com",
  "stripcash.com",
  "sundaysky.com",
  "syncapse.com",
  "syndication.exoclick.com",
  "taboola.com",
  "tapad.com",
  "tapit.com",
  "teads.tv",
  "technoratimedia.com",
  "theadex.com",
  "themoneytizer.com",
  "tidaltv.com",
  "tmogul.com",
  "tns-counter.ru",
  "trackalyzer.com",
  "tracx.com",
  "trafficfactory.biz",
  "trafficfactory.com",
  "trafficholder.com",
  "trafficjunky.com",
  "trafficjunky.net",
  "trafficleader.com",
  "tremorhub.com",
  "tremormedia.com",
  "tribalfusion.com",
  "tru.am",
  "tsyndicate.com",
  "turn.com",
  "tvsquared.com",
  "twittercounter.com",
  "undertone.com",
  "uniqodo.com",
  "unrulymedia.com",
  "vdopia.com",
  "veinteractive.com",
  "velti.com",
  "verve.com",
  "vi-serve.com",
  "vibrantmedia.com",
  "videologygroup.com",
  "vidible.tv",
  "vidoomy.com",
  "viglink.com",
  "w55c.net",
  "webads.nl",
  "webgains.com",
  "webtrekk.net",
  "widespace.com",
  "wiredminds.de",
  "wpnjs.com",
  "wpnjs.net",
  "xaxis.com",
  "yieldlab.net",
  "yieldmo.com",
  "yldbt.com",
  "yoc.com",
  "zcdsp.com",
  "zedo.com",
  "zergnet.com"
  ];

  static bool isBlocked(String url) {
    final low = url.toLowerCase();
    if (low.contains('adserver') || low.contains('/ads/') ||
        low.contains('popads') || low.contains('preroll') ||
        low.contains('/vast') || low.contains('imasdk') ||
        low.contains('doubleclick') || low.contains('googlesyndication') ||
        low.contains('exoclick') || low.contains('popcash')) return true;
    final uri = Uri.tryParse(low);
    final host = uri?.host ?? '';
    for (final h in hosts) {
      if (host == h || host.endsWith('.$h')) return true;
    }
    return false;
  }

  static const injectJS = r'''
(function() {
    if (window.__mussInit) return;
    window.__mussInit = true;
    window.open = function() { return null; };
    window.alert = function() {};
    window.confirm = function() { return false; };
    window.prompt = function() { return null; };
    var AD_SELECTORS = ['[id*="ad-"]','[class*="ad-"]','[id*="_ad"]','[class*="_ad"]',
        '[id*="advert"]','[class*="advert"]','[id*="popup"]','[class*="popup"]',
        '[id*="banner"]','[class*="banner"]','[class*="sponsor"]','ins.adsbygoogle',
        'iframe[src*="ads"]','iframe[src*="doubleclick"]','[role="dialog"]'];
    function killIn(doc) {
        AD_SELECTORS.forEach(function(sel) {
            try { doc.querySelectorAll(sel).forEach(function(el) {
                if (el.querySelector && el.querySelector('video')) return;
                el.remove();
            }); } catch (e) {}
        });
    }
    function kill() { killIn(document); }
    kill();
    new MutationObserver(function() { kill(); }).observe(document.documentElement, {childList: true, subtree: true});
    setInterval(kill, 3000);
    document.addEventListener('play', function(e) {
        setTimeout(function() {
            var v = e.target;
            if (!v || v.tagName !== 'VIDEO' || v.paused) return;
            var r = v.getBoundingClientRect();
            if (r.width < window.innerWidth * 0.6) return;
            var fn = v.webkitEnterFullscreen || v.requestFullscreen;
            if (fn) { try { var p = fn.call(v); if (p && p.catch) p.catch(function(){}); } catch (err) {} }
        }, 600);
    }, true);
})();
''';
}

// ================= APP =================

void main() => runApp(const MussApp());

class MussApp extends StatelessWidget {
  const MussApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'Muss',
        debugShowCheckedModeBanner: false,
        home: Gate(),
      );
}

class Gate extends StatelessWidget {
  const Gate({super.key});
  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
        future: Lic.isLicensed(),
        builder: (_, s) {
          if (!s.hasData) {
            return const Scaffold(backgroundColor: Colors.black);
          }
          return s.data! ? const WebPage() : const LicensePage();
        },
      );
}

// ================= ACTIVATION PAGE =================

class LicensePage extends StatefulWidget {
  const LicensePage({super.key});
  @override
  State<LicensePage> createState() => _LicensePageState();
}

class _LicensePageState extends State<LicensePage> {
  final _keyCtrl = TextEditingController();
  String _status = 'No active subscription';
  Color _statusColor = Colors.redAccent;
  String _devId = '...';
  Timer? _t;

  @override
  void initState() {
    super.initState();
    Lic.deviceId().then((id) => setState(() => _devId = id));
    _t = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() async {
    final rem = (await Lic.getExpiry()) -
        DateTime.now().millisecondsSinceEpoch / 1000;
    if (!mounted) return;
    if (rem <= 0) {
      setState(() {
        _status = 'Subscription expired - enter a new key';
        _statusColor = Colors.redAccent;
      });
      return;
    }
    var s = rem.toInt();
    final d = s ~/ 86400; s %= 86400;
    final h = s ~/ 3600; s %= 3600;
    final m = s ~/ 60;
    setState(() {
      _status =
          'PREMIUM ACTIVE   ${d}d : ${h.toString().padLeft(2, '0')}h : ${m.toString().padLeft(2, '0')}m : ${(s % 60).toString().padLeft(2, '0')}s';
      _statusColor = Colors.greenAccent;
    });
  }

  Future<void> _activate() async {
    final key = _keyCtrl.text.trim();
    if (key.isEmpty) {
      setState(() {
        _status = 'Please enter a key';
        _statusColor = Colors.redAccent;
      });
      return;
    }
    final exp = await Lic.verifyKey(key, _devId);
    if (exp <= 0) {
      setState(() {
        _status = 'Invalid key or wrong device';
        _statusColor = Colors.redAccent;
      });
      return;
    }
    await Lic.saveLicense(exp);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WebPage()));
  }

  @override
  void dispose() {
    _t?.cancel();
    _keyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF141F36), Color(0xFF090C12)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: const Color(0xF21E2735),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset('assets/logo.png', width: 74, height: 74),
                ),
                const SizedBox(height: 12),
                const Text('Muss',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 6),
                const Text('PREMIUM SUBSCRIPTION',
                    style: TextStyle(fontSize: 14, color: Color(0xFFE50914))),
                const SizedBox(height: 18),
                Text(_status,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: _statusColor)),
                const SizedBox(height: 14),
                Text(
                  'DEVICE ID: $_devId\n(send it to the admin to get your key)',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _keyCtrl,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.characters,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'XXXX-XXXX-XXXX-XXXX-XXXX-XXXX',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF0B0F16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE50914),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: _activate,
                    child: const Text('ACTIVATE',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 14),
                const Text('No key? Contact the admin to get one',
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= WEB PAGE (movy.sx) =================

class WebPage extends StatefulWidget {
  const WebPage({super.key});
  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  String _counter = '';
  Timer? _t;

  @override
  void initState() {
    super.initState();
    _t = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() async {
    if (!await Lic.isLicensed()) {
      _t?.cancel();
      if (mounted) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LicensePage()));
      }
      return;
    }
    final rem = (await Lic.getExpiry()) -
        DateTime.now().millisecondsSinceEpoch / 1000;
    var s = rem.toInt();
    final d = s ~/ 86400; s %= 86400;
    final h = s ~/ 3600; s %= 3600;
    final m = s ~/ 60;
    if (mounted) {
      setState(() => _counter =
          'KEY: ${d}d ${h.toString().padLeft(2, '0')}h ${m.toString().padLeft(2, '0')}m ${(s % 60).toString().padLeft(2, '0')}s');
    }
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(children: [
          InAppWebView(
            initialUrlRequest:
                URLRequest(url: WebUri('https://www.movy.sx/?tvapp=1')),
            initialUserScripts: UnmodifiableListView([
              UserScript(
                  source: AdBlock.injectJS,
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START),
            ]),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                mediaPlaybackRequiresUserGesture: false,
                supportZoom: false,
              ),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
              ),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true,
              ),
            ),
            shouldInterceptRequest: (controller, request) async {
              if (AdBlock.isBlocked(request.url.toString())) {
                return WebResourceResponse(
                    contentType: 'text/plain',
                    contentEncoding: 'utf-8',
                    data: Uint8List(0));
              }
              return null;
            },
          ),
          Positioned(
            top: 8,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(_counter,
                  style: const TextStyle(
                      color: Color(0xFF00E5FF),
                      fontSize: 11,
                      fontFamily: 'monospace')),
            ),
          ),
        ]),
      ),
    );
  }
}
