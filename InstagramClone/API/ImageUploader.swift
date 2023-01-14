//
//  ImageUploader.swift
//  InstagramClone
//
//  Created by Jade Yoo on 2023/01/15.
//

import UIKit
import FirebaseStorage

struct ImageUploader {  // String을 파라미터로 받는 컴플리션이 필요한 이유: 이미지 업로드시, (이미지를 다운로드할 수 있는) url을 전달
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        // 이미지를 더 작게 압축한 jpegData를 생성
        guard let imageDate = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString      // uuid 생성해서 파일명으로 사용
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")  // 저장할 스토리지 경로 + 파일이름
        
        ref.putData(imageDate, metadata: nil) { metadata, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }    // 절대경로 문자열
                completion(imageUrl)
            }
        }
    }
}

