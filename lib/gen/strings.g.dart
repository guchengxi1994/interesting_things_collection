/// Generated file. Do not edit.
///
/// Original: assets/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 64 (32 per locale)
///
/// Built on 2023-12-02 at 12:32 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _StringsEn> {
	en(languageCode: 'en', build: _StringsEn.build),
	zhCn(languageCode: 'zh', countryCode: 'CN', build: _StringsZhCn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _StringsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _StringsEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _StringsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_StringsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _StringsEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _StringsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _StringsEn implements BaseTranslations<AppLocale, _StringsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	late final _StringsSettingsEn settings = _StringsSettingsEn._(_root);
	late final _StringsLayoutEn layout = _StringsLayoutEn._(_root);
	late final _StringsCatalogsEn catalogs = _StringsCatalogsEn._(_root);
	late final _StringsDialogsEn dialogs = _StringsDialogsEn._(_root);
}

// Path: settings
class _StringsSettingsEn {
	_StringsSettingsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get showPreview => 'Show preview image';
	String get colorTheme => 'Color Theme';
	String get locale => 'Language';
	String get enablePassword => 'Enable unlock password';
	String get operateCatalog => 'Verify when operating catalogs';
	String get operateCatalogItems => 'Verify when operating catalog items';
	String get operateFastNote => 'Verify when operating fast notes';
	late final _StringsSettingsColumnEn column = _StringsSettingsColumnEn._(_root);
}

// Path: layout
class _StringsLayoutEn {
	_StringsLayoutEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get catalog => 'Catalogs';
	String get fastNote => 'Fast Note';
	String get dataTransfer => 'Data Transfer';
	String get setting => 'Settings';
	String get schedule => 'Schedule';
}

// Path: catalogs
class _StringsCatalogsEn {
	_StringsCatalogsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsCatalogsCardEn card = _StringsCatalogsCardEn._(_root);
	late final _StringsCatalogsDetailsEn details = _StringsCatalogsDetailsEn._(_root);
	late final _StringsCatalogsEditorEn editor = _StringsCatalogsEditorEn._(_root);
	late final _StringsCatalogsNewCEn newC = _StringsCatalogsNewCEn._(_root);
}

// Path: dialogs
class _StringsDialogsEn {
	_StringsDialogsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get loading => 'Loading ...';
}

// Path: settings.column
class _StringsSettingsColumnEn {
	_StringsSettingsColumnEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get color => 'Color Settings';
	String get common => 'Common Settings';
	String get language => 'Language Settings';
}

// Path: catalogs.card
class _StringsCatalogsCardEn {
	_StringsCatalogsCardEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String tag({required Object count}) => '${count} tags';
}

// Path: catalogs.details
class _StringsCatalogsDetailsEn {
	_StringsCatalogsDetailsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get name => 'Name';
	String get tags => 'Tags';
	String get rating => 'Rating';
	String get createAt => 'CreateAt';
	String get operations => 'Operations';
}

// Path: catalogs.editor
class _StringsCatalogsEditorEn {
	_StringsCatalogsEditorEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get saveAsJson => 'Save as json';
	String get savePreview => 'Save preview image';
	String get exit => 'Exit without saving';
	String get addContent => 'Add Content';
}

// Path: catalogs.newC
class _StringsCatalogsNewCEn {
	_StringsCatalogsNewCEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get name => 'Catalog Name';
	String get remark => 'Catalog Remark';
	String get tags => 'Tags';
	String get create => 'Create';
	String get emoji => 'Add Emoji';
	String maxLength({required Object count}) => 'Max length ${count}';
}

// Path: <root>
class _StringsZhCn implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZhCn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsZhCn _root = this; // ignore: unused_field

	// Translations
	@override late final _StringsSettingsZhCn settings = _StringsSettingsZhCn._(_root);
	@override late final _StringsLayoutZhCn layout = _StringsLayoutZhCn._(_root);
	@override late final _StringsCatalogsZhCn catalogs = _StringsCatalogsZhCn._(_root);
	@override late final _StringsDialogsZhCn dialogs = _StringsDialogsZhCn._(_root);
}

// Path: settings
class _StringsSettingsZhCn implements _StringsSettingsEn {
	_StringsSettingsZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get showPreview => '展示预览图';
	@override String get colorTheme => '主题色';
	@override String get locale => '语言';
	@override String get enablePassword => '开启解锁密码';
	@override String get operateCatalog => '修改分类需验证';
	@override String get operateCatalogItems => '修改分类条目需验证';
	@override String get operateFastNote => '修改笔记需验证';
	@override late final _StringsSettingsColumnZhCn column = _StringsSettingsColumnZhCn._(_root);
}

// Path: layout
class _StringsLayoutZhCn implements _StringsLayoutEn {
	_StringsLayoutZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get catalog => '分类';
	@override String get fastNote => '快速笔记';
	@override String get dataTransfer => '数据迁移';
	@override String get setting => '设置';
	@override String get schedule => '日程';
}

// Path: catalogs
class _StringsCatalogsZhCn implements _StringsCatalogsEn {
	_StringsCatalogsZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override late final _StringsCatalogsCardZhCn card = _StringsCatalogsCardZhCn._(_root);
	@override late final _StringsCatalogsDetailsZhCn details = _StringsCatalogsDetailsZhCn._(_root);
	@override late final _StringsCatalogsEditorZhCn editor = _StringsCatalogsEditorZhCn._(_root);
	@override late final _StringsCatalogsNewCZhCn newC = _StringsCatalogsNewCZhCn._(_root);
}

