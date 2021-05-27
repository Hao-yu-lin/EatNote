//
//  RoundedTextField.swift
//  EatNote
//
//  Created by Haoyu Lin on 2021/5/27.
//

import UIKit

class RoundedTextField: UITextField {

    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
    
    // 此矩形針對文字欄位的文字，輸入完成後的顯示方式
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    // 此矩形針對文字欄位的站位符文字，背景後面的字 Fill in the xxxx
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    // 此矩形針對用於顯示可編輯的文字，輸入的文字顯示處
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }


}
