// 支持的应用语言
enum AppLanguage: String {
    case en, zh, ja
}

import SwiftUI

// 枚举类型：毒性等级分类
enum ToxicityLevel {
    case deadly   // 致命
    case toxic    // 有毒
    case edible   // 可食用
    case unknown  // 未知

    // 每种毒性对应的颜色，用于界面显示
    var color: Color {
        switch self {
        case .deadly: return .red       // 致命 → 红色
        case .toxic: return .orange     // 有毒 → 橙色
        case .edible: return .green     // 可食用 → 绿色
        case .unknown: return .gray     // 未知 → 灰色
        }
    }

    // 每种毒性对应的图标（emoji），用于列表展示
    var icon: String {
        switch self {
        case .deadly: return "☠️"       // 致命 → 骷髅头
        case .toxic: return "🍄"        // 有毒 → 蘑菇
        case .edible: return "✅"       // 可食用 → 勾
        case .unknown: return "❓"      // 未知 → 问号
        }
    }
}

// 毒性映射器：将模型识别出的英文标签映射为毒性等级
struct ToxicityMapper {
    // 字典：已知标签名称 → 毒性等级
    static let map: [String: ToxicityLevel] = [
        "agaricus bisporus": .edible,//白蘑菇，マッシュルーム
        "amanita bisporigera": .deadly,//白鹅膏，ハクサンタマゴテングタケ
        "amanita citrina": .toxic,//黄绿鹅膏，シトリナタマゴテングタケ
        "amanita crocea": .edible,//橙盖鹅膏，オレンジタマゴテングタケ
        "amanita farinosa": .deadly,//青头鹅膏，アオタマゴテングタケ
        "amanita muscaria": .toxic,//毒蝇伞，ベニテングタケ
        "amanita ocreata": .deadly,//西部死亡帽，ニセシロタマゴテングタケ
        "amanita pantherina": .toxic,//豹斑鹅膏，ヒョウモンダケ
        "amanita pantherinoides": .deadly,//斑点鹅膏，ヒョウモンダケモドキ
        "amanita parcivolvata": .toxic,//红盖鹅膏，ベニダマゴテングタケ
        "amanita phalloides": .deadly,//毒鹅膏，タマゴテングタケ
        "amanita subjunquillea": .deadly,//近黄绿鹅膏，キミドリタマゴテングタケ
        "amanita vaginata": .toxic,//淡紫鹅膏，ウスムラサキタマゴテングタケ
        "amanita virosa": .deadly,//白毒鹅膏，シロタマゴテングタケ
        "antrodia cinnamomea": .edible,//牛樟芝，ニウショウシ
        "auricularia auricula-judae": .edible,//木耳，キクラゲ
        "auricularia polytricha": .edible,//老鸦头，アラゲキクラゲ
        "bolbitius vitellinus": .edible,//黄伞菌，キイロイグチ
        "boletus edulis": .edible,//牛肝菌，ヤマドリタケ
        "boletus venenatus": .toxic,//见手青，ベニテングタケ
        "cantharellus cibarius": .edible,//鸡油菌，アンズタケ
        "cantharellus cinnabarinus": .edible,//粉红鸡油菌，ベニイグチ
        "cantharellus formosus": .edible,//鸡油菌亚种，チャナメツムタケ
        "chlorophyllum brunneum": .toxic,//斑褶伞，ハラタケモドキ
        "chlorophyllum molybdites": .toxic,//绿褶伞，コレラタケ
        "chlorophyllum rachodes": .toxic,//大绿褶伞，オオキノコモドキ
        "clavulina cristata": .edible,//鹿茸菌，シロソウメンタケ
        "clitocybe dealbata": .deadly,//白粉褶伞，シロカワラタケ
        "clitocybe nuda": .edible,//灰红褶菌，ムラサキシメジ
        "coprinellus micaceus": .edible,//毛头鬼伞，キララタケ
        "coprinopsis atramentaria": .toxic,//鬼伞，ヒトヨタケ
        "coprinopsis nivea": .edible,//白鬼伞，シロヒトヨタケ
        "coprinopsis picacea": .toxic,//红鬼伞，マダラヒトヨタケ
        "coprinus comatus": .edible,//鸡髓伞，ササクレヒトヨタケ
        "cortinarius rubellus": .deadly,//红纱帽菌，ドクササコ
        "dermoloma cuneifolium": .edible,//红褶菌，アカヒダタケ
        "dictyophora indusiata": .edible,//绿褶网伞，キヌガサタケ
        "discina perlata": .edible,//绿盘菌，オオカサタケ
        "entoloma hochstetteri": .toxic,//绿盖菇，ルリヒラタケ
        "entoloma sinuatum": .deadly,//有毒粉褶菌，ヒダグロフウセンタケ
        "flammulina velutipes": .edible,//金针菇，エノキタケ
        "galerina marginata": .deadly,//毒盔伞，ニガクリタケ
        "ganoderma lucidum": .edible,//灵芝，レイシ
        "ganoderma tsugae": .edible,//鹿花灵芝，ツガレイシ
        "grifola frondosa": .edible,//舞茸，マイタケ
        "grifola umbellata": .edible,//灰树花，カワラタケ
        "gymnopilus spectabilis": .toxic,//锈褶菌，ドクカラカサタケ
        "gyromitra esculenta": .deadly,//假羊肚菌，シャグマアミガサタケ
        "gyromitra gigas": .deadly,//脑状菌，オオシャグマタケ
        "hebeloma crustuliniforme": .toxic,//褐蘑，カキシメジ
        "helvella crispa": .toxic,//鹿花菌，シロアミガサタケ
        "hericium erinaceus": .edible,//猴头菇，ヤマブシタケ
        "hydnum repandum": .edible,//刺芒菇，ハナビラタケ
        "hygrocybe conica": .edible,//黏褶伞，ベニヒガサ
        "hygrophorus purpurascens": .edible,//紫蜡伞，ムラサキヌメリガサ
        "inocybe erubescens": .deadly,//红变小菇，カラカサタケ
        "inonotus obliquus": .edible,//白桦茸，チャーガ
        "laccaria amethystina": .edible,//紫蘑菇，ムラサキシメジ
        "lactarius deliciosus": .edible,//湿地乳菇，アカモミタケ
        "lentinula edodes": .edible,//香菇，シイタケ
        "lepiota brunneoincarnata": .deadly,//褐红鳞伞，カラハリタケ
        "lepiota cristata": .deadly,//黑柄白毒伞，ヒメカラカサタケ
        "leucocoprinus birnbaumii": .toxic,//黄褶伞，キイロタマゴテングタケ
        "macrolepiota procera": .edible,//大环柄菇，オオシロカラカサタケ
        "marasmius oreades": .edible,//铃伞菌，カヤタケ
        "morchella esculenta": .edible,//马鞍菌，アミガサタケ
        "morchella importuna": .edible,//褐羊肚菌，クロアミガサタケ
        "mycena chlorophos": .edible,//荧光菇，ヤコウタケ
        "mycena epipterygia": .edible,//黄伞小菇，アカイボカサタケ
        "omphalotus illudens": .toxic,//假鸡油菌，ツキヨタケ
        "ophiocordyceps sinensis": .edible,//冬虫夏草，トウチュウカソウ
        "panaeolus cinctulus": .toxic,//黑盖伞，ヒカゲタケ
        "paxillus involutus": .deadly,//卷边菌，マツカサタケ
        "phallus impudicus": .edible,//鬼笔菌，スッポンタケ
        "pholiota nameko": .edible,//榆黄蘑，ナメコ
        "pholiota squarrosa": .toxic,//粘黄褶菇，ヌメリイグチ
        "pleurotus djamor": .edible,//短柄平菇，ピンクヒラタケ
        "pleurotus ostreatus": .edible,//平菇，ヒラタケ
        "pluteus cervinus": .edible,//粉红蘑菇，ウラベニホテイシメジ
        "polyporus umbellatus": .edible,//猪苓，チョレイマイタケ
        "psathyrella candolleana": .edible,//假脆柄菇，カラカサタケ
        "psilocybe cubensis": .toxic,//致幻蘑菇，シロシビンマッシュルーム
        "psilocybe semilanceata": .toxic,//锥顶小裸盖，セミランセアタケ
        "pycnoporus cinnabarinus": .edible,//火焰菌，ベニチャワンタケ
        "ramaria botrytis": .edible,//珊瑚菌，ホウキタケ
        "rubroboletus sinicus": .edible,//红孔牛肝菌，アカアミアシイグチ
        "russula emetica": .toxic,//红脆褶菌，ベニタケ
        "russula paludosa": .edible,//大红菇，ベニタケ
        "sarcoscypha coccinea": .edible,//杯状菌，ベニチャワンタケ
        "scleroderma citrinum": .toxic,//假马勃，ニセショウロ
        "stropharia aeruginosa": .toxic,//蓝绿小菇，アオミノフウセンタケ
        "suillus granulatus": .edible,//海绵伞，ヌメリイグチ
        "taiwanofungus camphoratus": .edible,//松杉灵芝，カンファタケ
        "trametes versicolor": .edible,//褶云芝，カワラタケ
        "tremella fuciformis": .edible,//银耳，シロキクラゲ
        "tricholoma equestre": .deadly,//黄骑马蘑菇，キンカクキンタケ
        "tricholoma matsutake": .edible,//松茸，マツタケ
        "tuber magnatum": .edible,//白松露，シロトリュフ
        "tuber melanosporum": .edible,//黑松露，クロトリュフ
        "tylopilus alboater": .edible,//黑牛肝菌，クロニガイグチ
        "volvariella volvacea": .edible,//草菇，ワライタケ
        "zygomyces californianus": .edible,//加利福尼亚蘑菇，カリフォルニアムシッシュルーム
        "zygomyces rosella": .edible,//红蘑菇，シロムシッシュルーム
        "zygomyces spicatus": .edible,//粉红蘑菇，ウラムシッシュルーム
        "zygomyces torridus": .edible,//褐色蘑菇，クロムシッシュルーム

    ]
    
