//
//  StorageManager.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 9/5/22.
//

import Foundation
import FirebaseStorage
import UIKit

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    
    public func uploadCompBanner(image: UIImage, compName: String) {
        
    }
}
