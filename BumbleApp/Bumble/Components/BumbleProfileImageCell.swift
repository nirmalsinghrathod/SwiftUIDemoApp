//
//  BumbleProfileImageCell.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 11/04/24.
//

import SwiftUI

struct BumbleProfileImageCell: View {
    var imageName: String = Constant.randomImage
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = Bool.random()
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(.bumbleGray, lineWidth: 2)
            
            Circle()
                .trim(from: 0, to: percentageRemaining)
                .stroke(.bumbleYellow, lineWidth: 4)
                .rotationEffect(Angle(degrees: -90))
                .scaleEffect(x: -1, y: 1, anchor: .center)
            
            ImageLoaderView(urlString: imageName)
                .clipShape(Circle())
                .padding(5)
            
        }
        .frame(width: 75, height: 75,alignment: .center)
        .overlay(alignment:.bottomTrailing) {
            ZStack{
                if hasNewMessage{
                    Circle()
                        .fill(.bumbleWhite)
                    Circle()
                        .fill(.yellow)
                        .padding(3)
                }
            }
            .frame(width: 24, height: 24)
            .offset(x:2,y:2)
        }
    }
}

#Preview {
    BumbleProfileImageCell()
}
