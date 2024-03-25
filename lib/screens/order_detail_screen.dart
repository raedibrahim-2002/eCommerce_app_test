import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task33_complete_from_my_frien/models/app_endpoints.dart';
import 'package:task33_complete_from_my_frien/models/order_details_response.dart';
import 'package:task33_complete_from_my_frien/screens/order_action_screen.dart';
import 'package:task33_complete_from_my_frien/utils/app_dio.dart';

class OrderDetailsScreen extends StatefulWidget {
  final num id;
  const OrderDetailsScreen({super.key, required this.id});
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Address address = Address();
  Data data = Data();
  bool orderCanceled = false;
  String deliverTo = '';
  @override
  void initState() {
    super.initState();
    getOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 22.sp,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Order Details",
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15.sp),
                  margin: EdgeInsets.only(bottom: 20.sp),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 242, 219, 0.8),
                    borderRadius: BorderRadius.circular(16.sp),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deliver To",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.sp),
                          Text(
                            deliverTo,
                            style: TextStyle(
                              fontSize: 17.sp,
                            ),
                          ),
                          SizedBox(height: 5.sp),
                          Text(
                            "Notes",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.sp),
                          Text(
                            address.notes,
                            style: TextStyle(
                              fontSize: 17.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                orderCanceled
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45.sp,
                        padding: EdgeInsets.all(15.sp),
                        margin: EdgeInsets.only(bottom: 20.sp),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 242, 219, 0.8),
                          borderRadius: BorderRadius.circular(16.sp),
                        ),
                        child: Text(
                          "Order Canceled",
                          style: TextStyle(
                            fontSize: 19.sp,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 85.sp,
                        padding: EdgeInsets.all(25.sp),
                        margin: EdgeInsets.only(bottom: 20.sp),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 242, 219, 0.8),
                          borderRadius: BorderRadius.circular(16.sp),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 19.sp,
                                      color: Colors.orange,
                                    ),
                                    SizedBox(
                                      height: 30.sp,
                                      child: const VerticalDivider(
                                        color: Colors.orange,
                                        thickness: 2,
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      size: 19.sp,
                                      color: Colors.black12,
                                    ),
                                    SizedBox(
                                      height: 30.sp,
                                      child: const VerticalDivider(
                                        color: Colors.black12,
                                        thickness: 2,
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      size: 19.sp,
                                      color: Colors.black12,
                                    ),
                                    SizedBox(
                                      height: 30.sp,
                                      child: const VerticalDivider(
                                        color: Colors.black12,
                                        thickness: 2,
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      size: 19.sp,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 20.sp),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order Placed',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 30.sp),
                                    Text(
                                      'Shipped',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 30.sp),
                                    Text(
                                      'Out of delivery',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 29.sp),
                                    Text(
                                      'Delivered',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 28.sp,
                              child: ElevatedButton(
                                onPressed: () {
                                  cancelOrder();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OrderActionScreen(
                                        action: 'Order Cancelled',
                                      ),
                                    ),
                                  ).then((value) => getOrderDetails());
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.sp),
                                  ),
                                ),
                                child: Text(
                                  'Cancel Order',
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 15.sp),
                  margin: EdgeInsets.only(bottom: 20.sp),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 242, 219, 0.8),
                    borderRadius: BorderRadius.circular(16.sp),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Order Details",
                        style: TextStyle(
                          fontSize: 19.sp,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.sp),
                      Container(
                        padding: EdgeInsets.all(15.sp),
                        color: const Color.fromRGBO(255, 214, 164, 1.0),
                        child: Row(
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(fontSize: 17.sp),
                            ),
                            const Spacer(),
                            Text(
                              data.date,
                              style: TextStyle(fontSize: 17.sp),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15.sp),
                        color: const Color.fromRGBO(255, 198, 99, 1.0),
                        child: Row(
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(fontSize: 17.sp),
                            ),
                            const Spacer(),
                            Text(
                              data.cost.toString(),
                              style: TextStyle(fontSize: 17.sp),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15.sp),
                        color: const Color.fromRGBO(255, 214, 164, 1.0),
                        child: Row(
                          children: [
                            Text(
                              'VAT',
                              style: TextStyle(fontSize: 17.sp),
                            ),
                            const Spacer(),
                            Text(
                              '14%',
                              style: TextStyle(fontSize: 17.sp),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15.sp),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 198, 99, 1.0),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16.sp),
                            bottomRight: Radius.circular(16.sp),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(fontSize: 17.sp),
                            ),
                            const Spacer(),
                            Text(
                              (data.cost + data.cost * 0.14).toStringAsFixed(2),
                              style: TextStyle(fontSize: 17.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Products",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 15.sp),
                    Text(
                      "(${data.products.length})",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.sp),
                productsItemBuilder(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productsItemBuilder() {
    return SizedBox(
      height: 60.sp,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.products.length,
        itemBuilder: (context, index) {
          return Container(
            width: 65.sp,
            padding: EdgeInsets.all(15.sp),
            margin: EdgeInsets.only(right: 20.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(16.sp),
            ),
            child: Column(
              children: [
                Image.network(
                  data.products[index].image,
                  height: 40.sp,
                ),
                Text(
                  data.products[index].name,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 17.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Text(
                  '${data.products[index].price} EGP',
                  style: TextStyle(fontSize: 17.sp),
                ),
                Text(
                  'Quantity: ${data.products[index].quantity}',
                  style: TextStyle(fontSize: 17.sp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> getOrderDetails() async {
    final response =
        await AppDio.get(endPoint: '${EndPoints.orders}/${widget.id}');
    final orderDetailsResponse = OrderDetailsResponse.fromJson(response.data);
    setState(() {
      address = orderDetailsResponse.data.address;
      deliverTo =
          '${address.name} - ${address.city} - ${address.region} - ${address.details}';
      data = orderDetailsResponse.data;
      orderCanceled = data.status == 'Cancelled' ? true : false;
    });
  }

  Future<void> cancelOrder() async {
    AppDio.get(endPoint: '${EndPoints.orders}/${widget.id}/cancel');
  }
}
