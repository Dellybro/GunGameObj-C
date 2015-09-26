//
//  EnemyNormalAttack.m
//  Squad
//
//  Created by Travis Delly on 9/24/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "EnemyNormalAttack.h"
#import "AppDelegate.h"

@implementation EnemyNormalAttack{
    AppDelegate *sharedDelegate;
}

-(id)initWithPositionAndRotation:(CGPoint)position with:(double)rotation{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"LaserBeam"]];
    if(self) {
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        self.position = position;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = true;
        self.physicsBody.categoryBitMask = sharedDelegate.enemyAmmoCategory;
        self.physicsBody.contactTestBitMask = sharedDelegate.spaceShipCategory;
        self.physicsBody.collisionBitMask = 0;
        
        [self shoot:rotation];
    }
    return self;
}

-(void)shoot:(double)rotation{
    
    [self runAction:[SKAction rotateToAngle:M_PI*rotation duration:0]];
    [self runAction:[SKAction moveToY:-1000 duration:1.5]];
    [self runAction:[SKAction sequence:@[[SKAction fadeAlphaTo:0.5 duration:1.5],
                                         [SKAction removeFromParent]]]];
}

@end
