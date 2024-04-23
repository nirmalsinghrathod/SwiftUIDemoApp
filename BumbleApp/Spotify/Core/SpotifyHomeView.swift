//
//  SpotifyHomeView.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 05/04/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {
    @Environment(\.router) var router
    
    @State private var currentUser: SpotifyUser? = nil
    @State private var products: [Product] = []
    @State private var productRow: [ProductRow] = []
    @State private var selectedCategory: SpotifyCategory? = nil
    
    var body: some View {
        ZStack{
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 1,pinnedViews:[.sectionHeaders], content: {
                    Section {
                        VStack(spacing:16){
                            recentsSection
                                .padding(.horizontal,16)
                            
                            if let product = products.first{
                                newReleaseSection(product)
                                    .padding(.horizontal,16)
                            }

                            listRow
                            
                        }
                        
                    } header: {
                        headerView
                    }
                })
                .padding(.top, 8)
                
            }
            .clipped()
            .scrollIndicators(.hidden)
        }
        .task {
           await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var headerView: some View{
        HStack(spacing: 0){
            ZStack{
                if let currentUser{
                    ImageLoaderView(urlString: currentUser.image)
                        
                        .background(.spotifyWhite)
                        .clipShape(.circle)
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
            }
            .frame(width: 35,height: 35)
            
            ScrollView(.horizontal){
                HStack(spacing: 8){
                    ForEach(SpotifyCategory.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == selectedCategory)
                        .asButton(.press) {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal,16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical,24)
        .padding(.leading,8)
        .background(Color.spotifyBlack)
    }

    
    private var recentsSection: some View{
        NonLazyVGrid(columns: 2,alignment: .center,spacing: 10,items: products) { product in
            if let product = product{
                SpotifyRecentCell(imageName:product.firstImage,
                                  title: product.title)
                .asButton(.press) {
                    navigateToProductDetailScreen(product)
                }
            }
        }
    }
    
    private func navigateToProductDetailScreen(_ product: Product){
        guard let currentUser else { return }
        router.showScreen(.push) { _ in
            SpotifyPlayListView(product: product, user: currentUser)
        }
    }
    
    private func newReleaseSection(_ product: Product)-> some View{
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subHeadline: product.category,
            title: product.title,
            subTitle: product.description,
            onAddtoPlaylistPressed: nil,
            onPlayPressed: {
                navigateToProductDetailScreen(product)
            }
            
        )
    }
    
    private func getData() async {
        
        do {
            currentUser = try await DataBaseHelper().getUsers().first
            products = try await Array(DataBaseHelper().getProducts().prefix(8))
            var rows: [ProductRow] = []
            let productBrand = Set(products.map{$0.brand})
            for brand in productBrand{
                let products = self.products.filter{ $0.brand == brand }
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            productRow = rows
            
        }catch{
            print(error)
        }
    }
    
    private var listRow: some View{
        ForEach(productRow) { row in
            VStack(spacing: 8){
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,16)
                
                ScrollView(.horizontal) {
                    HStack(alignment:.top, spacing: 16,content: {
                        ForEach(row.products) { product in
                            ImageTitleCell(imageSize: 120, imageName: product.firstImage, title: product.title)
                                .asButton(.press) {
                                    navigateToProductDetailScreen(product)
                                }
                        }
                    })
                    .padding(.horizontal,16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
}

#Preview {
    SpotifyHomeView()
}
