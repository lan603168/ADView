//
//  LXReUseScrollView.h
//  ReUseAdView
//
//  Created by lanzx on 15/12/10.
//  Copyright (c) 2015年 lan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXReUseScrollView;
@protocol LXReUseScrollViewDelegate <NSObject>

@required
/**
 *  @brief  返回item总数
 *
 *  @return
 */
-(NSInteger)numberOfItemsInReUseScrollView:(LXReUseScrollView *)reUseScrollView;

/**
 *  @brief  设置当前位置需要显示的图片
 *
 *  @param itemImageView
 */
-(void)displayItemAtReUseScrollView:(LXReUseScrollView *)reUseScrollView ItemImage:(UIImageView*)itemImageView withIndexPath:(NSInteger)index;

@optional

/**
 *  @brief  返回被选中的item位置
 *
 *  @param index
 */
-(void)didSelectItemAtReUseScrollView:(LXReUseScrollView *)reUseScrollView IndexPath:(NSInteger)index;

@end


@interface LXReUseScrollView : UIView
@property(nonatomic,assign)id<LXReUseScrollViewDelegate> delegate;

@property(nonatomic,assign,setter=showPageControl:)BOOL             showPageControl;
@property(nonatomic,assign,setter=setAutoScroll:)BOOL               autoScroll;
@property(nonatomic,assign,setter=SetAutoScrollTimeInterval:)int    timeInterval;

-(id)initWithFrame:(CGRect)frame Isinfiniteloop:(BOOL)isloop;

-(void)SetPageIndicatorTintColor:(UIColor*)tintColor;
-(void)SetCurrentPageIndicatorTintColor:(UIColor *)currentColor;
-(void)setImageBackGroundColor:(UIColor*)color;
-(void)reloadData;

-(void)stopTimer;


@end
