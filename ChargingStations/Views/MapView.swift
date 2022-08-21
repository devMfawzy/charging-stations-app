//
//  ContentView.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var viewModel: ChargingStationsViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.poiList, annotationContent: { poi in
                MapAnnotation(coordinate: poi.coordinate.mapCoordinate) {
                    MapAnnotationView()
                        .onTapGesture(count: 1, perform: {
                            viewModel.selectedPOI = poi
                        })
                }})
            .ignoresSafeArea()
            .onAppear {
                viewModel.fetchPOIs()
            }
            .sheet(item: $viewModel.selectedPOI, content: { selectedPOI in
                DetailsView(poi: selectedPOI)
            })
            statusView
                .padding(22)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(ChargingStationsViewModel())
    }
}

extension MapView {
    var statusView: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .tint(.accentColor)
                    .scaleEffect(2)
            case .error(let message):
                HStack() {
                    Text(message.description+",")
                    Button(String.retry) {
                        viewModel.fetchPOIs()
                    }
                }
                .font(.system(size: 18, weight: .bold))
                .padding()
                .background(.pink.opacity(0.6))
                .cornerRadius(10)
            case .finishedLoading(let message):
                Text(message)
                    .fontWeight(.bold)
            default:
                Text(String.waiting)
            }
        }
    }
}
