struct UserLoginDao:Decodable {
    let emp_id  : String?
    let emp_code  : String?
    let emp_username  : String?
    let emp_password  : String?
    let emp_pic  : String?
    let comp_id  : String?
    let mny_permission_code  : String?
    let emp_type  : String?
    let stk_type_code  : String?
    let acrp_id  : String?
    let branch_id  : String?
    let action:String?
    let firstname:String?
    let lastname:String?
    let dept_id:String?
}

struct  TimeLoadDao : Decodable{
    var count:String?
    var toDate:String?
    var comp_name:String?
    var lat:String?
    var lng:String?
    var comp_circumference:String?
    var stamp_in:String?
    var stamp_out:String?
    var inshif:String?
    var outshif:String?
    var branch_name:String?
    var branch_id:String?
}

struct  timeStampResult : Decodable{
    var status:Int
    var msg:String?
}

struct BranchAll:Decodable {
    let data:[TimeLoadDao]?
    let max : Int?
    
}

struct ActivityAll:Decodable {
    let data:[ActivityLists]?
    let max : Int?
    
}

struct  ActivityLists : Decodable{
    var id:String?
    var start_time:String?
    var end_time:String?
    var id_crearter:String?
    var activity_name:String?
    var lat:String?
    var lng:String?
    var location:String?
    var activity_cust:String?
    var circumference:String?
    var toDate:String?
    var stamp_in:String?
    var stamp_out:String?
    var count:String?
}

//Work module
struct  UnderUsers : Decodable{
    let data:[UnderUser]?
    let max : Int?
    let under_size : Int?
}

struct  UnderUser : Decodable{
    var emp_id:String?
    var under_emp_id:String?
    var emp_code:String?
    var emp_time_id:String?
    var emp_erp_id:String?
    var emp_username:String?
    var emp_password:String?
    var email:String?
    var posi_id:String?
    var posilv_id:String?
    var dept_id:String?
    var divis_id:String?
    var comp_id:String?
    var mail_group_id:String?
    var emp_type:String?
    var emp_start_date:String?
    var pass_pro:String?
    var emp_end_date:String?
    var emp_date_create:String?
    var emp_last_update:String?
    var emp_del:String?
    var emp_tel:String?
    var acrp_id:String?
    var system_type:String?
    var employee_type:String?
    var annou_lastview:String?
    var emp_referrer:String?
    var secret_code:String?
    var tmp_secret_code:String?
    var branch_id:String?
    var single_sign_on:String?
    var firebase_register_id:String?
    var emp_type_id:String?
    var title:String?
    var gender:String?
    var religion:String?
    var firstname:String?
    var lastname:String?
    var firstname_th:String?
    var lastname_th:String?
    var date_birth:String?
    var emp_pic:String?
    var date_create:String?
    var last_update:String?
    var nickname:String?
    var dna:String?
    var tel_office:String?
    var size_shirt:String?
    var bank_account:String?
    var social_hosp_id:String?
    var social_hosp_start:String?
    var social_hosp_end:String?
    var group_hosp_id:String?
    var group_hosp_start:String?
    var group_hosp_end:String?
    var signature:String?
    var signature_drawing:String?
    var dashboard:String?
    var m_job_desc:String?
    var m_job_spec:String?
    var job_description:String?
    var job_specification:String?
}

struct  WorkBalances : Decodable{
    let data:[WorkBalance]?
}

struct  WorkBalance : Decodable{
    var leave_type_id:String?
    var leave_type_color:String?
    var leave_type_name_en:String?
    var leave_type_name_th:String?
    var total:String?
    var used:String?
    var Available:String?
    var before_day:String?
    var hours_day:String?
}

struct  WorkLeaves : Decodable{
    let data:[WorkLeave]?
}

struct  WorkLeave : Decodable{
    var see_id:String?
    var TYPE:String?
    var from_date:String?
    var from_time:String?
    var to_date:String?
    var to_time:String?
    var total_date:String?
    var total_date_hour:String?
    var total_time:String?
    var reason:String?
    var dt:String?
    var note:String?
    var leave_name:String?
    var leave_name_th:String?
    var state_approve:String?
    var name_approve:String?
    var approve_comment:String?
    var leave_color:String?
    var approve_del:String?
    var del_status:String?
}

