//
//  GameScene.swift
//  Chicken Figher Ultra
//
//  Created by 90308589 on 10/20/20.
//

import SpriteKit
import GameplayKit
import UIKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var current_jumps = 0
    public var cn = 0
    var max_jumps = 2
    var ingame = false
    var shootspeed = 100
    var shootframe = 0
    var charbut1 = SKSpriteNode()
    var charbut2 = SKSpriteNode()
    var charbut3 = SKSpriteNode()
    var charbut4 = SKSpriteNode()
    var charback1 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 150, height: 150))
    var charback2 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 150, height: 150))
    var charback3 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 150, height: 150))
    var charback4 = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 150, height: 150))
    var backround = SKSpriteNode()
    var dummy = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
    var Punch_button = SKSpriteNode()
    var Right_Arrow = SKSpriteNode()
    var Platform = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 900, height: 100))
    var RightWall = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: 900))
    var LeftWall = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: 900))
    var jump_button = SKSpriteNode()
    var Left_Arrow = SKSpriteNode()
    var Player = Character(texture: SKTexture(imageNamed: "Chickette"))
    let buttonSize = CGSize(width: 96 , height: 96)
    let CharacterSize = CGSize(width: 96 , height: 96)
    var Play_Button = SKSpriteNode()
    var audioBackground: AVAudioPlayer?
    var dd = false
    var da:CGFloat = 100
    var dmax:CGFloat = 100
    var audioHurt: AVAudioPlayer?
    var audioJump: AVAudioPlayer?
    var audioPunch: AVAudioPlayer?
    var audioWoah: AVAudioPlayer?
    var heart = SKSpriteNode()
    var label = SKLabelNode(fontNamed: "AvenirNext-Bold")
    var score = 0
    var crate = SKSpriteNode()
    var Mute = false
    var MuteBttn = SKSpriteNode()
    var heartback = SKSpriteNode()
    var healthlabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    
    override func didMove(to view: SKView) {
        Player.setvalues(jumps: 2, jump_vel: 200, max_x_speed: 200, acc: 200, size: CharacterSize, anim_speed: 1)
        Player.setAnimations(run_sprite: "goose_walk", run_folder: "gooseMove", fly_sprite:"goose_flying" , fly_folder: "goose_flying_good", attack_sprite: "", attack_folder: "")
        print("gets called")
        setup()
    }
    func setupSounds(){
        do{
            var path = Bundle.main.path(forResource: "chicken_theme", ofType: "mp3")!
            var url = URL(fileURLWithPath: path)
            audioBackground = try AVAudioPlayer(contentsOf: url)
            path = Bundle.main.path(forResource: "OW2", ofType: "mp3")!
            url = URL(fileURLWithPath: path)
            audioHurt = try AVAudioPlayer(contentsOf: url)
            path = Bundle.main.path(forResource: "jump1", ofType: "mp3")!
            url = URL(fileURLWithPath: path)
            audioJump = try AVAudioPlayer(contentsOf: url)
            path = Bundle.main.path(forResource: "punch1", ofType: "mp3")!
            url = URL(fileURLWithPath: path)
            audioPunch = try AVAudioPlayer(contentsOf: url)
            path = Bundle.main.path(forResource: "realwoah", ofType: "mp3")!
            url = URL(fileURLWithPath: path)
            audioWoah = try AVAudioPlayer(contentsOf: url)
            } catch {}
        audioBackground?.play()
    }
    
    func setup(){
       
        set_names()
        set_textures()
        set_sizes()
        set_physics()
        set_positions()
        setup_main_menu()
        setupSounds()
    }
    
    func set_names(){
        Platform.name = "Platform"
        RightWall.name = "RightWall"
        LeftWall.name = "LeftWall"
        Player.name = "Player"
        Right_Arrow.name = "Right"
        Left_Arrow.name = "Left"
        Play_Button.name = "PlayButton"
        jump_button.name = "JumpButton"
        Punch_button.name = "PunchButton"
        dummy.name = "dummy"
        charbut1.name = "charbut1"
        charbut2.name = "charbut2"
        charbut3.name = "charbut3"
        charbut4.name = "charbut4"
        charback1.name = "charback1"
        charback2.name = "charback2"
        charback3.name = "charback3"
        charback4.name = "charback4"
        dummy.name = "dummy"
        MuteBttn.name = "mute"
    }
    
    func set_textures(){
        set_filtering_mode(fileNamed: "RightArrow", node: Right_Arrow)
        set_filtering_mode(fileNamed: "LeftArrow", node: Left_Arrow)
        set_filtering_mode(fileNamed: "StartButton", node: Play_Button)
        set_filtering_mode(fileNamed: "JumpButton", node: jump_button)
        set_filtering_mode(fileNamed: "clown", node: backround)
        set_filtering_mode(fileNamed: "Punch Button", node: Punch_button)
        //set_filtering_mode(fileNamed: "dummy", node: dummy)
        setTexture(folderName: "ChickenBossWalk", sprite: dummy, spriteName: "chickenBoss", speed: 100)
        set_filtering_mode(fileNamed: "goose_stand", node: charbut1)
        set_filtering_mode(fileNamed: "penguin_walk0", node: charbut2)
        set_filtering_mode(fileNamed: "sprite_0", node: charbut3)
        set_filtering_mode(fileNamed: "elunwalk0", node: charbut4)
        set_filtering_mode(fileNamed: "crate", node: crate)
        set_filtering_mode(fileNamed: "heart", node: heart)
        set_filtering_mode(fileNamed: "Mute", node: MuteBttn)
        set_filtering_mode(fileNamed: "emptyheart", node: heartback)
    }
    
    func set_sizes(){
        Right_Arrow.size = buttonSize
        Player.size = CharacterSize
        Left_Arrow.size = buttonSize
        Play_Button.size = buttonSize
        jump_button.size = buttonSize
        Punch_button.size = buttonSize
        charbut1.size = CGSize(width: 80, height: 80)
        charbut2.size = CGSize(width: 80, height: 80)
        charbut3.size = CGSize(width: 80, height: 80)
        charbut4.size = CGSize(width: 80, height: 80)
        dummy.size = CharacterSize
        backround.size = CGSize(width: 800, height: 541)
        label.fontSize = 30
        label.fontColor = UIColor.green
        
        label.zPosition = 100
        healthlabel.fontSize = 30
        healthlabel.fontColor = UIColor.green
        heart.size = CharacterSize
        heartback.size = CharacterSize
        crate.size = buttonSize
        MuteBttn.size = buttonSize
    }
    
    func set_physics(){
        
        //bit mask of 1 for player
        //bit mask of 2 for stuff like walls and platforms
        
        physicsWorld.contactDelegate = self
        RightWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 900))
        RightWall.physicsBody?.affectedByGravity = false
        RightWall.physicsBody?.isDynamic = false
        
        LeftWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 900))
        LeftWall.physicsBody?.affectedByGravity = false
        LeftWall.physicsBody?.isDynamic = false
       
        Platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 900, height: 100))
        Platform.physicsBody?.affectedByGravity = false
        Platform.physicsBody?.friction = 1
        Platform.physicsBody?.isDynamic = false
        Platform.physicsBody?.categoryBitMask = 2
        Platform.physicsBody?.contactTestBitMask = 1
        
        
        LeftWall.physicsBody?.categoryBitMask = 2
        RightWall.physicsBody?.categoryBitMask = 2
        
        dummy.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "chickenboss0"), size: CharacterSize)
        dummy.physicsBody?.allowsRotation = false
        dummy.physicsBody?.categoryBitMask = 8
        dummy.physicsBody?.collisionBitMask = 2
        
        crate.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "chickenboss0"), size: CharacterSize)
        
       
    }
    
    func set_positions(){
        Play_Button.position = CGPoint(x: 0, y: -200)
        
        charbut1.position = CGPoint(x: -200, y: 100)
        charbut1.zPosition = 0
        charbut2.position = CGPoint(x: 200, y: 100)
        charbut2.zPosition = 0
        charbut3.position = CGPoint(x: -200, y: -100)
        charbut3.zPosition = 0
        charbut4.position = CGPoint(x: 200, y: -100)
        charbut4.zPosition = 0
        
        charback1.position = CGPoint(x: -200, y: 100)
        charback1.zPosition = -1
        charback2.position = CGPoint(x: 200, y: 100)
        charback2.zPosition = -1
        charback3.position = CGPoint(x: -200, y: -100)
        charback3.zPosition = -1
        charback4.position = CGPoint(x: 200, y: -100)
        charback4.zPosition = -1
        
        Platform.position = CGPoint(x: 0, y: -200)
        LeftWall.position = CGPoint(x: -450, y: 0)
        Left_Arrow.position = CGPoint(x: -300, y: -200)
        heart.position = CGPoint(x: -300, y: 200)
        heart.zPosition = 9999
        healthlabel.position = CGPoint(x: -250, y: 150)
        healthlabel.zPosition = 10000
        heartback.position = CGPoint(x: -300, y: 200)
        heartback.zPosition = 9998
        Right_Arrow.position = CGPoint(x: -200,y: -200)
        RightWall.position = CGPoint(x: 435, y: 0)
        jump_button.position = CGPoint(x: 200, y: -200)
        Punch_button.position = CGPoint(x: 300, y: -200)
        backround.zPosition = -2
        Player.position.x = -300
        dummy.position.x = 300
        label.position = CGPoint(x: 300, y: 200)
        crate.position = CGPoint.zero
        MuteBttn.position  = CGPoint(x: 0, y: -100)
    }
    
    func setup_game_scene(){
        ingame = true
        score = 0
        label.text = "Score: \(score)"
        self.removeAllChildren()
        //true is left
        dd = Bool.random()
        if cn == 1{
            Player.setAnimations(run_sprite: "goose_walk", run_folder: "gooseMove", fly_sprite:"goose_flying" , fly_folder: "goose_flying_good", attack_sprite: "goose_gust", attack_folder: "goose_gust")
            Player.setvalues(jumps: 2, jump_vel: 200, max_x_speed: 200, acc: 200, size: CharacterSize,anim_speed: 1)
            set_filtering_mode(fileNamed: "barnSwag", node: backround)
        }else if cn == 2{
            Player.setAnimations(run_sprite: "penguin_Walk", run_folder: "Penguin_Move", fly_sprite:"penguin_jump" , fly_folder: "Penguin_fly", attack_sprite: "penguin_attack", attack_folder: "penguin_punch_folder")
            Player.setvalues(jumps: 2, jump_vel: 200, max_x_speed: 200, acc: 200, size: CharacterSize,anim_speed: 1)
            set_filtering_mode(fileNamed: "alaska", node: backround)
            
        }else if cn == 3{
            Player.setAnimations(run_sprite: "sprite_", run_folder: "micha_walk", fly_sprite:"micha_jump" , fly_folder: "micha_jump", attack_sprite: "micha_attack", attack_folder: "micha_attack")
            Player.setvalues(jumps: 2, jump_vel: 200, max_x_speed: 200, acc: 200, size: CharacterSize, anim_speed: 6)
            set_filtering_mode(fileNamed: "ocean", node: backround)
            
        }else if cn == 4{
            Player.setAnimations(run_sprite: "elunwalk", run_folder: "elunmaskwalk", fly_sprite:"elunjump" , fly_folder: "elunmaskjump", attack_sprite: "s_", attack_folder: "elunattack")
            Player.setvalues(jumps: 2, jump_vel: 200, max_x_speed: 200, acc: 200, size: CharacterSize, anim_speed: 1)
            set_filtering_mode(fileNamed: "space2", node: backround)
           
        }
        
        addChild(Platform)
        addChild(Player)
        addChild(Left_Arrow)
        addChild(Right_Arrow)
        addChild(RightWall)
        addChild(LeftWall)
        addChild(jump_button)
        addChild(backround)
        addChild(Punch_button)
        addChild(dummy)
        addChild(heart)
        addChild(heartback)
        addChild(healthlabel)
        addChild(label)
    }
    
    
    func setup_main_menu(){
        self.removeAllChildren()
        addChild(Play_Button)
        addChild(charbut1)
        addChild(charbut2)
        addChild(charbut3)
        addChild(charbut4)
        addChild(charback1)
        addChild(charback2)
        addChild(charback3)
        addChild(charback4)
        addChild(MuteBttn)
        set_filtering_mode(fileNamed: "clown", node: backround)
        addChild(backround)
    }
    
    func setup_game_over(){
        self.removeAllChildren()
        addChild(Play_Button)
        addChild(backround)
        addChild(label)
        set_filtering_mode(fileNamed: "gameover", node: backround)
        set_positions()
    }
   
    func set_filtering_mode(fileNamed: String,node: SKSpriteNode){
        let texture = SKTexture(imageNamed: fileNamed)
        texture.filteringMode = SKTextureFilteringMode.nearest
        node.texture = texture
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        buttonPress(touch: touches.first!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        if Right_Arrow.contains(location){
            
            Player.x_direction = ""
            Player.prevDir = "right"
            Right_Arrow.alpha = 1
        }
        if Left_Arrow.contains(location){
            
            Player.x_direction = ""
            Player.prevDir = "left"
            Left_Arrow.alpha = 1

        }
        if jump_button.contains(location){
           
            jump_button.alpha = 1

        }
        if Punch_button.contains(location){
            
            Player.sp = false
            Player.punch = false
            Punch_button.alpha = 1
        }
    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
    
    override func update(_ currentTime: TimeInterval) {
        if Mute{
            audioBackground?.volume = 0
            audioHurt?.volume = 0
            audioWoah?.volume = 0
            audioJump?.volume = 0
            audioPunch?.volume = 0
        }else {
            audioBackground?.volume = 1
            audioHurt?.volume = 1
            audioWoah?.volume = 1
            audioJump?.volume = 1
            audioPunch?.volume = 1
        }
       
        healthlabel.text = "\(Int(heart.alpha * 100))%"
      
        if heart.alpha <= 0.2{
            setup_game_over()
        }
        if shootframe < shootspeed && ingame && heart.alpha > 0{
            shootframe += 1
        }else if shootframe >= shootspeed && ingame && heart.alpha > 0{
            shootframe = 0
            contentsdotjson()
        }
        if dummy.position.x > 300{
            dd = true
            
        } else if dummy.position.x < -300{
            dd = false
            
        }
        if dd == false && (dummy.physicsBody?.velocity.dx)! < dmax{
            dummy.physicsBody?.velocity.dx += da
            dummy.xScale = 1
        }else if dd == true && (dummy.physicsBody?.velocity.dx)! > -dmax{
            dummy.physicsBody?.velocity.dx -= da
            dummy.xScale = -1
        }
        
        if Player.punch && (CGPointDistance(from: Player.position, to: dummy.position) < 100){
            if !audioHurt!.isPlaying{
                audioHurt?.play()
                score += 1
                label.text = "Score: \(score)"
            }
        }
        if !audioBackground!.isPlaying{
            audioBackground?.play()
        }
        Player.update_character()
        if Player.x_direction != "" && Player.position.y < 0 && heart.alpha >= 0.2{
            addEmiter(loc: CGPoint(x: Player.position.x, y: Player.position.y-Player.size.height/2), file: "PlayerWalkDust")
        }
        switch cn {
        case 1:
            charback1.color = UIColor.cyan
            charback2.color = UIColor.yellow
            charback3.color = UIColor.yellow
            charback4.color = UIColor.yellow
            break
        case 2:
            charback1.color = UIColor.yellow
            charback2.color = UIColor.cyan
            charback3.color = UIColor.yellow
            charback4.color = UIColor.yellow
            break
        case 3:
            charback1.color = UIColor.yellow
            charback2.color = UIColor.yellow
            charback3.color = UIColor.cyan
            charback4.color = UIColor.yellow
            break
        case 4:
            charback1.color = UIColor.yellow
            charback2.color = UIColor.yellow
            charback3.color = UIColor.yellow
            charback4.color = UIColor.cyan
        default:
            charback1.color = UIColor.yellow
            charback2.color = UIColor.yellow
            charback3.color = UIColor.yellow
            charback4.color = UIColor.yellow
            break
        }
    }
    
    func buttonPress(touch: UITouch){
        enumerateChildNodes(withName: "//*") { [self] (node, stop) in
            let location = touch.location(in: self)
            if node.name == "Right"{
                if (self.Right_Arrow.contains(location)){
                    self.Right_Arrow.alpha = 0.5
                    
                    Player.x_direction = "right"
                    Player.isFly = false
                    
                }
            }else  if node.name == "Left"{
                if (self.Left_Arrow.contains(location)){
                    self.Left_Arrow.alpha = 0.5
                    Player.x_direction = "left"
                    Player.isFly = false
                    
                }
            }else if node.name == "PlayButton"{
                if (self.Play_Button.contains(location) && self.cn != 0 && !ingame){
             
                    self.setup_game_scene()
                }else if (self.Play_Button.contains(location) && self.cn != 0 && ingame){
            
                    self.setup_main_menu()
                    heart.alpha = 1
                    ingame = false
                }
            }else if node.name == "JumpButton"{
                if(self.jump_button.contains(location)){
                    self.jump_button.alpha = 0.5
                 
                    if self.current_jumps < self.max_jumps{
                        self.current_jumps += 1
                        self.Player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: Player.jump_velocity))
                        Player.isWalk = false
                        if !self.audioJump!.isPlaying{
                            audioJump?.play()
                        }
                    }
                }
            }else if node.name == "PunchButton"{
                if self.Punch_button.contains(location){
                    self.Punch_button.alpha = 0.5
                
                    Player.sp = true
                    if !self.audioPunch!.isPlaying{
                        audioPunch?.play()
                        
                    }
                }
            }else if node.name == "charback1"{
                if self.charback1.contains(location){
                    self.cn = 1
                  
                }
            }else if node.name == "charback2"{
                if self.charback2.contains(location){
                    self.cn = 2
                  
                }
            }else if node.name == "charback3"{
                if self.charback3.contains(location){
                    self.cn = 3
                   
                }
            }else if node.name == "charback4"{
                if self.charback4.contains(location){
                    self.cn = 4
                    
                }
            }else if node.name == "mute"{
                if self.MuteBttn.contains(location){
                    Mute = !Mute
                    if Mute{
                        MuteBttn.alpha = 0.5
                    }else{
                        MuteBttn.alpha = 1
                    }
                }
            }
        }
    }
    
   
    func addEmiter(loc: CGPoint,file:String){
        let emitter = SKEmitterNode(fileNamed: file)
        emitter?.name = "emitter"
        emitter?.zPosition = 2;
        emitter?.position = CGPoint(x: loc.x, y: loc.y )
        addChild(emitter!)
        
        emitter?.run(SKAction.sequence([
            SKAction.wait(forDuration: 0.5),SKAction.removeFromParent()]))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        if nodeA?.name == "Player" && nodeB?.name == "Platform"{
            current_jumps = 0
            Player.isFly = false
        } else if nodeB?.name == "Player" && nodeA?.name == "Platform"{
            current_jumps = 0
            Player.isFly = false
        } else if nodeA?.name == "Player" && nodeB?.name == "egg"{
            heart.alpha -= 0.2
            nodeB!.removeFromParent()
            audioWoah?.play()
        } else if nodeB?.name == "Player" && nodeA?.name == "egg"{
            heart.alpha -= 0.2
            nodeB!.removeFromParent()
            audioWoah?.play()
        }
        
    }
    
    func contentsdotjson(){
        let egg = SKSpriteNode()
        
        set_filtering_mode(fileNamed: "egg", node: egg)
        let dx = Player.position.x - dummy.position.x
        let dy = Player.position.y - dummy.position.y
        egg.position.x = dummy.position.x
        egg.position.y = dummy.position.y
        egg.zPosition = 4
        egg.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "egg"), size: CGSize(width: 100, height: 100))
        egg.physicsBody?.categoryBitMask = 8
        egg.size = CGSize(width: 100, height: 100)
        egg.name = "egg"
        egg.physicsBody?.collisionBitMask = 2
        egg.physicsBody?.contactTestBitMask = 1
        egg.physicsBody?.mass = 0.05
        addChild(egg)
        egg.physicsBody?.applyImpulse(CGVector(dx: dx/10, dy: dy/10))
        egg.run(SKAction.sequence([
            SKAction.wait(forDuration: 1),SKAction.removeFromParent()]))
    }
    
    
    
    func setTexture(folderName: String,sprite:SKSpriteNode,spriteName: String,speed:Double){
           let textureAtlas = SKTextureAtlas(named: folderName)
           var frames: [SKTexture] = []
        
           for i in 0...textureAtlas.textureNames.count - 1{
               let name = "\(spriteName)\(i).png"
               let texture = SKTexture(imageNamed: name)
               texture.filteringMode = SKTextureFilteringMode.nearest
               frames.append(texture)
           }
        
        self.removeAllActions()
        let animation = SKAction.animate(with: frames, timePerFrame: (1/speed))
           sprite.run(SKAction.repeatForever(animation))
    }
    
}
