//
//  DetailsView.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var viewModel: ChargingStationsViewModel
    var poi: PointOfInterestBO
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(poi.info) { item in
                        HStack(alignment: .firstTextBaseline) {
                            Text(item.title)
                                .fontWeight(.medium)
                            Spacer()
                            Text(item.value)
                        }
                        Divider()
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle(poi.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button(String.done) {
                        viewModel.selectedPOI = nil
                    }
                    .font(.headline)
                }
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(poi: PointOfInterestBO(id: 32, title: "Some Item", coordinate: .init(latitude: 0, longitude: 0),info: [
            .init(title: "Number Of Charging Points", value: "2"),
            .init(title: "Address", value: "address line 1\nline 2")
        ]))
    }
}
