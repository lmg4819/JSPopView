
//
//  JSTableViewPopView.m
//  JSPopView_Example
//
//  Created by 罗孟歌 on 2019/12/2.
//  Copyright © 2019 lmg4819. All rights reserved.
//

#import "JSTableViewPopView.h"

@interface JSTableViewPopView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation JSTableViewPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}


- (void)setDataList:(NSArray *)dataList
{
    _dataList = dataList;
    self.tableView.frame = CGRectMake(0, 0, 300, 80*3);
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    cell.textLabel.text = self.dataList[indexPath.row];
    return cell;
}


#pragma mark - Set,Get
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 300, 240)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
