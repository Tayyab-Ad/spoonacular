import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:spoonacular_demo/db/favourites.dart';
import 'package:spoonacular_demo/spoonacular_model.dart';

class ReecipeDetail extends StatefulWidget {
   ReecipeDetail(this.recpipe, {super.key});
  
  RecipeData? recpipe;

  @override
  State<ReecipeDetail> createState() => _ReecipeDetailState();
}

class _ReecipeDetailState extends State<ReecipeDetail> {
  late double height;
  late double width;
  Box? box;
  bool isalreadyadded = false;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {    
      
      openBox();
 });

  }



  Future openBox()async{
    
    box = await Hive.openBox('hive_box');
    var items = box?.values.toList().reversed.toList();

     items?.forEach((element) {
      if(element.recipeId == widget.recpipe?.id){
        print(" it is added");
        isalreadyadded =    true;
        return;
      }
     });
     setState(() {
       
     });
    print("hive items :: ${items?.length}");
    
  }

  @override
  Widget build(BuildContext context) {
    
        height = MediaQuery.of(context).size.height;
        width = MediaQuery.of(context).size.width;
        // ModalRoute.of(context).settings.
    return  Scaffold(
      appBar: AppBar(title: Text("${widget.recpipe?.title??""}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),), centerTitle: true,),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 0.05*width),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 0.25*height,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.amber,
              
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(image: NetworkImage(widget.recpipe?.image??"", ),fit: BoxFit.fill)
                  ),
              ),
              const SizedBox(height: 15,),
              const Text("Ingedients", style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 15,),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.recpipe?.missedIngredients.length??0,
                itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(children: [
                    Container(
                  height: 0.1*width,
                  
                  width: 0.1*width,
                  decoration: BoxDecoration(
                      // color: Colors.amber,
                            
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: NetworkImage(widget.recpipe?.missedIngredients[index].image ??"", ),fit: BoxFit.fill)
                    ),
                              ),
                              const SizedBox(width: 10,),
                    SizedBox(
                      width: 0.6*width,
                      child: Text("${widget.recpipe?.missedIngredients[index].originalName}", style: const TextStyle(fontWeight: FontWeight.w500),)),
                    const Spacer(),
                    Text("${widget.recpipe?.missedIngredients[index].amount}", style: const TextStyle(fontWeight: FontWeight.w500),),
                    
                  ],),
                );
              }),
               const SizedBox(height: 15,),
              const Text("Instructions / Steps", style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 15,),
              widget.recpipe!.analyzedInstructions.first.steps.isEmpty?const Text("N/A", style: TextStyle(fontWeight: FontWeight.w600),):  ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.recpipe?.analyzedInstructions.first.steps.length??0,
                itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(children: [
                    
                              const SizedBox(width: 10,),
                    SizedBox(
                      width: 0.8*width,
                      child: Text("* ${widget.recpipe?.analyzedInstructions.first.steps[index].step}", style: const TextStyle(fontWeight: FontWeight.w400),)),
                  ],),
                );
              })
            ],
          ),
        ),
      ),
      floatingActionButton: isalreadyadded? null:  FloatingActionButton(
        child: const Icon(Icons.favorite),
        onPressed: (){
          if(isalreadyadded){
            print("recipe already added");
            return;
          }

         DataModel recipeDdata= DataModel(recipeId: widget.recpipe?.id,RecipeImage: widget.recpipe?.image,RecipeTitle: widget.recpipe?.title);
          box?.add(recipeDdata);
           var snackBar = const SnackBar(content: Text("Recipe adde to favourites"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
          isalreadyadded = true;
          setState(() {
            
          });
      }),
    )
    ;
  }
}