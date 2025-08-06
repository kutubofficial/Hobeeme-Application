// import 'dart:convert';

class SubCategory {
  final String id;
  final String name;
  final String slug;
  final String parentId;

  SubCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.parentId,
  });

  /// Creates a SubCategory object from a JSON map.
  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unnamed Sub-Category',
      slug: json['category_slug'] ?? '',
      parentId: json['parentId'] ?? '',
    );
  }

  /// Creates a JSON map from a SubCategory object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_slug': slug,
      'parentId': parentId,
    };
  }

  /// Overriding this allows you to compare two SubCategory objects for equality
  /// based on their content (specifically, their unique ID).
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SubCategory && other.id == id;
  }

  /// Overriding hashCode is necessary when you override `==`.
  /// It's crucial for performance in collections like Sets and Maps.
  @override
  int get hashCode => id.hashCode;

  /// Provides a readable string representation of the object, useful for debugging.
  @override
  String toString() {
    return 'SubCategory(id: $id, name: $name)';
  }
}
