import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spoonacular_demo/spoonacular_model.dart';


class RecipeController extends GetxController {

  SpoonacularModel? spoonacularModel;
  // RxnBool isLoading = RxnBool(true);
   RxBool isLoading = false.obs;
  


  fetchRecipes(String text)async{
    isLoading.value = true;
    // update();

    String url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=1cfdeeb8785d4758942fb8cde3998928&query=$text&instructionsRequired=true&fillIngredients=true&addRecipeInformation=true&addRecipeInstructions=true";
    final response = await http.get(Uri.parse(url));
    spoonacularModel =  spoonacularModelFromJson(response.body);

     isLoading.value = false;
    // update();


    // print("response is :: ${spoonacularModel?.results.first.title}");
  }
}