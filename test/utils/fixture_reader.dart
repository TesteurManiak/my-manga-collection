import 'dart:io' show File;

String fixture(String name) => File('test/resources/$name').readAsStringSync();

Future<String> fixtureAsync(String name) =>
    File('test/resources/$name').readAsString();
