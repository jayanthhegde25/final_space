import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../commoms/default_row.dart';
import '../controllers/final_space_controller.dart';
import '../models/episode_model.dart';
import '../services/locator_service.dart';

class SeasonsPage extends StatefulWidget {
  const SeasonsPage({super.key});

  @override
  State<SeasonsPage> createState() => _SeasonsPageState();
}

class _SeasonsPageState extends State<SeasonsPage> {

  final _controller = locator.get<FinalSpaceController>();
  final TextEditingController _searchController = TextEditingController();
  List<EpisodeModel> displayedItems = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void _onSearchChanged() {
    setState(() {
      displayedItems = _controller.episodes
          .where((item) =>
          item.name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episodes'),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Observer(
            builder: (context) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  FutureBuilder<List<EpisodeModel>>(
                    future: _controller.getEpisode(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        _controller.episodes = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _searchController.text.isEmpty ? _controller.episodes.length :displayedItems.length,
                          itemBuilder: (context, index) {
                            final episodes = _searchController.text.isEmpty ?_controller.episodes[index]: displayedItems[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _controller.selectedIndex=index;
                                });
                                // dialog();
                              },
                              child: Container(
                                height: 150,
                                margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 130.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        image: DecorationImage(
                                          image: NetworkImage(episodes.imgUrl ??
                                              "https://finalspaceapi.com/api/character/avatar/time_swap_sammy.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            DefaultRow(name:episodes.name,label:'Chapter : ',fontSize:14.sp,fontSize2:  16.sp),
                                          SizedBox(height: 6.h,),
                                          DefaultRow(name:episodes.director,label:'Director : ',fontSize:13.sp,fontSize2:14.sp),
                                          SizedBox(height: 6.h,),
                                          DefaultRow(name:episodes.writer,label:'Writer : ',fontSize:13.sp,fontSize2:14.sp),
                                          SizedBox(height: 6.h,),
                                          DefaultRow(name:episodes.airDate,label:'Release Date : ',fontSize:12.sp,fontSize2:12.sp)
                                          ]
                                        ),
                                      ),
                                    ),
                                    // Icon(Icons.arrow_forward_ios_outlined,size: 34.sp,color: Colors.grey,)
                                  ],
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
                  )
                ],
              );
            }
        ),
      )
    );
  }
}
