//
//  CustomTextField.swift
//  InstagramClone
//
//  Created by Jade Yoo on 2023/01/12.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)    // 상속받은 UITextField 클래스의 생성자 호출
        // .zero로 한 이유: 로그인컨트롤러에서 이 커스텀 TF를 생성할때 프레임을 만들것임.
        
        // 텍스트필드 placeholder 앞에 패딩 주기
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12) // 텍스트필드와 높이는 같게
        leftView = spacer   // leftView: The overlay view that displays on the left side of TF
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        // 파라미터로 받은 placeholder
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                      attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
