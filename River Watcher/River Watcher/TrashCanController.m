//
//  TrashCanController.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/13/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "TrashCanController.h"
#import "RWTrashCan.h"

@interface TrashCanController()

@end

@implementation TrashCanController
//--------------------------------------------------------------------------------
-(void)newTrashCan:(SKScene *)scene {
    
    self.trashCan = [ [RWTrashCan alloc] init ];
    [ scene addChild: self.trashCan.img ];
}
//--------------------------------------------------------------------------------
@end
