import 'package:ddm_atividade_2/data.dart';
import 'package:ddm_atividade_2/item.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Data data = Data();

  List<Item> itemsOnList = [];

  @override
  void didChangeDependencies() {
    fetchList();
    super.didChangeDependencies();
  }

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
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchList();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: itemsOnList
              .map(
                (item) => ListItemTile(
                  item: Item(
                    id: item.id,
                    title: item.title,
                    description: item.description,
                  ),
                  onDelete: () async {
                    await data.deleteItem(item.id);
                    await fetchList();
                  },
                  onEdit: () {
                    showEditModalBottomSheet(context, item);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Future fetchList() async {
    var aux = await data.items();
    setState(() {
      itemsOnList = aux;
    });
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
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: titleController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: "Titulo",
                          label: Text("Titulo"),
                        ),
                      ),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: "Descrição",
                          label: Text("Descrição"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          child: const Text("Salvar"),
                          onPressed: () async {
                            await data.insertItem(
                              Item(
                                id: await data.getNextId(),
                                title: titleController.text,
                                description: descriptionController.text,
                              ),
                            );
                            fetchList();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showEditModalBottomSheet(BuildContext context, Item item) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    titleController.text = item.title;
    descriptionController.text = item.description;
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
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: titleController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: "Titulo",
                          label: Text("Titulo"),
                        ),
                      ),
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: "Descrição",
                          label: Text("Descrição"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          child: const Text("Salvar"),
                          onPressed: () async {
                            await data.updateItem(
                              Item(
                                id: item.id,
                                title: titleController.text,
                                description: descriptionController.text,
                              ),
                            );
                            await fetchList();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
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
  final Function onEdit;

  const ListItemTile({
    required this.item,
    required this.onDelete,
    required this.onEdit,
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
                    widget.onEdit();
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
