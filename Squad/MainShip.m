//
//  MainShip.m
//  Squad
//
//  Created by Travis Delly on 9/24/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "MainShip.h"
#import "AppDelegate.h"
#import "NormalAttack.h"
#import <math.h>

@implementation MainShip{
    AppDelegate *sharedDelegate;
    SKTexture *skin;
    
}


-(id)init{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"SoldierStand"]];
    if(self) {
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        skin = [SKTexture textureWithImageNamed:@"SoldierStand"];
        _HandSide = 0;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
        self.physicsBody.categoryBitMask = sharedDelegate.spaceShipCategory;
        self.physicsBody.collisionBitMask = sharedDelegate.groundCategory;
        self.physicsBody.dynamic = true;
        self.zPosition = 10;
        
        
    }
    return self;
}

-(void)soldierRunRight{
    SKTexture *run1 = [SKTexture textureWithImageNamed:@"SoldierWalkRight1"];
    SKTexture *run2 = [SKTexture textureWithImageNamed:@"SoldierWalkRight2"];
    SKTexture *run3 = [SKTexture textureWithImageNamed:@"SoldierStandRight2"];
    
    _HandSide = 0;
    
    SKAction *finalAction = [SKAction animateWithTextures:@[run1, run2, run3] timePerFrame:.12];
    [self runAction:finalAction];
    
}
-(void)soldierRunLeft{
    SKTexture *run1 = [SKTexture textureWithImageNamed:@"SoldierWalkLeft1"];
    SKTexture *run2 = [SKTexture textureWithImageNamed:@"SoldierWalkLeft2"];
    SKTexture *run3 = [SKTexture textureWithImageNamed:@"SoldierStandLeft2"];
    
    _HandSide = 1;
    
    SKAction *finalAction = [SKAction animateWithTextures:@[run1, run2, run3] timePerFrame:.12];
    [self runAction:finalAction];
    
}
-(void)soldierJump{
    SKAction *jump = [SKAction moveTo:CGPointMake(self.position.x + 20, self.position.y+100) duration:.2];
    SKAction *sequence;
    
    if(_HandSide == 0){
        SKTexture *jump1 = [SKTexture textureWithImageNamed:@"SoldierJumpRight1"];
        SKTexture *jump2 = [SKTexture textureWithImageNamed:@"SoldierJumpRight2"];
        SKTexture *jump3 = [SKTexture textureWithImageNamed:@"SoldierJumpRight3"];
        SKTexture *stand = [SKTexture textureWithImageNamed:@"SoldierStand"];
        sequence = [SKAction animateWithTextures:@[jump1, jump2, jump3, stand] timePerFrame:.2];
    }else if(_HandSide == 1){
        SKTexture *jump1 = [SKTexture textureWithImageNamed:@"SoldierJumpLeft1"];
        SKTexture *jump2 = [SKTexture textureWithImageNamed:@"SoldierJumpLeft2"];
        SKTexture *jump3 = [SKTexture textureWithImageNamed:@"SoldierJumpLeft3"];
        SKTexture *stand = [SKTexture textureWithImageNamed:@"SoldierStand"];
        sequence = [SKAction animateWithTextures:@[jump1, jump2, jump3, stand] timePerFrame:.2];
    }
    
    [self runAction:sequence];
    [self runAction:jump];
}
-(void)soldierFire:(double)degrees{
    NSLog(@"%d", _HandSide);
    SKAction *sequence;
    
    NSLog(@"%f", degrees);
    
    if(degrees > 75 && degrees < 105 ){
        
        if(_HandSide == 0){
            
            SKTexture *fire1 = [SKTexture textureWithImageNamed:@"GunFireRightStraightUp1"];
            SKTexture *fire2 = [SKTexture textureWithImageNamed:@"GunFireRightStraightUp2"];
            SKTexture *fire3 = [SKTexture textureWithImageNamed:@"GunFireRight3"];
            
            
            sequence = [SKAction animateWithTextures:@[fire1, fire2, fire3] timePerFrame:.2];
            
            
        }else{
            SKTexture *fire1 = [SKTexture textureWithImageNamed:@"GunFireLeftStraightUp1"];
            SKTexture *fire2 = [SKTexture textureWithImageNamed:@"GunFireLeftStraightUp2"];
            SKTexture *fire3 = [SKTexture textureWithImageNamed:@"GunFireLeft3"];
            
            
            sequence = [SKAction animateWithTextures:@[fire1, fire2, fire3] timePerFrame:.2];
            
        }
        
    }else if(degrees > 35 && degrees < 75) {
        
        SKTexture *fire1 = [SKTexture textureWithImageNamed:@"GunFireRightUp1"];
        SKTexture *fire2 = [SKTexture textureWithImageNamed:@"GunFireRightUp2"];
        SKTexture *fire3 = [SKTexture textureWithImageNamed:@"GunFireRight3"];
        
        
        sequence = [SKAction animateWithTextures:@[fire1, fire2, fire3] timePerFrame:.2];
        
        
    }else if(degrees > 105 && degrees < 145) {
        
        SKTexture *fire1 = [SKTexture textureWithImageNamed:@"GunFireLeftUp1"];
        SKTexture *fire2 = [SKTexture textureWithImageNamed:@"GunFireLeftUp2"];
        SKTexture *fire3 = [SKTexture textureWithImageNamed:@"GunFireLeft3"];
        
        
        sequence = [SKAction animateWithTextures:@[fire1, fire2, fire3] timePerFrame:.2];
        
    }else{
        if(_HandSide == 0){
            SKTexture *fire1 = [SKTexture textureWithImageNamed:@"GunFireRight"];
            SKTexture *fire2 = [SKTexture textureWithImageNamed:@"GunFireRight2"];
            SKTexture *fire3 = [SKTexture textureWithImageNamed:@"GunFireRight3"];
            sequence = [SKAction animateWithTextures:@[fire1, fire2, fire3] timePerFrame:.1];
        }else if(_HandSide == 1){
            SKTexture *fire1 = [SKTexture textureWithImageNamed:@"GunFireLeft"];
            SKTexture *fire2 = [SKTexture textureWithImageNamed:@"GunFireLeft2"];
            SKTexture *fire3 = [SKTexture textureWithImageNamed:@"GunFireLeft3"];
            sequence = [SKAction animateWithTextures:@[fire1, fire2, fire3] timePerFrame:.1];
        }
    }
    
    
    [self runAction:sequence];
}
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

-(void)shoot:(CGPoint)touchPoint{
    
    NormalAttack *attack = [[NormalAttack alloc] initWithPosition:self.position];
    
    NSLog(@"%f", attack.zRotation);
    
    
    double finalX = touchPoint.x - self.position.x;
    double finalY = touchPoint.y - self.position.y;
    
    float angle = (float) atan2(touchPoint.y - self.position.y, touchPoint.x - self.position.x);

  
    if(touchPoint.x < self.position.x){
        _HandSide = 1;
        skin = [SKTexture textureWithImageNamed:@"SoldierStandLeft2"];
        self.texture = skin;
    } else if(touchPoint.x > self.position.x){
        _HandSide = 0;
        skin = [SKTexture textureWithImageNamed:@"SoldierStandRight2"];
        self.texture = skin;
    }
    
    
    if(touchPoint.x > self.position.x){
        CGVector vector = CGVectorMake(finalX, finalY);
        [attack shoot:angle location:vector];
        
    }else{
        CGVector vector = CGVectorMake(finalX-60, finalY);
        [attack shoot:angle location:vector];
        
    }
    [self.parent addChild:attack];
    
    [self soldierFire:radiansToDegrees(angle)];
}

@end
