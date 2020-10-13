
import UIKit
import MapKit
import Foundation
import CommonCrypto
import NVActivityIndicatorView

struct gb {
    static var user:UserLoginDao? = nil
    static let username = "origami"
    static let password = "ori20#17gami"
    static var now_vc   = "time"
    static let key_username = "key_username"
    static let key_password = "key_password"
    static var key_lang   = "key_lang"
    static var lang_now   = ""
    static var back_from  = false
    static var image_del  = false
    static var mapkit_location = ""
    static var address_coor = CLLocationCoordinate2D()
    static var address_name = ""
    static var ship_coor = CLLocationCoordinate2D()
    static var ship_name = ""
    static var doc_coor = CLLocationCoordinate2D()
    static var doc_name = ""
    static var selected_shipLocation = ""
    static var selected_shipLng = "0.0"
    static var selected_shipLat = "0.0"
    static var selected_docLocation = ""
    static var selected_docLng = "0.0"
    static var selected_docLat = "0.0"
    static var selected_cusLocation = ""
    static var selected_cusLng = "0.0"
    static var selected_cusLat = "0.0"
    static var selected_shipAddress = ""
    static var selected_docAddress = ""
    static var ship_change = false
    static var doc_change = false
    static var cus_change = false
    static var accountAdd:AccountList? = nil
    static var activityData: activity_data? = nil
    static var menu_list: menuList? = nil
    static var debug = ""
    static var refresh = false
    static var account_map_location = UIImage()

//    static let color_main       = UIColor(red: 1.00, green: 0.53, blue: 0.00, alpha: 1.00)
    static let color_secondary  = UIColor(red: 1.00, green: 0.65, blue: 0.10, alpha: 1.00)
    static let color_background = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
    //Color User Collection
    static let color_darkgrey_a6 = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 0.60)
    static let color_orenge_a6   = UIColor(red: 1.00, green: 0.58, blue: 0.00, alpha: 0.60)
    static let color_border      = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 0.85)

    static let color_EP = UIColor(red: 0.48, green: 0.75, blue: 0.26, alpha: 1.00)
    static let color_CR = UIColor(red: 0.01, green: 0.57, blue: 0.81, alpha: 1.00)
    static let color_PR = UIColor(red: 1.00, green: 0.75, blue: 0.00, alpha: 1.00)
    static let color_EL = UIColor(red: 0.85, green: 0.33, blue: 0.31, alpha: 1.00)
    //Color Status Request OT
    static let color_ot_green   = UIColor(red: 0.00, green: 0.76, blue: 0.57, alpha: 1.00)
    static let color_ot_yellow  = UIColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
    static let color_ot_red     = UIColor(red: 0.96, green: 0.26, blue: 0.21, alpha: 1.00)
    static let color_ot_blue    = UIColor(red: 0.01, green: 0.69, blue: 0.99, alpha: 1.00)
    static let color_ot_orenge  = UIColor(red: 0.98, green: 0.55, blue: 0.00, alpha: 1.00)

    static let color_main        = UIColor(red: 1.00, green: 0.49, blue: 0.00, alpha: 1.00)
    static let color_darkgrey    = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
    static let color_lightgrey   = UIColor(red: 0.53, green: 0.53, blue: 0.53, alpha: 1.00)
    static let color_seperate    = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00)
    static let color_greentext   = UIColor(red: 0.36, green: 0.72, blue: 0.36, alpha: 1.00)
    static let color_redtext     = UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1.00)
    static let color_phd         = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.00)
    static let color_skooped     = UIColor(red: 0.00, green: 0.76, blue: 0.57, alpha: 1.00)
    static let color_disable     = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
    
    //Activity Status Color
    static let ac_plan          = UIColor(red: 0.60, green: 0.81, blue: 0.91, alpha: 1.00)
    static let ac_close         = UIColor(red: 1.00, green: 0.60, blue: 0.00, alpha: 1.00)
    static let ac_approve       = UIColor(red: 0.00, green: 0.76, blue: 0.57, alpha: 1.00)
    static let ac_notapprove    = UIColor(red: 0.98, green: 0.59, blue: 0.47, alpha: 1.00)
    static let ac_needinfo      = UIColor(red: 1.00, green: 0.76, blue: 0.03, alpha: 1.00)
    static let ac_leave         = UIColor(red: 1.00, green: 0.12, blue: 0.12, alpha: 1.00)
    static let ac_create        = UIColor(red: 0.82, green: 0.71, blue: 0.87, alpha: 1.00)
    static let ac_join          = UIColor(red: 0.20, green: 0.48, blue: 0.72, alpha: 1.00)

    static func newMenuList(){
        menu_list = menuList.init(
        time        : "active",
        request_ot  : "inactive",
        work        : "inactive",
        need        : "inactive",
        approval    : "inactive",
        account     : "inactive",
        activity    : "inactive"
        )
    }
    
    static func newActivityData(){
        activityData = activity_data.init(
        activity_id     : "",
        emp_id          : "",
        comp_id         : "",
        subject         : "",
        description     : "",
        start_date      : "",
        start_time      : "",
        end_date        : "",
        end_time        : "",
        type            : "",
        project         : "",
        contact         : "",
        account         : "",
        place           : "",
        status          : "",
        priority        : "",
        cost            : "",
        location        : "",
        location_lat    : "",
        location_long   : "",
        type_id         : "",
        project_id      : "",
        contact_id      : "",
        account_id      : "",
        place_id        : "",
        status_id       : "",
        priority_id     : "",
        other_contact   : [],
        skoop_id        : "",
        skoop_description : "",
        skoop_location  : "",
        skoop_lat       : "",
        skoop_lng       : "",
        skooped         : "",
        close_start_date: "",
        close_start_time: "",
        close_end_date  : "",
        close_end_time  : "",
        activity_status : "",
        stamp_in        : "",
        stamp_out       : "",
        is_ticket       : ""
        )
    }
    
    static var newAccount = newAccounts.init(
        cus_id          : "",
        group_id        : "",
        group_gen       : "",
        group_type_id   : "",
        status          : "",
        code            : "",
        comp_th         : "",
        comp_en         : "",
        work_tel        : "",
        mobile_tel      : "",
        fax             : "",
        email           : "",
        website         : "",
        facebook        : "",
        contact         : "",
        no              : "",
        lane            : "",
        building        : "",
        road            : "",
        distict         : "",
        sub_distict     : "",
        provice         : "",
        post_code       : "",
        country         : "",
        distict_txt     : "",
        sub_distict_txt : "",
        provice_txt     : "",
        country_txt     : "",
        comp_size       : "",
        regist          : "",
        regist_name     : "",
        regist_capital  : "",
        number_staff    : "",
        payterm         : "",
        payterm_name    : "",
        tax_id          : "",
        old_code        : "",
        description     : "",
        cusLat          : "",
        cusLng          : "",
        cusLocation     : "",
        shipLat         : "",
        shipLng         : "",
        shipLocation    : "",
        docLat          : "",
        docLng          : "",
        docLocation     : "",
        shipAddress     : "",
        docAddress      : "",
        work_dial       : "",
        mob_dial        : "",
        fax_dial        : ""
    )
    
    static func setNewAccount(){
        newAccount = newAccounts.init(
            cus_id          : "",
            group_id        : "",
            group_gen       : "",
            group_type_id   : "",
            status          : "",
            code            : "",
            comp_th         : "",
            comp_en         : "",
            work_tel        : "",
            mobile_tel      : "",
            fax             : "",
            email           : "",
            website         : "",
            facebook        : "",
            contact         : "",
            no              : "",
            lane            : "",
            building        : "",
            road            : "",
            distict         : "",
            sub_distict     : "",
            provice         : "",
            post_code       : "",
            country         : "",
            distict_txt     : "",
            sub_distict_txt : "",
            provice_txt     : "",
            country_txt     : "",
            comp_size       : "",
            regist          : "",
            regist_name     : "",
            regist_capital  : "",
            number_staff    : "",
            payterm         : "",
            payterm_name    : "",
            tax_id          : "",
            old_code        : "",
            description     : "",
            cusLat          : "",
            cusLng          : "",
            cusLocation     : "",
            shipLat         : "",
            shipLng         : "",
            shipLocation    : "",
            docLat          : "",
            docLng          : "",
            docLocation     : "",
            shipAddress     : "",
            docAddress      : "",
            work_dial       : "",
            mob_dial        : "",
            fax_dial        : ""
        )
    }
}


extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}

 @IBDesignable
    open class customUITextField: UITextField {

        func setup() {
            let border = CALayer()
            let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

@IBDesignable class RoundButton : UIButton{

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override func prepareForInterfaceBuilder() {
        sharedInit()
    }

    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }

    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }

    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.masksToBounds = false
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.masksToBounds = false
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    let gradientLayer = CAGradientLayer()
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            gradientLayer.apply(angle: 45.0)
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
}

extension CAGradientLayer {
    func apply(angle : Double) {
        let x: Double! = angle / 360.0
        let a = pow(sinf(Float(2.0 * Double.pi * ((x + 0.75) / 2.0))),2.0);
        let b = pow(sinf(Float(2*Double.pi*((x+0.0)/2))),2);
        let c = pow(sinf(Float(2*Double.pi*((x+0.25)/2))),2);
        let d = pow(sinf(Float(2*Double.pi*((x+0.5)/2))),2);
        
        endPoint = CGPoint(x: CGFloat(c),y: CGFloat(d))
        startPoint = CGPoint(x: CGFloat(a),y:CGFloat(b))
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


extension UIViewController {

    func showLoad(){
        let frame = CGRect(x:(self.view.bounds.width / 2) - 32.5,y: (self.view.bounds.height / 2) - 32.5, width: 75, height: 75)
        let load_style = NVActivityIndicatorView(frame: frame, type: .lineScale, color: gb.color_main)
        load_style.startAnimating()
        
        let view_ = UIView(frame: self.view.bounds)
        view_.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        view_.addSubview(load_style)
        view_.tag = 9999
        
        self.view.addSubview(view_)
    }
    
    func closeLoad(){
        let subViews = self.view.subviews
        for subview in subViews{
            if subview.tag == 9999 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                   subview.alpha = 0.0
                }, completion: {finished in
                    subview.removeFromSuperview()
                })
            }
        }
    }
}

