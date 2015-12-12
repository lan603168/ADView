//
//  UIView+frame.m
//  SeeKCelebrity
//
//  Created by lanzx on 15/5/27.
//  Copyright (c) 2015年 GZSC. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)

-(CGFloat)frameWith
{
    return self.frame.size.width;
}

-(CGFloat)frameHeight
{
    return self.frame.size.height;
}

-(CGFloat)frameX
{
    return self.frame.origin.x;
}

-(CGFloat)frameY
{
    return self.frame.origin.y;
}

-(CGFloat)boundsWith
{
    return self.bounds.size.width;
}

-(CGFloat)boundsHeight
{
    return self.bounds.size.height;
}

-(CGFloat)boundsX
{
    return self.bounds.origin.x;
}

-(CGFloat)boundsY
{
    return self.bounds.origin.y;
}

-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1))); //+1,result is [from to]; else is [from, to)!!!!!!!
}
@end
