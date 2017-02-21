  import SpriteKit
  
  struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
  }
  
  class GameScene: SKScene {
    
    var objects: [SKShapeNode] = []
    
    let objectCategory: UInt32 = 0b1
    let ballCategory: UInt32 = 0b1 << 1
    
    override func didMove(to view: SKView) {
      physicsWorld.gravity = CGVector(dx: 0, dy: -2.5)
      physicsWorld.contactDelegate = self
    }
    
    func addObjectAt(location: CGPoint) {
      let object = SKShapeNode(ellipseOf: CGSize(width: 50, height: 50))
      object.name = "object"
      object.position = location
      object.physicsBody = SKPhysicsBody(circleOfRadius: 25)
      object.physicsBody?.isDynamic = false
      object.physicsBody?.categoryBitMask = objectCategory
      object.physicsBody?.contactTestBitMask = ballCategory
      objects.append(object)
      addChild(object)
    }
    
    func addBallAt(location: CGPoint) {
      let ball = SKShapeNode(ellipseOf: CGSize(width: 20, height: 20))
      ball.name = "ball"
      ball.position = location
      ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
      ball.physicsBody?.usesPreciseCollisionDetection = true
      ball.physicsBody?.restitution = 0.4
      ball.physicsBody?.categoryBitMask = ballCategory
      ball.physicsBody?.contactTestBitMask = objectCategory
      objects.append(ball)
      addChild(ball)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      guard let touch = touches.first else { return }
      
      let touchPositon = touch.location(in: self)
      
      if objects.count < 5 {
        addObjectAt(location: touchPositon)
        return
      }
      
      addBallAt(location: touchPositon)
      
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    override func update(_ currentTime: TimeInterval) {
      enumerateChildNodes(withName: "ball") { node, stop in
        if node.position.y < -20 {
          node.removeFromParent()
        }
      }
    }
    
  }
  
  extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
      var firstBody: SKPhysicsBody
      var secondBody: SKPhysicsBody
      
      if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
        firstBody = contact.bodyA
        secondBody = contact.bodyB
      } else {
        firstBody = contact.bodyB
        secondBody = contact.bodyA
      }
      
      if secondBody.node?.name == "ball" && firstBody.node?.name == "object" {
        if let secondBody = secondBody.node as? SKShapeNode {
          secondBody.alpha -= 0.2
          if secondBody.alpha < 0.2 {
            secondBody.removeFromParent()
          }
        }
      }
      
    }
    
  }
  
  
