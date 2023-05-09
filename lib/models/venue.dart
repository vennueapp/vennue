/// Represents a venue users can choose to visit
class Venue {
  final String name;
  final String description;
  final String location;
  final String imagePath;

  const Venue(
    this.name,
    this.description,
    this.location,
    this.imagePath,
  );

  factory Venue.fromMap(Map<String, dynamic> data) => Venue(
        data['name'],
        data['description'],
        data['location'],
        data['imagePath'],
      );
}
