enum TabBarItem: String {
    case home = "home"
    case market = "market"
    case action = "action"
    case assets = "assets"
    case menu = "menu"

    var order: Int {
        switch self {
        case .home:   return 0
        case .market: return 1
        case .action: return 2
        case .assets: return 3
        case .menu:   return 4
        }
    }
}
