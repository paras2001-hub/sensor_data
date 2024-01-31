import 'package:equatable/equatable.dart';

class MagneticFieldDataModel extends Equatable {
  final num x;
  final num y;
  final num z;

  const MagneticFieldDataModel(
      {required this.x, required this.y, required this.z});

  @override
  List<Object?> get props => [x, y, z];

  factory MagneticFieldDataModel.fromList(List<num> dataList) =>
      MagneticFieldDataModel(x: dataList[0], y: dataList[1], z: dataList[2]);
}