struct  NeedLists : Decodable{
    let list_request:[NeedList]?
}

struct  NeedList : Decodable{
    var name:String?
    var type:String?
    var doc_no:String?
    var date:String?
    var subject:String?
    var id:String?
    var status:String?
    var total:String?
    var type_id:String?
    var mny_for_team_id:String?
    var mny_request_note:String?
    var mny_request_type_id:String?
    var project_id:String?
    var apv_status:String?
}

struct  NeedItems : Decodable{
    let project_list:[NeedItems_Project]?
    let type_need:[NeedItems_Type]?
    let dept_list:[NeedItems_Depart]?
}

struct  NeedItems_Project : Decodable{
    var project_id:String?
    var inherit_project_id:String?
    var main_project_id:String?
    var state_project_num:String?
    var project_generate:String?
    var cus_id:String?
    var cont_id:String?
    var project_code:String?
    var project_name:String?
    var project_type_id:String?
    var project_categories_id:String?
    var project_comefrom_id:String?
    var project_latitude:String?
    var project_longtitude:String?
    var projct_location:String?
    var project_start:String?
    var project_end:String?
    var project_status_id:String?
    var project_sale_status_id:String?
    var project_oppo_id:String?
    var project_description:String?
    var project_value:String?
    var project_area:String?
    var project_area_plaster:String?
    var project_area_tbar:String?
    var project_area_wall:String?
    var currency_id:String?
    var project_all_cost:String?
    var project_all_dis:String?
    var project_all_total:String?
    var project_dis_percent:String?
    var project_dis_value:String?
    var project_oppo_reve:String?
    var photo_album_id:String?
    var emp_id:String?
    var project_create_user:String?
    var project_create_date:String?
    var project_last_user:String?
    var project_last_date:String?
    var last_activity_id:String?
    var last_activity_date:String?
    var project_del:String?
    var comp_id:String?
    var approve_quo:String?
    var project_during_start:String?
    var project_during_end:String?
    var project_service_level:String?
    var type_service_level:String?
    var project_auto_complete:String?
    var project_support:String?
    var project_model:String?
    var project_distance:String?
}

struct  NeedItems_Type : Decodable{
    var comp_id:String?
    var mny_request_generate_code:String?
    var mny_request_generate_generate:String?
    var mny_request_generate_year:String?
    var mny_request_generate_name:String?
    var mny_request_generate_status:String?
}

struct  NeedItems_Depart : Decodable{
    var dept_id:String?
    var dept_parent_id:String?
    var dept_code:String?
    var dept_description:String?
    var dept_head_flag:String?
    var dept_date_create:String?
    var dept_last_update:String?
    var comp_id:String?
    var dept_sort_no:String?
    var dept_del:String?
}

struct  NeedDetailLists : Decodable{
    let unit:[NeedDetail_Unit]?
    let type:[NeedDetail_Type]?
}

struct  NeedDetail_Unit : Decodable{
    var uom_code:String?
    var type_uom:String?
    var uom_description:String?
    var uom_second_description:String?
    var uom_third_description:String?
    var uom_soratble:String?
}

struct  NeedDetail_Type : Decodable{
    var comp_id:String?
    var mny_item_id:String?
    var mny_category_id:String?
    var mny_item_name:String?
    var mny_item_price:String?
    var mny_item_status:String?
    var mny_item_create_user:String?
    var mny_item_create_datetime:String?
    var mny_item_cal_distance:String?
}

struct  Request_Id : Decodable{
    var request_id:Int?
}

struct  Item_Id : Decodable{
    var ins_item_id:Int?
}

struct  Delete_Need : Decodable{
    var status:String?
    var massage:String?
}

struct  NeedItemDetail : Decodable{
    var data:[ItemDetail]?
}

struct  ItemDetail : Decodable{
    var unit:String?
    var mny_item_id:String?
    var item_name:String?
    var mny_item_sort_no:String?
    var mny_request_item_note:String?
    var mny_request_item_price:String?
    var mny_request_item_quantity:String?
    var mny_request_total:String?
    var listImg:[String]?
}

