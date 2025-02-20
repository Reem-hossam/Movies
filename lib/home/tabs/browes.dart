import 'package:flutter/material.dart';

class Browes extends StatefulWidget {
  const Browes({super.key});

  @override
  State<Browes> createState() => _BrowesState();
}

class _BrowesState extends State<Browes> {
  List<String> moviesCategories = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Sci-Fi",
    "Horror",
    "Fantasy",
  ];
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
        Column(
          children: [
            SizedBox(height:16 ,),
            Container(
                height: 40,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    width: 16,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectedCategory = index;
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: selectedCategory != index
                                ?  Colors.transparent
                                :Theme.of(context).primaryColor,
                            border: Border.all(
                              color:Theme.of(context).primaryColor,
                              width: 2,

                            ),
                            borderRadius: BorderRadius.circular(18)),
                        child: Text(
                          moviesCategories[index],
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                              color: selectedCategory == index
                                  ? Colors.black
                                  : Theme.of(context).primaryColor),
                        ),
                      ),
                    );
                  },
                  itemCount: moviesCategories.length,
                ),
              ),
          ],
        )
      
      ),
    );
  }
}
