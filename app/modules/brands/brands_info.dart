class Brand {
  final String name;
  final List<Category> categories;

  Brand({required this.name, required this.categories});
}

class Category {
  final String name;
  final List<Product> products;

  Category({required this.name, required this.products});
}

class Product {
  final String name;
  final List<ProductVariant> variants;

  Product({required this.name, required this.variants});
}

class ProductVariant {
  final String size;
  final double price;

  ProductVariant({required this.size, required this.price});
}

List<Brand> dummyBrands = [
  Brand(
    name: 'P&G',
    categories: [
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
    ],
  ),
  Brand(
    name: 'rahul',
    categories: [
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
    ],
  ),

  Brand(
    name: 'abishek',
    categories: [
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
    ],
  ),

  Brand(
    name: 'Unilever',
    categories: [
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Soap',
        products: [
          Product(
            name: 'Lux',
            variants: [
              ProductVariant(size: '100g', price: 2.5),
              ProductVariant(size: '200g', price: 4.0),
            ],
          ),
          Product(
            name: 'Dove',
            variants: [
              ProductVariant(size: '150g', price: 3.0),
              ProductVariant(size: '300g', price: 5.5),
            ],
          ),
        ],
      ),
      Category(
        name: 'Shampoo',
        products: [
          Product(
            name: 'Head & Shoulders',
            variants: [
              ProductVariant(size: '250ml', price: 6.0),
              ProductVariant(size: '500ml', price: 10.0),
            ],
          ),
          Product(
            name: 'Pantene',
            variants: [
              ProductVariant(size: '200ml', price: 5.0),
              ProductVariant(size: '400ml', price: 8.0),
            ],
          ),
        ],
      ),
    ],
  ),
  // Add more brands and their data as needed
];
