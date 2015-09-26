//
//  ArconShip.m
//  Squad
//
//  Created by Travis Delly on 9/24/15.
//  Copyright © 2015 Travis Delly. All rights reserved.
//

#import "ArconShip.h"
#import "AppDelegate.h"
#import "EnemyNormalAttack.h"


@implementation ArconShip{
    AppDelegate *sharedDelegate;
}


-(id)init{
    self = [super init];
    if(self) {
        sharedDelegate = [[UIApplication sharedApplication] delegate];
        
        _health = 3;
        
        self.size = CGSizeMake(100, 100);
        self.texture = [SKTexture textureWithImageNamed:@"Spaceship"];
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height/2];
        self.physicsBody.categoryBitMask = sharedDelegate.enemyShipCategory;
        [self runAction:[SKAction rotateByAngle:M_PI duration:0]];
        self.physicsBody.dynamic = false;
    }
    return self;
}

-(int)takeDamage{
    if(_health == 0){
        [self removeFromParent];
        return 0;
    } else {
        _health--;
        return 1;
    }
}

-(void)moveShip:(CGPoint)targetedUserLocation{
    SKAction* move1 = [SKAction moveTo:CGPointMake(targetedUserLocation.x+50, self.position.y+40) duration:2];
    SKAction* move2 = [SKAction moveTo:CGPointMake(targetedUserLocation.x-40, self.position.y) duration:2];
    SKAction* move3 = [SKAction moveTo:CGPointMake(targetedUserLocation.x+10, self.position.y-40) duration:2];
    SKAction* move4 = [SKAction moveTo:CGPointMake(targetedUserLocation.x-10, self.position.y-20) duration:2];
    SKAction* move5 = [SKAction moveTo:CGPointMake(targetedUserLocation.x+10, self.position.y+20) duration:2];
    SKAction* shoot = [SKAction runBlock:^{
        
        EnemyNormalAttack *laserBeam = [[EnemyNormalAttack alloc] initWithPositionAndRotation:self.position with:1.5];
        
        
        [self.parent addChild:laserBeam];
    }];
    
    NSLog(@"%f", self.position.x);
    
    SKAction* sequenceMoves =[SKAction sequence:@[move1, shoot, shoot, shoot, shoot, move2, shoot, move3, shoot, shoot, move4, shoot, shoot, move5]];
    SKAction* enemyShipMovement = [SKAction repeatActionForever:sequenceMoves];
    
    [self runAction:enemyShipMovement];
}



@end
