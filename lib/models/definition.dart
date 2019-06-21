class Definition {
  int id;
  String word;
  String definition;

  Definition(this.word, this.definition);
  Definition.withId(this.id, this.word, this.definition);

  int get getId => id;
  String get getWord => word;
  String get getDefinition => definition;

  set setWord(String newWord) {
    this.word = newWord;
  }

  set setDefinition(String newDefinition) {
    this.definition = newDefinition;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }

    map['word'] = word;
    map['definition'] = definition;

    return map;
  }
}
