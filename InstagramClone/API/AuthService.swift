//
//  AuthService.swift
//  InstagramClone
//
//  Created by Jade Yoo on 2023/01/15.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping (Error?) -> Void) {
        //print("DEBUG: Credentials are \(credentials)")
        // 이미지를 먼저 업로드 하고 -> Get access to image url -> 모든 user info를 업로드
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            // createUser: 파이어베이스 코드. 파베에 유저 생성
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("DEBUG: Failed to register user \(error.localizedDescription)")
                    return
                }
                
                // result 객체를 통해 유저의 unique identifier에 접근
                guard let uid = result?.user.uid else { return }
                
                // 파베에 업로드할 딕셔너리 데이터 생성
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname,
                                           "profileImageUrl": imageUrl,
                                           "uid": uid,
                                           "username": credentials.username]
                
                // 파베 데이터베이스에 users 라는 collection을 생성. 그 안에 document. 그 안에 이메일 등등의 필드를 세팅
                // 컴플리션(registerUser 함수 실행시 클로저에서 에러처리)
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
        }
    }
}
