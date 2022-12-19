class Appointments {
  static const List _appointments = [
    {
      "id": "1",
      "title": "Interview",
      "due": "TODAY",
      "description": "Interview for ITK SQUARE App for Making Appointments",
      "date": "12/28/2022",
      "time": "4:00 PM",
      'author': '001'
    },
    {
      "id": "2",
      "title": "PMO",
      "due": "MONDAY",
      "description": "PMO project. be formal, don't forget!",
      "date": "12/19/2022",
      "time": "8:35 AM",
      'author': '001'
    },
    {
      "id": "3",
      "title": "Walk with the Dog",
      "due": "TODAY",
      "description": "Going out to park with the dog. We ned to exercise",
      "date": "12/13/2022",
      "time": "5:30 PM",
      'author': '001'
    },
    {
      "id": "4",
      "title": "SuperMarket",
      "due": "WEDNESDAY",
      "description": "We need food remember bread and milk",
      "date": "12/14/2022",
      "time": "5:30 PM",
      'author': '002'
    },
    {
      "id": "5",
      "title": "Daily",
      "due": "MONDAY",
      "description": "Daily with Veronica",
      "date": "12/19/2022",
      "time": "3:30 PM",
      'author': '002'
    },
  ];

  List get appointments => _appointments;
}
