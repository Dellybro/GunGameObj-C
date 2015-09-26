//
//  GameScene.m
//  Squad
//
//  Created by Travis Delly on 9/24/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "GameScene.h"
#import "ArconShip.h"
#import "EnemyNormalAttack.h"
#import "MainShip.h"
#import "AppDelegate.h"
#import "NormalAttack.h"

@interface GameScene()


@property int count;
@property MainShip* ship;
@property SKSpriteNode *ground;
@property SKSpriteNode *background;
@property SKSpriteNode *fire;

@property SKSpriteNode *right;
@property SKSpriteNode *left;
@property SKSpriteNode *jump;
@property SKSpriteNode *crouch;

@property SKNode *enemyShips;
@property SKNode *playerStuff;

@end



@implementation GameScene{
    AppDelegate *sharedDelegate;
}

-(void)buttons{
    _count = 0;
    
    
    _right = [SKSpriteNode spriteNodeWithImageNamed:@"right"];
    _right.position = CGPointMake(self.size.width/2-20, 30);
    _right.name = @"right";
    _right.zPosition = 10;
    
    _left = [SKSpriteNode spriteNodeWithImageNamed:@"left"];
    _left.position = CGPointMake(self.size.width/2-160, 30);
    _left.name = @"left";
    _left.zPosition = 10;
    
    _jump = [SKSpriteNode spriteNodeWithImageNamed:@"jump"];
    _jump.position = CGPointMake(self.size.width/2-90, 100);
    _jump.zPosition = 10;
    _jump.name = @"jump";
    
    _crouch = [SKSpriteNode spriteNodeWithImageNamed:@"crouch"];
    _crouch.position = CGPointMake(self.size.width/2-90, 30);
    _crouch.zPosition = 10;
    _crouch.name = @"crouch";
    
    [self addChild:_right];
    [self addChild:_left];
    [self addChild:_jump];
    [self addChild:_crouch];
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    [self buttons];
    [self setup];
    [self makeEnemyShip];
    
    _ship = [[MainShip alloc] init];
    _ship.position = CGPointMake(CGRectGetMidX(self.frame),
                                CGRectGetMidY(self.frame)+100);
    _ship.zPosition = 10;
    [_playerStuff addChild:_ship];
    
}

-(void)makeEnemyShip{
    _count++;
    
    ArconShip *enemy = [[ArconShip alloc]init];
    enemy.position = CGPointMake(self.frame.size.width, CGRectGetMidY(self.frame)+200);
    [enemy moveShip:_ship.position];
    enemy.zPosition = 10;
    
    [_enemyShips addChild:enemy];
    
    NSLog(@"%i", _count);
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
            
        if([[self nodeAtPoint:location].name isEqualToString:@"jump"]){
            
            [_ship soldierJump];
        
        }else if([[self nodeAtPoint:location].name isEqualToString:@"right"] && _ship.position.x < 670){
            SKAction* moveShipByX = [SKAction moveByX:40 y:0 duration:.1];
            [_ship runAction:moveShipByX];
            [_ship soldierRunRight];
        }else if([[self nodeAtPoint:location].name isEqualToString:@"left"] && _ship.position.x > 380){
            SKAction *moveShipByX = [SKAction moveByX:-40 y:0 duration:.1];
            [_ship runAction:moveShipByX];
            [_ship soldierRunLeft];
        }else if([[self nodeAtPoint:location].name isEqualToString:@"right"] && _ship.position.x > 670 && _ground.position.x > 200){
            [_ship soldierRunRight];
            [self moveGame:-20 :-10 :-30];
        }else if([[self nodeAtPoint:location].name isEqualToString:@"left"] && _ship.position.x < 380 && _ground.position.x < 800){
            
            [_ship soldierRunLeft];
            [self moveGame:20 :10 :30];
        } else {
            [_ship shoot:location];
        }
    }
}
-(void)moveGame:(int)groundX :(int)backX :(int)enemyX{
    SKAction* moveGroundByX = [SKAction moveByX:groundX y:0 duration:.1];
    SKAction* moveBackgroundByX = [SKAction moveByX:backX y:0 duration:.1];
    SKAction* EnemyShipmoveX = [SKAction moveByX:enemyX y:0 duration:.1];
    [_enemyShips runAction:EnemyShipmoveX];
    [_background runAction:moveBackgroundByX];
    [_ground runAction:moveGroundByX];
}

-(void)didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody* node;
    
    contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask ? (node = contact.bodyA) : (node = contact.bodyB);
    
    if(node.categoryBitMask == sharedDelegate.laserBeamCategory){
        
        [self makeExplosionsAtNode:node];
        ArconShip *shipHit = (ArconShip*)contact.bodyB.node;
        [shipHit takeDamage] == 0 ? [self makeEnemyShip] : nil;
        
    }else if(contact.bodyA.categoryBitMask == sharedDelegate.enemyAmmoCategory || contact.bodyB.categoryBitMask == sharedDelegate.enemyAmmoCategory){
        
        [self makeExplosionsAtNode:contact.bodyA];
        
    }
}



#pragma Extras + Setup at bottom
-(void)makeExplosionsAtNode:(SKPhysicsBody*)node{
    

    
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:@"MyParticle" ofType:@"sks"]];
    explosion.zPosition = 5;
    
    if(node.categoryBitMask == sharedDelegate.enemyAmmoCategory){
        explosion.position = _ship.position;
    }else{
        explosion.position = node.node.position;
    }
    
    [self addChild:explosion];
    [explosion runAction:[SKAction sequence:@[[SKAction fadeAlphaTo:0.5 duration:1],
                                              [SKAction removeFromParent]]]];
    [node.node removeFromParent];
}

-(void)setup{
    sharedDelegate = [[UIApplication sharedApplication] delegate];
    
    _enemyShips = [SKNode node];
    _enemyShips.zPosition = 10;
    [self addChild:_enemyShips];
    
    _playerStuff = [SKNode node];
    _playerStuff.zPosition = 10;
    [self addChild:_playerStuff];
    
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0, -3);
    
    _fire = [SKSpriteNode spriteNodeWithImageNamed:@"fireButton"];
    _fire.position = CGPointMake(self.size.width/2+150, 50);
    _fire.name = @"fire";
    _fire.zPosition = 10;
    
    _background = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
    _background.size = CGSizeMake(self.size.width, self.size.height);
    _background.position = CGPointMake(400, self.size.height/2);
    _background.zPosition = 0;
    
    _ground = [SKSpriteNode spriteNodeWithImageNamed:@"floor"];
    _ground.size = CGSizeMake(_ground.size.width, 350);
    _ground.position = CGPointMake(400, 0);
    
    _ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.frame.size.width, 300)];
    _ground.physicsBody.dynamic = false;
    _ground.physicsBody.categoryBitMask = sharedDelegate.groundCategory;
    _ground.zPosition = 1;
    
    [self addChild:_background];
    [self addChild:_fire];
    [self addChild:_ground];
    
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
