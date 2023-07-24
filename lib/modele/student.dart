import 'dart:convert';

class Student{
  String? name;
  DateTime? date;

  Student(
   this.name,
   this.date,
  );

  Student copyWith({
    String? name,
    DateTime? date,
  }){
    return Student(
      name ?? this.name,
      date ?? this.date,
    );
  }

  factory Student.fromMap(Map<String,dynamic>map){
    return Student(
      map['name'] = map['name'] as String,
      map['date'] = map['date'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String src) => Student.fromMap(json.decode(src) as Map<String , dynamic>);

  @override
  String toString() => 'Student(name:$name, date:$date)';

  @override
  bool operator ==(Object other){
    if(identical(this, other)) return true;
    return other is Student && 
    other.name == name &&
    other.date == date ;
  }

  @override
  int get hashCode => name.hashCode ^ date.hashCode;
  
  Map <String , dynamic> toMap() {
    return <String , dynamic>{
      'name':name,
      'date':date
    };
  }
}