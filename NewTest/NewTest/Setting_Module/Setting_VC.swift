//
//  Setting_VC.swift
//  NewTest
//
//  Created by Todsaphorn Bualan on 15/6/2563 BE.
//  Copyright © 2563 Todsaphorn Bualan. All rights reserved.
//

import UIKit
import SideMenu
import WMSegmentControl
class Setting_VC: UIViewController {
    
    @IBOutlet weak var view_lang: UIView!
    @IBOutlet weak var view_lang1: UIView!
    @IBOutlet weak var view_lang2: UIView!
    @IBOutlet weak var txt_thai: UILabel!
    @IBOutlet weak var txt_eng: UILabel!
    @IBOutlet weak var txt_lang: UILabel!
    @IBOutlet weak var txt_ver: UILabel!
    @IBOutlet weak var txt_ver_num: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gb.now_vc = "setting"
        setLang()
        
        let gesture = UITapGestureRecognizer(target: self, action: Selector(("tapTH:")))
        view_lang1.addGestureRecognizer(gesture)
        
        let gesture2 = UITapGestureRecognizer(target: self, action: Selector(("tapEN:")))
        view_lang2.addGestureRecognizer(gesture2)
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        txt_ver_num.text = "v \(appVersion ?? "0.0.0")"
    }
    
    func setLang(){
        txt_eng.text = "english".localized(gb.lang_now)
        txt_thai.text = "thai".localized(gb.lang_now)
        txt_lang.text = "languages".localized(gb.lang_now)
        txt_ver.text = "version".localized(gb.lang_now)
        title = "title_setting".localized(gb.lang_now)
        if gb.lang_now == "en"{
            txt_thai.textColor = UIColor.darkGray
            txt_eng.textColor = gb.color_main
        }
        else{
            txt_thai.textColor = gb.color_main
            txt_eng.textColor = UIColor.darkGray
        }
    }
    
    @objc func tapTH(_ sender:UITapGestureRecognizer){
       let defaults = UserDefaults.standard
       defaults.set("th", forKey: gb.key_lang)
       gb.lang_now = "th"
       setLang()
    }
    
    @objc func tapEN(_ sender:UITapGestureRecognizer){
       let defaults = UserDefaults.standard
       defaults.set("en", forKey: gb.key_lang)
       gb.lang_now = "en"
       setLang()
    }

    //Navigation side menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
        sideMenuNavigationController.settings = makeSettings()
    }

    private func makeSettings() -> SideMenuSettings {
        let presentationStyle = selectedPresentationStyle()
        presentationStyle.backgroundColor = UIColor.clear
        presentationStyle.menuStartAlpha = CGFloat(1)
        presentationStyle.menuScaleFactor = CGFloat(1)
        presentationStyle.onTopShadowOpacity = 1
        presentationStyle.presentingEndAlpha = CGFloat(1)
        presentationStyle.presentingScaleFactor = CGFloat(1)
        
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = min(120, view.frame.height)
        let styles:[UIBlurEffect.Style?] = [nil, .dark, .light, .extraLight]
        settings.blurEffectStyle = styles[1]
        settings.statusBarEndAlpha = 1
        
        return settings
    }

    private func selectedPresentationStyle() -> SideMenuPresentationStyle {
        let modes: [SideMenuPresentationStyle] = [.menuSlideIn, .viewSlideOut, .viewSlideOutMenuIn, .menuDissolveIn, .viewSlideOutMenuPartialIn, .viewSlideOutMenuOut, .viewSlideOutMenuPartialOut, .viewSlideOutMenuZoom]
        return modes[0]
    }

    private func setupSideMenu() {
           SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
       }
    
    private func updateMenus() {
        let settings = makeSettings()
        SideMenuManager.default.leftMenuNavigationController?.settings = settings
    }
}
