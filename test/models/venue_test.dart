import "package:flutter_test/flutter_test.dart";
import "package:vennue/models/venue.dart";

void main() {
  test('Venue should be created with custom values', () {
    Venue venue = const Venue(
      venueName,
      venueDescription,
      venueLocation,
      venueImagePath,
    );

    expect(venue.name, venueName);
    expect(venue.description, venueDescription);
    expect(venue.location, venueLocation);
    expect(venue.imagePath, venueImagePath);
  });

  test('Venue should be created from map', () {
    Venue venue = Venue.fromMap(venueMap);

    expect(venue.name, venueName);
    expect(venue.description, venueDescription);
    expect(venue.location, venueLocation);
    expect(venue.imagePath, venueImagePath);
  });
}

const venueName = "Croff";
const venueDescription = "It's Croffee Time";
const venueLocation = "Raine Square";
const venueImagePath = "TheGoodBarista.jpg";

var venueMap = {
  "name": venueName,
  "description": venueDescription,
  "location": venueLocation,
  "imagePath": venueImagePath,
};
