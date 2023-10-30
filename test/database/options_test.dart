import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game/animated_background/models.dart';
import 'package:game/database/options.dart';
import 'package:game/database/scoreProvider.dart';
import 'package:game/widget/data.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Initialize sqflite for test.
void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}


Future main() async {
  sqfliteTestInit();


  group('OptionsProvider Unit test (CRUD)', () {

    test('Open', () async {
      OptionsProvider optionsProvider = OptionsProvider.forTest();
      await optionsProvider.open(inMemoryDatabasePath);
      expect(optionsProvider.db.isOpen, true);
      optionsProvider.close();
    });

    test('Close', () async {
      OptionsProvider optionsProvider = OptionsProvider.forTest();
      await optionsProvider.open(inMemoryDatabasePath);
      await optionsProvider.close();
      expect(optionsProvider.db.isOpen, false);
    });

    test('Insert', ()  async{
      OptionsProvider optionsProvider = OptionsProvider.forTest();
      await optionsProvider.open(inMemoryDatabasePath);
      Options options = Options(
          color_tile: const Color(0xffFF0000),
          button_style: StyleButton.glass,
          model: BackgroundStyle.bubble,
          theme: false,
          button_color: const Color(0xffFF0001),
          button_color_font: false
      );
      expect(await optionsProvider.insert(options), options);
        await optionsProvider.close();
    });

    test('getOptions', ()  async{
      OptionsProvider optionsProvider = OptionsProvider.forTest();
      await optionsProvider.open(inMemoryDatabasePath);
      Options options = Options(
          color_tile: const Color(0xffFF0000),
          button_style: StyleButton.glass,
          model: BackgroundStyle.bubble,
          theme: false,
          button_color: const Color(0xffFF0000),
          button_color_font: false
      );

      await optionsProvider.insert(options);
      Options? test = await optionsProvider.getOptionFromId(1);
      expect(test != null, true);


      expect(test!.color_tile, const Color(0xffFF0000));
      expect(test!.button_style, StyleButton.glass);
      expect(test!.model, BackgroundStyle.bubble);
      expect(test!.theme, false);
      expect(test!.button_color, const Color(0xffFF0000));
      expect(test!.button_color_font, false);
      await optionsProvider.close();

    });

  });
  

}

