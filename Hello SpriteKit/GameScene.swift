import SpriteKit

class GameScene: SKScene {
  
  var player: SKSpriteNode!
  
  override func didMove(to view: SKView) {
    player = SKSpriteNode(imageNamed: "Spaceship")
    addChild(player)
  }
    
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    
    let touchPositon = touch.location(in: self)
    
    let duration = getDuration(pointA: player.position, pointB: touchPositon, speed: 500)
    let move = SKAction.move(to: touchPositon, duration: duration)
    player.run(move)
    
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
  
  }
  
  override func update(_ currentTime: TimeInterval) {
      
  }
  
  func getDuration(pointA: CGPoint, pointB: CGPoint, speed: CGFloat) -> TimeInterval {
    let xDist = (pointB.x - pointA.x)
    let yDist = (pointB.y - pointA.y)
    let distance = sqrt((xDist * xDist) + (yDist * yDist));
    let duration = TimeInterval(distance/speed)
    return duration
  }
  
}
