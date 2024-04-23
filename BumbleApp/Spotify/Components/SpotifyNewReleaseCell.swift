//
//  SpotifyNewReleaseCell.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 10/04/24.
//

import SwiftUI
import SwiftfulUI

struct SpotifyNewReleaseCell: View {
    var imageName: String = Constant.randomImage
    var headline: String? = "New realse from"
    var subHeadline: String? = "Some Artist"
    var title: String? = "Some Playlist"
    var subTitle: String? = "Some - Title"
    var onAddtoPlaylistPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    
    var body: some View {
        VStack(spacing: 16, content: {
            HStack(spacing: 8){
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading,spacing: 2, content: {
                    if let headline{
                        Text(headline)
                            .foregroundStyle(.spotifyLightGray)
                            .font(.callout)
                    }
                    
                    if let subHeadline{
                        Text(subHeadline)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.spotifyWhite)
                    }
                })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack{
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140, height: 140)
                
                VStack(alignment: .leading, spacing: 32){
                    VStack(alignment: .leading,spacing: 2){
                        if let title{
                            Text(title )
                                .fontWeight(.semibold)
                                .foregroundStyle(.spotifyWhite)
                        }
                        if let subTitle{
                            Text(subTitle )
                                .foregroundStyle(.spotifyLightGray)
                        }
                    }
                    .font(.callout)
                    
                    HStack(spacing: 0){
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.spotifyLightGray)
                            .font(.title3)
                            .padding(4)
                            .background(Color.black.opacity(0.001))
                            .asButton(.press) {
                                onAddtoPlaylistPressed?()
                            }
                            
                            .offset(x:-4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(.spotifyWhite)
                            .font(.title)
                    }
                }
                .padding(.trailing,16)
            }
            .themeColors(isSelected: false)
            .cornerRadius(8)
            .asButton(.press) {
                onPlayPressed?()
            }
        })
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        SpotifyNewReleaseCell()
            .padding()
    }
}