extension String {
    func localized(_ lang:String) ->String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

class CustomTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0);

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension UISearchBar {

    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    func set(textColor: UIColor) { if let textField = getTextField() { textField.textColor = textColor } }
    func setPlaceholder(textColor: UIColor) { getTextField()?.setPlaceholder(textColor: textColor) }
    func setClearButton(color: UIColor) { getTextField()?.setClearButton(color: color) }

    func setTextField(color: UIColor) {
        guard let textField = getTextField() else { return }
        switch searchBarStyle {
        case .minimal:
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 6
        case .prominent, .default: textField.backgroundColor = color
        @unknown default: break
        }
    }

    func setSearchImage(color: UIColor) {
        guard let imageView = getTextField()?.leftView as? UIImageView else { return }
        imageView.tintColor = color
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
    }
}

private extension UITextField {

    private class Label: UILabel {
        private var _textColor = UIColor.lightGray
        override var textColor: UIColor! {
            set { super.textColor = _textColor }
            get { return _textColor }
        }

        init(label: UILabel, textColor: UIColor = .lightGray) {
            _textColor = textColor
            super.init(frame: label.frame)
            self.text = label.text
            self.font = label.font
        }

        required init?(coder: NSCoder) { super.init(coder: coder) }
    }


    private class ClearButtonImage {
        static private var _image: UIImage?
        static private var semaphore = DispatchSemaphore(value: 1)
        static func getImage(closure: @escaping (UIImage?)->()) {
            DispatchQueue.global(qos: .userInteractive).async {
                semaphore.wait()
                DispatchQueue.main.async {
                    if let image = _image { closure(image); semaphore.signal(); return }
                    guard let window = UIApplication.shared.windows.first else { semaphore.signal(); return }
                    let searchBar = UISearchBar(frame: CGRect(x: 0, y: -200, width: UIScreen.main.bounds.width, height: 44))
                    window.rootViewController?.view.addSubview(searchBar)
                    searchBar.text = "txt"
                    searchBar.layoutIfNeeded()
                    _image = searchBar.getTextField()?.getClearButton()?.image(for: .normal)
                    closure(_image)
                    searchBar.removeFromSuperview()
                    semaphore.signal()
                }
            }
        }
    }

    func setClearButton(color: UIColor) {
        ClearButtonImage.getImage { [weak self] image in
            guard   let image = image,
                let button = self?.getClearButton() else { return }
            button.imageView?.tintColor = color
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    var placeholderLabel: UILabel? { return value(forKey: "placeholderLabel") as? UILabel }

    func setPlaceholder(textColor: UIColor) {
        guard let placeholderLabel = placeholderLabel else { return }
        let label = Label(label: placeholderLabel, textColor: textColor)
        setValue(label, forKey: "placeholderLabel")
    }

    func getClearButton() -> UIButton? { return value(forKey: "clearButton") as? UIButton }
}


extension UIButton {
  func alignVertical(spacing: CGFloat = 4.0) {
    guard let imageSize = imageView?.image?.size,
      let text = titleLabel?.text,
      let font = titleLabel?.font
    else { return }

    titleEdgeInsets = UIEdgeInsets(
      top: 0.0,
      left: -imageSize.width,
      bottom: -(imageSize.height + spacing),
      right: 0.0
    )

    let titleSize = text.size(withAttributes: [.font: font])
    imageEdgeInsets = UIEdgeInsets(
      top: -(titleSize.height + spacing),
      left: 0.0,
      bottom: 0.0, right: -titleSize.width
    )

    let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
    contentEdgeInsets = UIEdgeInsets(
      top: edgeOffset,
      left: 0.0,
      bottom: edgeOffset,
      right: 0.0
    )
  }
}

@IBDesignable class UITextViewFixed: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}

@IBDesignable class UITextViewPadding: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 0, right: 10)
//        textContainer.lineFragmentPadding = 13
    }
}
//extension UIImageView {
//  func enableZoom() {
//    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
//    isUserInteractionEnabled = true
//    addGestureRecognizer(pinchGesture)
//  }
//
//  @objc
//  private func startZooming(_ sender: UIPinchGestureRecognizer) {
//    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
//    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
//    sender.view?.transform = scale
//    sender.scale = 1
//  }
//}
