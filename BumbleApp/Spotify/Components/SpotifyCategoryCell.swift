//
//  SpotifyCategoryCell.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 05/04/24.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    
    var title: String = "All"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(8)
            .padding(.horizontal,10)
            .themeColors(isSelected: isSelected)
            .cornerRadius(16)
    }
}

#Preview {
    ZStack{
        Color.spotifyBlack.ignoresSafeArea()
        VStack(spacing: 40){
            SpotifyCategoryCell()
        }
    }
}
