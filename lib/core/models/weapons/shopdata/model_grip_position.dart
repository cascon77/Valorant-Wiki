import 'dart:convert';

class GridPosition {
  int? row;
  int? column;

  GridPosition({
    this.row,
    this.column,
  });
  factory GridPosition.fromRawJson(String str) =>
      GridPosition.fromJson(json.decode(str));

  factory GridPosition.fromJson(Map<String, dynamic> json) => GridPosition(
        row: json["row"],
        column: json["column"],
      );
}
