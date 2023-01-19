class Appointment {
  final int id;
  String title;
  String description;
  DateTime date;
  String author;

  Appointment(
      {this.id = 0,
        required this.title,
        required this.description,
        required this.date,
        required this.author});

  Appointment.fromRow(Map<String, Object?> row)
      : id = row['ID'] as int,
        title = row['TITLE'] as String,
        description = row['DESCRIPTION'] as String,
        date = DateTime.parse(row['DATE'] as String),
        author = row['AUTHOR'] as String;

  @override
  String toString() {
    return 'Appointment {title: $title\ndescription: $description\ndate: $date\nauthor: $author}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'author': author
    };
  }

  // TODO cast data as needed
  get getDate {
    return date.toString().split(' ')[0];
  }

  get getTime {
    return date.toString().split(' ')[1];
  }

}