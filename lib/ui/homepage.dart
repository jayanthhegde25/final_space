import 'package:find_space/ui/cast_page.dart';
import 'package:find_space/ui/seasons_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/final_space_controller.dart';
import '../models/characters_model.dart';
import '../models/episode_model.dart';
import '../services/locator_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _controller = locator.get<FinalSpaceController>();

  @override
  void initState() {
    super.initState();
    _controller.getCharacters();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Observer(
              builder: (context) {
                return Column(
                  children: [
                    Container(
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 18.w),
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
                          Text("Character",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),
                          SizedBox(height: 14.h,),
                          SizedBox(
                            height: 200,
                            child:FutureBuilder<List<CharactersModel>>(
                              future: _controller.getCharacters(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final characters = snapshot.data!;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: characters.length > 4 ? 5 : characters.length,
                                    itemBuilder: (context, index) {
                                      final character = characters[index];
                                      if (index == 4) {
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const CastPage(),
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
                                                        // border: Border.all(width: 1,color: Colors.black)
                                                    ),
                                                    child: Icon(Icons.arrow_forward,size: 30.sp,color: Colors.black,)
                                                ),
                                              ),
                                              SizedBox(height: 40.h,),

                                            ],
                                          ),
                                        );
                                      }
                                      return Column(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            margin: const EdgeInsets.symmetric(horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                              border: Border.all(width: 1,color: Colors.grey),
                                              borderRadius: BorderRadius.circular(20),
                                              image: DecorationImage(image: NetworkImage(character.img_url??"https://finalspaceapi.com/api/character/avatar/time_swap_sammy.jpg"))
                                            ),
                                            // child: Image.network(character.img_url??"https://finalspaceapi.com/api/character/avatar/time_swap_sammy.jpg"),
                                          ),
                                          SizedBox(height: 2.h,),
                                          Center(
                                            child: SizedBox(
                                              width: 100,
                                              child: Center(
                                                child: Text(character.name??"-",
                                                  style:  TextStyle(color: Colors.black,fontSize: 14.sp),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Center(child: CircularProgressIndicator());
                                }
                              },
                            )
                          //
                          //   ListView.builder(
                          //     scrollDirection: Axis.horizontal,
                          //     shrinkWrap: true,
                          //       itemCount:  9,
                          //       itemBuilder: (context,index){
                          //         if (index == 4) {
                          //           return GestureDetector(
                          //             onTap: (){
                          //               // Navigator.push(
                          //               //   context,
                          //               //   MaterialPageRoute(
                          //               //     builder: (context) => MoreItemsPage(items: _controller.charList),
                          //               //   ),
                          //               // );
                          //             },
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               crossAxisAlignment: CrossAxisAlignment.center,
                          //               children: [
                          //                 Center(
                          //                   child: Container(
                          //                     padding: EdgeInsets.symmetric(vertical: 6.h,horizontal: 12.w),
                          //                     decoration: BoxDecoration(
                          //                       borderRadius: BorderRadius.circular(14),
                          //                       border: Border.all(width: 1,color: Colors.black)
                          //                     ),
                          //                     child: Icon(Icons.arrow_forward,size: 24.sp,color: Colors.black,)
                          //                   ),
                          //                 ),
                          //                 SizedBox(height: 4.h,),
                          //
                          //               ],
                          //             ),
                          //           );
                          //         }
                          //         return Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Container(
                          //               height: 100,
                          //               width: 100,
                          //               margin: const EdgeInsets.symmetric(horizontal: 8),
                          //               decoration: BoxDecoration(
                          //                   color: Colors.blue,
                          //                 image: DecorationImage(image: NetworkImage(''))
                          //
                          //               ),
                          //             ),
                          //             SizedBox(height: 2.h,),
                          //             SizedBox(
                          //               width: 100,
                          //               child: Center(
                          //                 child: Text(
                          //                   "gffg",
                          //                   style: const TextStyle(color: Colors.black),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         );
                          //   }),
                          ),
                          SizedBox(height: 14.h,),
                          Text("Episodes",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),
                          SizedBox(height: 12.h,),
                          season()
                        ],
                      ),
                    )
                  ],
                );
              }
            ),
          )
      ),
    );
  }
  Widget season(){
    return FutureBuilder<List<EpisodeModel>>(
      future: _controller.getEpisode(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final episodes = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              final episode = episodes[index];
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
                  height: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(width: 1,color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(image: NetworkImage(episode.imgUrl))
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }
}
