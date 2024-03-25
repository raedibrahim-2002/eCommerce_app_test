import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task33_complete_from_my_frien/models/app_endpoints.dart';
import 'package:task33_complete_from_my_frien/models/home_response.dart';
import 'package:task33_complete_from_my_frien/screens/cart_screen.dart';
import 'package:task33_complete_from_my_frien/utils/app_dio.dart';

class ProductScreen extends StatefulWidget {
  final Products product;
  final bool iconToggle;
  const ProductScreen(
      {super.key, required this.product, required this.iconToggle});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool iconToggle = false;
  bool inCart = false;
  @override
  void initState() {
    super.initState();
    iconToggle = widget.iconToggle;
    inCart = widget.product.inCart;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, iconToggle);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(
            Icons.arrow_back_ios,
            size: 22.sp,
            color: Colors.orange,
          ),
        ),
        title: Text(
          widget.product.name,
          style: TextStyle(
            fontSize: 19.sp,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 22.sp,
              color: Colors.orange,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          productItemBuilder(),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
              vertical: 16.sp,
            ),
            child: SizedBox(
              height: 30.sp,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    setItemToCart();
                    inCart = !inCart;
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                ),
                child: Text(
                  inCart ? 'Remove From Cart' : 'Add To Cart',
                  style: TextStyle(
                      fontSize: 19.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> setFavourite() async {
    await AppDio.post(
      endPoint: EndPoints.favorites,
      body: {'product_id': widget.product.id},
    );
  }

  Widget productItemBuilder() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        child: ListView(
          children: [
            Image.network(
              widget.product.image,
              fit: BoxFit.contain,
              height: 70.sp,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                        fontSize: 19.sp,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      iconToggle = !iconToggle;
                      setFavourite();
                    });
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    iconToggle
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.sp),
            Row(
              children: [
                Text(
                  "${widget.product.price} EGP",
                  style: TextStyle(
                    fontSize: 19.sp,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: widget.product.discount > 0 ? true : false,
                  child: Row(
                    children: [
                      Text(
                        "${widget.product.oldPrice} EGP",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 10.sp),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.sp,
                          vertical: 12.sp,
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(253, 151, 1, 0.6),
                            borderRadius: BorderRadius.circular(8.sp)),
                        child: Text(
                          "${widget.product.discount}%",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.sp),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 19.sp,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.sp),
                Text(
                  widget.product.description,
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> setItemToCart() async {
    await AppDio.post(
      endPoint: EndPoints.carts,
      body: {"product_id": widget.product.id},
    );
  }
}
