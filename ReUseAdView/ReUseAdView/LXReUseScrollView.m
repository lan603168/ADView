//
//  LXReUseScrollView.m
//  ReUseAdView
//
//  Created by lanzx on 15/12/10.
//  Copyright (c) 2015年 lan. All rights reserved.
//

#import "LXReUseScrollView.h"


@interface LXReuseViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView          *imageview;

@end

@implementation LXReuseViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        _imageview = [[UIImageView alloc] init];
        _imageview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _imageview.contentMode = UIViewContentModeScaleToFill;
        
        [self addSubview:_imageview];
    }
    return self;
}

@end




@interface LXReUseScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation LXReUseScrollView

{
    UICollectionView        *_CollentView;
    NSInteger               _TotalPages;
    BOOL                    _isloop;
    UIPageControl           *_pageControl;
    NSTimer                 *_autoScrollTimer;
}

-(id)initWithFrame:(CGRect)frame Isinfiniteloop:(BOOL)isloop
{
    self = [super initWithFrame:frame];
    if(self){
        _isloop = isloop;
        _autoScroll = NO;
        [self CreateSubView];
    }
    return self;
}

-(void)dealloc
{
    _delegate = nil;
    _CollentView.delegate = nil;
    _CollentView.dataSource = nil;
    _CollentView  = nil;
    _pageControl = nil;
    NSLog(@"ReUseScrollView销毁了");
}

-(void)CreateSubView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];//设置滚动方向
    
    _CollentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    _CollentView.delegate = self;
    _CollentView.dataSource = self;
    _CollentView.showsHorizontalScrollIndicator = NO;
    _CollentView.showsVerticalScrollIndicator = NO;
    _CollentView.pagingEnabled = YES;
    _CollentView.backgroundColor = [UIColor lightGrayColor];
    
    
    [self addSubview:_CollentView];
    //注册cell
    [_CollentView registerClass:[LXReuseViewCell class] forCellWithReuseIdentifier:@"LXReuseViewCell"];
    
    // UIPageControl
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.userInteractionEnabled = YES;
    _pageControl.numberOfPages = 0;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [_pageControl setCenter: CGPointMake(self.center.x, self.bounds.size.height*0.9)];
    //滑动点大小
    [self addSubview:_pageControl];
    
}


#pragma mark - UICollectionView代理实现
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(_delegate && [_delegate respondsToSelector:@selector(numberOfItemsInReUseScrollView:)]){
        _TotalPages = [_delegate numberOfItemsInReUseScrollView:self];
        _pageControl.numberOfPages = _TotalPages;
        _pageControl.currentPage = 0;
        if(_isloop && 2 <= _TotalPages){
            _TotalPages = _TotalPages +2;
        }
        
        if(_TotalPages < 0 ) _TotalPages = 0;
        
        return _TotalPages;
    }else{
        return 0;
    }
    
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LXReuseViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXReuseViewCell" forIndexPath:indexPath];
    cell.imageview.image = nil;
    if(_delegate && [_delegate respondsToSelector:@selector(displayItemAtReUseScrollView:ItemImage:withIndexPath:)]){
        NSInteger index = indexPath.row;
        if(_isloop && 2 <= _TotalPages){
            NSInteger last = _TotalPages - 1;
            if(0 == index){
                index = last-2;
            }else if(last == index){
                index = 0;
            }else{
                index = index - 1;
            }
        }
        [_delegate displayItemAtReUseScrollView:self ItemImage:cell.imageview withIndexPath:index];
    }else{
        cell.imageview.backgroundColor = [UIColor greenColor];
    }
    
    return cell;
}

-(void)DipatchOnceScroll
{
    if(_CollentView == nil) return;
    if(_isloop && 2 <= _TotalPages){
        [_CollentView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

//停止滚动的时候,设置点的位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(_CollentView == nil) return;
    NSIndexPath *indexPath = [_CollentView indexPathForItemAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
    NSInteger index = indexPath.row;
    if(_isloop && 2 <= _TotalPages){
        NSInteger last = _TotalPages - 1;
        if(0 == index){
            index = last-2;
            if(_CollentView == nil) return;
            [_CollentView scrollRectToVisible:CGRectMake(self.frame.size.width*(last-1), 0, self.frame.size.width, self.frame.size.height) animated:NO];
        }else if(last == index){
            index = 0;
            if(_CollentView == nil) return;
            [_CollentView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
        }else{
            index = index - 1;
        }
    }
    if(_pageControl == nil) return;
    _pageControl.currentPage = index;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_autoScrollTimer && _autoScrollTimer.isValid) {
        [_autoScrollTimer invalidate];
        _autoScrollTimer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    if(_autoScroll){
        if (!_autoScrollTimer || !_autoScrollTimer.isValid) {
            _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
        }
    }
    
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}
//定义每个UICollectionView cell左右之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//定义每个UICollectionView cell上下之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//定义整个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_delegate && [_delegate respondsToSelector:@selector(didSelectItemAtReUseScrollView:IndexPath:)]){
        NSInteger index = indexPath.row;
        if(_isloop && 2 <= _TotalPages){
            NSInteger last = _TotalPages - 1;
            if(0 == index){
                index = last-2;
            }else if(last == index){
                index = 0;
            }else{
                index = index - 1;
            }
        }
        [_delegate didSelectItemAtReUseScrollView:self IndexPath:index];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



#pragma mark - 对外方法
-(void)showPageControl:(BOOL)showPageControl
{
    _pageControl.hidden = !showPageControl;
}

-(void)SetPageIndicatorTintColor:(UIColor*)tintColor
{
    _pageControl.pageIndicatorTintColor = tintColor;
}

-(void)SetCurrentPageIndicatorTintColor:(UIColor *)currentColor
{
    _pageControl.currentPageIndicatorTintColor = currentColor;
}

-(void)setImageBackGroundColor:(UIColor*)color
{
    _CollentView.backgroundColor = color;
}

#pragma mark - auto scroll

- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    
    if (autoScroll) {
        if (!_autoScrollTimer || !_autoScrollTimer.isValid) {
            _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
        }
    } else {
        if (_autoScrollTimer && _autoScrollTimer.isValid) {
            [_autoScrollTimer invalidate];
            _autoScrollTimer = nil;
        }
    }
}

-(void)SetAutoScrollTimeInterval:(int)timeInterval
{
    if(_autoScroll && _TotalPages>1){
        if(_autoScrollTimer){
            [_autoScrollTimer invalidate];
            _autoScrollTimer = nil;
        }
        _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
    }
}


-(void)stopTimer
{
    _autoScroll = NO;
    if (_autoScrollTimer && _autoScrollTimer.isValid) {
        [_autoScrollTimer invalidate];
        _autoScrollTimer = nil;
    }
}

- (void)handleScrollTimer:(NSTimer *)timer
{
    if (_TotalPages == 0) {
        return;
    }
    
    if(_pageControl == nil) return;
    if(_CollentView == nil) return;
    NSInteger index = _pageControl.currentPage;
    
    [_CollentView scrollRectToVisible:CGRectMake(self.frame.size.width*(index+2), 0, self.frame.size.width, self.frame.size.height) animated:YES];
}


-(void)reloadData
{
    [_CollentView reloadData];
    [self performSelector:@selector(DipatchOnceScroll) withObject:nil afterDelay:0.2];
}

@end
