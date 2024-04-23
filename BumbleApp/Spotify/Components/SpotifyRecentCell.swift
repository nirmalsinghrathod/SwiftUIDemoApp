//
//  SpotifyRecentCell.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 05/04/24.
//

import SwiftUI

struct SpotifyRecentCell: View {
    var imageName: String = Constant.randomImage
    var title: String = "Tiefwefwef wefwtle"
    
    var body: some View {
        HStack(spacing: 16){
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
                .padding(.trailing,8)
                .frame(maxWidth: .infinity)
        }
        .themeColors(isSelected: false)
        .cornerRadius(6)
    }
}

#Preview {
    ZStack{
        Color.spotifyBlack.ignoresSafeArea()
        VStack{
            HStack{
                SpotifyRecentCell()
                SpotifyRecentCell()
            }
            HStack{
                SpotifyRecentCell()
                SpotifyRecentCell()
            }
        }
    }
    
}


extension View{
    func themeColors(isSelected: Bool)-> some View{
        self 
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
            .background(isSelected ? .spotifyGreen : .spotifyDrackGray)
    }
}
