//
//  TrashCanController.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/13/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "RWTrashCan.h"

@interface TrashCanController : NSObject

@property ( nonatomic, strong ) RWTrashCan * trashCan;

-(void)newTrashCan:(SKScene *)scene;

@end
