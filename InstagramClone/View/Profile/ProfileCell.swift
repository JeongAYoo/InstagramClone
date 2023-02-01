//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by Jade Yoo on 2023/02/02.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    // MARK: - Properties
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "markFeed5")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        addSubview(postImageView)
        postImageView.fillSuperview() // fill up entire profile cell
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
