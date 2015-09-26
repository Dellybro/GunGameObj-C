//
//  NormalAttack.m
//  Squad
//
//  Created by Travis Delly on 9/24/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "NormalAttack.h"
#import "AppDelegate.h"


@implementation NormalAttack{
    AppDelegate *sharedDelegate;
}

-(id)initWithPosition:(CGPoint)position{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"LaserBeam"]];
    if(self) {
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        self.position = CGPointMake(position.x, position.y+35);
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = true;
        self.physicsBody.categoryBitMask = sharedDelegate.laserBeamCategory;
        self.physicsBody.contactTestBitMask = sharedDelegate.enemyShipCategory;
        self.physicsBody.collisionBitMask = 0;
        self.name = @"normalAttck";
    }
    return self;
}

-(void)shoot:(double)rotation location:(CGVector)vector{
    

    
    
    [self runAction:[SKAction applyForce:vector duration:2]];
    [self runAction:[SKAction rotateToAngle:rotation duration:0]];
    [self runAction:[SKAction sequence:@[[SKAction fadeAlphaTo:0.5 duration:1.5],
                                              [SKAction removeFromParent]]]];
}

@end