// Path: dialogs
class _StringsDialogsZhCn implements _StringsDialogsEn {
	_StringsDialogsZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get loading => '稍等...';
}

// Path: settings.column
class _StringsSettingsColumnZhCn implements _StringsSettingsColumnEn {
	_StringsSettingsColumnZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get color => '颜色设置';
	@override String get common => '通用设置';
	@override String get language => '语言设置';
}

// Path: catalogs.card
class _StringsCatalogsCardZhCn implements _StringsCatalogsCardEn {
	_StringsCatalogsCardZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String tag({required Object count}) => '${count}个标签';
}

// Path: catalogs.details
class _StringsCatalogsDetailsZhCn implements _StringsCatalogsDetailsEn {
	_StringsCatalogsDetailsZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get name => '名称';
	@override String get tags => '标签';
	@override String get rating => '评分';
	@override String get createAt => '创建时间';
	@override String get operations => '操作';
}

// Path: catalogs.editor
class _StringsCatalogsEditorZhCn implements _StringsCatalogsEditorEn {
	_StringsCatalogsEditorZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get saveAsJson => '以json保存文件';
	@override String get savePreview => '保存预览图';
	@override String get exit => '退出但不保存';
	@override String get addContent => '添加内容';
}

// Path: catalogs.newC
class _StringsCatalogsNewCZhCn implements _StringsCatalogsNewCEn {
	_StringsCatalogsNewCZhCn._(this._root);

	@override final _StringsZhCn _root; // ignore: unused_field

	// Translations
	@override String get name => '输入名称';
	@override String get remark => '输入备注';
	@override String get tags => '标签';
	@override String get create => '创建';
	@override String get emoji => '添加表情';
	@override String maxLength({required Object count}) => '长度限制${count}';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'settings.showPreview': return 'Show preview image';
			case 'settings.colorTheme': return 'Color Theme';
			case 'settings.locale': return 'Language';
			case 'settings.enablePassword': return 'Enable unlock password';
			case 'settings.operateCatalog': return 'Verify when operating catalogs';
			case 'settings.operateCatalogItems': return 'Verify when operating catalog items';
			case 'settings.operateFastNote': return 'Verify when operating fast notes';
			case 'settings.column.color': return 'Color Settings';
			case 'settings.column.common': return 'Common Settings';
			case 'settings.column.language': return 'Language Settings';
			case 'layout.catalog': return 'Catalogs';
			case 'layout.fastNote': return 'Fast Note';
			case 'layout.dataTransfer': return 'Data Transfer';
			case 'layout.setting': return 'Settings';
			case 'layout.schedule': return 'Schedule';
			case 'catalogs.card.tag': return ({required Object count}) => '${count} tags';
			case 'catalogs.details.name': return 'Name';
			case 'catalogs.details.tags': return 'Tags';
			case 'catalogs.details.rating': return 'Rating';
			case 'catalogs.details.createAt': return 'CreateAt';
			case 'catalogs.details.operations': return 'Operations';
			case 'catalogs.editor.saveAsJson': return 'Save as json';
			case 'catalogs.editor.savePreview': return 'Save preview image';
			case 'catalogs.editor.exit': return 'Exit without saving';
			case 'catalogs.editor.addContent': return 'Add Content';
			case 'catalogs.newC.name': return 'Catalog Name';
			case 'catalogs.newC.remark': return 'Catalog Remark';
			case 'catalogs.newC.tags': return 'Tags';
			case 'catalogs.newC.create': return 'Create';
			case 'catalogs.newC.emoji': return 'Add Emoji';
			case 'catalogs.newC.maxLength': return ({required Object count}) => 'Max length ${count}';
			case 'dialogs.loading': return 'Loading ...';
			default: return null;
		}
	}
}

extension on _StringsZhCn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'settings.showPreview': return '展示预览图';
			case 'settings.colorTheme': return '主题色';
			case 'settings.locale': return '语言';
			case 'settings.enablePassword': return '开启解锁密码';
			case 'settings.operateCatalog': return '修改分类需验证';
			case 'settings.operateCatalogItems': return '修改分类条目需验证';
			case 'settings.operateFastNote': return '修改笔记需验证';
			case 'settings.column.color': return '颜色设置';
			case 'settings.column.common': return '通用设置';
			case 'settings.column.language': return '语言设置';
			case 'layout.catalog': return '分类';
			case 'layout.fastNote': return '快速笔记';
			case 'layout.dataTransfer': return '数据迁移';
			case 'layout.setting': return '设置';
			case 'layout.schedule': return '日程';
			case 'catalogs.card.tag': return ({required Object count}) => '${count}个标签';
			case 'catalogs.details.name': return '名称';
			case 'catalogs.details.tags': return '标签';
			case 'catalogs.details.rating': return '评分';
			case 'catalogs.details.createAt': return '创建时间';
			case 'catalogs.details.operations': return '操作';
			case 'catalogs.editor.saveAsJson': return '以json保存文件';
			case 'catalogs.editor.savePreview': return '保存预览图';
			case 'catalogs.editor.exit': return '退出但不保存';
			case 'catalogs.editor.addContent': return '添加内容';
			case 'catalogs.newC.name': return '输入名称';
			case 'catalogs.newC.remark': return '输入备注';
			case 'catalogs.newC.tags': return '标签';
			case 'catalogs.newC.create': return '创建';
			case 'catalogs.newC.emoji': return '添加表情';
			case 'catalogs.newC.maxLength': return ({required Object count}) => '长度限制${count}';
			case 'dialogs.loading': return '稍等...';
			default: return null;
		}
	}
}
