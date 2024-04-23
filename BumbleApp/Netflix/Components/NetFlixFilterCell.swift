//
//  NetFlixFilterCell.swift
//  BumbleApp
//
//  Created by Hemant Singh Rajput on 21/04/24.
//

import SwiftUI

struct NetFlixFilterCell: View {
    
    var title: String = "Category"
    var isDropDown: Bool = true
    var isSelected: Bool = false
    
    var body: some View {
        HStack{
            Text(title)
            if isDropDown{
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal,16)
        .padding(.vertical,8)
        .background(
            ZStack{
                
                    Capsule(style: .circular)
                        .fill(.netflixDrackGray)
                        .opacity(isSelected ? 1:0 )
                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
            }
        )
        .foregroundColor(.netflixLightGray)
    }
}

#Preview {
    NetFlixFilterCell()
}
