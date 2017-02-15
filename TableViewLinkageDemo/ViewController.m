//
//  ViewController.m
//  TableViewLinkageDemo
//
//  Created by chaoyao on 2017/2/15.
//  Copyright © 2017年 OneStore. All rights reserved.
//

#import "ViewController.h"
#import "SecondTableVC.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, SecondTableVCDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) SecondTableVC *secondVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.title = @"tableView联动Demo";
    [self configData];
    [self createTableView];
    [self createSecondTableVC];
}

- (void)configData {
    
    self.dataArr = @[].mutableCopy;
    for (int i=0; i < arc4random()%10 + 18; i++) {
        NSString *titleAtr = [NSString stringWithFormat:@"第%d栏", i];
        [self.dataArr addObject:titleAtr];
    }
}

- (void)createTableView {
    
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width * 0.3, self.view.bounds.size.height)
                                                      style:UITableViewStylePlain];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.leftTableView];
}

- (void)createSecondTableVC {
    
    self.secondVC = [[SecondTableVC alloc] init];
    self.secondVC.secondTableDelegate = self;
    self.secondVC.sectionTitleArr = self.dataArr.copy;
    [self addChildViewController:self.secondVC];
    [self.view addSubview:self.secondVC.view];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.secondVC scrollToSelectedIndexPath:indexPath];
}

#pragma mark - SecondTableVCDelegate

- (void)willDispalyHeaderViewForSection:(NSInteger)section {
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)didEndDisplayingHeaderViewForSection:(NSInteger)section {
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section + 1 inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionMiddle];
}


@end
