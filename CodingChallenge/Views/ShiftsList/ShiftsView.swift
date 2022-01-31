//
//  ShiftsView.swift
//  CodingChallenge
//
//  Created by Brady Miller on 4/7/21.
//

import SwiftUI

struct ShiftsView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.shiftDays.isEmpty {
                    
//TODO: extract this to new ShiftListView struct
                    ScrollView {
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            ForEach(viewModel.shiftDays, id: \.dateInString) { section in
                                Section(header: ShiftListHeaderView(header: section.dateInString)) {
                                    ForEach(section.shifts) { availableShift in
                                        ShiftsListCell(viewModel: .init(shift: availableShift))
                                            .onAppear {
                                                viewModel.fetchMoreIfNeeded(currentItem: availableShift)
                                            }
                                            .onTapGesture {
                                                viewModel.selectedShift = availableShift
                                                viewModel.isPresentingDetails = true
                                            }
                                    }
                                }
                            }
                            if viewModel.isFetching {
                                ProgressView().padding()
                            }
                        }
                    }
                } else {
                    if viewModel.isFetching {
                        FetchingInProgressView()
                    } else {
                        NoAvailableShiftsView()
                    }
                }
            }
            .sheet(isPresented: $viewModel.isPresentingDetails, onDismiss: {
                viewModel.isPresentingDetails = false
            }, content: {
                ShiftDetailsView(viewModel: .init(shift: viewModel.selectedShift, requestedLocation: viewModel.shiftMeta))
            })
            .navigationTitle("Shifts")
        }
        .navigationViewStyle(.stack)
        .onAppear {
            viewModel.loadMoreShifts(reset: true)
        }
    }
}

extension ShiftsView {
    class ViewModel: ObservableObject {
        let dataProvider: DataProvider
        
        @Published private(set) var isFetching = false
        @Published private(set) var shiftDays: [AvailableShiftsDay]
        @Published private(set) var shiftMeta: AvailableShiftsMeta?
        private(set) var canLoadMore = true
//TODO: add filter view for fetch configuration
        private(set) var nextShiftFetchFilter = AvailableShiftFilter.default
        private(set) var flatShiftsCache: [AvailableShift] = []
        
        @Published var isPresentingDetails = false
        var selectedShift: AvailableShift?
        
//TODO: add view with error and change filter button
        @Published var presentedError: Error?
        
        init(dataProvider: DataProvider = DataProviderImpl(networkManager: URLSessionNetworkManager()), shiftDays: [AvailableShiftsDay] = []) {
            self.dataProvider = dataProvider
            self.shiftDays = shiftDays
        }
        
        func loadMoreShifts(reset: Bool = false) {
            guard !isFetching && canLoadMore else {
                return
            }
            
            isFetching = true
            
            dataProvider.availableShifts(filter: nextShiftFetchFilter) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let json):
                    self.handleFetchedShifts(reset: reset, json: json)
                case .failure(let error):
                    self.presentedError = error
                    print(error)
                }
                self.isFetching = false
            }
        }
        
        func fetchMoreIfNeeded(currentItem: AvailableShift) {
            let loadingTresholdIndex = flatShiftsCache.index(flatShiftsCache.endIndex, offsetBy: -4)
            if flatShiftsCache.firstIndex(where: { $0.id == currentItem.id }) == loadingTresholdIndex {
                loadMoreShifts()
            }
        }
        
        private func handleFetchedShifts(reset: Bool, json: AvailableShiftsResponse) {
            nextShiftFetchFilter.nextPage()
            shiftDays = reset ? json.data : shiftDays + json.data
            shiftMeta = json.meta
            flatShiftsCache = shiftDays.reduce(into: []) { $0.append(contentsOf: $1.shifts) }
            
            if json.data.isEmpty {
                checkFetchStopCondition(json: json)
            }
        }
        
        private func checkFetchStopCondition(json: AvailableShiftsResponse) {
            guard let stopFetchingDate = Date().shiftFormattedString.incrementShiftFormattedString(addingDays: 365) else {
                canLoadMore = false
                return
            }
            
            switch nextShiftFetchFilter.type {
            case .week(let start),.fourDays(let start):
                guard let start = start, start < stopFetchingDate else {
                    canLoadMore = false
                    return
                }
                break
            case .list(let start, let end):
                guard
                    end != nil,
                    let start = start,
                    start < stopFetchingDate
                else {
                    canLoadMore = false
                    return
                }
                break
            }
        }
    }
}

struct ShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftsView(viewModel: .init(shiftDays: ShiftsView_Previews.mockedShiftDays))
    }
}

extension ShiftsView_Previews {
    static var mockedShiftDays: [AvailableShiftsDay] {
        return [
            AvailableShiftsDay(dateInString: "2022-02-07", shifts: [ShiftsListCell_Previews.mockedShift, ShiftsListCell_Previews.mockedShift]),
             AvailableShiftsDay(dateInString: "2022-02-08", shifts: [ShiftsListCell_Previews.mockedShift, ShiftsListCell_Previews.mockedShift])]
    }
}
