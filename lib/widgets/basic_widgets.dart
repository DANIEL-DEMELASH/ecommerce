import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/user.dart';
import '../screens/product_detail.dart';
import '../screens/products_by_category.dart';

Widget displayProducts(List<Product> products, BuildContext context) {
  return GridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: List.generate(products.length, (index) {
        final Product product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetail(product: product)));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            height: MediaQuery.of(context).size.height / 4,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    product.image.toString(),
                    height: MediaQuery.of(context).size.height / 7,
                  ),
                ),
                SizedBox(height: 18.0, child: Text(product.title.toString())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('\$${product.price}'),
                    Row(
                      children: [
                        Text('${product.rating!.rate}'),
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 15,
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }));
}

Widget displayCategories(List<String> categories, BuildContext context) {
  return GridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: List.generate(categories.length, (index) {
        final String category = categories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductByCategoryScreen(category: category)));
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: MediaQuery.of(context).size.height / 4,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Center(
                  child: Text(
                category,
                style: const TextStyle(fontSize: 20.0),
              ))),
        );
      }));
}

Widget displayProfile(User user, BuildContext context) {
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController numberText = TextEditingController();
  TextEditingController streetText = TextEditingController();
  TextEditingController cityText = TextEditingController();

  emailText.text = user.email!;
  passwordText.text = user.phone!;
  numberText.text = user.address!.number.toString();
  streetText.text = user.address!.street.toString();
  cityText.text = user.address!.city.toString();

  return Container(
    color: Colors.white,
    width: double.infinity,
    height: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
    child: Column(
      children: [
        const CircleAvatar(
          radius: 60.0,
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          '${user.name!.firstname} ${user.name!.lastname}',
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          '@${user.username}',
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        TextField(
          enabled: false,
          controller: emailText,
          decoration: const InputDecoration(
              labelText: 'Email Address'), // will disable paste operation
        ),
        const SizedBox(
          height: 25.0,
        ),
        TextField(
          enabled: false,
          controller: passwordText,
          decoration: const InputDecoration(
              labelText: 'Phone number'), // will disable paste operation
        ),
        const SizedBox(
          height: 25.0,
        ),
        Row(
          children: [
            DisabledTextField(
              numberText: numberText,
              labelText: 'number',
            ),
            const SizedBox(width: 10.0),
            DisabledTextField(
              numberText: streetText,
              labelText: 'street',
            ),
            const SizedBox(width: 10.0),
            DisabledTextField(
              numberText: cityText,
              labelText: 'city',
            ),
          ],
        )
      ],
    ),
  );
}

class DisabledTextField extends StatelessWidget {
  const DisabledTextField({
    Key? key,
    required this.numberText,
    required this.labelText,
  }) : super(key: key);

  final TextEditingController numberText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        enabled: false,
        controller: numberText,
        decoration: InputDecoration(
            labelText: labelText), // will disable paste operation
      ),
    );
  }
}
