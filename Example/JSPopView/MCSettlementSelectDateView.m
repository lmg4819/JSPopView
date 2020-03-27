//
//  MCSettlementSelectDateView.m
//  JSPopView_Example
//
//  Created by 罗孟歌 on 2020/3/23.
//  Copyright © 2020 lmg4819. All rights reserved.
//

#import "MCSettlementSelectDateView.h"
#import "UIColor+MCExtension.h"
#import <Masonry/Masonry.h>
#import <FSCalendar/FSCalendar.h>
#import <FSCalendarExtensions.h>
#import <FSCalendarTransitionCoordinator.h>
#import "MCRangePickerCell.h"
#import "NSDate+MCExtension.h"


@interface MCSettlementSelectDateView ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>

@property(nonatomic,strong) UIView *headerView;
@property(nonatomic,strong) UIView *contentView;
@property(nonatomic,strong) UIView *bottomView;
@property(nonatomic,strong) UILabel *promptLabel;
@property(nonatomic,strong) UIButton *resetButton;
@property(nonatomic,strong) UIButton *sureButton;
@property(nonatomic,strong) UIView *lineView;

@property (strong, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

// The start date of the range
@property (strong, nonatomic) NSDate *date1;
// The end date of the range
@property (strong, nonatomic) NSDate *date2;
@property(nonatomic,strong) NSArray *selectDateTitles;
@property(nonatomic,strong) NSMutableDictionary *selectDateTitleTexts;


@end

@implementation MCSettlementSelectDateView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy-MM-dd";
        self.selectDateTitleTexts = [NSMutableDictionary dictionary];
        self.backgroundColor = [UIColor mcColorWithAlpha:0.4 hexString:@"#000000"];
        [self addSubview:self.headerView];
        [self addSubview:self.contentView];
        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.lineView];
        [self.bottomView addSubview:self.promptLabel];
        [self.bottomView addSubview:self.resetButton];
        [self.bottomView addSubview:self.sureButton];
        [self.contentView addSubview:self.calendar];
    
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(64);
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(115);
        }];
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.height.mas_equalTo(137);
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.bottomView);
            make.height.mas_equalTo(1);
        }];
        
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.headerView.mas_bottom);
            make.bottom.mas_equalTo(self.bottomView.mas_top);
        }];
        
        [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        
        [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bottomView.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.bottomView.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.bottomView.mas_top).mas_offset(15);
            make.height.mas_equalTo(40);
        }];
        
        CGFloat btnWidth = ([UIScreen mainScreen].bounds.size.width-30-10)/2.0;
        [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bottomView.mas_left).mas_offset(15);
            make.width.mas_equalTo(btnWidth);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.bottomView.mas_top).mas_offset(72);
        }];
        [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bottomView.mas_right).mas_offset(-15);
            make.width.mas_equalTo(btnWidth);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(self.bottomView.mas_top).mas_offset(72);
        }];
    }
    return self;
}


- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor mcColorWithHexString:@"#262626"];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.text = @"请选择配送日期 至少选择4天";
        [_headerView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(_headerView.mas_left);
            make.right.mas_equalTo(_headerView.mas_right);
            make.height.mas_equalTo(22);
        }];
        
        UILabel *detailLabel = [UILabel new];
        detailLabel.textColor = [UIColor mcColorWithHexString:@"#999999"];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.font = [UIFont systemFontOfSize:12];
        detailLabel.text = @"点击选择配送日期，再次点击取消选择";
        [_headerView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(2);
            make.left.right.mas_equalTo(titleLabel);
            make.height.mas_equalTo(17);
        }];
        
        UIButton *closeButton = [UIButton new];
        [closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setImage:[UIImage imageNamed:@"alertView_close"] forState:UIControlStateNormal];
        [_headerView addSubview:closeButton];
        [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(44);
            make.top.mas_equalTo(_headerView.mas_top).mas_offset(13);
            make.right.mas_equalTo(_headerView.mas_right).mas_offset(-3);
        }];
        
        UIView *container = [UIView new];
        container.backgroundColor = [UIColor whiteColor];
        [_headerView addSubview:container];
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.left.mas_equalTo(_headerView.mas_left).mas_offset(12);
            make.right.mas_equalTo(_headerView.mas_right).mas_offset(-12);
            make.bottom.mas_equalTo(_headerView.mas_bottom);
        }];
        NSDictionary *textDic = @{@0:@"日",@1:@"一",@2:@"二",@3:@"三",@4:@"四",@5:@"五",@6:@"六"};
        CGFloat margin = 12;
        CGFloat width = ([UIScreen mainScreen].bounds.size.width-margin*2)/7.0;
        for (int i=0; i<7; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(width*i, 0, width, 45)];
            label.textAlignment = NSTextAlignmentCenter;
            if (i == 0 || i == 6) {
                label.textColor = [UIColor mcColorWithHexString:@"#FF614A"];
            }else{
                label.textColor = [UIColor mcColorWithHexString:@"#666666"];
            }
            label.font = [UIFont systemFontOfSize:12];
            label.text = textDic[@(i)];
            [container addSubview:label];
        }
    }
    return _headerView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor mcColorWithHexString:@"#F6F6F6"];
    }
    return _lineView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [UILabel new];
        _promptLabel.font = [UIFont systemFontOfSize:14];
        _promptLabel.numberOfLines = 2;
        _promptLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _promptLabel.attributedText = [MCSettlementSelectDateView getAttributeStringWithString:@"已选择配送日期：请选择日期" subString:@"请选择日期" stringColor:[UIColor mcColorWithHexString:@"#262626"] subStringColor:[UIColor mcColorWithHexString:@"#0DAF52"]];
    }
    return _promptLabel;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        _resetButton = [UIButton new];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
        _resetButton.layer.cornerRadius = 20;
        _resetButton.layer.masksToBounds = YES;
        _resetButton.layer.borderWidth = 0.5;
        _resetButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setResetButtonDisableState:_resetButton];
    }
    return _resetButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton new];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sureButton setTitleColor:[UIColor mcColorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        _sureButton.layer.cornerRadius = 20;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setSureButtonDisableState:_sureButton];
    }
    return _sureButton;
}

- (FSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [FSCalendar new];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.pagingEnabled = NO;
        _calendar.allowsMultipleSelection = YES;
        _calendar.rowHeight = 55;
        _calendar.scope = FSCalendarScopeMonth;
        _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
        _calendar.appearance.titleDefaultColor = [UIColor blackColor];
        _calendar.appearance.titleSelectionColor = [UIColor whiteColor];
        _calendar.appearance.headerTitleColor = [UIColor blackColor];
        _calendar.appearance.titleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        _calendar.appearance.subtitleFont = [UIFont systemFontOfSize:8];
        _calendar.appearance.headerDateFormat = @"yyyy 年 MM 月";
        _calendar.appearance.headerTitleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        _calendar.appearance.headerTitleColor = [UIColor mcColorWithHexString:@"#262626"];
        _calendar.headerHeight = 42;
        _calendar.weekdayHeight = 0;
        
        _calendar.today = nil; // Hide the today circle
        [_calendar registerClass:[MCRangePickerCell class] forCellReuseIdentifier:@"cell"];
    }
    return _calendar;
}


- (void)setResetButtonNormalState:(UIButton *)sender {
    [sender setTitleColor:[UIColor mcColorWithHexString:@"#0DAF52"] forState:UIControlStateNormal];
    sender.layer.borderColor = [UIColor mcColorWithHexString:@"#0DAF52"].CGColor;
    sender.backgroundColor = [UIColor mcColorWithHexString:@"#FFFFFF"];
}

