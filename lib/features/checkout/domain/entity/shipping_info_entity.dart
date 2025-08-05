import 'package:equatable/equatable.dart';

class ShippingInfoEntity extends Equatable {
  final String fullName;
  final String address;
  final String phoneNo;

  const ShippingInfoEntity({
    required this.fullName,
    required this.address,
    required this.phoneNo,
  });

  @override
  List<Object?> get props => [fullName, address, phoneNo];
}
