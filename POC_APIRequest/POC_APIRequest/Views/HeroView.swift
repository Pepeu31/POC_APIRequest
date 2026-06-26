//
//  HeroView.swift
//  POC_APIRequest
//
//  Created by Pedro Henrique L. Moreiras on 25/06/26.
//

import SwiftUI

struct HeroView: View {
    @State private var user: HeroModel?
    
    var body: some View {
        VStack(spacing: 20) {
            if user != nil {
                AsyncImage(url: URL(string:  "https://picsum.photos/100")) { image in
                    image
                        .resizable()
                        .clipShape(.circle)
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                }
            }
           

            Text(user?.name ?? "Hero Name")
                .bold()
                .font(.title3)
            
            Text(user?.biography.fullName ?? "Hero Real Name")
            
            Text(user?.biography.firstAppearance ?? "First Apperance")
                .padding()
            
            
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getHero()
            } catch HRError.invaliURL{
                print("Invalid URL")
            } catch HRError.invalidResponse{
                print("Invalid response")
            } catch HRError.invalidData {
                print("Invalid Data")
            } catch {
                print("Unexpected error")
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    HeroView()
}
