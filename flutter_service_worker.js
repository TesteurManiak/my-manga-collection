'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "8bd5c0be0592d7333c40b0f8c3f1b4e0",
"manifest.json": "e6ece4462d08431dea6643591cd5850b",
"version.json": "fb7fb8579463edb60089e3b17083b952",
"flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"index.html": "4e6722cbd7016d72cdebc9732ca66993",
"/": "4e6722cbd7016d72cdebc9732ca66993",
"icons/Icon-512.png": "46d0a6514648ab8d52a4a2d7d64a7a4a",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "5049fda883388f0b343387309fb8decf",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"assets/AssetManifest.json": "ab5cec130e97466aafbd6389d83f69b3",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/easy_localization/i18n/en.json": "5f5fda8715e8bf5116f77f469c5cf493",
"assets/packages/easy_localization/i18n/en-US.json": "5f5fda8715e8bf5116f77f469c5cf493",
"assets/packages/easy_localization/i18n/ar.json": "acc0a8eebb2fcee312764600f7cc41ec",
"assets/packages/easy_localization/i18n/ar-DZ.json": "acc0a8eebb2fcee312764600f7cc41ec",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Medium.ttf": "d08840599e05db7345652d3d417574a9",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Black.ttf": "ec4c9962ba54eb91787aa93d361c10a8",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Light.ttf": "fc84e998bc29b297ea20321e4c90b6ed",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Regular.ttf": "3e1af3ef546b9e6ecef9f3ba197bf7d2",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Thin.ttf": "89e2666c24d37055bcb60e9d2d9f7e35",
"assets/packages/alchemist/assets/fonts/Roboto/Roboto-Bold.ttf": "ee7b96fa85d8fdb8c126409326ac2d2b",
"assets/assets/translations/en.json": "b9d6c31ef30c7a883f4bca30c88f4503",
"assets/assets/translations/fr.json": "eed5b759bf8fa4a60f742fb9990d1ad3",
"assets/NOTICES": "2a1c61c0fe3512673ead154f20c97b5e",
"assets/FontManifest.json": "ef7cc3a419427703f6f345f8cd7109f9",
"splash/style.css": "0a7590cb91aa32e0f7451aac88c29ca1",
"splash/img/light-4x.png": "1c95088d39cd15f8c5fd4faa001de8c9",
"splash/img/dark-3x.png": "17339aa73e8e30edb4879638e6a26428",
"splash/img/dark-1x.png": "e78bd5fee1979acc41fa15d276c795fb",
"splash/img/dark-2x.png": "4b12251b51c10f23585fc0d8869e91fa",
"splash/img/dark-4x.png": "1c95088d39cd15f8c5fd4faa001de8c9",
"splash/img/light-3x.png": "17339aa73e8e30edb4879638e6a26428",
"splash/img/light-1x.png": "e78bd5fee1979acc41fa15d276c795fb",
"splash/img/light-2x.png": "4b12251b51c10f23585fc0d8869e91fa",
"splash/splash.js": "c6a271349a0cd249bdb6d3c4d12f5dcf",
"favicon.png": "711590e79dadaa1773d4f76cb0776b3b"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
