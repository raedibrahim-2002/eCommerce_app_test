
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:task33_complete_from_my_frien/models/app_endpoints.dart';
import 'package:task33_complete_from_my_frien/models/favorite.dart';
import 'package:task33_complete_from_my_frien/models/favorite_response.dart';
import 'package:task33_complete_from_my_frien/models/home_response.dart';
import 'package:task33_complete_from_my_frien/screens/product_screen.dart';
import 'package:task33_complete_from_my_frien/utils/app_dio.dart';
class SavedItems extends StatefulWidget {
  const SavedItems({super.key});
  @override
  State<SavedItems> createState() => _SavedItemsState();
}
class _SavedItemsState extends State<SavedItems> {
  List<Favorite> iconsToggle = [];
  List<DataListFavorite> products = [];
  @override
  void initState() {
    super.initState();
    getFavorite();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Saved Items",
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: savedItemsBuilder(),
    );
  }
  Widget savedItemsBuilder() {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(
                  product: Products.fromDataListFavorite(products[index]),
                  iconToggle: iconsToggle[index].toggle,
                ),
              ),
            ).then((value) {
              setState(() {
                getFavorite();
              });
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15.sp),
            margin: EdgeInsets.symmetric(
              vertical: 10.sp,
              horizontal: 10.sp,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.sp),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  products[index].product.image,
                  width: 35.sp,
                  height: 35.sp,
                ),
                SizedBox(width: 15.sp),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                  products[index].product.name,
                    style: TextStyle(
                      fontSize: 17.sp,
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Row(
                    children: [
                  Text(
                  "${products[index].product.price}",
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10.sp),
                  Visibility(
                    visible: products[index].product.discount > 0
                        ? true
                        : false,
                    child: Row(
                      children: [
                    Text(
                    "${products[index].product.oldPrice}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.sp,
                          vertical: 10.sp,
                        ),
                        decoration: BoxDecoration(
                    color:
                    const Color.fromRGBO(253, 151, 1, 0.6),
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Text(
                    "${products[index].product.discount}%",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
        ],
        ),
        ),
        IconButton(
        onPressed: () {
        setState(() {
        iconsToggle[index].toggle = !iconsToggle[index].toggle;
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
        ),
        );
      },
    );
  }
  Future<void> setFavourite(int index) async {
    await AppDio.post(
      endPoint: EndPoints.favorites,
      body: {'product_id': products[index].product.id},
    );
  }
  Future<void> getFavorite() async {
    final response = await AppDio.get(endPoint: EndPoints.favorites);
    final favoriteResponse = FavoriteResponse.fromJson(response.data);
    setState(() {
      products = favoriteResponse.data.data;
      iconsToggle.clear();
      for (int i = 0; i < products.length; i++) {
        iconsToggle.add(
          Favorite(
            id: favoriteResponse.data.data[i].id,
            toggle: true,
          ),
        );
      }
    });
  }
}