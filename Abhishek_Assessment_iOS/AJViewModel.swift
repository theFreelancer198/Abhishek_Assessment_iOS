//
//  AJViewModel.swift
//  iOSAssesment_Abhishek
//
//  Created by Abhishek J  on 29/04/24.
//

import Foundation

class JsonViewModel {
    private(set) var jsonData: [AJModel] = [] {
        didSet {
            jsondataChanged?()
        }
    }

    private var currentPage = 1
    private var isFetching = false
    private let pageSize = 20

    var isLoading: Bool = false {
        didSet {
            loadingStateChanged?()
        }
    }

    var errorMessage: String? {
        didSet {
            errorOccurred?()
        }
    }

    var jsondataChanged: (() -> Void)?
    var loadingStateChanged: (() -> Void)?
    var errorOccurred: (() -> Void)?

    func fetchJsonData(reset: Bool = false) {
        if isFetching {
            return
        }

        isFetching = true
        if reset {
            currentPage = 1
            jsonData.removeAll()
        }

        isLoading = true
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            self.isLoading = false
            self.isFetching = false

            if let error = error {
                self.errorMessage = "Network error: \(error.localizedDescription)"
                return
            }

            guard let data = data else {
                self.errorMessage = "No data received"
                return
            }

            do {
                let decodedData = try JSONDecoder().decode([AJModel].self, from: data)
                self.jsonData.append(contentsOf: decodedData)
                self.currentPage += 1
            } catch {
                self.errorMessage = "Data parsing error"
            }
        }.resume()
    }
}
