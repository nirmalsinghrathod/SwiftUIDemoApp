//
//  NetflixHomeView.swift
//  BumbleApp
//
//  Created by Hemant Singh Rajput on 21/04/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct NetflixHomeView: View {
    @Environment(\.router) var router
    
    @State var filters : [FilterModel] = FilterModel.mockArray
    @State var isSelectedFilter : FilterModel? = nil
    @State var fullHeaderSize : CGSize = .zero
    @State private var heroProduct: Product? = nil
    @State private var scrollViewOffSet: CGFloat = 0
    
    @State private var currentUser: SpotifyUser? = nil
    @State private var productRow: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment:.top){
            Color.netflixBlack.ignoresSafeArea()
            
            backgroundGradientLayer
            
            scrolViewReader
            
            supperHeaderl
            
        }
        .foregroundColor(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var backgroundGradientLayer: some View{
        ZStack{
            LinearGradient(
                colors: [.netflixDrackGray.opacity(1),.netflixDrackGray.opacity(0) ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            LinearGradient(
                colors: [.netflixRed.opacity(0.5),.netflixRed.opacity(0) ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, 400 + (scrollViewOffSet * 0.75)))
        .opacity(scrollViewOffSet < -150 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffSet)
    }
    
    private var scrolViewReader: some View{
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false) {
                VStack(spacing:8){
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    
                    if let heroProduct{
                        heroCell(heroProduct)
                    }
                    
                    categoryView
                }
            } onScrollChanged: { offSet in
                scrollViewOffSet = min(0, offSet.y)
            }
    }
    
    private var supperHeaderl: some View{
        VStack(spacing:0){
            header
                .padding(16)
            
            if scrollViewOffSet > -20{
                NetFlixFilterBarView(
                    filters: FilterModel.mockArray,
                    isSelected: isSelectedFilter) { filter in
                        isSelectedFilter = filter
                    } onXmarkPressed: {
                        isSelectedFilter = nil
                    }
                    .padding(.top,16)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            
        }
        .padding(.bottom, 8)
        .background(
            ZStack{
                if scrollViewOffSet < -70 {
                    Rectangle()
                        .fill(Color.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth,value: scrollViewOffSet)
        .readingFrame { frame in
            if fullHeaderSize == .zero{
                fullHeaderSize = frame.size
            }
        }
    }
    
    private var categoryView: some View{
        LazyVStack(spacing:16){
            ForEach(Array(productRow.enumerated()), id: \.offset) { (index1,row) in
                VStack(alignment:.leading, spacing:6){
                    Text(row.title)
                        .font(.headline)
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal){
                        LazyHStack{
                            ForEach(Array(row.products.enumerated()), id:\.offset) { (index,product) in
                                NetfilxMovieCell(
                                    imageName: product.firstImage,
                                    title: product.title,
                                    topRanking: (index1 == 1) ? (index+1) : nil
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
    
    private func heroCell(_ heroProduct: Product)-> some View{
        NetfilxHeroCell(
            imageName: heroProduct.firstImage,
            isNetfilxFilm: true,
            title: heroProduct.title,
            categores: [heroProduct.category.capitalized, heroProduct.brand]) {
                
            } onPlayPressed: {
                
            } onMyListPressed: {
                
            }
            .padding(24)
    }
    
    private var header: some View{
        HStack(spacing:0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .onTapGesture {
                    router.dismissScreen()
                }
            
            HStack(spacing:16){
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
                
            }
            .font(.title2)
            
        }
    }
    
    private func getData() async {
        
        do {
            currentUser = try await DataBaseHelper().getUsers().first
            let products = try await Array(DataBaseHelper().getProducts().prefix(8))
            var rows: [ProductRow] = []
            let productBrand = Set(products.map{$0.brand})
            heroProduct = products.first
            
            for brand in productBrand{
                let products = products.filter{ $0.brand == brand }
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            productRow = rows
            
        }catch{
            print(error)
        }
    }
    
}

#Preview {
    NetflixHomeView()
}
