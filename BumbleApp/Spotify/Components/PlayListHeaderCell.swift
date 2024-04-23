//
//  PlayListHeaderCell.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 10/04/24.
//

import SwiftUI
import SwiftfulUI

struct PlayListHeaderCell: View {
    
    var headerImageHeight: CGFloat = 300
    var title: String = "Some Playlist Title Goes Here"
    var subTitle: String = "SubTitle Goes Here"
    var imageName: String = Constant.randomImage
    var shadowColor: Color = .spotifyBlack.opacity(0.8)
    
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay{
                ImageLoaderView(urlString: imageName)
            }
            .overlay(alignment: .bottomLeading, content: {
                VStack(alignment: .leading,spacing: 8, content: {
                    Text(subTitle)
                        .font(.headline)
                    
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                })
                .foregroundColor(.spotifyWhite)
                .padding(16)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background{
                    LinearGradient(
                        colors: [shadowColor.opacity(0), shadowColor],
                        startPoint: .top, endPoint: .bottom)
                }
                
            })
            .asStretchyHeader(startingHeight: 300)
            .frame(height: headerImageHeight)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        ScrollView {
            PlayListHeaderCell()
        }
        .ignoresSafeArea()
    }
}
