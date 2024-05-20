// import 'package:hive/hive.dart';
// import 'package:spoonacular_demo/spoonacular_model.dart';


// part 'favourites.g.dart'; 



// @HiveType(typeId: 0)
// class DataModel extends HiveObject{
 
//   @HiveField(0)
//   final List<RecipeData>? recipeData;

//   DataModel({this.recipeData});
// }


import 'package:hive/hive.dart';
import 'package:spoonacular_demo/spoonacular_model.dart';


part 'favourites.g.dart'; 



@HiveType(typeId: 0)
class DataModel extends HiveObject{
 
  @HiveField(0)
  final int? recipeId;
  @HiveField(1)
  final String?  RecipeImage;
  @HiveField(2)
  final String? RecipeTitle;

  DataModel({this.recipeId, this.RecipeImage, this.RecipeTitle});
}