//
//  Random.h
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/15/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Random : NSObject

-(CGFloat) floatRand:(CGFloat)low high:(CGFloat)high;
-(int) intRand:(int)low high:(int)high;

@end
