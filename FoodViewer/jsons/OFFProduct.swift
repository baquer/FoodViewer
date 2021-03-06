//
//  OFFProduct.swift
//  FoodViewer
//
//  Created by arnaud on 09/02/2018.
//  Copyright © 2018 Hovering Above. All rights reserved.
//

import Foundation

class OFFProduct: Codable {
    let additives: String?
    let additives_debug_tags: [String]
    let additives_n: Int?
    let additives_old_n: Int?
    let additives_old_tags: [String]
    let additives_prev: String?
    let additives_prev_n: Int?
    let additives_prev_tags: [String]
    let additives_tags: [String]
    let allergens: String
    let allergens_hierarchy: [String]
    let allergens_tags: [String]
    let brands: String
    let brands_tags: [String]
    let categories: String
    let categories_debug_tags: [String]
    let categories_hierarchy: [String]
    let categories_prev_hierarchy: [String]
    let categories_prev_tags: [String]
    let categories_tags: [String]
    let checkers_tags: [String]
    let cities_tags: [String]?
    let code: String
    let codes_tags: [String]
    let complete: Int
    let completed_t: Int?
    let correctors_tags: [String]
    let countries: String
    let countries_hierarchy: [String]
    let countries_tags: [String]
    let created_t: Int // 1410949750
    let creator: String
    let editors: [String]?
    let editors_tags: [String]
    let emb_codes: String?
    let emb_codes_20141016: String?
    let emb_codes_orig: String?
    let emb_codes_tags: [String]?
    let expiration_date: String? // "04/12/2016"
    let entry_dates_tags: [String]
    // generic_name_fr is handled in the child
    let generic_name: String?
    let id: String
    let image_front_small_url: URL?
    let image_front_thumb_url: URL?
    let image_front_url: URL?
    let image_ingredients_small_url: URL?
    let image_ingredients_thumb_url: URL?
    let image_ingredients_url: URL
    let image_nutrition_small_url: URL?
    let image_nutrition_thumb_url: URL?
    let image_nutrition_url: URL?
    let image_small_url: URL?
    let image_thumb_url: URL?
    let image_url: String?
    let images: [String:OFFProductImage]
    let informers_tags: [String]
    let ingredients: [OFFProductIngredient]
    let ingredients_debug: [String]
    let ingredients_from_or_that_may_be_from_palm_oil_n: Int?
    let ingredients_from_palm_oil_n: Int?
    let ingredients_from_palm_oil_tags: [String]
    let ingredients_ids_debug: [String]
    let ingredients_n: String?
    let ingredients_n_tags: [String]?
    let ingredients_that_may_be_from_palm_oil_n: Int?
    let ingredients_tags: [String]
    let ingredients_text: String
    // ingredients_text_fr is handled in the child
    let ingredients_text_debug: String
    let ingredients_that_may_be_from_palm_oil_tags: [String]
    let ingredients_text_with_allergens: String?
    // let ingredients_text_with_allergens_fr is handled in the child
    let interface_version_created: String?  // not always with value
    let interface_version_modified: String
    let labels: String
    let labels_debug_tags: [String]
    let labels_hierarchy: [String]
    let labels_prev_hierarchy: [String]
    let labels_prev_tags: [String]
    let labels_tags: [String]
    let lang: String
    let languages: [String:Int]
    let languages_hierarchy: [String]
    let languages_tags: [String]
    let last_edit_dates_tags: [String]
    let last_editor: String?  // not always with value
    let last_image_dates_tags: [String]
    let last_image_t: Int
    let last_modified_by: String?  // not always with value
    let last_modified_t: Int // 1463315494
    let lc: String
    let link: String?  // not always with value
    let manufacturing_places: String?  // not always with value
    let manufacturing_places_tags: [String]?  // not always with value
    let max_imgid: String
    let new_additives_n: Int?  // not always with value
    let no_nutrition_data: String
    let nutrient_levels: OFFProductNutrientLevels?
    let nutrient_levels_tags: [OFFProductNutrientLevel]
    let nutrition_grade_fr: String?
    let nutrition_score_debug: String
    let nutriments: OFFProductNutriments
    let nutrition_data_per: String
    let nutrition_grades_tags: [String]
    let origins: String?   // not always with value
    let origins_tags: [String]?   // not always with value
    let packaging: String?
    let packaging_tags: [String]?
    let period_after_opening: String?
    let photographers_tags: [String]
    let pnns_groups_1: String
    let pnns_groups_1_tags: [String]
    let pnns_groups_2: String
    let pnns_groups_2_tags: [String]
    let product_name: String
    // product_name_fr is handled in the child
    let purchase_places: String?
    let purchase_places_tags: [String]?
    let quantity: String?
    let rev: Int
    let scans_n: Int?  // not always with value
    let selected_images: OFFProductSelectedImages
    let server: String?
    let serving_quantity: Double
    let serving_size: String?
    let sortkey: Int
    let states: String
    let states_hierarchy: [OFFProductStates]
    let states_tags: [OFFProductStates]
    let stores: String?
    let stores_tags: [String]?
    let traces: String?
    let traces_hierarchy: [String]?
    let traces_tags: [String]?
    let unique_scans_n: Int?  // not always with value
    let unknown_nutrients_tags: [String]
    let update_key: String?
    let _id: String
    let _keywords: [String]
    
