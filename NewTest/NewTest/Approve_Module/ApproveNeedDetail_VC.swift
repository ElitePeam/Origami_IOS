//
//  ApproveNeedDetail_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 28/4/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit

class ApproveNeedDetail_VC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collection_item: UICollectionView!
    @IBOutlet weak var collection_image: UICollectionView!
    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var label_price: UILabel!
    @IBOutlet weak var label_unit: UILabel!
    @IBOutlet weak var label_total: UILabel!
    @IBOutlet weak var label_amout: UILabel!
    @IBOutlet weak var textfield_detail: UITextView!
    @IBOutlet weak var view_info: UIView!
    @IBOutlet weak var label_date: UILabel!
    @IBOutlet weak var label_info_type: UILabel!
    @IBOutlet weak var label_project: UILabel!
    @IBOutlet weak var label_dept: UILabel!
    @IBOutlet weak var label_topic: UILabel!
    @IBOutlet weak var label_reason: UILabel!
    @IBOutlet weak var view_content: UIView!
    @IBOutlet weak var button_close: UIButton!
    @IBOutlet weak var txt_type: UILabel!
    @IBOutlet weak var txt_price: UILabel!
    @IBOutlet weak var txt_unit: UILabel!
    @IBOutlet weak var txt_total: UILabel!
    @IBOutlet weak var txt_detail: UILabel!
    @IBOutlet weak var txt_rq_need_info: UILabel!
    @IBOutlet weak var txt_date: UILabel!
    @IBOutlet weak var txt_type_popup: UILabel!
    @IBOutlet weak var txt_project: UILabel!
    @IBOutlet weak var txt_department: UILabel!
    @IBOutlet weak var txt_topic: UILabel!
    @IBOutlet weak var txt_reason: UILabel!
    @IBOutlet weak var btn_preview: UIButton!
    
    
    public class NeedItem {
        var item_id: String
        var type: String
        var type_id: String
        var detail: String
        var price: String
        var amount: String
        var unit: String
        var total: String
        var image: [UIImage]
        var new_image: [UIImage]
        init(item_id: String,type: String,type_id: String,detail: String,price: String,amount: String,unit: String,total: String,image: [UIImage],new_image: [UIImage]) {
            self.item_id = item_id
            self.type = type
            self.type_id = type_id
            self.detail = detail
            self.price = price
            self.amount = amount
            self.unit = unit
            self.total = total
            self.image = image
            self.new_image = new_image
        }
    }
    
    var needItemDetail:NeedItemDetail? = nil
    var needRequest:NeedRequest? = nil
    var needItem = [NeedItem]()
    var selectedItem: NeedItem? = nil
    var needLists:NeedLists? = nil
    var request_id = ""
    var view_bg = UIView()
    var selected_image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "back".localized(gb.lang_now), style: .plain, target: nil, action: nil)
        
        showLoad()
        self.title = "detail_need".localized(gb.lang_now)
        txt_type.text = "need_type".localized(gb.lang_now)
        txt_price.text = "price".localized(gb.lang_now)
        txt_unit.text = "unit".localized(gb.lang_now)
        txt_total.text = "total".localized(gb.lang_now)
        txt_detail.text = "detail".localized(gb.lang_now)
        button_close.setTitle("close".localized(gb.lang_now), for: .normal)
        txt_date.text = "date".localized(gb.lang_now)
        txt_type_popup.text = "type".localized(gb.lang_now)
        txt_project.text = "project".localized(gb.lang_now)
        txt_department.text = "department".localized(gb.lang_now)
        txt_topic.text = "subject".localized(gb.lang_now)
        txt_reason.text = "reason".localized(gb.lang_now)
        txt_rq_need_info.text = "detail_need".localized(gb.lang_now)
        
        getItemDetail()
        
        label_date.text = needRequest?.mny_request_date
        label_dept.text = needRequest?.dept
        label_project.text = needRequest?.project_name
        label_info_type.text = needRequest?.type
        label_topic.text = needRequest?.mny_request_location
        label_reason.text = needRequest?.mny_request_note
        
        collection_image.layer.cornerRadius = 5
        collection_image.layer.borderWidth = 1
        collection_image.layer.borderColor = gb.color_border.cgColor
        
        textfield_detail.layer.cornerRadius = 5
        textfield_detail.layer.borderWidth = 1
        textfield_detail.layer.borderColor = gb.color_border.cgColor
        
        view_content.layer.cornerRadius = 8
        view_content.layer.shadowColor = UIColor.lightGray.cgColor
        view_content.layer.shadowOffset = CGSize(width: 0, height: 0)
        view_content.layer.shadowRadius = 1.0
        view_content.layer.shadowOpacity = 1
        view_content.layer.masksToBounds = false
        
        view_info.layer.cornerRadius = 5
        view_info.layer.shadowColor = UIColor.lightGray.cgColor
        view_info.layer.shadowOffset = CGSize(width: 0, height: 0)
        view_info.layer.shadowRadius = 1.0
        view_info.layer.shadowOpacity = 1
        view_info.layer.masksToBounds = false
        
        button_close.setTitleColor(UIColor.white, for: .normal)
        
        collection_item.layer.shadowOffset = CGSize(width: 0, height: 2)
        collection_item.layer.shadowRadius = 3
        collection_item.layer.shadowOpacity = 1
        collection_item.layer.shadowColor = UIColor.lightGray.cgColor
        collection_item.clipsToBounds = false
        collection_item.layer.masksToBounds = false
    }
    
