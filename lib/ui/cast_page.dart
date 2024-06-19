import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../commoms/default_row.dart';
import '../controllers/final_space_controller.dart';
import '../models/characters_model.dart';
import '../services/locator_service.dart';

class CastPage extends StatefulWidget {
  const CastPage({super.key});

  @override
  State<CastPage> createState() => _CastPageState();
}

class _CastPageState extends State<CastPage> {
  final TextEditingController _searchController = TextEditingController();
  List<CharactersModel> displayedItems = [];

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
      displayedItems = _controller.characters
          .where((item) =>
          item.name!.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
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
                FutureBuilder<List<CharactersModel>>(
                  future: _controller.getCharacters(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _controller.characters = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _searchController.text.isEmpty ? _controller.characters.length :displayedItems.length,
                        itemBuilder: (context, index) {
                          final character = _searchController.text.isEmpty ?_controller.characters[index]: displayedItems[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller.selectedIndex=index;
                              });
                              dialog();
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
                                        image: NetworkImage(character.img_url ??
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
                                          DefaultRow(name: character.name ??"NULL", label: 'Name : ', fontSize: 13.sp, fontSize2: 13.sp,),
                                          SizedBox(height: 6.h),
                                          DefaultRow(name: character.status??"NULL", label: 'Status : ', fontSize: 13.sp, fontSize2: 13.sp,),
                                          SizedBox(height: 6.h),
                                          DefaultRow(name: character.gender??"NULL", label: 'Gender : ', fontSize: 13.sp, fontSize2: 13.sp,),
                                          SizedBox(height: 6.h),
                                          DefaultRow(name: character.species ?? "NULL", label: 'Species : ', fontSize: 13.sp, fontSize2: 13.sp,),
                                          SizedBox(height: 6.h),
                                          DefaultRow(name: character.hair ?? "Null", label: 'Hair : ', fontSize: 13.sp, fontSize2: 13.sp,),
                                          SizedBox(height: 6.h),
                                          DefaultRow(name: character.origin ?? "Null", label: 'Origin : ', fontSize: 13.sp, fontSize2: 13.sp,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_outlined,size: 34.sp,color: Colors.grey,)
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
  Future dialog(){
    return  showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return AlertDialog(
            title: Center(
              child: Text(_controller.characters[_controller.selectedIndex].name!,
                style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.black
                ),
              ),
            ),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250.h,
                    width: 600.w,
                    decoration:BoxDecoration(
                        color: Colors.black,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(width: 1,color: Colors.grey.shade300),
                      image: DecorationImage(image: NetworkImage(_controller.characters[_controller.selectedIndex].img_url??""),
                          fit:BoxFit.cover )
                    ) ,
                  ),
                  SizedBox(height: 30.h,),
                  // DefaultRow(name: _controller.characters[_controller.selectedIndex].name ??"NULL", label: 'Name : ', fontSize: 14.sp, fontSize2: 16.sp,),
                  // SizedBox(height: 6.h),
                  DefaultRow(name: _controller.characters[_controller.selectedIndex].status??"NULL", label: 'Status : ', fontSize: 14.sp, fontSize2: 14.sp,),
                  SizedBox(height: 6.h),
                  DefaultRow(name: _controller.characters[_controller.selectedIndex].gender??"NULL", label: 'Gender : ', fontSize: 14.sp, fontSize2: 14.sp,),
                  SizedBox(height: 6.h),
                  DefaultRow(name: _controller.characters[_controller.selectedIndex].species ?? "NULL", label: 'Species : ', fontSize: 14.sp, fontSize2: 14.sp,),
                  SizedBox(height: 6.h),
                  DefaultRow(name: _controller.characters[_controller.selectedIndex].hair ?? "Null", label: 'Hair : ', fontSize: 14.sp, fontSize2: 14.sp,),
                  SizedBox(height: 6.h),
                  DefaultRow(name: _controller.characters[_controller.selectedIndex].origin ?? "Null", label: 'Origin : ', fontSize: 14.sp, fontSize2: 14.sp,),
                  SizedBox(height: 12.h),
                  Text("Abilities : ",
                   style: TextStyle(
                       fontSize: 14.sp,
                       fontWeight: FontWeight.w500,
                       color: Colors.grey[900]),),
                  SizedBox(height: 2.h),
                  list(_controller.characters[_controller.selectedIndex].abilities!,),
                  SizedBox(height: 12.h),
                  Text("Alias : ",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[900]),),
                  SizedBox(height: 2.h),
                  list(_controller.characters[_controller.selectedIndex].alias!,),

                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget list(List listname){
    return  Container(
      // color: Colors.red,
      height: 130.h,
      width: 400.w,
      child: ListView.builder(
        padding:EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listname.length,
          itemBuilder: (context,index){
            var names = listname[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(names,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700]),),
                SizedBox(height: 2.h),
              ],
            );

          }),);
  }
}