
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task33_complete_from_my_frien/models/app_endpoints.dart';
import 'package:task33_complete_from_my_frien/models/category_details_response.dart';
import 'package:task33_complete_from_my_frien/models/favorite.dart';
import 'package:task33_complete_from_my_frien/models/home_response.dart';
import 'package:task33_complete_from_my_frien/screens/cart_screen.dart';
import 'package:task33_complete_from_my_frien/screens/product_screen.dart';
import 'package:task33_complete_from_my_frien/utils/app_dio.dart';
class CategoryScreen extends StatefulWidget {
  final num id;
  final String name;
  const CategoryScreen({super.key, required this.id, required this.name});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}
class _CategoryScreenState extends State<CategoryScreen> {
  List<DataListCategoryDetails> products = [];
  List<Favorite> iconsToggle = [];
  @override
  void initState() {
    super.initState();
    getCategoryDetails();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      backgroundColor: Colors.white
      ,
      appBar: AppBar
        (
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white
        ,
        elevation:
        0
        ,
        leading: IconButton
          (
          onPressed: () {
            Navigator.pop(context, iconsToggle
            )
            ;

          }
          ,
          highlightColor: Colors.transparent
          ,
          splashColor: Colors.transparent
          ,
          icon: Icon
            (
            Icons.arrow_back_ios
            ,
            size: 22
                .sp
            ,
            color: Colors.orange
            ,

          )
          ,

        )
        ,
        title: Text
          (
          widget
              .name
          ,
          style: TextStyle
            (
            fontSize: 19
                .sp
            ,
            color: Colors.orange
            ,
            fontWeight: FontWeight.bold
            ,

          )
          ,

        )
        ,
        centerTitle: true,
        actions: [
          IconButton
            (
            onPressed: () {
              Navigator.push
                (
                context
                ,
                MaterialPageRoute
                  (
                  builder: (context) => const CartScreen()
                  ,

                )
                ,

              )
              ;

            }
            ,
            highlightColor: Colors.transparent
            ,
            splashColor: Colors.transparent
            ,
            icon: Icon
              (
              Icons.shopping_cart_outlined
              ,
              size: 22
                  .sp
              ,
              color: Colors.orange
              ,

            )
            ,

          )
          ,

        ]
        ,

      )
      ,
      body: Padding
        (
        padding: EdgeInsets
            .only
          (
          top: 10
              .sp
          ,
          right: 12
              .sp
          ,
          left: 12
              .sp
          ,

        )
        ,
        child: productItemBuilder()
        ,

      )
      ,

    )
    ;

  }
  Widget productItemBuilder() {
    return ListView
        .builder
      (
        itemCount: products
            .length
        ,
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
                        product: Products.fromDataListCategoryDetails(
                            products[index + 1 == products.length &&
                                products.length % 2 != 0
                                ? index
                                : index - 1]),
                        iconToggle: iconsToggle[
                        index + 1 == products.length &&
                            products.length % 2 != 0
                            ? index
                            : index - 1]
                            .toggle,
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
                  padding: EdgeInsets.all(15.sp),
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
                      ),
                      Visibility(
                        visible:
                        products[index].discount > 0 ? true : false,
                        child: Row(
                          children: [
                            Text(
                              "${products[index].oldPrice} EGP",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.sp,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.sp,
                                vertical: 12.sp,
                              ),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(
                                      253, 151, 1, 0.6),
                                  borderRadius:
                                  BorderRadius.circular(8.sp)),
                              child: Text(
                                "${products[index].discount}%",
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
                      product:
                      Products.fromDataListCategoryDetails(
                          products[index]),
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
                padding: EdgeInsets.all(15.sp),
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
                    Visibility(
                      visible: products[index].discount > 0
                          ? true
                          : false,
                      child: Row(
                        children: [
                          Text(
                            "${products[index].oldPrice} EGP",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.sp,
                              decoration:
                              TextDecoration.lineThrough,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.sp,
                              vertical: 12.sp,
                            ),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(
                                    253, 151, 1, 0.6),
                                borderRadius:
                                BorderRadius.circular(8.sp)),
                            child: Text(
                              "${products[index].discount}%",
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
              ),
            ),
          ),
        ],
      )
          : const SizedBox();
    },
    );
  }
  Future<void> getCategoryDetails() async {
    final response =
    await AppDio.get(endPoint: '${EndPoints.categories}/${widget.id}');
    
    final categoryDetailsResponse =
    CategoryDetailsResponse.fromJson(response.data);
    setState(() {
      products = categoryDetailsResponse.data.data;
      for (int i = 0; i < products.length; i++) {
        iconsToggle.add(
          Favorite(
            id: categoryDetailsResponse.data.data[i].id,
            toggle: categoryDetailsResponse.data.data[i].inFavorites,
          ),
        );
      }
    });
  }
  Future<void> setFavourite(int index) async {
    await AppDio.post(
      endPoint: EndPoints.favorites,
      body: {'product_id': products[index].id},
    );
  }
}