struct  UpdateNeed : Decodable{
    var status:String?
    var msg:String?
}

struct  NeedApprove : Decodable{
    var data:[ItemApprove]?
    var max:Int?
}

struct  ItemApprove : Decodable{
    var mny_request_id:String?
    var mny_permission_code:String?
    var mny_request_approve_code:String?
    var mny_request_approve_code_hint:String?
    var mny_request_approve_status:String?
    var mny_request_approve_datetime:String?
    var mny_request_approve_comment:String?
    var mny_request_approve_emp_id:String?
    var mny_permission_name:String?
    var emp_id:String?
    var title:String?
    var gender:String?
    var religion:String?
    var firstname:String?
    var lastname:String?
    var firstname_th:String?
    var lastname_th:String?
    var date_birth:String?
    var emp_pic:String?
    var date_create:String?
    var last_update:String?
    var nickname:String?
    var dna:String?
    var tel_office:String?
    var size_shirt:String?
    var bank_account:String?
    var social_hosp_id:String?
    var social_hosp_start:String?
    var social_hosp_end:String?
    var group_hosp_id:String?
    var group_hosp_start:String?
    var group_hosp_end:String?
    var signature:String?
    var signature_drawing:String?
    var dashboard:String?
    var m_job_desc:String?
    var m_job_spec:String?
    var job_description:String?
    var job_specification:String?
    var comp_id:String?
    var mny_type_id:String?
    var mny_sort_number:String?
    var this_prove_code:String?
}

struct  WorkRequests : Decodable{
    var data:[WorkRequest]?
}

struct  WorkRequest : Decodable{
    var type:String?
    var approve_name:String?
    var u_id:String?
    var u_emp_id:String?
    var end:String?
    var u_firstname:String?
    var u_lastname:String?
    var u_head_id:String?
    var u_apv_status:String?
    var u_apv_comment:String?
    var u_apv_code:String?
    var u_subject:String?
    var u_req_start:String?
    var u_req_start_time:String?
    var u_req_end:String?
    var u_req_end_time:String?
    var u_total_time:String?
    var u_no_money:String?
    var u_type_en:String?
    var u_type_th:String?
}

struct  NeedRequests : Decodable{
    var data:[NeedRequest]?
    var max:Int?
}

struct  NeedRequest : Decodable{
    var mny_request_id:String?
    var emp_id:String?
    var mny_request_type_id:String?
    var user_create:String?
    var type:String?
    var mny_request_generate_code:String?
    var mny_request_date:String?
    var mny_request_location:String?
    var mny_request_total:String?
    var mny_request_note:String?
    var emp_pic:String?
    var dept:String?
    var project_id:String?
    var project_name:String?
    var generat:String?
    var mny_sort_number:String?
    var under_wait_approve:String?
}

struct  RequestOTLists : Decodable{
    var msg:[RequestOTList]?
    var status:Int?
}

struct  RequestOTList : Decodable{
    var id_request_ot:String?
    var request_run_no:String?
    var request_ot_in:String?
    var request_ot_out:String?
    var ot_reason:String?
    var ot_status:String?
    var create_by_user:String?
    var emp_id:String?
    var comp_id:String?
    var total_hrs:String?
    var emp_info:String?
    var emp_pic:String?
    var upper_name:String?
    var creater_name:String?
    var creater_pic:String?
}

struct  BasicReturn : Decodable{
    var msg:String?
    var status:Int?
}

struct  AccountLists : Decodable{
    var data:[AccountList]?
    var max:Int?
    var sum:Int?
}

