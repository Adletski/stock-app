
import Foundation
import UIKit


final class Assembly {
    static let assembler: Assembly = .init()
    let favoritesService: FavoritesServiceProtocol = FavoritesLocalService()
    
    private init() {}
    
    private lazy var network: NetworkService = Network()
    
    private lazy var stocksService: StocksServiceProtocol = StocksService(network: network)
    private lazy var chartsService: ChartsServiceProtocol = ChartsService(network: network)
    
    
    private func stocksModule() -> UIViewController {
        let presneter = StocksPresenter(service: stocksService)
        let view = StocksViewController(presenter: presneter)
        presneter.view = view
        
        return view
    }
    
    private func favoriteModule() -> UIViewController {
        let presenter = FavoritePresenter(service: stocksService)
        let favoritesVC = FavoriteViewController(presenter: presenter)
        presenter.view = favoritesVC
        return favoritesVC
    }
    
    private func searchModule() -> UIViewController {
        let searchService = SearchService(service: stocksService)
        let presenter = SearchPersenter(service: searchService)
        let searchVC = SearchViewController(presenter: presenter)
        presenter.viewController = searchVC
        return searchVC
    }
    
    
    
    func thirdVC() -> UIViewController {
        UIViewController()
    }
    
    func tabbarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        
        let stocksVC = UINavigationController(rootViewController: stocksModule())
        stocksVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "diagram"), tag: 0)
        
        let favoriteVC = UINavigationController(rootViewController: favoriteModule())
        favoriteVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Icon"), tag: 1)
        
        let searchVC = UINavigationController(rootViewController: searchModule())
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search") , tag: 2)
        
        tabbar.viewControllers = [stocksVC, favoriteVC, searchVC]
        tabbar.tabBarItem.imageInsets = .init(top: 5, left: 0, bottom: -5, right: 0)
        tabbar.tabBar.barTintColor = .backgroundGray
        tabbar.tabBar.backgroundColor = .backgroundGray
        return tabbar
    }
    
    func detailVC(model: StockModelProtocol) -> UIViewController {
        let presenter = StockDetailPresenter(model: model, service: chartsService)
        let view = StockDetailViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
