//
//  NetfilxHeroCell.swift
//  BumbleApp
//
//  Created by Hemant Singh Rajput on 21/04/24.
//

import SwiftUI
import SwiftfulUI

struct NetfilxHeroCell: View {
    
    var imageName: String = Constant.randomImage
    var isNetfilxFilm: Bool = true
    var title: String = "Players"
    var categores: [String] = ["Raunchy","Romantic","Comedy"]
    var onBackgroundPresseds: (()->Void)? = nil
    var onPlayPressed: (()->Void)? = nil
    var onMyListPressed: (()->Void)? = nil
    
    var body: some View {
        ZStack(alignment:.bottom){
            ImageLoaderView(urlString: imageName)
            VStack(spacing: 16, content: {
                VStack(spacing: 0){
                    if isNetfilxFilm {
                        HStack(spacing:8){
                            Text("N")
                                .foregroundStyle(.netflixRed)
                                .font(.largeTitle)
                                .fontWeight(.black)
                            
                            Text("FILM")
                                .kerning(3)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.netflixWhite)
                        }
                    }
                    
                    Text(title)
                        .font(.system(size: 50, weight: .medium, design: .serif))
                }
                HStack(spacing:8){
                    ForEach(categores, id: \.self){ categore in
                        Text(categore)
                            .font(.callout)
                        if categore != categores.last{
                            Circle()
                                .frame(width: 4, height: 4)
                        }
                    }
                }
                HStack(spacing: 16,content: {
                    HStack(content: {
                        Image(systemName: "play.fill")
                        Text("Play")
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(.netflixDrackGray)
                    .background(.netflixWhite)
                    .cornerRadius(4)
                    .asButton(.press) {
                        onPlayPressed?()
                    }
                    
                    HStack(content: {
                        Image(systemName: "plus")
                        Text("My List")
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(.netflixWhite)
                    .background(.netflixDrackGray)
                    .cornerRadius(4)
                    .asButton(.press) {
                        onMyListPressed?()
                    }
                    
                })
                .font(.callout)
                .fontWeight(.medium)
            })
            
            .padding(24)
            .background(
                LinearGradient(
                    colors: [.netflixBlack.opacity(0.0),
                             .netflixBlack.opacity(0.4),
                             .netflixBlack.opacity(0.4),
                             .netflixBlack.opacity(0.4)
                            ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .foregroundStyle(.netflixWhite)
        .cornerRadius(10)
        .aspectRatio(0.8, contentMode: .fit)
        .onTapGesture {
            onBackgroundPresseds?()
        }
    }
}

#Preview {
    NetfilxHeroCell()
}
