//
//  File.swift
//  RandomMessageApp
//
//  Created by ㅣ on 2023/09/20.
//

import UIKit



struct UserInfo {
    let userID: UUID?
    let sendCounting: Int?
    let receiveCounting: Int?
    let newcomer: Bool?
}



struct Message {
    let contents: String?
    let hashTag: String?
    let stickerImage: UIImage?
    let timeStamp: Date?
    let LikeCounting: Int?
}

struct MessageQueue {
    let messageQueue: (Message)?
}
