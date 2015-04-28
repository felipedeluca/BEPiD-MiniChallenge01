//
//  RWPoow.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/24/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "RWPoow.h"

@implementation RWPoow
//--------------------------------------------------------------------------------
-(instancetype)init{
    
    if ( self = [super init]){
        
        self = [ RWPoow spriteNodeWithImageNamed: @"poow" ];
        
        [ self setScale: 0.3 ];
        self.zPosition = 28.0;        
        self.name = @"[Poow!]";
        
    }
    
    return self;
}
//--------------------------------------------------------------------------------
-(void)animatePoow {

    SKAction *poowAnimation = [SKAction sequence:@[
                                                   [SKAction waitForDuration:0.0],
                                                   [SKAction scaleBy: 0.7 duration: 0.1],
                                                   [SKAction scaleBy: 0.7 duration: 0.05],
                                                  // [SKAction waitForDuration: 0.02],
                                                   [SKAction fadeAlphaTo: 0.0 duration: 0.05],
                                                   ]];
    
    [ self runAction: poowAnimation
          completion:^{
              [ self removeFromParent ];
          }];
    
}
//--------------------------------------------------------------------------------
@end