- (void)setResetButtonDisableState:(UIButton *)sender {
    [sender setTitleColor:[UIColor mcColorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
    sender.layer.borderColor = [UIColor mcColorWithHexString:@"#CCCCCC"].CGColor;
    sender.backgroundColor = [UIColor mcColorWithHexString:@"#FFFFFF"];
}

- (void)setSureButtonNormalState:(UIButton *)sender {
    sender.backgroundColor = [UIColor mcColorWithHexString:@"#0DAF52"];
}

- (void)setSureButtonDisableState:(UIButton *)sender {
    sender.backgroundColor = [UIColor mcColorWithHexString:@"#CCCCCC"];
}

- (void)resetAction:(UIButton *)sender {
    if (self.selectDateTitles.count > 0) {
        [self.calendar.selectedDates enumerateObjectsUsingBlock:^(NSDate * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"-----------%lu-----------",(unsigned long)idx);
            NSDate *date = (NSDate *)obj;
            [self.calendar deselectDate:date];
            if (idx == (self.selectDateTitles.count-1)) {
               [self configureVisibleCells];
            }
        }];
    }
}

- (void)sureAction:(UIButton *)sender {
    if (self.selectDateTitles.count > 0) {
        
    }
}

- (void)updateContentHeightWithHeight:(CGFloat)height{
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(height);
    }];
}

- (void)closeAction:(UIButton *)sender {
    [self removeFromSuperview];
}
/*
 {414, 634}
 */
+ (void)show {
    MCSettlementSelectDateView *dateView = [[MCSettlementSelectDateView alloc]init];
    NSDate *targetDate1 = [dateView.gregorian dateByAddingUnit:NSCalendarUnitDay value:-7 toDate:[NSDate date] options:0];
    NSDate *targetDate2 = [dateView.gregorian dateByAddingUnit:NSCalendarUnitDay value:50 toDate:[NSDate date] options:0];
    
    dateView.calendar.beginDate = targetDate1;
    dateView.calendar.endDate = targetDate2;
    [[UIApplication sharedApplication].keyWindow addSubview:dateView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@",NSStringFromCGSize(dateView.calendar.collectionView.contentSize));
        CGFloat maxContentHeight = [UIScreen mainScreen].bounds.size.height-64-115-137;
        if (dateView.calendar.collectionView.contentSize.height < maxContentHeight) {
            CGFloat height = maxContentHeight - dateView.calendar.collectionView.contentSize.height;
            [dateView updateContentHeightWithHeight:height];
        }
        [dateView.calendar.collectionView reloadData];
        
        
//        UICollectionViewCell *cell1 = [dateView.calendar cellForDate:targetDate1 atMonthPosition:FSCalendarMonthPositionCurrent];
//        
//        UICollectionViewCell *cell2 = [dateView.calendar cellForDate:targetDate2 atMonthPosition:FSCalendarMonthPositionCurrent];
//        
//        NSIndexPath *idx1 = [dateView.calendar.collectionView indexPathForCell:cell1];
//        NSIndexPath *idx2 = [dateView.calendar.collectionView indexPathForCell:cell2];
        
//        [dateView.calendar setDateLimitWithBeginDate:targetDate1 endDate:targetDate2];
//        [dateView.calendar scrollToDate:targetDate animated:YES];
    });
    
}

+ (NSAttributedString *)getAttributeStringWithString:(NSString *)string subString:(NSString *)subString  stringColor:(UIColor *)stringColor subStringColor:(UIColor *)subStringColor
{
    
    NSRange range = [string rangeOfString:subString];
    return [self getAttributeStringWithString:string range:range stringColor:stringColor subStringColor:subStringColor];
}


+ (NSAttributedString *)getAttributeStringWithString:(NSString *)string range:(NSRange)range  stringColor:(UIColor *)stringColor subStringColor:(UIColor *)subStringColor
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    if (range.length == 0) {
        [attString setAttributes:@{NSForegroundColorAttributeName:stringColor} range:NSMakeRange(0, string.length)];
        return attString;
    }
    [attString setAttributes:@{NSForegroundColorAttributeName:subStringColor} range:range];
    NSRange beforeRange = NSMakeRange(0, range.location);
    NSRange afterRange = NSMakeRange(range.location+range.length, string.length-(range.location+range.length));
    [attString setAttributes:@{NSForegroundColorAttributeName:stringColor} range:beforeRange];
    [attString setAttributes:@{NSForegroundColorAttributeName:stringColor} range:afterRange];
    return attString;
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate date] options:0];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:50 toDate:[NSDate date] options:0];
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    return nil;
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    MCRangePickerCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    if (date <= [NSDate date]) {
        return NO;
    }
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return YES;
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @"今日";
    }
    if ([self.selectDateTitleTexts.allKeys containsObject:date]) {
        NSNumber *number = self.selectDateTitleTexts[date];
        NSString *text = [NSString stringWithFormat:@"配送%@",number];
        return text;
    }
    return @"";
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleDefaultColorForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return [UIColor mcColorWithHexString:@"#D2D2D2"];
    }
    return [UIColor whiteColor];
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleSelectionColorForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return [UIColor mcColorWithHexString:@"#D2D2D2"];
    }
    return [UIColor whiteColor];
}

