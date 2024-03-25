import 'dart:math';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task33_complete_from_my_frien/database/shared_prefrences.dart';
import 'package:task33_complete_from_my_frien/models/app_endpoints.dart';
import 'package:task33_complete_from_my_frien/models/category_response.dart';
import 'package:task33_complete_from_my_frien/models/favorite.dart';
import 'package:task33_complete_from_my_frien/models/home_response.dart';
import 'package:task33_complete_from_my_frien/models/notification_response.dart';
import 'package:task33_complete_from_my_frien/screens/cart_screen.dart';
import 'package:task33_complete_from_my_frien/screens/category_screen.dart';
import 'package:task33_complete_from_my_frien/screens/product_screen.dart';
import 'package:task33_complete_from_my_frien/utils/app_dio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> userName =
      PreferenceUtils.getString(PrefKeys.userName).split(" ");
  num totalNotifications = 0;
  Banners banner = Banners();
  List<DataListCategory> categories = [];
  List<Banners> banners = [];
  List<Products> products = [];
  List<Favorite> iconsToggle = [];
  @override
  void initState() {
    super.initState();
    getTotalNotifications();
    getCategories();
    getHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome, ',
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: userName[0],
                    style: TextStyle(
                      fontSize: 19.sp,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "What would you like to buy today?",
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {},
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.notifications_active_outlined,
                  size: 22.sp,
                ),
              ),
              Positioned(
                bottom: 15.sp,
                right: 2.sp,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 1.sp,
                    horizontal: 8.sp,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(500),
                  ),
                  child: Text(
                    " $totalNotifications ",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 10.sp,
          right: 12.sp,
          left: 12.sp,
        ),
        child: ListView(
          children: [
            categoryItemBuilder(),
            bannerItemBuilder(),
            productItemBuilder(),
          ],
        ),
      ),
    );
  }

  Widget categoryItemBuilder() {
    return SizedBox(
      height: 38.sp,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    id: categories[index].id,
                    name: categories[index].name,
                  ),
                ),
              ).then((value) {
                setState(() {
                  for (int i = 0; i < iconsToggle.length; i++) {
                    for (int j = 0; j < value.length; j++) {
                      if (iconsToggle[i].id == value[j].id) {
                        iconsToggle[i].toggle = value[j].toggle;
                      }
                    }
                  }
                });
              });
            },
            child: Container(
              width: 50.sp,
              margin: EdgeInsets.only(right: 10.sp),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.sp),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Image.network(
                      categories[index].image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: const Color.fromRGBO(126, 126, 127, 0.5),
                    ),
                  ),
                  Text(
                    categories[index].name,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getCategories() async {
    final response = await AppDio.get(endPoint: EndPoints.categories);
    final categoryResponse = CategoryResponse.fromJson(response.data);
    setState(() {
      categories = categoryResponse.data.data;
    });
  }

  Widget bannerItemBuilder() {
    return Container(
      height: 65.sp,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.sp)),
      child: Visibility(
        visible: banner.image == '' ? false : true,
        child: Image.network(
          banner.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget productItemBuilder() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return index * 2 < products.length
            ? Row(
                children: [
                  Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                              product: products[index + 1 == products.length && products.length % 2 != 0? index: index - 1],
                              iconToggle: iconsToggle[index + 1 == products.length &&products.length % 2 != 0 ? index: index - 1].toggle,
                            ),
                          ),
                        ).then((value) {
                          setState(() {
                            iconsToggle[index - 1].toggle = value;
                          });
                        });
                      },
                      child: Container(
                        height: 70.sp,
                        padding: EdgeInsets.all(10.sp),
                        margin: EdgeInsets.only(bottom: 10.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(16.sp),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                products[index = index * 2].image,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Text(
                              products[index].name,
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  "${products[index].price.toString()} EGP",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (index + 1 == products.length &&
                                          products.length % 2 != 0) {
                                        iconsToggle[index].toggle =
                                            !iconsToggle[index].toggle;
                                        setFavourite(index);
                                      } else {
                                        iconsToggle[index - 1].toggle =
                                            !iconsToggle[index - 1].toggle;
                                        setFavourite(index - 1);
                                      }
                                    });
                                  },
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(
                                    iconsToggle[index].toggle
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.sp),
                  Expanded(
                    child: index + 1 == products.length
                        ? const SizedBox()
                        : InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductScreen(
                                    product: products[index],
                                    iconToggle: iconsToggle[index].toggle,
                                  ),
                                ),
                              ).then((value) {
                                setState(() {
                                  iconsToggle[index].toggle = value;
                                });
                              });
                            },
                            child: Container(
                              height: 70.sp,
                              padding: EdgeInsets.all(10.sp),
                              margin: EdgeInsets.only(bottom: 10.sp),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(16.sp),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      products[++index].image,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Text(
                                    products[index].name,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${products[index].price.toString()} EGP",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            iconsToggle[index].toggle =
                                                !iconsToggle[index].toggle;
                                            setFavourite(index);
                                          });
                                        },
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        icon: Icon(
                                          iconsToggle[index].toggle
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              )
            : const SizedBox();
      },
    );
  }

  Future<void> getHome() async {
    final response = await AppDio.get(endPoint: EndPoints.home);
    final homeResponse = HomeResponse.fromJson(response.data);
    setState(() {
      banners = homeResponse.data.banners;
      products = homeResponse.data.products;
      for (int i = 0; i < products.length; i++) {
        iconsToggle.add(
          Favorite(
            id: homeResponse.data.products[i].id,
            toggle: homeResponse.data.products[i].inFavorites,
          ),
        );
      }
      banner = banners[Random().nextInt(banners.length)];
    },
    );
  }

  Future<void> setFavourite(int index) async {
    await AppDio.post(
      endPoint: EndPoints.favorites,
      body: {'product_id': products[index].id},
    );
  }

  Future<void> getTotalNotifications() async {
    final response = await AppDio.get(endPoint: EndPoints.notifications);
    final notificationResponse = NotificationResponse.fromJson(response.data);
    setState(() {
      totalNotifications = notificationResponse.data.total;
    });
  }
}
