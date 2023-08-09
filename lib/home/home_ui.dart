import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_sample/common/extention.dart';
import 'package:ui_sample/common/product.dart';

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});
}

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: kToolbarHeight + 66,
          flexibleSpace: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.transparent,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu_outlined),
                      Icon(Icons.notifications),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Perfect Shoes",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "For Perfect Style",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 10,
              backgroundColor: Colors.grey.shade200,
              floating: true,
              toolbarHeight: kToolbarHeight + 80,
              flexibleSpace: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.transparent,
                child: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: kToolbarHeight - 10,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              SizedBox(width: 15),
                              Icon(Icons.search),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Cari produk...",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor),
                        child: const Icon(
                          Icons.settings_input_composite,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: SizedBox(
                  height: 50,
                  child: Categories(),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 190),
                itemBuilder: (context, index) {
                  final p = Product.list()[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 3 / 2,
                            child: Image.asset(
                              p.image,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  p.price.toInt().toRupiah(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.red),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: Product.list().length,
              ),
            )
            // SliverList.builder(
            //   itemBuilder: (context, index) {
            //     return Container(
            //       margin: const EdgeInsets.all(10),
            //       padding: const EdgeInsets.all(10),
            //       color: Colors.amber,
            //       height: 50,
            //       width: 100,
            //       child: Text("Yellow $index"),
            //     );
            //   },
            //   itemCount: Product.list().length,
            // ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.zero,
          height: kToolbarHeight,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: kToolbarHeight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: Icon(
                      Icons.home,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: kToolbarHeight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: const Icon(Icons.explore),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: kToolbarHeight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: const Icon(Icons.supervised_user_circle_rounded),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: kToolbarHeight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: const Icon(Icons.settings),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int active = 0;

  final categories = ["Nike", "Puma", "Adidas", "New Balance", "Diadora"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => setState(() {
          active = index;
        }),
        child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: active == index
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).scaffoldBackgroundColor),
            child: Text(
              categories[index],
              style: TextStyle(
                  color: active == index ? Colors.white : Colors.black),
            )),
      ),
      itemCount: categories.length,
    );
  }
}
