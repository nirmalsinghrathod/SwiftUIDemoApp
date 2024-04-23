//
//  BumbleAppApp.swift
//  BumbleApp
//
//  Created by Nirmal Singh Rajput on 04/04/24.
//

import SwiftUI
import SwiftfulRouting

@main
struct BumbleAppApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView() { _ in
                ContentView()
            }
        }
    }
}


/*
struct ContentView: View {
    
    @State private var user: GitHubUser?
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user?.avatarUrl ?? ""))
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(user?.login ?? "")
            Text(user?.bio ?? "")
        }
        .padding()
        .task {
            do {
                user = try await getUserData()
            }catch GHError.invalidData{
                print("")
            }catch GHError.invalidResponse{
                print("")
            }catch GHError.invalidURL{
                print("")
            } catch {
                print("")
            }
        }
    }
    
    func getUserData() async throws -> GitHubUser{
        let endpoint = "https://api.github.com/users/sallen0400"
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GitHubUser.self, from: data)
        }catch{
            throw GHError.invalidData
        }
    }
}

struct GitHubUser: Codable{
    let login: String
    let avatarUrl: String
    let bio: String
}

enum GHError: Error{
    case invalidURL
    case invalidResponse
    case invalidData
}

#Preview {
    ContentView()
}


*/
