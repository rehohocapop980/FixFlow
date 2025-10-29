


import OneSignalFramework
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static var orientationLock: UIInterfaceOrientationMask = .portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        AppDelegate.orientationLock
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        start()
        OneSignal.initialize("26e617e2-0448-4dee-bca0-870464c0a0ee", withLaunchOptions: launchOptions)
        OneSignal.Notifications.requestPermission({ accepted in
            print("User accepted notifications: \(accepted)")
        }, fallbackToSettings: true)

        return true
    }
    
    private func start() {
        self.window = .init()
        let rootViewController = UIHostingController(rootView: MainTabView())
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
}

