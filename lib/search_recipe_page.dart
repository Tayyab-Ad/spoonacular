import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:spoonacular_demo/fav_recipes.dart';
import 'package:spoonacular_demo/recipe_detail.dart';
import 'package:spoonacular_demo/search_controller.dart';


class SearchRecipe extends StatefulWidget {
  const SearchRecipe({super.key});

  @override
  State<SearchRecipe> createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {
  final controller = Get.put(RecipeController());
  
  TextEditingController searchCtrl = TextEditingController();

  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return  Scaffold(
      appBar: AppBar( title:const Text("Search Recipe", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),), centerTitle: true,),
      body:  SingleChildScrollView(
        child: Column(
              children: [
                const SizedBox(height: 20),
                searchField(),
                GetX<RecipeController>(
                  builder: (ctrl) {
                    return ctrl.isLoading.value?  Container(
                      height: height*0.7,
                      child: Center(child: CircularProgressIndicator())):recipeItems();
                  }
                      ),
              ],
            ),
      ),
          floatingActionButton: FloatingActionButton(
            
        child: const Icon(Icons.favorite),
        onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (_)=> const FavouriteRecipes()));

      }),
    );
  }

  Widget searchField(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:  TextField(
        
        controller: searchCtrl,
        decoration:   InputDecoration(
          suffixIcon: GestureDetector(
            onTap: ()async{

              if(searchCtrl.text.isEmpty){
          return;
        }

        FocusScope.of(context).unfocus();

        await controller.fetchRecipes(searchCtrl.text.trim());

            },
            child: const Icon(Icons.search)),
          hintText: 'Type your recipe here',
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget recipeItems(){
    
    return GetX<RecipeController>(
                builder: (ctrl) {
                  return ctrl.isLoading.value? const CircularProgressIndicator():ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ctrl.spoonacularModel?.results.length??0,
                    itemBuilder: (context, index){
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 0.05*width),
                      leading: Container(height: 50,width: 50,
                      decoration: BoxDecoration(
                        // color: Colors.amber,

                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(image: NetworkImage(ctrl.spoonacularModel?.results[index].image??"", ),fit: BoxFit.fill)
                      ),
                      ),
                      title: Text(ctrl.spoonacularModel?.results[index].title?? ""),
                      subtitle: Text("Serving : ${ctrl.spoonacularModel?.results[index].servings}"),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> ReecipeDetail(ctrl.spoonacularModel?.results[index])));
                      },
                    );
                  }, separatorBuilder: (context, indes){
    return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 0.05*width),
                  child: const Divider(
                    height: 5,
                    thickness: 1,
                    color: Colors.grey,
                  ),
    );
                  });
                }
                    
     );
  }

}