    /*
    enum CodingKeys: String, CodingKey {
        case additives
        case additives_debug_tags
        case additives_n
        case additives_old_n
        case additives_old_tags
        case additives_prev
        case additives_prev_n
        case additives_prev_tags
        case additives_tags
        case allergens
        case allergens_hierarchy
        case allergens_tags
        case brands
        case brands_tags
        case categories
        case categories_debug_tags
        case categories_hierarchy
        case categories_prev_hierarchy
        case categories_prev_tags
        case categories_tags
        case checkers_tags
        case cities_tags
        case code
        case codes_tags
        case complete
        case completed_t
        case correctors_tags
        case countries
        case countries_hierarchy
        case countries_tags
        case created_t
        case creator
        case editors
        case editors_tags
        case emb_codes
        case emb_codes_20141016
        case emb_codes_orig
        case emb_codes_tags
        case expiration_date
        case entry_dates_tags
        // generic_name_fr
        case generic_name
        case id
        case image_front_small_url
        case image_front_thumb_url
        case image_front_url
        case image_ingredients_small_url
        case image_ingredients_thumb_url
        case image_ingredients_url
        case image_nutrition_small_url
        case image_nutrition_thumb_url
        case image_nutrition_url
        case image_small_url
        case image_thumb_url
        case image_url
        case images
        case informers_tags
        case ingredients
        case ingredients_debug
        case ingredients_from_or_that_may_be_from_palm_oil_n
        case ingredients_from_palm_oil_n
        case ingredients_from_palm_oil_tags
        case ingredients_ids_debug
        case ingredients_n
        case ingredients_n_tags
        case ingredients_that_may_be_from_palm_oil_n
        case ingredients_tags
        case ingredients_text
        // ingredients_text_fr
        case ingredients_text_debug
        case ingredients_that_may_be_from_palm_oil_tags
        case ingredients_text_with_allergens
        // case ingredients_text_with_allergens_fr
        case interface_version_created
        case interface_version_modified
        case labels
        case labels_debug_tags
        case labels_hierarchy
        case labels_prev_hierarchy
        case labels_prev_tags
        case labels_tags
        case lang
        case languages
        case languages_codes
        case languages_hierarchy
        case languages_tags
        case last_edit_dates_tags
        case last_editor
        case last_image_dates_tags
        case last_image_t
        case last_modified_by
        case last_modified_t
        case lc
        case link
        case manufacturing_places
        case manufacturing_places_tags
        case max_imgid
        case new_additives_n
        case no_nutrition_data
        case nutrient_levels
        case nutrient_levels_tags
        case nutrition_score_debug
        // case nutriments: OFFProductNutriments
        case nutrition_data_per
        case nutrition_grades_tags
        case origins
        case origins_tags
        case packaging
        case packaging_tags
        case photographers_tags
        case pnns_groups_1
        case pnns_groups_1_tags
        case pnns_groups_2
        case pnns_groups_2_tags
        case product_name
        // product_name_fr
        case purchase_places
        case purchase_places_tags
        case quantity
        case rev
        case scans_n
        case selected_images
        case serving_quantity
        case serving_size
        case sortkey
        case states
        case states_hierarchy
        case states_tags
        case stores
        case stores_tags
        case traces
        case traces_hierarchy
        case traces_tags
        case unique_scans_n
        case unknown_nutrients_tags
        case update_key
        case _id
        case _keywords

    }
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.additives = try container.decode(String.self, forKey: .additives)
        self.additives_debug_tags = try container.decode(Array.self, forKey: .additives_debug_tags) // [String]
        additives_n = try container.decode(Int.self, forKey: .additives_n) //  Int?
        additives_old_n = try container.decode(Int.self, forKey: .additives_old_n) //  Int?
        additives_old_tags = try container.decode(Array.self, forKey: .additives_old_tags) //  [String]
        additives_prev = try container.decode(String.self, forKey: .additives_prev) //  String
        additives_prev_n = try container.decode(Int.self, forKey: .additives_prev_n) //  Int
        additives_prev_tags = try container.decode(Array.self, forKey: .additives_prev_tags) //  [String]
        additives_tags = try container.decode(Array.self, forKey: .additives_tags) //  [String]
        allergens = try container.decode(String.self, forKey: .allergens) //  String
        allergens_hierarchy = try container.decode(Array.self, forKey: .allergens_hierarchy) //  [String]
        allergens_tags = try container.decode(Array.self, forKey: .allergens_tags) //  [String]
        brands = try container.decode(String.self, forKey: .brands) //  String
        brands_tags = try container.decode(Array.self, forKey: .brands_tags) //  [String]
        categories = try container.decode(String.self, forKey: .categories) //  String
        categories_debug_tags = try container.decode(Array.self, forKey: .categories_debug_tags) //  [String]
        categories_hierarchy = try container.decode(Array.self, forKey: .categories_hierarchy) //  [String]
        categories_prev_hierarchy = try container.decode(Array.self, forKey: .categories_prev_hierarchy) //  [String]
        categories_prev_tags = try container.decode(Array.self, forKey: .categories_prev_tags) //  [String]
        categories_tags = try container.decode(Array.self, forKey: .categories_tags) //  [String]
        checkers_tags = try container.decode(Array.self, forKey: .checkers_tags) //  [String]
        cities_tags = try container.decode(Array.self, forKey: .cities_tags) //  [String]?
        code = try container.decode(String.self, forKey: .code) //  String
        codes_tags = try container.decode(Array.self, forKey: .codes_tags) //  [String]
        complete = try container.decode(Int.self, forKey: .complete) //  Int
        completed_t = try container.decode(Int.self, forKey: .completed_t) //  Int?
        correctors_tags = try container.decode(Array.self, forKey: .correctors_tags) //  [String]
        countries = try container.decode(String.self, forKey: .countries) //  String
        countries_hierarchy = try container.decode(Array.self, forKey: .countries_hierarchy) //  [String]
        countries_tags = try container.decode(Array.self, forKey: .countries_tags) //  [String]
        created_t = try container.decode(Int.self, forKey: .created_t) //  Int // 1410949750
        creator = try container.decode(String.self, forKey: .creator) //  String
        editors = try container.decode(Array.self, forKey: .editors) //  [String]?
        editors_tags = try container.decode(Array.self, forKey: .editors_tags) //  [String]
        emb_codes = try container.decode(String.self, forKey: .emb_codes) //  String?
        emb_codes_20141016 = try container.decode(String.self, forKey: .emb_codes_20141016) //  String?
        emb_codes_orig = try container.decode(String.self, forKey: .emb_codes_orig) //  String?
        emb_codes_tags = try container.decode(Array.self, forKey: .emb_codes_tags) //  [String]?
        expiration_date = try container.decode(String.self, forKey: .expiration_date) //  String? // "04/12/2016"
        entry_dates_tags = try container.decode(Array.self, forKey: .entry_dates_tags) //  [String]
        // generic_name_fr
        generic_name = try container.decode(String.self, forKey: .generic_name) //  String
        id = try container.decode(String.self, forKey: .id) //  String
        image_front_small_url = try container.decode(URL.self, forKey: .image_front_small_url) //  URL
        image_front_thumb_url = try container.decode(URL.self, forKey: .image_front_thumb_url) //  URL
        image_front_url = try container.decode(URL.self, forKey: .image_front_url) //  URL
        image_ingredients_small_url = try container.decode(URL.self, forKey: .image_ingredients_small_url) //  URL
        image_ingredients_thumb_url = try container.decode(URL.self, forKey: .image_ingredients_thumb_url) //  URL
        image_ingredients_url = try container.decode(URL.self, forKey: .image_ingredients_url) //  URL
        image_nutrition_small_url = try container.decode(URL.self, forKey: .image_nutrition_small_url) //  URL
        image_nutrition_thumb_url = try container.decode(URL.self, forKey: .image_nutrition_thumb_url) //  URL
        image_nutrition_url = try container.decode(URL.self, forKey: .image_nutrition_url) //  URL
        image_small_url = try container.decode(URL.self, forKey: .image_small_url) //  URL
        image_thumb_url = try container.decode(URL.self, forKey: .image_thumb_url) //  URL
        image_url = try container.decode(String.self, forKey: .image_url) //0  String
        images = try container.decode(Dictionary.self, forKey: .images) // [String:OFFProductImage]
        informers_tags = try container.decode(Array.self, forKey: .informers_tags) //  [String]
        ingredients = try container.decode(Array.self, forKey: .ingredients) //  [OFFProductIngredient]
        ingredients_debug = try container.decode(Array.self, forKey: .ingredients_debug) //  [String]
        ingredients_from_or_that_may_be_from_palm_oil_n = try container.decode(Int.self, forKey: .ingredients_from_or_that_may_be_from_palm_oil_n) //  Int
        ingredients_from_palm_oil_n = try container.decode(Int.self, forKey: .ingredients_from_palm_oil_n) //  Int
        ingredients_from_palm_oil_tags = try container.decode(Array.self, forKey: .ingredients_from_palm_oil_tags) //  [String]
        ingredients_ids_debug = try container.decode(Array.self, forKey: .ingredients_ids_debug) //  [String]
        ingredients_n = try container.decode(String.self, forKey: .ingredients_n) //  String
        ingredients_n_tags = try container.decode(Array.self, forKey: .ingredients_n_tags) //  [String]
        ingredients_that_may_be_from_palm_oil_n = try container.decode(Int.self, forKey: .ingredients_that_may_be_from_palm_oil_n) //  Int
        ingredients_tags = try container.decode(Array.self, forKey: .ingredients_tags) //  [String]
        ingredients_text = try container.decode(String.self, forKey: .ingredients_text) //  String
        // ingredients_text_fr
        ingredients_text_debug = try container.decode(String.self, forKey: .ingredients_text_debug) //  String
        ingredients_that_may_be_from_palm_oil_tags = try container.decode(Array.self, forKey: .ingredients_that_may_be_from_palm_oil_tags) //  [String]
        ingredients_text_with_allergens = try container.decode(String.self, forKey: .ingredients_text_with_allergens) //  String
        // ingredients_text_with_allergens_fr
        interface_version_created = try container.decode(String.self, forKey: .interface_version_created) //  String?  // not always with value
        interface_version_modified = try container.decode(String.self, forKey: .interface_version_modified) //  String
        labels = try container.decode(String.self, forKey: .labels) //  String
        labels_debug_tags = try container.decode(Array.self, forKey: .labels_debug_tags) //  [String]
        labels_hierarchy = try container.decode(Array.self, forKey: .labels_hierarchy) //  [String]
        labels_prev_hierarchy = try container.decode(Array.self, forKey: .labels_prev_hierarchy) //  [String]
        labels_prev_tags = try container.decode(Array.self, forKey: .labels_prev_tags) //  [String]
        labels_tags = try container.decode(Array.self, forKey: .labels_tags) //  [String]
        lang = try container.decode(String.self, forKey: .lang) //  String
        languages = try container.decode(Dictionary.self, forKey: .languages) // Int]
        languages_codes = try container.decode(Dictionary.self, forKey: .languages_codes) // Int]
        languages_hierarchy = try container.decode(Array.self, forKey: .languages_hierarchy) //  [String]
        languages_tags = try container.decode(Array.self, forKey: .languages_tags) //  [String]
        last_edit_dates_tags = try container.decode(Array.self, forKey: .last_edit_dates_tags) //  [String]
        last_editor = try container.decode(String.self, forKey: .last_editor) //  String?  // not always with value
        last_image_dates_tags = try container.decode(Array.self, forKey: .last_image_dates_tags) //  [String]
        last_image_t = try container.decode(Int.self, forKey: .last_image_t) //  Int
        last_modified_by = try container.decode(String.self, forKey: .last_modified_by) //  String?  // not always with value
        last_modified_t = try container.decode(Int.self, forKey: .last_modified_t) //  Int // 1463315494
        lc = try container.decode(String.self, forKey: .lc) //  String
        link = try container.decode(String.self, forKey: .link) //  String?  // not always with value
        manufacturing_places = try container.decode(String.self, forKey: .manufacturing_places) //  String?  // not always with value
        manufacturing_places_tags = try container.decode(Array.self, forKey: .manufacturing_places_tags) //  [String]?  // not always with value
        max_imgid = try container.decode(String.self, forKey: .max_imgid) //  String
        new_additives_n = try container.decode(Int.self, forKey: .new_additives_n) //  Int?  // not always with value
        no_nutrition_data = try container.decode(String.self, forKey: .no_nutrition_data) //  String
        nutrient_levels = try container.decode(OFFProductNutrientLevels.self, forKey: .nutrient_levels) //  OFFProductNutrientLevels?
        nutrient_levels_tags = try container.decode(Array.self, forKey: .nutrient_levels_tags) //  [OFFProductNutrientLevel]
        nutrition_score_debug = try container.decode(String.self, forKey: .nutrition_score_debug) //  String
        // nutriments = try container.decode(Array.self, forKey: .additives_debug_tags) //  OFFProductNutriments
        nutrition_data_per = try container.decode(String.self, forKey: .nutrition_data_per) //  String
        nutrition_grades_tags = try container.decode(Array.self, forKey: .nutrition_grades_tags) //  [String]
        origins = try container.decode(String.self, forKey: .origins) //  String?   // not always with value
        origins_tags = try container.decode(Array.self, forKey: .origins_tags) //  [String]?   // not always with value
        packaging = try container.decode(String.self, forKey: .packaging) //  String
        packaging_tags = try container.decode(Array.self, forKey: .packaging_tags) //  [String]
        photographers_tags = try container.decode(Array.self, forKey: .photographers_tags) //  [String]
        pnns_groups_1 = try container.decode(String.self, forKey: .pnns_groups_1) //  String
        pnns_groups_1_tags = try container.decode(Array.self, forKey: .pnns_groups_1_tags) //  [String]
        pnns_groups_2 = try container.decode(String.self, forKey: .pnns_groups_2) //  String
        pnns_groups_2_tags = try container.decode(Array.self, forKey: .pnns_groups_2_tags) //  [String]
        product_name = try container.decode(String.self, forKey: .product_name) //  String
        // product_name_fr
        purchase_places = try container.decode(String.self, forKey: .purchase_places) //  String?
        purchase_places_tags = try container.decode(Array.self, forKey: .purchase_places_tags) //  [String]
        quantity = try container.decode(String.self, forKey: .quantity) //  String
        rev = try container.decode(Int.self, forKey: .rev) //  Int
        scans_n = try container.decode(Int.self, forKey: .scans_n) //  Int?  // not always with value
        selected_images = try container.decode(OFFProductSelectedImages.self, forKey: .selected_images) //  OFFProductSelectedImages
        serving_quantity = try container.decode(Double.self, forKey: .serving_quantity) //  Double
        serving_size = try container.decode(String.self, forKey: .serving_size) //  String?
        sortkey = try container.decode(Int.self, forKey: .sortkey) //  Int
        states = try container.decode(String.self, forKey: .states) //  String
        states_hierarchy = try container.decode(Array.self, forKey: .states_hierarchy) //  [OFFProductStates]
        states_tags = try container.decode(Array.self, forKey: .states_tags) //  [OFFProductStates]
        stores = try container.decode(String.self, forKey: .stores) //  String
        stores_tags = try container.decode(Array.self, forKey: .stores_tags) //  [String]
        traces = try container.decode(String.self, forKey: .traces) //  String?
        traces_hierarchy = try container.decode(Array.self, forKey: .traces_hierarchy) //  [String]?
        traces_tags = try container.decode(Array.self, forKey: .traces_tags) //  [String]?
        unique_scans_n = try container.decode(Int.self, forKey: .unique_scans_n) //  Int?  // not always with value
        unknown_nutrients_tags = try container.decode(Array.self, forKey: .unknown_nutrients_tags) //  [String]
        update_key = try container.decode(String.self, forKey: .update_key) //  String?
        _id = try container.decode(String.self, forKey: ._id) //  String
        _keywords = try container.decode(Array.self, forKey: ._keywords) //  [String]

    }
 */
}
