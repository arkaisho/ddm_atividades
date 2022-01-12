import 'package:ddm_atividade_2/data.dart';
import 'package:ddm_atividade_2/item.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To do list"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          showAddModalBottomSheet(context);
        },
      ),
      body: Column(
        children: Data.itemsOnList
            .map(
              (item) => ListItemTile(
                item: Item(
                  title: item.title,
                  description: item.description,
                ),
                onDelete: () {
                  setState(() {
                    Data.itemsOnList.remove(item);
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  void showAddModalBottomSheet(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Card(
            child: SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width - 20,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: "Titulo",
                        label: Text("Titulo"),
                      ),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Descrição",
                        label: Text("Descrição"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        child: const Text("Salvar"),
                        onPressed: () {
                          setState(() {
                            Data.itemsOnList.add(
                              Item(
                                title: titleController.text,
                                description: descriptionController.text,
                              ),
                            );
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showEditModalBottomSheet(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Card(
            child: SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width - 20,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: "Titulo",
                        label: Text("Titulo"),
                      ),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Descrição",
                        label: Text("Descrição"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        child: const Text("Salvar"),
                        onPressed: () {
                          setState(() {
                            Data.itemsOnList.add(
                              Item(
                                title: titleController.text,
                                description: descriptionController.text,
                              ),
                            );
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ListItemTile extends StatefulWidget {
  final Item item;
  final Function onDelete;

  const ListItemTile({
    required this.item,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  State<ListItemTile> createState() => _ListItemTileState();
}

class _ListItemTileState extends State<ListItemTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.title),
                Text(widget.item.description),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Data.itemsOnList.remove(widget.item);
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    widget.onDelete();
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
    );
  }
}
