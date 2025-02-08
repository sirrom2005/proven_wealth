class Permissions{
  final String name;
  final bool canRead;
  final bool canCreate;
  final bool canEdit;
  final bool canDelete;
  final bool? isGeoLocationEnabled;

  Permissions(
      {
        required this.name,
        required this.canRead,
        required this.canCreate,
        required this.canEdit,
        required this.canDelete,
        this.isGeoLocationEnabled
      }
  );
}