//
//  RWHeart.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/24/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWHeart.h"

@implementation RWHeart
//----------------------------------------------------------------------
-(instancetype)init {
    
    if ( self = [super init] ){
        
        self = [ RWHeart spriteNodeWithImageNamed: @"heart" ];
        [ self setScale: 0.00 ];
        self.zPosition = 28.0;
        
        self.name = @"[Heart]";
    }
    
    return self;
}
//----------------------------------------------------------------------
-(void)animateHeart {
    
    SKAction *heartAction = [ SKAction sequence: @[
                                                   [SKAction scaleTo: 0.08 duration: 0.2],
                                                   [SKAction scaleTo: 0.05 duration: 0.3],
                                                   [SKAction scaleTo: 0.3 duration: 6.0],
                                                   ]];
    
    SKAction *verticalAction = [ SKAction moveBy: CGVectorMake(0.0, 200.0) duration: 5.0 ];
    
    SKAction *delayBeforeAction = [ SKAction waitForDuration: 2.0 ];
    SKAction *fadeOut = [ SKAction sequence: @[
                                               [SKAction waitForDuration: 1.0 ],
                                               [SKAction fadeAlphaTo: 0.0 duration: 2.0]
                                               ]];
    
    [ self runAction: delayBeforeAction
          completion:^{
              [ self runAction: fadeOut ];
              [ self runAction: verticalAction ];
              [ self runAction: heartAction
                    completion:^{
                        [ self removeAllActions ];
                        [ self removeFromParent ];
                    }];
    }];
    
}
//----------------------------------------------------------------------
@end