struct  AccountList : Decodable{
    var cus_id:String?
    var cus_name_th:String?
    var cus_name_en:String?
    var cus_code:String?
    var cus_tel_no:String?
    var cus_fax_no:String?
    var cus_email:String?
    var cus_website:String?
    var cus_latitude:String?
    var cus_longtitude:String?
    var cus_description:String?
    var emp_id:String?
    var cus_logo:String?
    var cus_mob_no:String?
    var cus_group_name:String?
    var cus_type_name:String?
    var cus_status_name:String?
    var cus_group_id:String?
    var cus_status_id:String?
    var cus_type_id:String?
    var cus_facebook:String?
    var comp_id:String?
    var cus_address_th:String?
    var cus_txtsoi:String?
    var cus_txtroad:String?
    var cus_txtbuilding:String?
    var country_id:String?
    var country_name:String?
    var province_id:String?
    var province_txt:String?
    var district_id:String?
    var district_txt:String?
    var sub_district_id:String?
    var sub_district_txt:String?
    var post_id:String?
    var post_txt:String?
    var firstname:String?
    var lastname:String?
    var emp_pic:String?
    var cus_code_old:String?
    var cus_tax_no:String?
    var cus_cost_register:String?
    var cus_size:String?
    var cus_all_staff:String?
    var ship_location_name:String?
    var ship_latitude:String?
    var ship_longtitude:String?
    var doc_location_name:String?
    var doc_latitude:String?
    var doc_longtitude:String?
    var cus_location_name:String?
    var cus_type_doc_id:String?
    var cus_type_doc_name:String?
    var cus_map:String?
    var doc_address:String?
    var ship_address:String?
    var work_dial:String?
    var mob_dial:String?
    var fax_dial:String?
}

struct GroupLists : Decodable{
    var cus_group_id:String?
    var cus_group_shcode:String?
    var cus_group_name:String?
    var cus_group_gen:String?
    var cus_group_create_user:String?
    var cus_group_create_date:String?
    var comp_id:String?
}

struct StatusLists : Decodable{
    var cus_status_id:String?
    var cus_status_name:String?
    var cus_status_create_user:String?
    var comp_id:String?
}

struct TypeLists : Decodable{
    var cus_type_id:String?
    var cus_type_name:String?
    var cus_type_create_user:String?
    var comp_id:String?
}

struct WorkShift : Decodable{
    var state:String?
    var txt:String?
}

struct FloatShift : Decodable{
    var state:String?
    var txt:String?
    var sum_break:String?
}

struct  AddressComponent : Decodable{
    var country:[Country]?
    var province:[Province]?
    var district:[District]?
    var sub_district:[Sub_District]?
    var postcode:[Postcode]?
}

struct Country : Decodable{
    var country_id:String?
    var country_name:String?
}

struct Province : Decodable{
    var province_id:String?
    var province_name:String?
    var country_id:String?
}

struct District : Decodable{
    var district_id:String?
    var district_name:String?
    var province_id:String?
}

struct Sub_District : Decodable{
    var sub_district_id:String?
    var sub_district_name:String?
    var district_id:String?
}

struct Postcode : Decodable{
    var district_post_id:String?
    var district_id:String?
    var post_code:String?
    var country_id:String?
}

struct Payment : Decodable{
    var cus_type_doc_id:String?
    var cus_type_doc_name:String?
}

struct  AccountContacts : Decodable{
    var data:[AccountContact]?
    var status:Int?
}

struct  AccountContact : Decodable{
    var cus_cont_id:String?
    var cus_cont_name:String?
    var cus_cont_photo:String?
    var cus_cont_surname:String?
    var cus_cont_mob:String?
    var cus_cont_tel:String?
}

struct  AccountProjects : Decodable{
    var data:[AccountProject]?
    var status:Int?
}

struct  AccountProject : Decodable{
    var project_id:String?
    var project_name:String?
    var firstname:String?
    var lastname:String?
    var firstname_th:String?
    var lastname_th:String?
    var cus_cont_name:String?
    var cus_cont_surname:String?
}

struct  AccountActivitys : Decodable{
    var data:[AccountActivity]?
    var status:Int?
}

struct  AccountActivity : Decodable{
    var activity_id:String?
    var activity_project_name:String?
    var activity_start_date:String?
    var activity_start_time_:String?
    var activity_end_date:String?
    var activity_end_time_:String?
    var emp_pic:String?
    var cus_cont_name:String?
    var cus_cont_surname:String?
    var project_name:String?
    var comp_id:String?
    var emp_id:String?
    var first_en:String?
    var last_en:String?
    var first_th:String?
    var last_th:String?
    var account:String?
    var account_th:String?
    var type_chage:String?
    var activity_status:String?
    var type_name:String?
    var status:String?
}

