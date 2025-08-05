import 'package:gadgetify/features/checkout/domain/entity/shipping_info_entity.dart';

class ShippingInfoModel extends ShippingInfoEntity {
  // CORRECTED: The constructor now passes the values to the super class
  const ShippingInfoModel({
    required super.fullName,
    required super.address,
    required super.phoneNo,
  });

  factory ShippingInfoModel.fromJson(Map<String, dynamic> json) {
    return ShippingInfoModel(
      fullName: json['fullName'] as String? ?? 'N/A',
      address: json['address'] as String? ?? 'N/A',
      phoneNo: json['phoneNo'] as String? ?? 'N/A',
    );
  }
}
