
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task33_complete_from_my_frien/models/app_endpoints.dart';
import 'package:task33_complete_from_my_frien/models/order_response.dart';
import 'package:task33_complete_from_my_frien/screens/order_detail_screen.dart';
import 'package:task33_complete_from_my_frien/utils/app_dio.dart';
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}
class _OrdersScreenState extends State<OrdersScreen> {
  List<DataListOrder> orders = [];
  @override
  void initState() {
    super.initState();
    getOrders();
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
          "Orders",
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ordersItemBuilder(),
    );
  }
  Widget ordersItemBuilder() {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderDetailsScreen(id: orders[index].id),
            ),
            ).then((value) => getOrders());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15.sp),
            margin: EdgeInsets.symmetric(
              vertical: 10.sp,
              horizontal: 20.sp,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 242, 219, 0.8),
              borderRadius: BorderRadius.circular(16.sp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  orders[index].date,
                  style: TextStyle(fontSize: 18.sp),
                ),
                Text(
                  orders[index].total.toStringAsFixed(2),
                  style: TextStyle(fontSize: 18.sp),
                ),
                Text(
                  orders[index].status,
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> getOrders() async {
    final response = await AppDio.get(endPoint: EndPoints.orders);
    final orderResponse = OrderResponse.fromJson(response.data);
    setState(() {
      orders = orderResponse.data.data;
    });
  }
}