struct  ActivitysLists : Decodable{
    var data:[ActivitysList]?
}

struct  ActivitysList : Decodable{
    var activity_id:String?
    var activity_name:String?
    var comp_id:String?
    var emp_id:String?
    var start_date:String?
    var end_date:String?
    var time_start:String?
    var time_end:String?
    var first_en:String?
    var last_en:String?
    var first_th:String?
    var last_th:String?
    var emp_pic:String?
    var account:String?
    var account_th:String?
    var project_name:String?
    var type_chage:String?
    var activity_status:String?
    var type_name:String?
    var status:String?
}

struct  StartEndWork : Decodable{
    var dt:String?
    var datetime_in:String?
    var datetime_out:String?
}

struct  NumberType : Decodable{
    var name:String?
    var dial_code:String?
    var code:String?
}

struct  AddressTxt : Decodable{
    var country:[AddressName]?
    var province:[AddressName]?
    var district:[AddressName]?
    var sub_district:[AddressName]?
}

struct AddressName : Decodable{
    var name:String?
}

struct  ActivityTypes : Decodable{
    var data:[ActivityType]?
}

struct  ActivityType : Decodable{
    var type_id:String?
    var type_name:String?
}

struct  ActivityProjects : Decodable{
    var data:[ActivityProject]?
}

struct  ActivityProject : Decodable{
    var project_id:String?
    var project_name:String?
}

struct  ActivityContacts : Decodable{
    var data:[ActivityContact]?
}

struct  ActivityContact : Decodable{
    var contact_id:String?
    var contact_first:String?
    var contact_last:String?
    var account_id:String?
    var account_en:String?
    var account_th:String?
}

struct  ActivityStatuss : Decodable{
    var data:[ActivityStatus]?
}

struct  ActivityStatus : Decodable{
    var status_id:String?
    var status_name:String?
}

struct  ActivityPrioritys : Decodable{
    var data:[ActivityPriority]?
}

struct  ActivityPriority : Decodable{
    var priority_id:String?
    var priority_name:String?
    var priority_value:String?
}

struct  AddActivityContacts : Decodable{
    var data:[AddActivityContact]?
}

struct  AddActivityContact : Decodable{
    var contact_id:String?
    var contact_first:String?
    var contact_last:String?
    var contact_image:String?
    var customer_id:String?
    var customer_en:String?
    var customer_th:String?
}

struct  StandardReturn : Decodable{
    var status:String?
    var msg:String?
}

struct ActivityInfo : Decodable{
    var data:[ActivityInfoData]?
    var other_contact:[ActivityInfoContact]?
}

struct ActivityInfoData : Decodable{
    var activity_id:String?
    var activity_name:String?
    var activity_description:String?
    var comp_id:String?
    var emp_id:String?
    var start_date:String?
    var end_date:String?
    var time_start:String?
    var time_end:String?
    var first_en:String?
    var last_en:String?
    var emp_pic:String?
    var account_en:String?
    var account_th:String?
    var contact_first:String?
    var contact_last:String?
    var project_name:String?
    var type_id:String?
    var type_name:String?
    var project_id:String?
    var account_id:String?
    var contact_id:String?
    var place:String?
    var status_id:String?
    var status_name:String?
    var priority_id:String?
    var priority_name:String?
    var location:String?
    var location_lat:String?
    var location_lng:String?
    var cost:String?
    var activity_status:String?
    var skoop_id:String?
    var skoop_detail:String?
    var skoop_location:String?
    var skoop_lat:String?
    var skoop_lng:String?
    var skooped:String?
    var status:String?
    var stamp_in:String?
    var stamp_out:String?
    var is_ticket:String?
}

struct ActivityInfoContact : Decodable{
    var contact_id:String?
    var contact_first:String?
    var contact_last:String?
    var account_en:String?
    var account_th:String?
    var contact_image:String?
}

struct ActivityFiles : Decodable{
    var data:[ActivityFile]?
}

