import 'package:flutter/material.dart';
import 'package:task33_complete_from_my_frien/models/address_response.dart';
import 'package:task33_complete_from_my_frien/models/app_endpoints.dart';
import 'package:task33_complete_from_my_frien/models/cart_response.dart';
import 'package:task33_complete_from_my_frien/utils/app_dio.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final regionController = TextEditingController();
  final detailsController = TextEditingController();
  final noteController = TextEditingController();
  bool newAddress = true;
  num subTotal = 0;
  num vat = 0.14;

  DataListAddress address = DataListAddress();
  List<CartItems> products = [];
  List<num> quantity = [];
  @override
  void initState() {
    super.initState();
    getAddress();
    getCart();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    cityController.dispose();
    regionController.dispose();
    detailsController.dispose();
    noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 22,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 19,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  newAddress
                      ? InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  alertDialog(title: 'Add Address'),
                              barrierDismissible: true,
                            );
                          },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .1,
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 242, 219, 0.8),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Add Address',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Icon(
                                  Icons.add,
                                  size: 22,
                                  color: Colors.orange,
                                ),
                              ],
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  alertDialog(title: 'Edit Address'),
                              barrierDismissible: true,
                            );
                          },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 242, 219, 0.8),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Deliver To",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${address.name} - ${address.city} -${address.region} - ${address.details}',
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Notes",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        address.notes,
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.edit_outlined,
                                  size: 22,
                                  color: Colors.orange,
                                ),
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        "Products",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "(${products.length})",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  inCartItemBuilder(),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(15),
            color: Colors.grey[100],
            child: Row(
              children: [
                const Text(
                  'Sub Total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                // constacer(),
                Text(
                  '$subTotal EGP',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: Row(
              children: [
                const Text(
                  'VAT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                // constacer(),
                Text(
                  '${(vat * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(15),
            color: Colors.grey[100],
            child: Row(
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                // constacer(),
                Text(
                  '${(subTotal + subTotal * vat).toStringAsFixed(2)} EGP',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  if (!newAddress && products.isNotEmpty) {
                    addOrder();
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const OrderConfirmedScreen(),
                    //   ),
                    //   (route) => false,
                    // );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Confirm Order',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget inCartItemBuilder() {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  products[index].product.image,
                  width: 32,
                  height: 35,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        products[index].product.name,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "${products[index].product.price}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Visibility(
                            visible: products[index].product.discount > 0
                                ? true
                                : false,
                            child: Row(
                              children: [
                                Text(
                                  "${products[index].product.oldPrice}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(253, 151, 1, 0.6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "${products[index].product.discount}%",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              deleteItemFromCart(index);
                              subTotal = subTotal -
                                  products[index].product.price *
                                      quantity[index];
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                quantity[index]++;
                                updateCart(index);
                                subTotal =
                                    subTotal + products[index].product.price;
                              });
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(253, 151, 1, 0.6),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text('${quantity[index]}'),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                quantity[index]--;
                                updateCart(index);
                                subTotal =
                                    subTotal - products[index].product.price;
                              });
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(253, 151, 1, 0.6),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> getCart() async {
    final ronse = await AppDio.get(endPoint: EndPoints.carts);
    final cartRonse = CartResponse.fromJson(ronse.data);
    setState(() {
      products = cartRonse.data.cartItems;
      subTotal = cartRonse.data.subTotal;
      quantity.clear();
      for (int i = 0; i < products.length; i++) {
        quantity.add(products[i].quantity);
      }
    });
  }

  Future<void> deleteItemFromCart(int index) async {
    await AppDio.delete(endPoint: '${EndPoints.carts}/${products[index].id}');
    setState(() {
      products.removeAt(index);
      quantity.removeAt(index);
    });
  }

  Future<void> updateCart(int index) async {
    await AppDio.put(
      endPoint: '${EndPoints.carts}/${products[index].id}',
      body: {
        'quantity': quantity[index],
      },
    );
  }

  Future<void> getAddress() async {
    final ronse = await AppDio.get(endPoint: EndPoints.addresses);
    final addressRonse = AddressResponse.fromJson(ronse.data);
    setState(() {
      if (addressRonse.data.total == 0) {
        newAddress = true;
      } else {
        address = addressRonse.data.data[0];
        newAddress = false;
      }
    });
  }

  Widget alertDialog({required String title}) {
    nameController.text = address.name;
    cityController.text = address.city;
    regionController.text = address.region;
    detailsController.text = address.details;
    noteController.text = address.notes;
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter name!";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outlined,
                    color: Colors.orange,
                  ),
                  label: Text(
                    "Name",
                    style: TextStyle(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: cityController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter city!";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_city,
                    color: Colors.orange,
                  ),
                  label: Text(
                    "City",
                    style: TextStyle(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: regionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter region!";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.orange,
                  ),
                  label: Text(
                    "Region",
                    style: TextStyle(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: detailsController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter details!";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.orange,
                  ),
                  label: Text(
                    "Details",
                    style: TextStyle(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: noteController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter note!";
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.note_alt_outlined,
                    color: Colors.orange,
                  ),
                  label: Text(
                    "Note",
                    style: TextStyle(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (newAddress) {
                        addAddress();
                        getAddress();
                      } else {
                        updateAddress();
                        getAddress();
                      }
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 242, 219, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Future<void> updateAddress() async {
    await AppDio.put(
      endPoint: '${EndPoints.addresses}/${address.id}',
      body: {
        "name": nameController.text,
        "city": cityController.text,
        "region": regionController.text,
        "details": detailsController.text,
        "latitude": 0,
        "longitude": 0,
        "notes": noteController.text
      },
    );
  }

  Future<void> addAddress() async {
    await AppDio.post(
      endPoint: EndPoints.addresses,
      body: {
        "name": nameController.text,
        "city": cityController.text,
        "region": regionController.text,
        "details": detailsController.text,
        "notes": noteController.text,
        "latitude": 0,
        "longitude": 0
      },
    );
  }

  Future<void> addOrder() async {
    await AppDio.post(
      endPoint: EndPoints.orders,
      body: {
        'address_id': address.id,
        'payment_method': 1,
        'use_points': false
      },
    );
  }
}
