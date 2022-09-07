//
//  ViewController.swift
//  DynamicLocalizationTest
//
//  Created by Giwan Jo on 2022/09/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.text = "greeting".localized(with: "asdf", "bbbb", 1234)
    }
}

extension String {
    var localized: String {
//        return localized(UserDefaults.standard.string(forKey: "AppLanguage") ?? "ko")
           return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
//       출처: https://zeddios.tistory.com/368 [ZeddiOS:티스토리]
    }
    
    func localized(with params: CVarArg...) -> String {
        return String(format: self.localized, arguments: params)
    }
    
}
extension String {
    func localized(_ lang: String) -> String {
        
        if lang.count <= 0 {
            if UserDefaults.standard.string(forKey: "AppLanguage") == nil || UserDefaults.standard.string(forKey: "AppLanguage") == "" {
                
                let path = Bundle.main.path(forResource: "ko", ofType: "lproj")
                let bundle = Bundle(path: path!)
                
                return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
            } else {
                return NSLocalizedString(self, comment: "")
            }

        } else {
            let path = Bundle.main.path(forResource: lang, ofType: "lproj")
            let bundle = Bundle(path: path!)
            
            #if _KTFLOW_ && _MDM_
            let localizedStr = NSLocalizedString(self as String, tableName: nil, bundle: bundle!, value: "", comment: "")
            return SysUtils.getDecodedStr(forKTBizWorks: localizedStr)
            #else
            return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
            #endif
        }
    }
}
