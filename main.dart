import 'dart:html';
import 'dart:typed_data';

void main() {
  querySelector('#output')?.text = 'Your Dart app is running.';

  List<Student> students = [];

  void displayStudents() {
    var studentsContainer = document.getElementById('students');
    studentsContainer?.innerHtml = '';

    var table = document.createElement('table') as TableElement;
    table.className = 'table';

    var thead = table.createTHead();
    var headerRow = thead.addRow();

    var headers = ['Name', 'Grade'];

    for (var headerText in headers) {
      var th = document.createElement('th') as TableCellElement;
      th.text = headerText;
      headerRow.append(th);
    }

    var tbody = table.createTBody();
    for (var student in students) {
      var row = tbody.addRow();
      var cell1 = row.addCell();
      var cell2 = row.addCell();

      cell1.text = student.name;
      cell2.text = student.grade.toString();
    }

    studentsContainer?.append(table);
  }

  void addStudent() {
    var nameInput = document.getElementById('name') as InputElement?;
    var gradeInput = document.getElementById('grade') as InputElement?;

    if (nameInput != null &&
        nameInput.value != null &&
        nameInput.value!.isNotEmpty &&
        gradeInput != null &&
        gradeInput.value != null &&
        gradeInput.value!.isNotEmpty) {
      var newStudent = Student(nameInput.value!, int.parse(gradeInput.value!));
      students.add(newStudent);

      displayStudents();

      nameInput.value = '';
      gradeInput.value = '';
    }
  }

  void printList() {
    window.print();
  }

  void saveList() {
    var csvContent = 'Name,Grade\n';

    for (var student in students) {
      csvContent += '${student.name},${student.grade}\n';
    }

var blob = Blob([Uint8List.fromList(csvContent.codeUnits)], 'text/csv;charset=utf-8');

    var anchor = AnchorElement(href: Url.createObjectUrlFromBlob(blob))
      ..target = 'blank'
      ..download = 'student_list.csv'
      ..click();
  }

  // Add event listener to the button for adding students
  var addButton = document.getElementById('addButton');
  addButton?.onClick.listen((event) {
    addStudent();
  });

  // Add event listener to the button for printing the list
  var printButton = document.getElementById('printButton');
  printButton?.onClick.listen((event) {
    printList();
  });

  // Add event listener to the button for saving the list
  var saveButton = document.getElementById('saveButton');
  saveButton?.onClick.listen((event) {
    saveList();
  });
}

class Student {
  final String name;
  final int grade;

  Student(this.name, this.grade);
}
