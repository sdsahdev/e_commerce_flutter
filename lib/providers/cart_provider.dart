import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider {
  static const _cartKey = 'cart_items';

  // Method to add a product to the cart
  Future<void> addToCart(Map<String, dynamic> product) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = await _getCart();

    cart.add(product);
    await prefs.setString(_cartKey, json.encode(cart));
  }

  // Method to retrieve the cart items
  Future<List<Map<String, dynamic>>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString(_cartKey) ?? '[]';
    final List<dynamic> cartJson = json.decode(cartString);
    return List<Map<String, dynamic>>.from(cartJson);
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }

  Future<void> removeFromCart(Map<String, dynamic> product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cart') ?? [];
    cartItems.removeWhere((item) => jsonDecode(item)['id'] == product['id']);
    await prefs.setString(_cartKey, json.encode(cartItems));
  }

  Future<List<Map<String, dynamic>>> _getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString(_cartKey) ?? '[]';
    final List<dynamic> cartJson = json.decode(cartString);
    return List<Map<String, dynamic>>.from(cartJson);
  }
}

final Map<String, List<Map<String, dynamic>>> staticProductData = {
  'electronics': [
    {
      "id": 9,
      "title": "WD 2TB Elements Portable External Hard Drive - USB 3.0 ",
      "price": 64,
      "description":
          "USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg",
      "rating": {"rate": 3.3, "count": 203}
    },
    {
      "id": 10,
      "title": "SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s",
      "price": 109,
      "description":
          "Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5” hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg",
      "rating": {"rate": 2.9, "count": 470}
    },
    {
      "id": 11,
      "title":
          "Silicon Power 256GB SSD 3D NAND A55 SLC Cache Performance Boost SATA III 2.5",
      "price": 109,
      "description":
          "3D NAND flash are applied to deliver high transfer speeds Remarkable transfer speeds that enable faster bootup and improved overall system performance. The advanced SLC Cache Technology allows performance boost and longer lifespan 7mm slim design suitable for Ultrabooks and Ultra-slim notebooks. Supports TRIM command, Garbage Collection technology, RAID, and ECC (Error Checking & Correction) to provide the optimized performance and enhanced reliability.",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg",
      "rating": {"rate": 4.8, "count": 319}
    },
    {
      "id": 12,
      "title":
          "WD 4TB Gaming Drive Works with Playstation 4 Portable External Hard Drive",
      "price": 114,
      "description":
          "Expand your PS4 gaming experience, Play anywhere Fast and easy, setup Sleek design with high capacity, 3-year manufacturer's limited warranty",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/61mtL65D4cL._AC_SX679_.jpg",
      "rating": {"rate": 4.8, "count": 400}
    },
    {
      "id": 13,
      "title":
          "Acer SB220Q bi 21.5 inches Full HD (1920 x 1080) IPS Ultra-Thin",
      "price": 599,
      "description":
          "21. 5 inches Full HD (1920 x 1080) widescreen IPS display And Radeon free Sync technology. No compatibility for VESA Mount Refresh Rate: 75Hz - Using HDMI port Zero-frame design | ultra-thin | 4ms response time | IPS panel Aspect ratio - 16: 9. Color Supported - 16. 7 million colors. Brightness - 250 nit Tilt angle -5 degree to 15 degree. Horizontal viewing angle-178 degree. Vertical viewing angle-178 degree 75 hertz",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg",
      "rating": {"rate": 2.9, "count": 250}
    },
    {
      "id": 14,
      "title":
          "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor (LC49HG90DMNXZA) – Super Ultrawide Screen QLED ",
      "price": 999.99,
      "description":
          "49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR with dual 27 inch screen side by side QUANTUM DOT (QLED) TECHNOLOGY, HDR support and factory calibration provides stunningly realistic and accurate color and contrast 144HZ HIGH REFRESH RATE and 1ms ultra fast response time work to eliminate motion blur, ghosting, and reduce input lag",
      "category": "electronics",
      "image": "https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg",
      "rating": {"rate": 2.2, "count": 140}
    }
  ],
  'jewelery': [
    {
      "id": 5,
      "title":
          "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet",
      "price": 695,
      "description":
          "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.",
      "category": "jewelery",
      "image":
          "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
      "rating": {"rate": 4.6, "count": 400}
    },
    {
      "id": 6,
      "title": "Solid Gold Petite Micropave ",
      "price": 168,
      "description":
          "Satisfaction Guaranteed. Return or exchange any order within 30 days.Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days.",
      "category": "jewelery",
      "image":
          "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg",
      "rating": {"rate": 3.9, "count": 70}
    },
    {
      "id": 7,
      "title": "White Gold Plated Princess",
      "price": 9.99,
      "description":
          "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love more for Engagement, Wedding, Anniversary, Valentine's Day...",
      "category": "jewelery",
      "image":
          "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
      "rating": {"rate": 3, "count": 400}
    },
    {
      "id": 8,
      "title": "Pierced Owl Rose Gold Plated Stainless Steel Double",
      "price": 10.99,
      "description":
          "Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel",
      "category": "jewelery",
      "image":
          "https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
      "rating": {"rate": 1.9, "count": 100}
    }
  ],
  'grocery': [
    {
      "id": 16,
      "title": "Almond Milk - Unsweetened",
      "price": 3.49,
      "description":
          "A healthy and delicious alternative to dairy milk, perfect for lactose-intolerant individuals.",
      "category": "groceries",
      "image":
          "https://epigamiastore.com/cdn/shop/products/New-Almond-Drink_Beverage-4_61d27e93-8151-4372-afd3-202447bbff46_1080x.jpg?v=1680179315",
      "rating": {"rate": 4.7, "count": 200}
    },
    {
      "id": 17,
      "title": "Organic Eggs (12-pack)",
      "price": 4.99,
      "description": "Fresh organic eggs, free from antibiotics and hormones.",
      "category": "groceries",
      "image":
          "https://cdn.meatigo.com/fit-in/659x705/product/1692272783754_164_-_free_range_eggs",
      "rating": {"rate": 4.8, "count": 250}
    },
    {
      "id": 15,
      "title": "Organic Bananas",
      "price": 1.99,
      "description":
          "Fresh organic bananas, perfect for a healthy snack or breakfast.",
      "category": "groceries",
      "image":
          "https://www.bigbasket.com/media/uploads/p/l/10000688_2-gopalan-organic-banana-yellaki.jpg",
      "rating": {"rate": 4.5, "count": 150}
    },
    {
      "id": 18,
      "title": "Quinoa (1 lb)",
      "price": 6.99,
      "description": "High-protein quinoa, great for salads or as a side dish.",
      "category": "groceries",
      "image":
          "https://humpyfarms.com/cdn/shop/files/qn01_1.png?v=1706001599&width=1080",
      "rating": {"rate": 4.6, "count": 120}
    },
    {
      "id": 19,
      "title": "Whole Grain Bread",
      "price": 2.99,
      "description":
          "Freshly baked whole grain bread, perfect for sandwiches or toast.",
      "category": "groceries",
      "image":
          "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRSKBrByxEPITcqgZ8xREAZ8DAAHO99YSauEKJIP2ZkHOBrUpMc-UX6AX5LQ92yYm8x72j30ostYfEE-qJZwQZw7FLCRce_FLFuB-RlWI_kMPgZwA4jFvhoKA",
      "rating": {"rate": 4.3, "count": 180}
    },
    {
      "id": 20,
      "title": "Greek Yogurt - Plain",
      "price": 4.49,
      "description":
          "Thick and creamy Greek yogurt, perfect for a healthy breakfast or snack.",
      "category": "groceries",
      "image":
          "https://www.jiomart.com/images/product/original/491317036/epigamia-natural-greek-yogurt-85-g-cup-product-images-o491317036-p491317036-0-202301261114.jpg?im=Resize=(420,420)",
      "rating": {"rate": 4.9, "count": 220}
    },
    {
      "id": 21,
      "title": "Organic Honey (16 oz)",
      "price": 7.99,
      "description":
          "Pure organic honey, a natural sweetener for tea, baking, or cooking.",
      "category": "groceries",
      "image":
          "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQnSG8E-tJE5rCL8xItATUmHevFMi8vI6bbavBblVVCqkJHAgC9gHIaMfRNW7JSZUCBD1murLy0TtiLylPh4vNSFKdwfdzan9MmZGPkdExp2_x2S0baaOVP",
      "rating": {"rate": 4.7, "count": 140}
    },
    {
      "id": 22,
      "title": "Broccoli Crowns (1 lb)",
      "price": 2.49,
      "description":
          "Fresh broccoli crowns, perfect for steaming or stir-frying.",
      "category": "groceries",
      "image":
          "https://punjabigroceries.com/cdn/shop/products/BroccoliCrown.jpg?v=1605828765&width=1200",
      "rating": {"rate": 4.6, "count": 160}
    },
    {
      "id": 23,
      "title": "Almond Butter (12 oz)",
      "price": 8.99,
      "description":
          "Smooth and creamy almond butter, a great source of healthy fats and protein.",
      "category": "groceries",
      "image":
          "https://m.media-amazon.com/images/I/41I+1Evj7cL._SY300_SX300_.jpg",
      "rating": {"rate": 4.8, "count": 110}
    },
    {
      "id": 24,
      "title": "Organic Carrots (2 lb)",
      "price": 3.49,
      "description": "Fresh organic carrots, great for snacking or cooking.",
      "category": "groceries",
      "image":
          "https://rukminim2.flixcart.com/image/1200/1200/xif0q/plant-seed/b/b/f/100-carrot-seeds-gachwala-original-imagv8dq5zxtbqza.jpeg?q=60&crop=false",
      "rating": {"rate": 4.7, "count": 130}
    },
    {
      "id": 25,
      "title": "Brown Rice (2 lb)",
      "price": 4.49,
      "description":
          "Whole grain brown rice, a nutritious side dish for any meal.",
      "category": "groceries",
      "image":
          "https://m.media-amazon.com/images/I/51dCUG+aRsS._SY300_SX300_.jpg",
      "rating": {"rate": 4.4, "count": 190}
    },
    {
      "id": 26,
      "title": "Coconut Water (1 L)",
      "price": 2.99,
      "description": "Refreshing coconut water, a natural source of hydration.",
      "category": "groceries",
      "image":
          "https://cdn.zeptonow.com/production///tr:w-1000,ar-980-980,pr-true,f-auto,q-80/cms/product_variant/75e89fbd-3f9d-42aa-88e2-e8dcef1871f5.jpeg",
      "rating": {"rate": 4.5, "count": 100}
    }
  ],
  "women's clothing": [
    {
      "id": 15,
      "title": "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats",
      "price": 56.99,
      "description":
          "Note:The Jackets is US standard size, Please choose size as your usual wear Material: 100% Polyester; Detachable Liner Fabric: Warm Fleece. Detachable Functional Liner: Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets: 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design: Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg",
      "rating": {"rate": 2.6, "count": 235}
    },
    {
      "id": 16,
      "title":
          "Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket",
      "price": 29.95,
      "description":
          "100% POLYURETHANE(shell) 100% POLYESTER(lining) 75% POLYESTER 25% COTTON (SWEATER), Faux leather material for style and comfort / 2 pockets of front, 2-For-One Hooded denim style faux leather jacket, Button detail on waist / Detail stitching at sides, HAND WASH ONLY / DO NOT BLEACH / LINE DRY / DO NOT IRON",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg",
      "rating": {"rate": 2.9, "count": 340}
    },
    {
      "id": 17,
      "title": "Rain Jacket Women Windbreaker Striped Climbing Raincoats",
      "price": 39.99,
      "description":
          "Lightweight perfet for trip or casual wear---Long sleeve with hooded, adjustable drawstring waist design. Button and zipper front closure raincoat, fully stripes Lined and The Raincoat has 2 side pockets are a good size to hold all kinds of things, it covers the hips, and the hood is generous but doesn't overdo it.Attached Cotton Lined Hood with Adjustable Drawstrings give it a real styled look.",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2.jpg",
      "rating": {"rate": 3.8, "count": 679}
    },
    {
      "id": 18,
      "title": "MBJ Women's Solid Short Sleeve Boat Neck V ",
      "price": 9.85,
      "description":
          "95% RAYON 5% SPANDEX, Made in USA or Imported, Do Not Bleach, Lightweight fabric with great stretch for comfort, Ribbed on sleeves and neckline / Double stitching on bottom hem",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/71z3kpMAYsL._AC_UY879_.jpg",
      "rating": {"rate": 4.7, "count": 130}
    },
    {
      "id": 19,
      "title": "Opna Women's Short Sleeve Moisture",
      "price": 7.95,
      "description":
          "100% Polyester, Machine wash, 100% cationic polyester interlock, Machine Wash & Pre Shrunk for a Great Fit, Lightweight, roomy and highly breathable with moisture wicking fabric which helps to keep moisture away, Soft Lightweight Fabric with comfortable V-neck collar and a slimmer fit, delivers a sleek, more feminine silhouette and Added Comfort",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg",
      "rating": {"rate": 4.5, "count": 146}
    },
    {
      "id": 20,
      "title": "DANVOUY Womens T Shirt Casual Cotton Short",
      "price": 12.99,
      "description":
          "95%Cotton,5%Spandex, Features: Casual, Short Sleeve, Letter Print,V-Neck,Fashion Tees, The fabric is soft and has some stretch., Occasion: Casual/Office/Beach/School/Home/Street. Season: Spring,Summer,Autumn,Winter.",
      "category": "women's clothing",
      "image": "https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg",
      "rating": {"rate": 3.6, "count": 145}
    }
  ]
};
