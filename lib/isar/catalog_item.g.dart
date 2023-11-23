// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCatalogItemCollection on Isar {
  IsarCollection<CatalogItem> get catalogItems => this.collection();
}

const CatalogItemSchema = CollectionSchema(
  name: r'CatalogItem',
  id: 7586471786704941128,
  properties: {
    r'catalogId': PropertySchema(
      id: 0,
      name: r'catalogId',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.long,
    ),
    r'fullText': PropertySchema(
      id: 2,
      name: r'fullText',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(
      id: 3,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'orderNum': PropertySchema(
      id: 5,
      name: r'orderNum',
      type: IsarType.long,
    ),
    r'preview': PropertySchema(
      id: 6,
      name: r'preview',
      type: IsarType.string,
    ),
    r'remark': PropertySchema(
      id: 7,
      name: r'remark',
      type: IsarType.string,
    ),
    r'score': PropertySchema(
      id: 8,
      name: r'score',
      type: IsarType.double,
    )
  },
  estimateSize: _catalogItemEstimateSize,
  serialize: _catalogItemSerialize,
  deserialize: _catalogItemDeserialize,
  deserializeProp: _catalogItemDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _catalogItemGetId,
  getLinks: _catalogItemGetLinks,
  attach: _catalogItemAttach,
  version: '3.1.0+1',
);

int _catalogItemEstimateSize(
  CatalogItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.fullText;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.preview;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.remark;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _catalogItemSerialize(
  CatalogItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.catalogId);
  writer.writeLong(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.fullText);
  writer.writeLong(offsets[3], object.hashCode);
  writer.writeString(offsets[4], object.name);
  writer.writeLong(offsets[5], object.orderNum);
  writer.writeString(offsets[6], object.preview);
  writer.writeString(offsets[7], object.remark);
  writer.writeDouble(offsets[8], object.score);
}

CatalogItem _catalogItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CatalogItem();
  object.catalogId = reader.readLongOrNull(offsets[0]);
  object.createdAt = reader.readLongOrNull(offsets[1]);
  object.fullText = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[4]);
  object.orderNum = reader.readLongOrNull(offsets[5]);
  object.preview = reader.readStringOrNull(offsets[6]);
  object.remark = reader.readStringOrNull(offsets[7]);
  object.score = reader.readDoubleOrNull(offsets[8]);
  return object;
}

P _catalogItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _catalogItemGetId(CatalogItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _catalogItemGetLinks(CatalogItem object) {
  return [];
}

void _catalogItemAttach(
    IsarCollection<dynamic> col, Id id, CatalogItem object) {
  object.id = id;
}

extension CatalogItemQueryWhereSort
    on QueryBuilder<CatalogItem, CatalogItem, QWhere> {
  QueryBuilder<CatalogItem, CatalogItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CatalogItemQueryWhere
    on QueryBuilder<CatalogItem, CatalogItem, QWhereClause> {
  QueryBuilder<CatalogItem, CatalogItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CatalogItemQueryFilter
    on QueryBuilder<CatalogItem, CatalogItem, QFilterCondition> {
  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      catalogIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'catalogId',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      catalogIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'catalogId',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      catalogIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'catalogId',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      catalogIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'catalogId',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      catalogIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'catalogId',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      catalogIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'catalogId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      createdAtEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      createdAtGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      createdAtLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      createdAtBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      fullTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fullText',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      fullTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fullText',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> fullTextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      fullTextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      fullTextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> fullTextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fullText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      fullTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      fullTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      fullTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fullText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> fullTextMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fullText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      fullTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullText',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      fullTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fullText',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      orderNumIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'orderNum',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      orderNumIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'orderNum',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> orderNumEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderNum',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      orderNumGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderNum',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      orderNumLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderNum',
        value: value,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> orderNumBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderNum',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      previewIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'preview',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      previewIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'preview',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> previewEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      previewGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> previewLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> previewBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preview',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      previewStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> previewEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> previewContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> previewMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'preview',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      previewIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preview',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      previewIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'preview',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> remarkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remark',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      remarkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remark',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> remarkEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      remarkGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> remarkLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> remarkBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remark',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      remarkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> remarkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> remarkContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> remarkMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remark',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      remarkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remark',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      remarkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remark',
        value: '',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> scoreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'score',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      scoreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'score',
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> scoreEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition>
      scoreGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> scoreLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterFilterCondition> scoreBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension CatalogItemQueryObject
    on QueryBuilder<CatalogItem, CatalogItem, QFilterCondition> {}

extension CatalogItemQueryLinks
    on QueryBuilder<CatalogItem, CatalogItem, QFilterCondition> {}

extension CatalogItemQuerySortBy
    on QueryBuilder<CatalogItem, CatalogItem, QSortBy> {
  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByCatalogId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catalogId', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByCatalogIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catalogId', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByFullText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByFullTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByOrderNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNum', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByOrderNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNum', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByPreview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preview', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByPreviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preview', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByRemark() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remark', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByRemarkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remark', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> sortByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }
}

extension CatalogItemQuerySortThenBy
    on QueryBuilder<CatalogItem, CatalogItem, QSortThenBy> {
  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByCatalogId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catalogId', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByCatalogIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catalogId', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByFullText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByFullTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByOrderNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNum', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByOrderNumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderNum', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByPreview() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preview', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByPreviewDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'preview', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByRemark() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remark', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByRemarkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remark', Sort.desc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QAfterSortBy> thenByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }
}

extension CatalogItemQueryWhereDistinct
    on QueryBuilder<CatalogItem, CatalogItem, QDistinct> {
  QueryBuilder<CatalogItem, CatalogItem, QDistinct> distinctByCatalogId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'catalogId');
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QDistinct> distinctByFullText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QDistinct> distinctByOrderNum() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderNum');
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QDistinct> distinctByPreview(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preview', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QDistinct> distinctByRemark(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remark', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CatalogItem, CatalogItem, QDistinct> distinctByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score');
    });
  }
}

extension CatalogItemQueryProperty
    on QueryBuilder<CatalogItem, CatalogItem, QQueryProperty> {
  QueryBuilder<CatalogItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CatalogItem, int?, QQueryOperations> catalogIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'catalogId');
    });
  }

  QueryBuilder<CatalogItem, int?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CatalogItem, String?, QQueryOperations> fullTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullText');
    });
  }

  QueryBuilder<CatalogItem, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<CatalogItem, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CatalogItem, int?, QQueryOperations> orderNumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderNum');
    });
  }

  QueryBuilder<CatalogItem, String?, QQueryOperations> previewProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preview');
    });
  }

  QueryBuilder<CatalogItem, String?, QQueryOperations> remarkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remark');
    });
  }

  QueryBuilder<CatalogItem, double?, QQueryOperations> scoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score');
    });
  }
}
