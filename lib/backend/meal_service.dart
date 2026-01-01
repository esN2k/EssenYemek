import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MealService {
  static CollectionReference<Map<String, dynamic>> mealsCollection({
    FirebaseFirestore? firestore,
  }) {
    final db = firestore ?? FirebaseFirestore.instance;
    return db.collection('meals');
  }

  static Stream<List<MealsRecord>> streamMeals({
    FirebaseFirestore? firestore,
    List<String>? dietFilters,
    int? maxCalories,
    int limit = 20,
  }) {
    var query = mealsCollection(firestore: firestore).limit(limit);

    // Apply diet filters if provided
    if (dietFilters != null && dietFilters.isNotEmpty) {
      query = query.where('meal_diet', arrayContainsAny: dietFilters);
    }

    return query.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => MealsRecord.fromSnapshot(doc))
        .where((meal) =>
            maxCalories == null || meal.mealCalories <= maxCalories)
        .toList());
  }

  static Future<List<MealsRecord>> fetchMeals({
    FirebaseFirestore? firestore,
    List<String>? dietFilters,
    int? maxCalories,
    int limit = 20,
  }) async {
    var query = mealsCollection(firestore: firestore).limit(limit);

    if (dietFilters != null && dietFilters.isNotEmpty) {
      query = query.where('meal_diet', arrayContainsAny: dietFilters);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => MealsRecord.fromSnapshot(doc))
        .where((meal) =>
            maxCalories == null || meal.mealCalories <= maxCalories)
        .toList();
  }

  /// Seeds the database with 30+ realistic meal data
  /// Categories: Vejeteryan, Vegan, Düşük Kalori, Protein Ağırlıklı, Glutensiz
  static Future<void> seedSampleMeals({
    FirebaseFirestore? firestore,
  }) async {
    final db = firestore ?? FirebaseFirestore.instance;
    final mealsCol = mealsCollection(firestore: db);

    // Check if meals already exist
    final existing = await mealsCol.limit(1).get();
    if (existing.docs.isNotEmpty) {
      print('Meals collection already has data. Skipping seed.');
      return;
    }

    final meals = _getSampleMealsData();

    for (final meal in meals) {
      await mealsCol.add(meal);
    }

    print('Successfully seeded ${meals.length} meals to Firestore!');
  }

  static List<Map<String, dynamic>> _getSampleMealsData() {
    return [
      // Protein Ağırlıklı (High Protein)
      {
        'meal_name': 'Izgara Tavuk Salatası',
        'meal_image':
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800',
        'meal_ingredients':
            'Tavuk göğsü, yeşil salata, domates, salatalık, zeytinyağı, limon',
        'meal_allergens': [],
        'meal_calories': 380,
        'meal_diet': ['Dengeli', 'Protein Ağırlıklı', 'Düşük Kalori'],
      },
      {
        'meal_name': 'Somon Fileto & Brokoli',
        'meal_image':
            'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=800',
        'meal_ingredients':
            'Somon fileto, brokoli, limon, sarımsak, zeytinyağı, tuz, karabiber',
        'meal_allergens': ['Balık'],
        'meal_calories': 450,
        'meal_diet': ['Dengeli', 'Protein Ağırlıklı'],
      },
      {
        'meal_name': 'Biftek & Patates Püresi',
        'meal_image':
            'https://images.unsplash.com/photo-1558030006-450675393462?w=800',
        'meal_ingredients':
            'Dana biftek, patates, süt, tereyağı, tuz, karabiber, kekik',
        'meal_allergens': ['Süt'],
        'meal_calories': 620,
        'meal_diet': ['Dengeli', 'Protein Ağırlıklı', 'Lezzetli'],
      },
      {
        'meal_name': 'Ton Balıklı Salata',
        'meal_image':
            'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800',
        'meal_ingredients':
            'Ton balığı, marul, mısır, zeytin, domates, limon, zeytinyağı',
        'meal_allergens': ['Balık'],
        'meal_calories': 320,
        'meal_diet': ['Dengeli', 'Protein Ağırlıklı', 'Düşük Kalori'],
      },
      {
        'meal_name': 'Tavuk Fajita',
        'meal_image':
            'https://images.unsplash.com/photo-1565299507177-b0ac66763828?w=800',
        'meal_ingredients':
            'Tavuk göğsü, biber, soğan, tortilla, avokado, lime, baharat',
        'meal_allergens': ['Gluten'],
        'meal_calories': 480,
        'meal_diet': ['Dengeli', 'Protein Ağırlıklı', 'Lezzetli'],
      },

      // Vejeteryan (Vegetarian)
      {
        'meal_name': 'Sebzeli Omlet',
        'meal_image':
            'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800',
        'meal_ingredients':
            'Yumurta, biber, mantar, domates, soğan, peynir, maydanoz',
        'meal_allergens': ['Yumurta', 'Süt'],
        'meal_calories': 340,
        'meal_diet': ['Dengeli', 'Vejeteryan'],
      },
      {
        'meal_name': 'Margherita Pizza',
        'meal_image':
            'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=800',
        'meal_ingredients':
            'Pizza hamuru, domates sosu, mozzarella, fesleğen, zeytinyağı',
        'meal_allergens': ['Gluten', 'Süt'],
        'meal_calories': 580,
        'meal_diet': ['Vejeteryan', 'Lezzetli'],
      },
      {
        'meal_name': 'Peynirli Makarna',
        'meal_image':
            'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800',
        'meal_ingredients':
            'Makarna, krema, parmesan, kaşar, tereyağı, karabiber',
        'meal_allergens': ['Gluten', 'Süt'],
        'meal_calories': 520,
        'meal_diet': ['Vejeteryan', 'Lezzetli'],
      },
      {
        'meal_name': 'Sebzeli Kuskus',
        'meal_image':
            'https://images.unsplash.com/photo-1596797038530-2c107229654b?w=800',
        'meal_ingredients':
            'Kuskus, kabak, havuç, nohut, kırmızı biber, baharatlar',
        'meal_allergens': ['Gluten'],
        'meal_calories': 380,
        'meal_diet': ['Vejeteryan', 'Dengeli'],
      },
      {
        'meal_name': 'Falafel Wrap',
        'meal_image':
            'https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=800',
        'meal_ingredients':
            'Nohut köftesi, lavash, marul, domates, tahin sosu, turşu',
        'meal_allergens': ['Gluten', 'Susam'],
        'meal_calories': 420,
        'meal_diet': ['Vejeteryan', 'Dengeli'],
      },

      // Vegan
      {
        'meal_name': 'Quinoa Buddha Bowl',
        'meal_image':
            'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800',
        'meal_ingredients':
            'Quinoa, nohut, avokado, ıspanak, havuç, susam, limon',
        'meal_allergens': ['Susam'],
        'meal_calories': 420,
        'meal_diet': ['Vegan', 'Dengeli', 'Düşük Kalori'],
      },
      {
        'meal_name': 'Vegan Burger',
        'meal_image':
            'https://images.unsplash.com/photo-1520072959219-c595dc870360?w=800',
        'meal_ingredients':
            'Fasulye köftesi, burger ekmeği, marul, domates, soğan, hardal',
        'meal_allergens': ['Gluten', 'Soya'],
        'meal_calories': 460,
        'meal_diet': ['Vegan', 'Lezzetli'],
      },
      {
        'meal_name': 'Sebze Curry',
        'meal_image':
            'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=800',
        'meal_ingredients':
            'Hindistan cevizi sütü, patates, havuç, bezelye, curry, pilav',
        'meal_allergens': [],
        'meal_calories': 480,
        'meal_diet': ['Vegan', 'Lezzetli', 'Dengeli'],
      },
      {
        'meal_name': 'Tofu Stir-Fry',
        'meal_image':
            'https://images.unsplash.com/photo-1546069901-d5bfd2cbfb1f?w=800',
        'meal_ingredients':
            'Tofu, brokoli, havuç, biber, soya sosu, susam yağı, zencefil',
        'meal_allergens': ['Soya', 'Susam'],
        'meal_calories': 360,
        'meal_diet': ['Vegan', 'Protein Ağırlıklı', 'Düşük Kalori'],
      },
      {
        'meal_name': 'Mercimek Çorbası',
        'meal_image':
            'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800',
        'meal_ingredients':
            'Kırmızı mercimek, havuç, patates, soğan, domates, baharat',
        'meal_allergens': [],
        'meal_calories': 240,
        'meal_diet': ['Vegan', 'Düşük Kalori', 'Dengeli'],
      },

      // Düşük Kalori (Low Calorie)
      {
        'meal_name': 'Izgara Sebze Tabağı',
        'meal_image':
            'https://images.unsplash.com/photo-1572449043416-55f4685c9bb7?w=800',
        'meal_ingredients':
            'Kabak, patlıcan, biber, mantar, kiraz domates, zeytinyağı',
        'meal_allergens': [],
        'meal_calories': 180,
        'meal_diet': ['Vegan', 'Düşük Kalori', 'Vejeteryan'],
      },
      {
        'meal_name': 'Yeşil Detox Smoothie Bowl',
        'meal_image':
            'https://images.unsplash.com/photo-1590301157890-4810ed352733?w=800',
        'meal_ingredients':
            'Ispanak, muz, mango, chia tohumu, hindistan cevizi, granola',
        'meal_allergens': [],
        'meal_calories': 280,
        'meal_diet': ['Vegan', 'Düşük Kalori'],
      },
      {
        'meal_name': 'Izgara Balık & Salata',
        'meal_image':
            'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800',
        'meal_ingredients':
            'Levrek, roka, limon, zeytinyağı, kırmızı soğan, marul',
        'meal_allergens': ['Balık'],
        'meal_calories': 320,
        'meal_diet': ['Düşük Kalori', 'Protein Ağırlıklı', 'Dengeli'],
      },
      {
        'meal_name': 'Tavuk Şiş & Cacık',
        'meal_image':
            'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=800',
        'meal_ingredients':
            'Tavuk göğsü, yoğurt, salatalık, sarımsak, nane, bulgur pilavı',
        'meal_allergens': ['Süt'],
        'meal_calories': 400,
        'meal_diet': ['Düşük Kalori', 'Protein Ağırlıklı', 'Dengeli'],
      },
      {
        'meal_name': 'Sezar Salatası',
        'meal_image':
            'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?w=800',
        'meal_ingredients':
            'Marul, kruton, parmesan, tavuk göğsü, sezar sos, limon',
        'meal_allergens': ['Gluten', 'Süt'],
        'meal_calories': 380,
        'meal_diet': ['Düşük Kalori', 'Protein Ağırlıklı'],
      },

      // Glutensiz (Gluten-Free)
      {
        'meal_name': 'Glutensiz Tavuklu Pilav',
        'meal_image':
            'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=800',
        'meal_ingredients':
            'Tavuk göğsü, basmati pirinç, havuç, bezelye, tereyağı',
        'meal_allergens': ['Süt'],
        'meal_calories': 480,
        'meal_diet': ['Glutensiz', 'Dengeli', 'Protein Ağırlıklı'],
      },
      {
        'meal_name': 'Patates & Dana Sote',
        'meal_image':
            'https://images.unsplash.com/photo-1603073661030-89f8e8ecd90b?w=800',
        'meal_ingredients':
            'Dana eti, patates, biber, domates, soğan, baharatlar',
        'meal_allergens': [],
        'meal_calories': 540,
        'meal_diet': ['Glutensiz', 'Protein Ağırlıklı', 'Lezzetli'],
      },
      {
        'meal_name': 'Zeytinyağlı Enginar',
        'meal_image':
            'https://images.unsplash.com/photo-1604263439201-171fb8c0fddc?w=800',
        'meal_ingredients':
            'Enginar, havuç, bezelye, patates, zeytinyağı, limon, şeker',
        'meal_allergens': [],
        'meal_calories': 220,
        'meal_diet': ['Glutensiz', 'Vegan', 'Düşük Kalori', 'Vejeteryan'],
      },
      {
        'meal_name': 'Glutensiz Makarna Bolonez',
        'meal_image':
            'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=800',
        'meal_ingredients':
            'Glutensiz makarna, kıyma, domates sosu, soğan, sarımsak, fesleğen',
        'meal_allergens': [],
        'meal_calories': 520,
        'meal_diet': ['Glutensiz', 'Protein Ağırlıklı', 'Lezzetli'],
      },
      {
        'meal_name': 'Karides Wok',
        'meal_image':
            'https://images.unsplash.com/photo-1559847844-5315695dadae?w=800',
        'meal_ingredients':
            'Karides, brokoli, havuç, biber, soya sosu, zencefil, susam',
        'meal_allergens': ['Kabuklu Deniz Ürünleri', 'Soya', 'Susam'],
        'meal_calories': 340,
        'meal_diet': ['Glutensiz', 'Protein Ağırlıklı', 'Düşük Kalori'],
      },

      // Lezzetli (Tasty / Comfort Food)
      {
        'meal_name': 'Mantı',
        'meal_image':
            'https://images.unsplash.com/photo-1623653387945-2fd25214f8fc?w=800',
        'meal_ingredients':
            'Hamur, kıyma, yoğurt, sarımsak, tereyağı, pul biber',
        'meal_allergens': ['Gluten', 'Süt'],
        'meal_calories': 580,
        'meal_diet': ['Lezzetli'],
      },
      {
        'meal_name': 'Izgara Köfte & Pilav',
        'meal_image':
            'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=800',
        'meal_ingredients':
            'Dana kıyma, soğan, pirinç pilavı, domates, biber, maydanoz',
        'meal_allergens': [],
        'meal_calories': 620,
        'meal_diet': ['Lezzetli', 'Protein Ağırlıklı', 'Dengeli'],
      },
      {
        'meal_name': 'Lazanya',
        'meal_image':
            'https://images.unsplash.com/photo-1574894709920-11b28e7367e3?w=800',
        'meal_ingredients':
            'Lazanya hamuru, kıyma, beşamel sos, domates sosu, peynir',
        'meal_allergens': ['Gluten', 'Süt'],
        'meal_calories': 680,
        'meal_diet': ['Lezzetli'],
      },
      {
        'meal_name': 'Chicken Wings & Patates',
        'meal_image':
            'https://images.unsplash.com/photo-1527477396000-e27163b481c2?w=800',
        'meal_ingredients':
            'Tavuk kanatları, patates kızartması, barbekü sos, ranch sos',
        'meal_allergens': ['Süt'],
        'meal_calories': 720,
        'meal_diet': ['Lezzetli', 'Protein Ağırlıklı'],
      },
      {
        'meal_name': 'Cheeseburger & Patates',
        'meal_image':
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=800',
        'meal_ingredients':
            'Dana burger, peynir, marul, domates, soğan, turşu, patates',
        'meal_allergens': ['Gluten', 'Süt'],
        'meal_calories': 780,
        'meal_diet': ['Lezzetli'],
      },

      // Dengeli (Balanced)
      {
        'meal_name': 'Tavuk Güveç',
        'meal_image':
            'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=800',
        'meal_ingredients':
            'Tavuk but, patates, havuç, soğan, domates, biber, baharatlar',
        'meal_allergens': [],
        'meal_calories': 480,
        'meal_diet': ['Dengeli', 'Lezzetli'],
      },
      {
        'meal_name': 'Izgara Levrek & Zeytinyağlılar',
        'meal_image':
            'https://images.unsplash.com/photo-1544025162-d76694265947?w=800',
        'meal_ingredients':
            'Levrek, taze fasulye, enginar, havuç, zeytinyağı, limon',
        'meal_allergens': ['Balık'],
        'meal_calories': 380,
        'meal_diet': ['Dengeli', 'Düşük Kalori'],
      },
      {
        'meal_name': 'Etli Nohut',
        'meal_image':
            'https://images.unsplash.com/photo-1551248429-40975aa4de74?w=800',
        'meal_ingredients':
            'Dana eti, nohut, soğan, domates, biber, baharatlar, pilav',
        'meal_allergens': [],
        'meal_calories': 560,
        'meal_diet': ['Dengeli', 'Protein Ağırlıklı'],
      },
    ];
  }
}
