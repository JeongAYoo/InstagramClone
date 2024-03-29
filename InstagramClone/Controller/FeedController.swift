//
//  FeedController.swift
//  InstagramClone
//
//  Created by Jade Yoo on 2023/01/10.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedController: UICollectionViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Actions
    
    /// 로그아웃 버튼 클릭시 실행함수. 로그아웃 후 메인탭컨트롤러로 이동
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier) // 셀 등록
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleLogout))
        navigationItem.title = "Feed"

    }
}

// MARK: - UICollectionViewDataSource
// 프로토콜 채택할 필요 없음 얘 자체가 컬렉션뷰컨트롤러니까 이미 포함되어있음. 걍 확장시키고 재정의하기
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    // Set up the sizing for each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        // 8: top spacing of profile iv
        // 40: size of profile imageView
        // 8: bottom spacing of profile iv
        var height = width + 8 + 40 + 8
        height += 50    // 버튼들 높이
        height += 60    // 나머지 레이블들 높이
        
        return CGSize(width: width, height: height)
    }
}
