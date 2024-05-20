import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavouriteRecipes extends StatefulWidget {
  const FavouriteRecipes({super.key});

  @override
  State<FavouriteRecipes> createState() => _FavouriteRecipesState();
}

class _FavouriteRecipesState extends State<FavouriteRecipes> {
     Box? box;

  @override
  void initState() {
   openBox();
    super.initState();
  }

  bool _isLoaded = false;
  var items;



  Future openBox()async{
    
    box = await Hive.openBox('hive_box');
     items = box?.values.toList().reversed.toList();
    _isLoaded = true;
    setState(() {
      
    });
    print("hive items :: ${items?.length}");
    
  }


  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
        height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar:  AppBar(title:const Text("Favourite Recipes", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),), centerTitle: true,),

      body:_isLoaded?  SingleChildScrollView(
        child: ListView.separated(
          padding: EdgeInsets.only(top: 20),
          itemCount:items.length??0,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index){
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0.05*width),
            leading: Container(height: 50,width: 50,
            decoration: BoxDecoration(
              // color: Colors.amber,
      
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(image: NetworkImage(items[index].RecipeImage??"", ),fit: BoxFit.fill)
            ),
            ),
            title: Text(items[index].RecipeTitle?? ""),
            onTap: (){
            },
          );
        }, separatorBuilder: (context, indes){
          return Padding(
        padding:  EdgeInsets.symmetric(horizontal: 0.05*width),
        child: const Divider(
          height: 10,
          thickness: 1,
          color: Colors.grey,
        ),
          );
        }),
      ) : SizedBox.shrink()
    );
  }
}