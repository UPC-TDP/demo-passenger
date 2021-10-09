class MarkModel {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final bool isBusStop;
  final bool isStartPoint;
  final bool isFinishPoint;

  MarkModel(this.id, this.name, this.latitude, this.longitude, this.isBusStop,
      this.isStartPoint, this.isFinishPoint);
}
