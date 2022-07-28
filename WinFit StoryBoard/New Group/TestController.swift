//
//  TestController.swift
//  WinFit StoryBoard
//
//  Created by Babak Kiaie on 7/14/22.
//

import Foundation


class TestCellController {
    struct TestItem: Hashable {
        let title: String
        let description: String
    }
    
    struct TestItemCollection: Hashable {
        let TestItems: [TestItem] = [TestItem(title: "Scone ", description: "Pone")]
    }
    
    
    
}
    
   
