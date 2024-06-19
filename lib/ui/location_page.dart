import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../commoms/default_row.dart';
import '../controllers/final_space_controller.dart';
import '../models/location_model.dart';
import '../services/locator_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController _searchController = TextEditingController();
  List<LocationModel> displayedItems = [];

  final _controller = locator.get<FinalSpaceController>();

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

  void _onSearchChanged() {
    setState(() {
      displayedItems = _controller.locations
          .where((item) =>
          item.name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                  FutureBuilder<List<LocationModel>>(
                    future: _controller.getLocation(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        _controller.locations = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _searchController.text.isEmpty ? _controller.locations.length :displayedItems.length,
                          itemBuilder: (context, index) {
                            final locations = _searchController.text.isEmpty ?_controller.locations[index]: displayedItems[index];
                            return GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   _controller.selectedIndex = index;
                                // });
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
                                          image: NetworkImage(locations.imgUrl ??
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
                                        width: 180.w,
                                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            DefaultRow(name: locations.name ??"NULL", label: 'Name : ', fontSize: 14.sp, fontSize2: 14.sp,),
                                            SizedBox(height: 6.h),
                                            DefaultRow(name: locations.type??"NULL", label: 'Status : ', fontSize: 14.sp, fontSize2: 14.sp,),
                                            SizedBox(height: 6.h),
                                            // DefaultRow(name: locations.??"NULL", label: 'Gender : ', fontSize: 13.sp, fontSize2: 13.sp,),
                                            Text("Inhabitants : ",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                              ),
                                            ),
                                            SizedBox(height: 4.h,),
                                            SizedBox(
                                              height: 100.h,
                                              child: ListView.builder(
                                              shrinkWrap: true,
                                                itemCount:locations.inhabitants.length ,
                                                  itemBuilder: (context,index){
                                                var items  = locations.inhabitants[index];
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(items,
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.grey[700],
                                                      ),
                                                    ),
                                                    SizedBox(height: 2.h,),
                                                  ],

                                                );

                                              }),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
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
      ),
    );
  }

}
