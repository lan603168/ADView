//
//  UIView+frame.h
//  SeeKCelebrity
//
//  Created by lanzx on 15/5/27.
//  Copyright (c) 2015年 GZSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)
-(CGFloat)frameWith;

-(CGFloat)frameHeight;

-(CGFloat)frameX;

-(CGFloat)frameY;



-(CGFloat)boundsWith;

-(CGFloat)boundsHeight;

-(CGFloat)boundsX;

-(CGFloat)boundsY;

-(int)getRandomNumber:(int)from to:(int)to;
@end
