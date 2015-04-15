//
//  Random.m
//  River Watcher
//
//  Created by Felipe R. de Luca on 4/15/15.
//  Copyright (c) 2015 Bearded Men and The Lady. All rights reserved.
//

#import "Random.h"

@implementation Random

//------------------------------------------------------------------
-(CGFloat) skRand:(CGFloat)low high:(CGFloat)high{
    return ( (rand() / ( CGFloat ) RAND_MAX) * ( high - low ) ) + low;
}
//------------------------------------------------------------------
@end
