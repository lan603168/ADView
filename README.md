# IOS ADView
####Automatic cycle display advertising images
![sample](https://github.com/lan603168/ADView/blob/master/ads.gif)

##Usage

import `"LXReUseScrollView.h"`  
See the code snippet below for an example of how to use adview
```objective-c
_adView = [[LXReUseScrollView alloc] initWithFrame:CGRectMake(0, 40, self.view.frameWith, 150) Isinfiniteloop:YES];
    [self.view addSubview:_adView];
    _adView.delegate = self;
    _adView.autoScroll = YES;
    _adView.showPageControl = YES;
    [_adView reloadData];
```
Simply set the delegate (which must conform to LXReUseScrollViewDelegate) and implement the 2 required delegate methods.The respond to the required delegate methods:
```objective-c
//return the item sum
-(NSInteger)numberOfItemsInReUseScrollView:(LXReUseScrollView *)reUseScrollView
{
     return _imagearray.count;
}

//display item
-(void)displayItemAtReUseScrollView:(LXReUseScrollView *)reUseScrollView ItemImage:(UIImageView*)itemImageView withIndexPath:(NSInteger)index
{
    itemImageView.image = [UIImage imageNamed:[_imagearray objectAtIndex:index]];
}
```
   
   
Example delegate method for didSelected item:
```objective-c
-(void)didSelectItemAtReUseScrollView:(LXReUseScrollView *)reUseScrollView IndexPath:(NSInteger)index
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tips" message:[NSString stringWithFormat:@"selected index:%ld",(long)index] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
```

##License
Copyright 2015 Lanx.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
