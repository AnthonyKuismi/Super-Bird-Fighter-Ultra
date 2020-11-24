//
//  Character.swift
//  Chicken Fighter Ultra
//
//  Created by 90308589 on 11/18/20.
//

import SpriteKit
import GameplayKit
import UIKit
import Foundation

class Character:SKSpriteNode{
    
    var x_direction = ""
    var isWalk = false
    var isFly = false
    var punch = false
    
    var max_jumps: CGFloat = 0
    var jump_velocity: CGFloat = 0
    var x_max_speed:CGFloat = 0
    var x_acc:CGFloat = 0
    var CharacterSize: CGSize = CGSize.zero
    
    var run_animation_sprite_name: String = ""
    var run_animation_folder_name: String = ""
    var fly_animation_sprite_name: String = ""
    var fly_animation_folder_name: String = ""
    var attack_animation_sprite_name: String = ""
    var attack_animation_folder_name: String = ""
    
    
    init(texture: SKTexture!){
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   public func setvalues(jumps:CGFloat, jump_vel:CGFloat, max_x_speed:CGFloat, acc:CGFloat, size:CGSize){
        max_jumps = jumps
        jump_velocity = jump_vel
        x_max_speed = max_x_speed
        x_acc = acc
        CharacterSize = size
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: run_animation_sprite_name + "0"), size: CharacterSize)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.collisionBitMask = 2
        self.physicsBody?.contactTestBitMask = 2
    self.physicsBody?.mass = 0.4
    }
    
    public func setAnimations(run_sprite:String,run_folder:String,fly_sprite:String,fly_folder:String,attack_sprite:String,attack_folder:String){
        run_animation_sprite_name = run_sprite
        run_animation_folder_name  = run_folder
        fly_animation_sprite_name = fly_sprite
        fly_animation_folder_name = fly_folder
        attack_animation_sprite_name = attack_sprite
        attack_animation_folder_name = attack_folder
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
             
           let animation = SKAction.animate(with: frames, timePerFrame: 1/speed)
           sprite.run(SKAction.repeatForever(animation))
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

    public func update_character(){
      
        
        
        if punch{
            self.removeAllActions()
            if x_direction == "left"{
                self.xScale = -1
            }else{
                self.xScale = 1
            }
            setTexture(folderName: attack_animation_folder_name, sprite: self, spriteName: attack_animation_sprite_name,speed: 100)
            punch = false
        }
        else if x_direction == "right" && !isFly{
            if (self.physicsBody?.velocity.dx)! < x_max_speed{
                self.physicsBody?.velocity.dx += x_acc
                if (!isWalk){
                    self.removeAllActions()
                    setTexture(folderName: run_animation_folder_name, sprite: self, spriteName: run_animation_sprite_name,speed: 100)
                    self.xScale = 1
                    isWalk = true
                }
            }
        }else if x_direction == "left" && !isFly{
            if (self.physicsBody?.velocity.dx)! > -x_max_speed{
                self.physicsBody?.velocity.dx -= x_acc
                if (!isWalk){
                    self.removeAllActions()
                    setTexture(folderName: run_animation_folder_name, sprite: self, spriteName: run_animation_sprite_name,speed: 100)
                    self.xScale = -1
                    isWalk = true
                }
            }
        }else if (self.physicsBody?.velocity.dy)! >= 5 && !isWalk{
            if x_direction == "left"{
                self.xScale = -1
            }else{
                self.xScale = 1
            }
            if (!isFly){
                self.removeAllActions()
                setTexture(folderName: fly_animation_folder_name, sprite: self, spriteName: fly_animation_sprite_name,speed: 15)
                isWalk = false
                isFly = true
            }
            
        }else {
            self.removeAllActions()
            isWalk = false
            isFly = false
        }
        
    }
}
