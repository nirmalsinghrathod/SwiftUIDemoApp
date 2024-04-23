//
//  BumbleChatPreviewCell.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 11/04/24.
//

import SwiftUI

struct BumbleChatPreviewCell: View {
    
    var percentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = Bool.random()
    var user: SpotifyUser = .mockUser
    var isYourMove: Bool = Bool.random()
    
    
    var body: some View {
        HStack(spacing: 16){
            BumbleProfileImageCell(
                imageName: user.image,
                percentageRemaining: percentageRemaining,
                hasNewMessage: hasNewMessage
            )
            
            
            VStack(spacing: 2){
                HStack(spacing: 5){
                    Text(user.firstName)
                        .font(.headline)
                        .foregroundStyle(.bumbleBlack)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    
                    if isYourMove{
                        Text("Your Move")
                            .font(.caption2)
                            .bold()
                            .padding(.horizontal,6)
                            .padding(.vertical,4)
                            .background(.bumbleYellow)
                            .cornerRadius(32)
                    }
                }
                
                Text("This the last message")
                    .font(.subheadline)
                    .foregroundStyle(.bumbleGray)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
            }
            .padding(.trailing,16)
            .lineLimit(1)
        }
    }
}

#Preview {
    BumbleChatPreviewCell()
}
