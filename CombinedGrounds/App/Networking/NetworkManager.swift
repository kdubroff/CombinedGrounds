//
//  NetworkManager.swift
//  CombinedGrounds
//
//  Created by Kenny Dubroff on 12/9/21.
//

import Foundation
import Combine

class NetworkManager {
    static let baseUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    func getData(from url: URL = NetworkManager.baseUrl) -> AnyPublisher<Data, URLError> {
        let subscription = URLSession.shared.dataTaskPublisher(for: url).map {
            $0.data
        }
        .eraseToAnyPublisher()

        return subscription
    }
}
