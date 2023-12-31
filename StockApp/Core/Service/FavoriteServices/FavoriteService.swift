
import Foundation

protocol FavoritesServiceProtocol {
    func save(id: String)
    func remove(id: String)
    func isFavorite(for id: String) -> Bool
}
