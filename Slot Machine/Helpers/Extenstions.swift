//
//  Extenstions.swift
//  Slot Machine
//
//  Created by A. Faruk Acar on 27.11.2023.
//

import SwiftUI

extension Text {
    func scoreLableStyle() -> Text {
        self
            .foregroundColor(.white)
            .font(.system(size: 10,weight: .bold,design: .rounded))
    }
    
    func scoreNumberStyle() -> Text {
        self
            .foregroundColor(.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}
