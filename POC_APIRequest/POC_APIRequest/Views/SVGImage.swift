//
//  SVGImage.swift
//  CheckInGuesser
//
//  Created by Pedro Henrique L. Moreiras on 26/01/26.
//

import SwiftUI
import UIKit
/// Responsable to show and fetch the image from API
struct SVGImage: View {
    public var url: URL
    
    /// Variable responsable to call use the elements from the SVGModel
    @State private var svgModel: SVGModel = SVGModel()
    
    var body: some View {
        Group {
            if let image = svgModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            else {
                ProgressView()
                    .onAppear {
                        svgModel.fetch(from: url)
                    }
            }
        }
    }
}
