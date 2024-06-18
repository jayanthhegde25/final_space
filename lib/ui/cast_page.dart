import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/final_space_controller.dart';
import '../models/characters_model.dart';
import '../services/locator_service.dart';

class CastPage extends StatefulWidget {
  const CastPage({super.key});

  @override
  State<CastPage> createState() => _CastPageState();
}

class _CastPageState extends State<CastPage> {

   final TextEditingController _searchController =  TextEditingController();
  List<CharactersModel> characters =[];
  List<CharactersModel> displayedItems  =[];

  final _controller = locator.get<FinalSpaceController>();

    // @override
    // void initState() {
    //   super.initState();
    //   _searchController = TextEditingController();
    //   _searchController.addListener(_onSearchChanged);
    // }

    // @override
    // void dispose() {
    //   _searchController.removeListener(_onSearchChanged);
    //   _searchController.dispose();
    //   super.dispose();
    // }

    // void _onSearchChanged() {
    //   setState(() {
    //     displayedItems = characters
    //         .where((item) => item.toLowerCase().contains(_searchController.text.toLowerCase()))
    //         .toList();
    //   });
    // }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Characters'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(
                      color: Colors.black
                  ),
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              FutureBuilder<List<CharactersModel>>(
                future: _controller.getCharacters(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final characters = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: characters.length,
                      itemBuilder: (context, index) {
                        final character = characters[index];
                        return  GestureDetector(
                          onTap: (){
                            setState(() {

                            });
                          },
                          child: Container(
                            height: 150,
                            margin:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                            decoration: BoxDecoration(
                                // color: Colors.blue,
                                border: Border.all(width: 1,color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(20),
                                // image: DecorationImage(image: NetworkImage(character.img_url??"https://finalspaceapi.com/api/character/avatar/time_swap_sammy.jpg"))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image.network(character.img_url??"https://finalspaceapi.com/api/character/avatar/time_swap_sammy.jpg",fit: BoxFit.cover,),
                                SizedBox(width: 12.w,),
                                Container(
                                  // padding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 4.w),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _namesRow(character.name!,'Name : '),
                                        SizedBox(height: 2.h,),
                                        _namesRow(character.status!,'Status : '),
                                        SizedBox(height: 2.h,),
                                        _namesRow(character.gender!,'Gender : '),
                                        SizedBox(height: 2.h,),
                                        _namesRow(character.species??"NULL",'Species : '),
                                        SizedBox(height: 2.h,),
                                        _namesRow(character.hair??"Null",'Hair : '),
                                        SizedBox(height: 2.h,),
                                        _namesRow(character.origin??"Null",'Origin : '),


                                      ],
                                    ),
                                  ),
                                )
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
            ]
          ),
        )
      );

    }

    Widget _namesRow(String name,String label){
      return Row(
        children: [
          Text(label,
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[900]),),
          Container(
            width: 130.w,
            // color: Colors.red,
            child: Text(name,
              style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[900]),),
          ),


        ],

      );
    }

}

