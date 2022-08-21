//
//  ChargingStationsViewModel.swift
//  ChargingStations
//
//  Created by Mohamed Fawzy on 21/08/2022.
//

import Foundation
import Combine
import MapKit

final class ChargingStationsViewModel: ObservableObject {
    @Published var poiList = [PointOfInterestBO]()
    @Published var selectedPOI: PointOfInterestBO?
    @Published var state: ViewModelState = .idle
    @Published var region = MKCoordinateRegion()
    var centerCoordinate = LocationCoordinate.defaultCoordinate
    var defaultRegoinSpan = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
    var delayedUpdate = PassthroughSubject<Void, Never>()
    var updateAfterTimeInterval: TimeInterval = 10
    let service: ChargingStationsServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    init(service: ChargingStationsServiceProtocol = ChargingStationsService()) {
        self.service = service
        self.configureNextUpdate()
        self.region.span = defaultRegoinSpan
    }
    
    func fetchPOIs() {
        self.state = .loading
        service.poiList()
            .map { ChargingStations(dtos: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case let .failure(error) = completion {
                    self.state = .error(error)
                }
            }, receiveValue: { [weak self] chargingStations in
                guard let self = self else { return }
                guard !chargingStations.poiList.isEmpty else {
                    self.state = .error(.emptyDataSet)
                    return
                }
                self.poiList = chargingStations.poiList
                if let coordinate = chargingStations.centerCoordinate, coordinate != self.centerCoordinate {
                    self.centerCoordinate = coordinate
                    let newCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    self.region.center = newCoordinate
                }
                let message: String = .updateAtMessage(date: Date())
                self.state = .finishedLoading(message)
                self.delayedUpdate.send()
            })
            .store(in: &cancellables)
    }
    
    private func configureNextUpdate() {
        delayedUpdate
            .delay(for: .seconds(updateAfterTimeInterval), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.fetchPOIs()
            }.store(in: &cancellables)
    }
}
