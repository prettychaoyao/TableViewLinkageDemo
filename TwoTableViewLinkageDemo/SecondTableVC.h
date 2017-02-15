//
//  SecondTableVC.h
//  TwoTableViewLinkageDemo
//
//  Created by chaoyao on 2017/2/15.
//  Copyright © 2017年 OneStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SecondTableVCDelegate <NSObject>

- (void)willDispalyHeaderViewForSection:(NSInteger)section;
- (void)didEndDisplayingHeaderViewForSection:(NSInteger)section;

@end

@interface SecondTableVC : UIViewController

@property (nonatomic, weak) id<SecondTableVCDelegate> secondTableDelegate;

@property (nonatomic, strong) NSArray *sectionTitleArr;

- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath;

@end
