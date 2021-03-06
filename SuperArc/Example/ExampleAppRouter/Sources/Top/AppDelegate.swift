//
//  Copyright © 2019 An Tran. All rights reserved.
//

import FeatureA
import FeatureB
import SuperArcCoreComponent
import SuperArcCore
import SuperArcFoundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var core: Core!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Initialize Core
        #if DEBUG
        let endpoint: Endpoint = .development
        #else
        let endpoint: Endpoint = .production
        #endif
        let configurations = AnyRegistry(ConfigurationsRegistry(endpoint: endpoint))
        core = Core(endpoint: endpoint, configurations: configurations)

        // Initialize ComponentsRouter
        let navigator = Navigator(context: core.context)
        core.context.viewControllerContext.register(navigator, for: Navigator.self)

        // Register Components
        FeatureAComponent.register(to: core.context, navigator: navigator, dependencyProvider: core)
        FeatureBComponent.register(to: core.context, navigator: navigator, dependencyProvider: core)
        FeatureCComponent.register(to: core.context, navigator: navigator, dependencyProvider: core)
        FeatureDComponent.register(to: core.context, navigator: navigator, dependencyProvider: core)

        // Register Routers
        navigator.routerRegistry.register(FeatureAComponentRouter(context: core.context), for: FeatureAComponentRouter.self)
        navigator.routerRegistry.register(FeatureBComponentRouter(context: core.context), for: FeatureBComponentRouter.self)

        // Initialize first screen
        let dashboardComponent = DashboardComponent(dependency: EmptyComponent(), viewControllerContext: core.context.viewControllerContext, dependencyProvider: core)

        // Show the app
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = dashboardComponent.makeDashboardViewController()
        window?.makeKeyAndVisible()

        return true
    }
}

extension Core: DependencyProvider {}
