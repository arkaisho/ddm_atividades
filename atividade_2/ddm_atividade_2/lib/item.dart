class Item {
  String title;
  String description;
  int id;

  Item({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Item{id: $id, title: $title, description: $description}';
  }
}
