//
//  MapAnnotationView.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import SwiftUI

struct MapAnnotationView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.pink)
            Image(systemName: "star.fill")
                .resizable()
                .colorInvert()
                .padding(7)
        }
        .frame(width: 30, height: 30)
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView()
            .previewLayout(.sizeThatFits)
    }
}