//    func getNeedList(){
//        let postString = "idEmp=\(String(needRequest!.emp_id!))"
//        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_NEED_LIST)!
//        var request = URLRequest(url: url)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        request.httpBody = postString.data(using: .utf8)
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            _ = String(data: data!, encoding: .utf8)
//            do{
//                self.needLists = try JSONDecoder().decode(NeedLists.self, from: data!)
//            }catch let err{
//                print("Error : ",err)
//            }
//
//            DispatchQueue.main.async {
//                do{
//
//                }
//            }
//        }
//        task.resume()
//    }
    
    func getItemDetail(){
        let postString = "requestid=\(String(needRequest!.mny_request_id!))"
        let url = URL(string: Const_Var.BASE_URL + Const_Var.GET_NEED_ITEM_DETAIL)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do{
                self.needItemDetail = try JSONDecoder().decode(NeedItemDetail.self, from: data!)
            }catch let err{
                print("Error : ",err)
            }
            
            DispatchQueue.main.async {
                for item in self.needItemDetail!.data! {
                    var tmp_image : [UIImage] = []
                    let tmp_new_image : [UIImage] = []
                    if item.listImg != nil {
                        for img in item.listImg! {
                            if img != "" {
                                var imageString = "\(Const_Var.BASE_URL)\(String(((img.replacingOccurrences(of: "\\", with: "")))))"
                                imageString = "\(String(imageString.replacingOccurrences(of: "..", with: "")))"
                                let url = URL(string: imageString)
                                if url != nil {
                                    do{
                                        let data = try Data(contentsOf: url!)
                                        tmp_image.append(UIImage(data: data) ?? UIImage(named:"dummy_pdf")!)
                                    }
                                    catch{
                                        tmp_image.append(UIImage(named:"dummy_pdf")!)
                                    }
                                }
                                else {
                                    tmp_image.append(UIImage(named:"dummy_pdf")!)
                                }
                            }
                            else {
                                tmp_image.append(UIImage(named:"dummy_pdf")!)
                            }
                        }
                    }

                    let new_need_item = NeedItem(
                        item_id : item.mny_item_sort_no!,
                        type    : item.item_name!,
                        type_id : item.mny_item_id!,
                        detail  : item.mny_request_item_note!,
                        price   : item.mny_request_item_price!,
                        amount  : item.mny_request_item_quantity!,
                        unit    : item.unit!,
                        total   : item.mny_request_total!,
                        image   : tmp_image,
                        new_image: tmp_new_image)
                    self.needItem.append(new_need_item)
                    self.collection_item.reloadData()
                    self.collection_image.reloadData()
                }
                self.selectedItem = self.needItem[0]
                self.label_type.text = self.selectedItem?.type
                self.label_price.text = self.selectedItem?.price
                self.label_unit.text = self.selectedItem?.unit
                self.label_amout.text = self.selectedItem?.amount
                self.label_total.text = self.selectedItem?.total
                self.textfield_detail.text = self.selectedItem?.detail
                self.closeLoad()
            }
        }
        task.resume()
    }
    
    @IBAction func tapInfo(_ sender: Any) {
        view_bg.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        view_bg.frame = self.view.frame
        self.view.addSubview(view_bg)
        self.view.addSubview(view_info)
        view_bg.alpha = 0
        view_info.isHidden = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view_bg.alpha = 0.5
        }, completion: nil)
        
        
    }
    
    @objc func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.view_bg.alpha = 0
        }, completion: nil)
    }
    
    @IBAction func tapClose(_ sender: Any) {
        view_info.isHidden = true
        onClickTransparentView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var row = 0
         if collectionView == collection_item {
            row = needItem.count
        }
         else{
            if selectedItem != nil {
                row = (selectedItem?.image.count)!
            }
        }
        
        return row
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collection_item {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ApproveNeedItemCollectionViewCell
            cell.label_item.text = "\(String(indexPath.row + 1))"
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ApproveNeedImageCollectionViewCell
            cell.image_uplaod.image = selectedItem?.image[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if collectionView == collection_item {
            selectedItem        = needItem[indexPath.row]
            label_type.text     = selectedItem?.type
            label_price.text    = selectedItem?.price
            label_unit.text     = selectedItem?.unit
            label_amout.text    = selectedItem?.amount
            label_total.text    = selectedItem?.total
            textfield_detail.text = selectedItem?.detail
            collection_item.reloadData()
            collection_image.reloadData()
            
        }
        else if collectionView == collection_image {
            selected_image = (selectedItem?.image[indexPath.row])!
            btn_preview.sendActions(for: .touchUpInside)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            let sb = segue.destination as! Preview_Image2_VC
            sb.img_preview = selected_image
        }
    }
}
