//
//  LXViewController.m
//  ReUseAdView
//
//  Created by lanzx on 15/12/10.
//  Copyright (c) 2015年 lan. All rights reserved.
//

#import "LXViewController.h"
#import "LXReUseScrollView.h"
#import "UIView+frame.h"

@interface LXViewController ()<LXReUseScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray      *imagearray;

@end

@implementation LXViewController
{
    LXReUseScrollView     *_adView;
}

-(id)init
{
    self = [super init];
    if(self){
        _imagearray = [NSMutableArray array];
        [_imagearray addObjectsFromArray:[NSArray arrayWithObjects:@"bangongshi.png",@"bolise.png",@"xiyang.png",@"yuqi.png", nil]];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor grayColor];
    _adView = [[LXReUseScrollView alloc] initWithFrame:CGRectMake(0, 40, self.view.frameWith, 150) Isinfiniteloop:YES];
    [self.view addSubview:_adView];
    _adView.delegate = self;
    _adView.autoScroll = YES;
    _adView.showPageControl = YES;
    [_adView reloadData];
    
    UIButton *_reloadbt = [UIButton buttonWithType:UIButtonTypeCustom];
    _reloadbt.frame = CGRectMake(10, 200, 80, 45);
    [_reloadbt setTitle:@"Reload" forState:UIControlStateNormal];
    [_reloadbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_reloadbt setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    _reloadbt.titleLabel.font = [UIFont systemFontOfSize:16];
    _reloadbt.backgroundColor = [UIColor darkGrayColor];
    [_reloadbt addTarget:self action:@selector(AdReload) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_reloadbt];
    
    UIButton *_autoScrollbt = [UIButton buttonWithType:UIButtonTypeCustom];
    _autoScrollbt.frame = CGRectMake(100, 200, 100, 45);
    [_autoScrollbt setTitle:@"ManualScroll" forState:UIControlStateNormal];
    [_autoScrollbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_autoScrollbt setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    _autoScrollbt.titleLabel.font = [UIFont systemFontOfSize:16];
    _autoScrollbt.backgroundColor = [UIColor darkGrayColor];
    [_autoScrollbt addTarget:self action:@selector(AutoScroll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_autoScrollbt];
    
    UIButton *_OnetimeIntervalbt = [UIButton buttonWithType:UIButtonTypeCustom];
    _OnetimeIntervalbt.frame = CGRectMake(10, 250, 120, 45);
    [_OnetimeIntervalbt setTitle:@"TimeInterval:1s" forState:UIControlStateNormal];
    [_OnetimeIntervalbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_OnetimeIntervalbt setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    _OnetimeIntervalbt.titleLabel.font = [UIFont systemFontOfSize:16];
    _OnetimeIntervalbt.backgroundColor = [UIColor darkGrayColor];
    [_OnetimeIntervalbt addTarget:self action:@selector(TimeIntervalOne) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_OnetimeIntervalbt];
    
    UIButton *_FivetimeIntervalbt = [UIButton buttonWithType:UIButtonTypeCustom];
    _FivetimeIntervalbt.frame = CGRectMake(150, 250, 120, 45);
    [_FivetimeIntervalbt setTitle:@"TimeInterval:5s" forState:UIControlStateNormal];
    [_FivetimeIntervalbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_FivetimeIntervalbt setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    _FivetimeIntervalbt.titleLabel.font = [UIFont systemFontOfSize:16];
    _FivetimeIntervalbt.backgroundColor = [UIColor darkGrayColor];
    [_FivetimeIntervalbt addTarget:self action:@selector(TimeIntervalFive) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_FivetimeIntervalbt];
    
}

-(void)AdReload
{
    [_imagearray addObject:@"cizhuan.png"];
    [_imagearray addObject:@"wenli.png"];
    [_adView reloadData];
}

-(void)AutoScroll:(id)sender
{
    UIButton *bt = sender;
    if(_adView.autoScroll){
        [bt setTitle:@"AutoScroll" forState:UIControlStateNormal];
    }else{
        [bt setTitle:@"ManualScroll" forState:UIControlStateNormal];
    }
    _adView.autoScroll = !_adView.autoScroll;
}

-(void)TimeIntervalOne
{
    _adView.timeInterval = 1;
}

-(void)TimeIntervalFive
{
    _adView.timeInterval = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - LXReUseScrolllView delegate init
-(NSInteger)numberOfItemsInReUseScrollView:(LXReUseScrollView *)reUseScrollView
{
    return _imagearray.count;
}

-(void)displayItemAtReUseScrollView:(LXReUseScrollView *)reUseScrollView ItemImage:(UIImageView*)itemImageView withIndexPath:(NSInteger)index
{
    itemImageView.image = [UIImage imageNamed:[_imagearray objectAtIndex:index]];
}

-(void)didSelectItemAtReUseScrollView:(LXReUseScrollView *)reUseScrollView IndexPath:(NSInteger)index
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tips" message:[NSString stringWithFormat:@"selected index:%ld",(long)index] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