- (CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance subtitleOffsetForDate:(NSDate *)date
{
    return CGPointMake(0, 12);
}

-(CGPoint)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleOffsetForDate:(NSDate *)date
{
    return CGPointMake(0, -2);
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    [self configureVisibleCells];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    [self configureVisibleCells];
}

- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @[[UIColor orangeColor]];
    }
    return @[appearance.eventDefaultColor];
}


#pragma mark - Private methods

- (void)configureVisibleCells
{
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(__kindof FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position
{
    MCRangePickerCell *rangeCell = cell;
    if (position != FSCalendarMonthPositionCurrent) {
        rangeCell.selectionLayer.hidden = YES;
        return;
    }
    if ([self.calendar.selectedDates containsObject:date]) {
        rangeCell.selectionLayer.hidden = NO;
    }else{
        rangeCell.selectionLayer.hidden = YES;
    }

    self.selectDateTitles = [self.calendar.selectedDates sortedArrayUsingSelector:@selector(compare:)];
    [self.selectDateTitleTexts removeAllObjects];
    if (self.selectDateTitles.count > 0) {
        [self.selectDateTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDate *date = (NSDate *)obj;
            self.selectDateTitleTexts[date] = @(idx);
            if (self.selectDateTitleTexts.allKeys.count == self.selectDateTitles.count) {
                [self reloadSubTitles];
            }
        }];
    }else{
        [self reloadSubTitles];
    }
}

- (void)reloadSubTitles{
    for (NSDate *date in self.selectDateTitleTexts) {
        MCRangePickerCell *pickCell = (MCRangePickerCell *)[self.calendar cellForDate:date atMonthPosition:FSCalendarMonthPositionCurrent];
        pickCell.subtitleLabel.text = [NSString stringWithFormat:@"配送%@",self.selectDateTitleTexts[date]];
    }
    NSDate *firstDay = [self.selectDateTitles firstObject];
    NSDate *secondDay = nil;
    NSString *text = [NSString stringWithFormat:@"%ld月%ld日",(long)firstDay.mcMonth,(long)firstDay.mcDay];
    for (NSDate *date in self.selectDateTitles) {
        if (![date isEqualToDate:firstDay]) {
            if ([firstDay mcMonth] == [date mcMonth]) {
                text = [text stringByAppendingFormat:@"、%ld日",(long)date.mcDay];
            }else{
                secondDay = date;
                if (![secondDay isEqualToDate:date]) {
                    text = [text stringByAppendingFormat:@"、%ld日",(long)date.mcDay];
                }else{
                    text = [text stringByAppendingFormat:@"、%ld月%ld日",(long)secondDay.mcMonth,(long)secondDay.mcDay];
                }
            }
        }
    }
    text = [text stringByAppendingFormat:@" 共%ld日",(long)self.selectDateTitles.count];
    if (self.selectDateTitles.count > 0) {
        self.promptLabel.attributedText = [MCSettlementSelectDateView getAttributeStringWithString:[NSString stringWithFormat:@"已选择配送日期：%@",text] subString:text stringColor:[UIColor mcColorWithHexString:@"#262626"] subStringColor:[UIColor mcColorWithHexString:@"#0DAF52"]];
        [self setResetButtonNormalState:self.resetButton];
        [self setSureButtonNormalState:self.sureButton];
    }else{
        self.promptLabel.attributedText = [MCSettlementSelectDateView getAttributeStringWithString:@"已选择配送日期：请选择日期" subString:@"请选择日期" stringColor:[UIColor mcColorWithHexString:@"#262626"] subStringColor:[UIColor mcColorWithHexString:@"#0DAF52"]];
        [self setResetButtonDisableState:self.resetButton];
        [self setSureButtonDisableState:self.sureButton];
    }
}

@end
