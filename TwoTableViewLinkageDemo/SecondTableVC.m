//
//  SecondTableVC.m
//  TwoTableViewLinkageDemo
//
//  Created by chaoyao on 2017/2/15.
//  Copyright © 2017年 OneStore. All rights reserved.
//

#import "SecondTableVC.h"

@interface SecondTableVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *detailTableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, assign) BOOL isScrollUp;
@property (atomic, assign) CGFloat lastOffsetY;

@end

@implementation SecondTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isScrollUp = NO;
    self.lastOffsetY = 0;
    
    self.dataArr = @[@"鞋子",@"衣服",@"化妆品",@"饮用水",@"副食品",@"小吃",@"鞋子",@"衣服",@"化妆品",@"饮用水"];
    [self createTableView];
}

- (void)createTableView {
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.3, 64, self.view.bounds.size.width * 0.7 , self.view.bounds.size.height - 64)];
    self.detailTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    self.detailTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.detailTableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sectionTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.sectionTitleArr[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"cellIdentity";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if ([self.secondTableDelegate respondsToSelector:@selector(willDispalyHeaderViewForSection:)] && !self.isScrollUp) {
        [self.secondTableDelegate willDispalyHeaderViewForSection:section];
    }
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if ([self.secondTableDelegate respondsToSelector:@selector(didEndDisplayingHeaderViewForSection:)] && self.isScrollUp) {
        [self.secondTableDelegate didEndDisplayingHeaderViewForSection:section];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.isScrollUp = self.lastOffsetY < scrollView.contentOffset.y;
    self.lastOffsetY = scrollView.contentOffset.y;
}

#pragma mark - common methods

- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath {
    
    [self.detailTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row]
                                      animated:YES scrollPosition:UITableViewScrollPositionTop];
}

@end