struct ActivityFile : Decodable{
    var activity_id:String?
    var image_id:String?
    var image_path:String?
    var image_name:String?
    var image_type:String?
}

struct SkoopFiles : Decodable{
    var data:[SkoopFile]?
}

struct SkoopFile : Decodable{
    var image_id:String?
    var image_path:String?
    var image_name:String?
}

struct MenuLists : Decodable{
    var status:String?
    var msg:String?
    var data:[MenuList]?
}

struct MenuList : Decodable{
    var acm_name:String?
    var path:String?
    var acm_seq:String?
}

struct  WorkDatas : Decodable{
    var status:String?
    var msg:String?
    var data:[WorkData]
}

struct  WorkData : Decodable{
    var emp_id:String?
    var first_en:String?
    var last_en:String?
    var first_th:String?
    var last_th:String?
    var type_id:String?
    var start_date:String?
    var start_time:String?
    var end_date:String?
    var end_time:String?
    var total_date:String?
    var total_time:String?
    var subject:String?
    var note:String?
    var no_money:String?
}

//----------------------------------------------------------------------

public class selectedEmp {
    var emp_id: String
    var comp_id: String
    var f_name: String
    var l_name: String
    init(emp_id: String,comp_id: String,f_name: String,l_name: String) {
        self.emp_id = emp_id
        self.comp_id = comp_id
        self.f_name = f_name
        self.l_name = l_name
    }
}

public class selectedAccount {
    var cus_id: String
    var group_id: String
    var group_gen: String
    var group_type_id: String
    var status: String
    var code: String
    var comp_th: String
    var comp_en: String
    var work_tel: String
    var mobile_tel: String
    var fax: String
    var email: String
    var website: String
    var facebook: String
    var contact: String
    var no: String
    var lane: String
    var building: String
    var road: String
    var distict: String
    var sub_distict: String
    var provice: String
    var post_code: String
    var country: String
    var distict_txt: String
    var sub_distict_txt: String
    var provice_txt: String
    var country_txt: String
    var comp_size: String
    var regist: String
    var regist_name:String
    var regist_capital: String
    var number_staff: String
    var payterm: String
    var tax_id: String
    var old_code: String
    var description: String
    var cusLat: String
    var cusLng: String
    var cusLocation: String
    var shipLat: String
    var shipLng: String
    var shipLocation: String
    var docLat: String
    var docLng: String
    var docLocation: String
    var ship_address: String
    var doc_address: String
    var work_dial: String
    var mob_dial: String
    var fax_dial: String
    
    init(cus_id: String,group_id: String,group_gen: String,group_type_id: String,status: String,code: String,comp_th: String,comp_en: String,work_tel: String,mobile_tel: String,fax: String,email: String,website: String,facebook: String,contact: String,no: String,lane: String,building: String,road: String,distict: String,sub_distict: String,provice: String,post_code: String,country: String,distict_txt: String,sub_distict_txt: String,provice_txt: String,country_txt: String,comp_size: String,regist: String,regist_name: String,regist_capital: String,number_staff: String,payterm: String,tax_id: String,old_code: String,description: String,cusLat: String,cusLng: String,cusLocation: String,shipLat: String,shipLng: String,shipLocation: String,docLat: String,docLng: String,docLocation: String,ship_address: String,doc_address: String,work_dial: String,mob_dial: String,fax_dial: String) {
        self.cus_id = cus_id
        self.group_id = group_id
        self.group_gen = group_gen
        self.group_type_id = group_type_id
        self.status = status
        self.code = code
        self.comp_th = comp_th
        self.comp_en = comp_en
        self.work_tel = work_tel
        self.mobile_tel = mobile_tel
        self.fax = fax
        self.email = email
        self.website = website
        self.facebook = facebook
        self.contact = contact
        self.no = no
        self.lane = lane
        self.building = building
        self.road = road
        self.distict = distict
        self.sub_distict = sub_distict
        self.provice = provice
        self.post_code = post_code
        self.country = country
        self.distict_txt = distict_txt
        self.sub_distict_txt = sub_distict_txt
        self.provice_txt = provice_txt
        self.country_txt = country_txt
        self.comp_size = comp_size
        self.regist = regist
        self.regist_name = regist_name
        self.regist_capital = regist_capital
        self.number_staff = number_staff
        self.payterm = payterm
        self.tax_id = tax_id
        self.old_code = old_code
        self.description = description
        self.cusLat = cusLat
        self.cusLng = cusLng
        self.cusLocation = cusLocation
        self.shipLat = shipLat
        self.shipLng = shipLng
        self.shipLocation = shipLocation
        self.docLat = docLat
        self.docLng = docLng
        self.docLocation = docLocation
        self.ship_address = ship_address
        self.doc_address = doc_address
        self.work_dial = work_dial
        self.mob_dial = mob_dial
        self.fax_dial = fax_dial
    }
}

