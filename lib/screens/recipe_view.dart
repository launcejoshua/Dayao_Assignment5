import 'package:flutter/material.dart';
import 'package:mad_pinoy_recipes_3b/models/recipe.dart';

class RecipeViewScreen extends StatefulWidget {
  RecipeViewScreen(this.recipe, {super.key});

  Recipe recipe;

  @override
  State<RecipeViewScreen> createState() => _RecipeViewScreenState();
}

class _RecipeViewScreenState extends State<RecipeViewScreen>
    with TickerProviderStateMixin {
  late TabController tab_control;
  

  @override
  void initState() {
    super.initState();
    tab_control = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
      ),
      body: Column(
        children: [
          if (widget.recipe.imageUrl != null)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: AspectRatio(
                aspectRatio: 3 / 2,
                child: Image.network(
                  widget.recipe.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          TabBar(
            controller: tab_control, tabs: [
            Tab(
              icon: Icon(Icons.restaurant_menu_outlined, color: Colors.blue),
              child: Text(
                "Ingredients",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.directions,
                color: Colors.blue,
              ),
              child: Text(
                "Steps",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ]),
          const SizedBox(
            height: 8,
          ),
          Expanded(
              child: TabBarView(
                controller: tab_control,
                 children: [
            Container(
                    margin: const EdgeInsets.all(18),
                    child: ListView.builder(
                      itemCount: widget.recipe.ingredients?.length,
                      shrinkWrap: true,
                      itemBuilder: ((_, index) {
                        return Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 15,
                            ),
                            child: Text(widget.recipe.ingredients![index],
                            style: TextStyle(
                              fontSize: 15,
                                ),
                              ),
                            ), 
                          );
                        }
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(18),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.recipe.steps?.length,
                      itemBuilder: ((_, index){
                    return Card(
                      elevation: 4,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 15,
                        child: Text('${index + 1}'),
                        ),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8
                            ),
                            child: Text(widget.recipe.steps![index],
                            style: TextStyle(
                              fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
