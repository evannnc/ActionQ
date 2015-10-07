//
//  actionSerializer.swift
//  SuperHealos
//
//  Created by Evan on 10/5/15.
//  Copyright (c) 2015 Evan. All rights reserved.
//

import Foundation
import SpriteKit

// nodes that represent an action to preform on a sprite
class Node {
    var action: SKAction? = nil
    var next: Node? = nil
    var sprite: SKSpriteNode
    
    
    init(sprite: SKSpriteNode, action: SKAction) {
        self.action = action
        self.sprite = sprite
    }
}


// the main class that manages the action queue.  simply create an ActionQ object, and call the 
// addNext function to put an action into the queue to be processed immediately.action
// actions are processed sequentially and each action in the queue waits for the previous action
// to finish before it will start. 
class ActionQ {
    var count: Int = 0
    var head: Node? = nil
    var tail: Node? = nil
    
    init(){
        
    }
    
    
    // add a new sprite/action to the end of the queue to be processed.
    func addNext(sprite : SKSpriteNode, action :SKAction){
        let n = Node(sprite : sprite, action: action)
        
        if self.isEmpty() {
            self.count++
            self.head = n
            self.tail = n
            sprite.runAction(action, completion: actionComplete)
        } else {
            self.count++
            self.tail!.next = n
            self.tail! = n
        }
        
    }
    
    
    // this function is called every time an action in the queue is completed
    func actionComplete(){
        if self.head != nil  {
            if self.head!.next != nil {
                self.head! = self.head!.next!
                self.head?.sprite.runAction(self.head?.action, completion: self.actionComplete)
            } else {
                self.head = nil
            }
        }
        self.count--
    }
    
    func isEmpty() -> Bool {
        return self.count == 0
    }
}