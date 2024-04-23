//
//  SpotifyPlayListView.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 10/04/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlayListView: View {
    
    @Environment(\.router) var router
    var product: Product = .mockProduct
    var user: SpotifyUser = .mockUser
    
    @State private var products: [Product] = []
    @State private var showHeader: Bool = false
    
    var body: some View {
        ZStack{
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical){
                LazyVStack(spacing: 12,
                           content: {
                    PlayListHeaderCell(
                        headerImageHeight: 250,
                        title: product.title,
                        subTitle: product.brand,
                        imageName: product.firstImage
                    )
                    .readingFrame { frame in
                        showHeader = (frame.maxY < 150)
                    }
                })
                
                
                PlayListDescriptionCell(description: product.description,userName: user.firstName, subHeadline: product.category)
                    .padding([.horizontal,.top],16)
                    .padding(.top,10)
                
                ForEach(products){ product in
                    SongRowCell(
                        imageSize: 60,
                        imageName: product.firstImage,
                        title: product.title,
                        subTitle: product.description,
                        onEllipsisPress: nil,
                        onCellPress: {
                            navigateToProductDetailScreen(product)
                        }
                    )
                    .padding(.leading,16)
                }
            }
            .scrollIndicators(.hidden)
            
            
            ZStack{
                Text(product.title)
                    .font(.headline)
                    .foregroundStyle(.spotifyWhite)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color.spotifyBlack)
                    .offset(y: showHeader ? 0 : -40)
                    .opacity(showHeader ? 1 : 0)
                
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .foregroundStyle(.spotifyWhite)
                    .padding(10)
                    .background(showHeader ? Color.clear : Color.spotifyBlack.opacity(0.3))
                    .clipShape(Circle())
                    .asButton(.press) {
                        router.dismissScreen()
                    }
                    .frame(maxWidth: .infinity,alignment:.leading)
                    .padding(10)
            }
            .frame(maxHeight: .infinity,alignment: .top)
            .animation(.smooth(duration: 0.2),value: showHeader)
            
        }
        .task {
            await getData()
        }.toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        
        do {
            products = try await Array(DataBaseHelper().getProducts().prefix(8))
        }catch{
            
        }
    }
    
    private func navigateToProductDetailScreen(_ product: Product){
        router.showScreen(.push) { _ in
            SpotifyPlayListView(product: product, user: user)
        }
    }
}

#Preview {
    SpotifyPlayListView()
}
