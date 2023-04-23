part of 'venues_bloc.dart';

enum VenuesStatus { initial, success, failure }

class VenuesState {
  const VenuesState({
    this.status = VenuesStatus.initial,
    this.venues = const <Venue>[],
  });

  final VenuesStatus status;
  final List<Venue> venues;

  VenuesState copyWith({
    VenuesStatus? status,
    List<Venue>? venues,
  }) {
    return VenuesState(
      status: status ?? this.status,
      venues: venues ?? this.venues,
    );
  }
}
