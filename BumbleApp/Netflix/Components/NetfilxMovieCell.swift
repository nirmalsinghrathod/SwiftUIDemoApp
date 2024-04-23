//
//  NetfilxMovieCell.swift
//  BumbleApp
//
//  Created by Hemant Singh Rajput on 23/04/24.
//

import SwiftUI

struct NetfilxMovieCell: View {
    
    var width: CGFloat = 90
    var height: CGFloat = 140
    var imageName: String = Constant.randomImage1
    var title: String? = "Movie Name"
    var isRecentlyAdded: Bool = Bool.random()
    var topRanking: Int? = nil
    
    var body: some View {
        HStack(alignment:.bottom,spacing: -8){
            
            if let topRanking{
                Text("\(topRanking)")
                    .font(.system(size: 100,weight: .medium,design: .serif))
                    .offset(y: 20)
            }
            
            ZStack(alignment:.bottom){
                ImageLoaderView(urlString: imageName)
                
                VStack(spacing:0){
                    if let title, let first = title.components(separatedBy: " ").first{
                        Text(first)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    }
                    
                    Text("Recently Added")
                        .padding(.horizontal,4)
                        .padding(.vertical,2)
                        .padding(.bottom,2)
                        .background(.netflixRed)
                        .cornerRadius(2)
                        .offset(y:2)
                        .lineLimit(1)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal,8)
                        .opacity(isRecentlyAdded ? 1:0)
                    
                }
                .padding(.top,6)
                .background(
                    .linearGradient(colors: [
                        .netflixBlack.opacity(0),
                        .netflixBlack.opacity(0.3),
                        .netflixBlack.opacity(0.4),
                    ], startPoint: .top, endPoint: .bottom)
                )
            }
            .cornerRadius(4)
            .frame(width: width,height: height)
            .foregroundStyle(.netflixWhite)
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    NetfilxMovieCell()
}
