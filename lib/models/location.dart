/// Represents a venue users can choose to visit
class Location {
  final String name;

  const Location(
    this.name,
  );

  factory Location.fromMap(Map<String, dynamic> data) => Location(
        data['name'],
      );
}
