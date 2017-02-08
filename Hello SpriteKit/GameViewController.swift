import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      
      /*
      The default view for the view controller is cast to an SKView.
      This type of view can display an SKScene.
      */
      if let view = self.view as! SKView? {
        let scene = SKScene(size: view.bounds.size)
        
        scene.scaleMode = .aspectFill
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        
        view.presentScene(scene)
      }
    
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
