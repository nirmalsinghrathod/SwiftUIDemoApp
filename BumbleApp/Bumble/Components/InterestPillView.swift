//
//  InterestPillView.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 10/04/24.
//

import SwiftUI

struct InterestPillView: View {
    
    var iconName: String? = "heart.fill"
    var emoji: String? = ""
    var name: String = "Graduate Degree"
    
    var body: some View {
        HStack(spacing: 4){
            if let iconName{
                Image(systemName: iconName)
            }else if let emoji{
                Text(emoji)
            }
            Text(name)
        }
        .font(.callout)
        .fontWeight(.medium)
        .padding(.vertical,6)
        .padding(.horizontal,12)
        .foregroundStyle(.bumbleBlack)
        .background(.bumbleYellow.opacity(0.6))
        .cornerRadius(32)
    }
}

#Preview {
    InterestPillView()
}