public class newAccounts {
    var cus_id: String
    var group_id: String
    var group_gen: String
    var group_type_id: String
    var status: String
    var code: String
    var comp_th: String
    var comp_en: String
    var work_tel: String
    var mobile_tel: String
    var fax: String
    var email: String
    var website: String
    var facebook: String
    var contact: String
    var no: String
    var lane: String
    var building: String
    var road: String
    var distict: String
    var sub_distict: String
    var provice: String
    var post_code: String
    var country: String
    var distict_txt: String
    var sub_distict_txt: String
    var provice_txt: String
    var country_txt: String
    var comp_size: String
    var regist: String
    var regist_name:String
    var regist_capital: String
    var number_staff: String
    var payterm: String
    var payterm_name: String
    var tax_id: String
    var old_code: String
    var description: String
    var cusLat: String
    var cusLng: String
    var cusLocation: String
    var shipLat: String
    var shipLng: String
    var shipLocation: String
    var docLat: String
    var docLng: String
    var docLocation: String
    var shipAddress: String
    var docAddress: String
    var work_dial: String
    var mob_dial: String
    var fax_dial: String
    init(cus_id: String,group_id: String,group_gen: String,group_type_id: String,status: String,code: String,comp_th: String,comp_en: String,work_tel: String,mobile_tel: String,fax: String,email: String,website: String,facebook: String,contact: String,no: String,lane: String,building: String,road: String,distict: String,sub_distict: String,provice: String,post_code: String,country: String,distict_txt: String,sub_distict_txt: String,provice_txt: String,country_txt: String,comp_size: String,regist: String,regist_name: String,regist_capital: String,number_staff: String,payterm: String,payterm_name: String,tax_id: String,old_code: String,description: String,cusLat: String,cusLng: String,cusLocation: String,shipLat: String,shipLng: String,shipLocation: String,docLat: String,docLng: String,docLocation: String,shipAddress: String,docAddress: String,work_dial: String,mob_dial: String,fax_dial: String) {
        self.cus_id = cus_id
        self.group_id = group_id
        self.group_gen = group_gen
        self.group_type_id = group_type_id
        self.status = status
        self.code = code
        self.comp_th = comp_th
        self.comp_en = comp_en
        self.work_tel = work_tel
        self.mobile_tel = mobile_tel
        self.fax = fax
        self.email = email
        self.website = website
        self.facebook = facebook
        self.contact = contact
        self.no = no
        self.lane = lane
        self.building = building
        self.road = road
        self.distict = distict
        self.sub_distict = sub_distict
        self.provice = provice
        self.post_code = post_code
        self.country = country
        self.distict_txt = distict_txt
        self.sub_distict_txt = sub_distict_txt
        self.provice_txt = provice_txt
        self.country_txt = country_txt
        self.comp_size = comp_size
        self.regist = regist
        self.regist_name = regist_name
        self.regist_capital = regist_capital
        self.number_staff = number_staff
        self.payterm = payterm
        self.payterm_name = payterm_name
        self.tax_id = tax_id
        self.old_code = old_code
        self.description = description
        self.cusLat = cusLat
        self.cusLng = cusLng
        self.cusLocation = cusLocation
        self.shipLat = shipLat
        self.shipLng = shipLng
        self.shipLocation = shipLocation
        self.docLat = docLat
        self.docLng = docLng
        self.docLocation = docLocation
        self.shipAddress = shipAddress
        self.docAddress = docAddress
        self.work_dial = work_dial
        self.mob_dial = mob_dial
        self.fax_dial = fax_dial
    }
}

