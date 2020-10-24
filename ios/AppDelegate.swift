
import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var bridge: RCTBridge!


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    initializeFlipper(with: application)
    
    let bridge = RCTBridge(delegate: self, launchOptions: launchOptions)
    let rootView = RCTRootView(bridge: bridge!, moduleName: "KotlinSwift", initialProperties: nil)
    let rootViewController = UIViewController()
    rootViewController.view = rootView
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = rootViewController
    self.window?.makeKeyAndVisible()
    return true

  }

 private func initializeFlipper(with application: UIApplication) {
      #if DEBUG
      #if FB_SONARKIT_ENABLED
        let client = FlipperClient.shared()
        let layoutDescriptorMapper = SKDescriptorMapper(defaults: ())
        FlipperKitLayoutComponentKitSupport.setUpWith(layoutDescriptorMapper)
        client?.add(FlipperKitLayoutPlugin(rootNode: application, with: layoutDescriptorMapper!))
        client?.add(FKUserDefaultsPlugin(suiteName: nil))
        client?.add(FlipperKitReactPlugin())
        client?.add(FlipperKitNetworkPlugin(networkAdapter: SKIOSNetworkAdapter()))
        client?.add(FlipperReactPerformancePlugin.sharedInstance())
        client?.start()
      #endif
      #endif
    }

}


extension AppDelegate:RCTBridgeDelegate{
  func sourceURL(for bridge: RCTBridge!) -> URL! {
    return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
  }
}