    static let nameMap: [String: (zh: String, ja: String, en: String)] = [
        "agaricus bisporus": ("白蘑菇", "マッシュルーム", "Agaricus bisporus"),
        "amanita bisporigera": ("白鹅膏", "ハクサンタマゴテングタケ", "Amanita bisporigera"),
        "amanita citrina": ("黄绿鹅膏", "シトリナタマゴテングタケ", "Amanita citrina"),
        "amanita crocea": ("橙盖鹅膏", "オレンジタマゴテングタケ", "Amanita crocea"),
        "amanita farinosa": ("青头鹅膏", "アオタマゴテングタケ", "Amanita farinosa"),
        "amanita muscaria": ("毒蝇伞", "ベニテングタケ", "Amanita muscaria"),
        "amanita ocreata": ("西部死亡帽", "ニセシロタマゴテングタケ", "Amanita ocreata"),
        "amanita pantherina": ("豹斑鹅膏", "ヒョウモンダケ", "Amanita pantherina"),
        "amanita pantherinoides": ("斑点鹅膏", "ヒョウモンダケモドキ", "Amanita pantherinoides"),
        "amanita parcivolvata": ("红盖鹅膏", "ベニダマゴテングタケ", "Amanita parcivolvata"),
        "amanita phalloides": ("毒鹅膏", "タマゴテングタケ", "Amanita phalloides"),
        "amanita subjunquillea": ("近黄绿鹅膏", "キミドリタマゴテングタケ", "Amanita subjunquillea"),
        "amanita vaginata": ("淡紫鹅膏", "ウスムラサキタマゴテングタケ", "Amanita vaginata"),
        "amanita virosa": ("白毒鹅膏", "シロタマゴテングタケ", "Amanita virosa"),
        "antrodia cinnamomea": ("牛樟芝", "ニウショウシ", "Antrodia cinnamomea"),
        "auricularia auricula-judae": ("木耳", "キクラゲ", "Auricularia auricula-judae"),
        "auricularia polytricha": ("老鸦头", "アラゲキクラゲ", "Auricularia polytricha"),
        "bolbitius vitellinus": ("黄伞菌", "キイロイグチ", "Bolbitius vitellinus"),
        "boletus edulis": ("牛肝菌", "ヤマドリタケ", "Boletus edulis"),
        "boletus venenatus": ("见手青", "アイアシベニイグチ", "Boletus venenatus"),
        "cantharellus cibarius": ("鸡油菌", "アンズタケ", "Cantharellus cibarius"),
        "cantharellus cinnabarinus": ("粉红鸡油菌", "ベニアンズタケ", "Cantharellus cinnabarinus"),
        "cantharellus formosus": ("鸡油菌亚种", "チャナメツムタケ", "Cantharellus formosus"),
        "chlorophyllum brunneum": ("斑褶伞", "ハラタケモドキ", "Chlorophyllum brunneum"),
        "chlorophyllum molybdites": ("绿褶伞", "コレラタケ", "Chlorophyllum molybdites"),
        "chlorophyllum rachodes": ("大绿褶伞", "オオキノコモドキ", "Chlorophyllum rachodes"),
        "clavulina cristata": ("鹿茸菌", "シロソウメンタケ", "Clavulina cristata"),
        "clitocybe dealbata": ("白粉褶伞", "シロカワラタケ", "Clitocybe dealbata"),
        "clitocybe nuda": ("灰红褶菌", "ムラサキシメジ", "Clitocybe nuda"),
        "coprinellus micaceus": ("毛头鬼伞", "キララタケ", "Coprinellus micaceus"),
        "coprinopsis atramentaria": ("鬼伞", "ヒトヨタケ", "Coprinopsis atramentaria"),
        "coprinopsis nivea": ("白鬼伞", "シロヒトヨタケ", "Coprinopsis nivea"),
        "coprinopsis picacea": ("红鬼伞", "マダラヒトヨタケ", "Coprinopsis picacea"),
        "coprinus comatus": ("鸡髓伞", "ササクレヒトヨタケ", "Coprinus comatus"),
        "cortinarius rubellus": ("红纱帽菌", "ドクササコ", "Cortinarius rubellus"),
        "dermoloma cuneifolium": ("红褶菌", "アカヒダタケ", "Dermoloma cuneifolium"),
        "dictyophora indusiata": ("绿褶网伞", "キヌガサタケ", "Dictyophora indusiata"),
        "discina perlata": ("绿盘菌", "オオカサタケ", "Discina perlata"),
        "entoloma hochstetteri": ("绿盖菇", "ルリヒラタケ", "Entoloma hochstetteri"),
        "entoloma sinuatum": ("有毒粉褶菌", "ヒダグロフウセンタケ", "Entoloma sinuatum"),
        "flammulina velutipes": ("金针菇", "エノキタケ", "Flammulina velutipes"),
        "galerina marginata": ("毒盔伞", "ニガクリタケ", "Galerina marginata"),
        "ganoderma lucidum": ("灵芝", "レイシ", "Ganoderma lucidum"),
        "ganoderma tsugae": ("鹿花灵芝", "ツガレイシ", "Ganoderma tsugae"),
        "grifola frondosa": ("舞茸", "マイタケ", "Grifola frondosa"),
        "grifola umbellata": ("灰树花", "カワラタケ", "Grifola umbellata"),
        "gymnopilus spectabilis": ("锈褶菌", "ドクカラカサタケ", "Gymnopilus spectabilis"),
        "gyromitra esculenta": ("假羊肚菌", "シャグマアミガサタケ", "Gyromitra esculenta"),
        "gyromitra gigas": ("脑状菌", "オオシャグマタケ", "Gyromitra gigas"),
        "hebeloma crustuliniforme": ("褐蘑", "カキシメジ", "Hebeloma crustuliniforme"),
        "helvella crispa": ("鹿花菌", "シロアミガサタケ", "Helvella crispa"),
        "hericium erinaceus": ("猴头菇", "ヤマブシタケ", "Hericium erinaceus"),
        "hydnum repandum": ("刺芒菇", "ハナビラタケ", "Hydnum repandum"),
        "hygrocybe conica": ("黏褶伞", "ベニヒガサ", "Hygrocybe conica"),
        "hygrophorus purpurascens": ("紫蜡伞", "ムラサキヌメリガサ", "Hygrophorus purpurascens"),
        "inocybe erubescens": ("红变小菇", "ベニカラカサタケ", "Inocybe erubescens"),
        "inonotus obliquus": ("白桦茸", "チャーガ", "Inonotus obliquus"),
        "laccaria amethystina": ("紫蘑菇", "ムラサキシメジ", "Laccaria amethystina"),
        "lactarius deliciosus": ("湿地乳菇", "アカモミタケ", "Lactarius deliciosus"),
        "lentinula edodes": ("香菇", "シイタケ", "Lentinula edodes"),
        "lepiota brunneoincarnata": ("褐红鳞伞", "ドクカラカサタケ", "Lepiota brunneoincarnata"),
        "lepiota cristata": ("黑柄白毒伞", "ヒメカラカサタケ", "Lepiota cristata"),
        "leucocoprinus birnbaumii": ("黄褶伞", "キイロタマゴテングタケ", "Leucocoprinus birnbaumii"),
        "macrolepiota procera": ("大环柄菇", "オオシロカラカサタケ", "Macrolepiota procera"),
        "marasmius oreades": ("铃伞菌", "カヤタケ", "Marasmius oreades"),
        "morchella esculenta": ("马鞍菌", "アミガサタケ", "Morchella esculenta"),
        "morchella importuna": ("褐羊肚菌", "クロアミガサタケ", "Morchella importuna"),
        "mycena chlorophos": ("荧光菇", "ヤコウタケ", "Mycena chlorophos"),
        "mycena epipterygia": ("黄伞小菇", "アカイボカサタケ", "Mycena epipterygia"),
        "omphalotus illudens": ("假鸡油菌", "ツキヨタケ", "Omphalotus illudens"),
        "ophiocordyceps sinensis": ("冬虫夏草", "トウチュウカソウ", "Ophiocordyceps sinensis"),
        "panaeolus cinctulus": ("黑盖伞", "ヒカゲタケ", "Panaeolus cinctulus"),
        "paxillus involutus": ("卷边菌", "マツカサタケ", "Paxillus involutus"),
        "phallus impudicus": ("鬼笔菌", "スッポンタケ", "Phallus impudicus"),
        "pholiota nameko": ("榆黄蘑", "ナメコ", "Pholiota nameko"),
        "pholiota squarrosa": ("粘黄褶菇", "ヌメリイグチ", "Pholiota squarrosa"),
        "pleurotus djamor": ("短柄平菇", "ピンクヒラタケ", "Pleurotus djamor"),
        "pleurotus ostreatus": ("平菇", "ヒラタケ", "Pleurotus ostreatus"),
        "pluteus cervinus": ("粉红蘑菇", "ウラベニホテイシメジ", "Pluteus cervinus"),
        "polyporus umbellatus": ("猪苓", "チョレイマイタケ", "Polyporus umbellatus"),
        "psathyrella candolleana": ("假脆柄菇", "カラカサタケ", "Psathyrella candolleana"),
        "psilocybe cubensis": ("致幻蘑菇", "シロシビンマッシュルーム", "Psilocybe cubensis"),
        "psilocybe semilanceata": ("锥顶小裸盖", "セミランセアタケ", "Psilocybe semilanceata"),
        "pycnoporus cinnabarinus": ("火焰菌", "ベニチャワンタケ", "Pycnoporus cinnabarinus"),
        "ramaria botrytis": ("珊瑚菌", "ホウキタケ", "Ramaria botrytis"),
        "rubroboletus sinicus": ("红孔牛肝菌", "アカアミアシイグチ", "Rubroboletus sinicus"),
        "russula emetica": ("红脆褶菌", "ベニタケ", "Russula emetica"),
        "russula paludosa": ("大红菇", "オオベニタケ", "Russula paludosa"),
        "sarcoscypha coccinea": ("杯状菌", "ベニチャワンタケ", "Sarcoscypha coccinea"),
        "scleroderma citrinum": ("假马勃", "ニセショウロ", "Scleroderma citrinum"),
        "stropharia aeruginosa": ("蓝绿小菇", "アオミノフウセンタケ", "Stropharia aeruginosa"),
        "suillus granulatus": ("海绵伞", "ヌメリイグチ", "Suillus granulatus"),
        "taiwanofungus camphoratus": ("松杉灵芝", "カンファタケ", "Taiwanofungus camphoratus"),
        "trametes versicolor": ("褶云芝", "カワラタケ", "Trametes versicolor"),
        "tremella fuciformis": ("银耳", "シロキクラゲ", "Tremella fuciformis"),
        "tricholoma equestre": ("黄骑马蘑菇", "キンカクキンタケ", "Tricholoma equestre"),
        "tricholoma matsutake": ("松茸", "マツタケ", "Tricholoma matsutake"),
        "tuber magnatum": ("白松露", "シロトリュフ", "Tuber magnatum"),
        "tuber melanosporum": ("黑松露", "クロトリュフ", "Tuber melanosporum"),
        "tylopilus alboater": ("黑牛肝菌", "クロニガイグチ", "Tylopilus alboater"),
        "volvariella volvacea": ("草菇", "フクロタケ", "Volvariella volvacea"),
        "zygomyces californianus": ("加利福尼亚蘑菇", "カリフォルニアムシッシュルーム", "Zygomyces californianus"),
        "zygomyces rosella": ("红蘑菇", "シロムシッシュルーム", "Zygomyces rosella"),
        "zygomyces spicatus": ("粉红蘑菇", "ウラムシッシュルーム", "Zygomyces spicatus"),
        "zygomyces torridus": ("褐色蘑菇", "クロムシッシュルーム", "Zygomyces torridus")

    ]

    // 查询方法：将模型识别标签转为标准格式后查找毒性等级
    static func toxicity(for label: String) -> ToxicityLevel {
        let key = label
            .replacingOccurrences(of: "_", with: " ")         // 下划线换成空格
            .trimmingCharacters(in: .whitespacesAndNewlines)  // 去掉首尾空白
            .lowercased()                                     // 转小写
        // print("🔍 查找 key: \(key)")  // ← 调试输出用
        return map[key] ?? .unknown // 查找结果，若无匹配则返回 unknown
    }
    
    static func localizedName(for label: String, lang: AppLanguage) -> String {
        let key = label
            .replacingOccurrences(of: "_", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        guard let name = nameMap[key] else { return label }
        switch lang {
        case .zh: return name.zh
        case .ja: return name.ja
        case .en: return name.en
        }
    }
    static func normalize(_ label: String) -> String {
        return label
            .replacingOccurrences(of: "_", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
    }
}
