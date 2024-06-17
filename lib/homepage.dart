import 'package:find_space/ui/cast_page.dart';
import 'package:find_space/ui/seasons_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<String> items = List<String>.generate(47, (index) => "Item $index");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight:Radius.circular(16) ),
                      image: DecorationImage(
                          image: AssetImage('assets/images/finalSpace1.jpeg'),
                          fit: BoxFit.fill
                      )
                  ),
                  height: 200.h,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                top: 192.h,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(14),topRight:  Radius.circular(14))
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 18.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Final Space",
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 6.h,),
                        Row(
                          children: [
                            Icon(Icons.star,color: Colors.yellow[900],size: 16.sp,),
                            SizedBox(width: 6.w,),
                            Text("8.2/10 \tIMDb",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 6.h,),
                        Row(
                          children: [
                            Text("2016",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]
                              ),
                            ),
                            SizedBox(width: 8.h,),
                            Text("Drama",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]
                              ),
                            ),
                            SizedBox(width: 8.h,),
                            Text("3 Seasons",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[600]
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Text("Description",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 6.h,),
                        Text("Final Space is an epic animated sci-fi comedy about a spaceman named Gary who is working off a prison sentence and makes a mysterious new alien friend, Mooncake, that he immediately bonds with. But what Gary doesn't know is that his adorable new sidekick is actually wanted by the sinister Lord Commander who will stop at nothing to use Mooncake's untapped powers for evil.",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 18.h,),
                        Text("Cast",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 14.h,),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                              itemCount: items.length > 4 ? 5 : items.length,
                              itemBuilder: (context,index){
                                if (index == 4) {
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MoreItemsPage(items: items),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 6.h,horizontal: 12.w),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(14),
                                              border: Border.all(width: 1,color: Colors.black)
                                            ),
                                            child: Icon(Icons.arrow_forward,size: 24.sp,color: Colors.black,)
                                          ),
                                        ),
                                        SizedBox(height: 4.h,),

                                      ],
                                    ),
                                  );
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      color: Colors.blue,
                                    ),
                                    SizedBox(height: 2.h,),
                                    SizedBox(
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                          items[index],
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                          }),
                        ),
                        SizedBox(height: 14.h,),
                        Text("Seasons",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 12.h,),
                        season("Season 1",0),
                        season("Season 2",1),
                        season("Season 3",2),

                      ],
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
  Widget season(String name, int index){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SeasonsPage(),
          ),
        );

      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 4.w),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1,color: Colors.grey))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name,
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
              ),
            ),
            Icon(Icons.arrow_forward_ios_outlined,size: 24.sp,color: Colors.black,)

          ],
        ),

      ),
    );
  }
}