public class activity_data {
    var activity_id : String
    var emp_id      : String
    var comp_id     : String
    var subject     : String
    var description : String
    var start_date  : String
    var start_time  : String
    var end_date    : String
    var end_time    : String
    var type        : String
    var project     : String
    var contact     : String
    var account     : String
    var place       : String
    var status      : String
    var priority    : String
    var cost        : String
    var location    : String
    var location_lat: String
    var location_long: String
    var type_id     : String
    var project_id  : String
    var contact_id  : String
    var account_id  : String
    var place_id    : String
    var status_id   : String
    var priority_id : String
    var other_contact: [activity_contacts]
    var skoop_id: String
    var skoop_description: String
    var skoop_location : String
    var skoop_lat : String
    var skoop_lng : String
    var skooped : String
    var close_start_date  : String
    var close_start_time  : String
    var close_end_date    : String
    var close_end_time    : String
    var activity_status : String
    var stamp_in    : String
    var stamp_out : String
    var is_ticket : String
    init(activity_id: String, emp_id: String,comp_id: String,subject: String,description: String,start_date: String,start_time: String,end_date: String,end_time: String,type: String,project: String,contact: String,account: String,place: String,status: String,priority: String,cost: String,location: String,location_lat: String,location_long: String,type_id: String,project_id: String,contact_id: String,account_id: String,place_id: String,status_id: String,priority_id: String,other_contact: [activity_contacts],skoop_id: String,skoop_description: String,skoop_location: String,skoop_lat: String,skoop_lng: String,skooped: String,close_start_date: String,close_start_time: String,close_end_date: String,close_end_time: String,activity_status: String,stamp_in: String,stamp_out: String,is_ticket: String) {
        self.activity_id = activity_id
        self.emp_id     = emp_id
        self.comp_id    = comp_id
        self.subject    = subject
        self.description = description
        self.start_date = start_date
        self.start_time = start_time
        self.end_date   = end_date
        self.end_time   = end_time
        self.type       = type
        self.project    = project
        self.contact    = contact
        self.account    = account
        self.place      = place
        self.status     = status
        self.priority   = priority
        self.cost       = cost
        self.location   = location
        self.location_lat = location_lat
        self.location_long = location_long
        self.type_id    = type_id
        self.project_id = project_id
        self.contact_id = contact_id
        self.account_id = account_id
        self.place_id   = place_id
        self.status_id  = status_id
        self.priority_id = priority_id
        self.other_contact = other_contact
        self.skoop_id = skoop_id
        self.skoop_description   = skoop_description
        self.skoop_location  = skoop_location
        self.skoop_lat = skoop_lat
        self.skoop_lng = skoop_lng
        self.close_start_date   = close_start_date
        self.close_start_time  = close_start_time
        self.close_end_date = close_end_date
        self.close_end_time = close_end_time
        self.skooped = skooped
        self.activity_status = activity_status
        self.stamp_in = stamp_in
        self.stamp_out = stamp_out
        self.is_ticket = is_ticket
    }
}

public class activity_contacts {
    var contact_id          : String
    var contact_first       : String
    var contact_last        : String
    var contact_image       : String
    var contact_account_en  : String
    var contact_account_th  : String
    init(contact_id: String,contact_first: String,contact_last: String,contact_image: String,contact_account_en: String,contact_account_th: String) {
        self.contact_id         = contact_id
        self.contact_first      = contact_first
        self.contact_last       = contact_last
        self.contact_image      = contact_image
        self.contact_account_en = contact_account_en
        self.contact_account_th = contact_account_th
    }
}

public class menuList {
    var time: String
    var request_ot: String
    var work: String
    var need: String
    var approval: String
    var account: String
    var activity: String
    init(time: String,request_ot: String,work: String,need: String,approval: String,account: String,activity: String) {
        self.time = time
        self.request_ot = request_ot
        self.work = work
        self.need = need
        self.approval = approval
        self.account = account
        self.activity = activity
    }
}
