

import 'package:merocanteen/app/modules/brands/brands_info.dart';
 import 'package:flutter/material.dart';

class BrandsPage extends StatelessWidget {
  // Predefined list of preferred brands for the user
  final List<String> userPreferredBrands = ['P&G', 'Unilever', 'rahul','abishek']; // Example list

  final List<Brand> brands = dummyBrands;

  @override
  Widget build(BuildContext context) {
    List<Brand> filteredBrands = brands.where((brand) => userPreferredBrands.contains(brand.name)).toList();

    // Sort brands based on userPreferredBrands list index
    filteredBrands.sort((a, b) => userPreferredBrands.indexOf(a.name).compareTo(userPreferredBrands.indexOf(b.name)));

    return Scaffold(
      appBar: AppBar(
        title: Text('Preferred Brands'),
      ),
       body: ListView.builder(
        itemCount: filteredBrands.length,
        itemBuilder: (context, index) {
          Brand brand = filteredBrands[index];
          return Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0), // Rounded corners for the brand container
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    brand.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildCategoriesGrid(brand.categories),
              ],
            ),
          );
        },
      ),
   
    );
  }

  Widget _buildCategoriesGrid(List<Category> categories) {
  return SizedBox(
    height: 250, // Adjust height as needed
    child: GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of categories in each row
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        Category category = categories[index];
        return GestureDetector(
          onTap: (){
          
          
                    },
          child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(8.0)),
                            child: Image.network(
                              "https://media.istockphoto.com/id/1148233863/photo/shot-of-data-center-with-multiple-rows-of-fully-operational-server-racks-modern.jpg?s=612x612&w=0&k=20&c=MxDmt3OlQlIgBcOSGcpr-tTonpHG9NcNEHTI0OMwX5k=",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Text(
                             category.name,
                            style: TextStyle(
                              fontSize: 16.0,
                              // You can adjust other text properties as needed
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines:
                                1, // Set to 1 line to show ellipsis for longer text
                          ),
                        ),
                        // Making billing fast every day
                      ],
          )),
        );
        
        
         
      },
    ),
  );
}

}

