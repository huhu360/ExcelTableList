//
//  ExcelView.m
//  ExcelTableList
//
//  Created by DS99 on 2018/10/15.
//  Copyright © 2018年 ZWM. All rights reserved.
//

#import "ExcelView.h"

@interface ExcelView () <UITableViewDelegate,UITableViewDataSource,ExcelLeftViewDataSource>

@property (nonatomic, strong) UITableView *rightTableV;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIScrollView * myScrollView;
@property (nonatomic, strong) NSMutableArray <ExcelLeftView *> *leftViews;
@property (nonatomic, strong) NSMutableArray <ClassifyView *> *classifyViews;
@property (nonatomic, strong) NSMutableArray <SubtypeView *> *headViews;
@property (nonatomic, assign) CGFloat topHeight;

@end

@implementation ExcelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        self.leftViews = [NSMutableArray array];
        self.classifyViews = [NSMutableArray array];
    }
    return self;
}


- (void)creatView {
    self.topHeight = mHeight;
    if ([self.dataSource respondsToSelector:@selector(heightForTopRowInExcelView:)]) {
        self.topHeight = [self.dataSource heightForTopRowInExcelView:self];
    }
    [[NSUserDefaults standardUserDefaults] setObject:@(_rightTops.count) forKey:@"column"];
    [self creatLeftView];
    [self creatRightView];
}

- (void)creatLeftView {
    if (self.leftTops.count == 0) {
        return;
    }
    for (NSInteger index = 0;index < self.leftTops.count;index++) {
        // 左侧头部
        CGFloat leftTotalW = 0;
        for (NSInteger jndex = 0 ; jndex < index; jndex++) {
            if ([self.dataSource respondsToSelector:@selector(excelView:widthForLeftRowInColumn:)]) {
                leftTotalW += [self.dataSource excelView:self widthForLeftRowInColumn:jndex];
            } else {
                leftTotalW += leftWidth;
            }
        }
        CGFloat leftItemWidth = leftWidth;
        if ([self.dataSource respondsToSelector:@selector(excelView:widthForLeftRowInColumn:)]) {
            leftItemWidth = [self.dataSource excelView:self widthForLeftRowInColumn:index];
        }
        
        NSString * leftTopString = self.leftTops[index];
        ClassifyView * classifyView = [[ClassifyView alloc] initWithFrame:CGRectMake(leftTotalW, 0, leftItemWidth, self.topHeight)];
        classifyView.titLabel.text = leftTopString;
        classifyView.backgroundColor = lineColor;
        classifyView.layer.borderColor = backColor.CGColor;
        classifyView.layer.borderWidth = 0.5;
        [self addSubview:classifyView];
        [_classifyViews addObject:classifyView];
        
        // 左侧内容
        ExcelLeftView * leftView = [[ExcelLeftView alloc] initWithFrame:CGRectMake(leftTotalW, self.topHeight, leftItemWidth, self.bounds.size.height - self.topHeight)];
//        leftView.tableV.frame = leftView.bounds;
        leftView.dataSource = self;
        leftView.backgroundColor = [UIColor colorWithRed:239 green:220 blue:49 alpha:1];
        [self addSubview:leftView];
        [_leftViews addObject:leftView];
    }
}

- (void)creatRightView {
    // 右侧头部
    CGFloat right_X = 0;
    CGFloat rightWidth = 0;
    UIView * Headview = [[UIView alloc] initWithFrame:CGRectZero];
    self.headView = Headview;
    self.headView.backgroundColor = backColor;
    for(int i = 0; i < _rightTops.count; i++){
        if ([self.dataSource respondsToSelector:@selector(excelView:widthForRightRowInColumn:)]) {
            if (i > 0) {
                right_X += [self.dataSource excelView:self widthForRightRowInColumn:i-1];
            }
            rightWidth = [self.dataSource excelView:self widthForRightRowInColumn:i];
        } else {
            if (i > 0) {
                right_X += mWidth;
            }
            rightWidth = mWidth;
        }
        SubtypeView * headView = [[SubtypeView alloc]initWithFrame:CGRectMake(right_X + 0.5 * i, 0, rightWidth - 0.5, self.topHeight - 0.5)];
        headView.backgroundColor = lineColor;
        headView.text = self.rightTops[i];
        [self.headView addSubview:headView];
        [_headViews addObject:headView];
    }
    if ([self.dataSource respondsToSelector:@selector(excelView:widthForRightRowInColumn:)]) {
        right_X += [self.dataSource excelView:self widthForRightRowInColumn:_rightTops.count-1];
    } else {
        right_X += mWidth;
    }
    Headview.frame = CGRectMake(0, 0, right_X , self.topHeight);
    
    // 右侧内容
    self.rightTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, right_X, self.frame.size.height) style:(UITableViewStylePlain)];
    self.rightTableV.delegate = self;
    self.rightTableV.dataSource = self;
    self.rightTableV.allowsSelection = NO;
    self.rightTableV.bounces = NO;
    self.rightTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.rightTableV registerClass:[ExcelCell class] forCellReuseIdentifier:@"ExcelCell"];
    
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    [_myScrollView addSubview: self.rightTableV];
    _myScrollView.bounces = NO;
    _myScrollView.contentSize = CGSizeMake(right_X, 0);
    [self addSubview:_myScrollView];
    
    [self LayoutRight];
    
}

- (void)LayoutRight {
    CGFloat leftTotalW = 0;
    for (NSInteger index = 0 ; index < _leftTops.count; index++) {
        if ([self.dataSource respondsToSelector:@selector(excelView:widthForLeftRowInColumn:)]) {
            leftTotalW += [self.dataSource excelView:self widthForLeftRowInColumn:index];
        } else {
            leftTotalW += leftWidth;
        }
    }
    _myScrollView.frame = CGRectMake(leftTotalW, 0, kScreenWidth-leftTotalW, self.frame.size.height);
    
}


#pragma ExcelLeftViewDataSource
- (NSInteger)numberOfRowsInExcelLeftView:(ExcelLeftView *)excelLeftView {
    if ([self.dataSource respondsToSelector:@selector(excelView:numberOfRowsInSection:)]) {
        return [self.dataSource excelView:self numberOfRowsInSection:0];
    }
    return 0;
}
- (NSString *)excelLeftView:(ExcelLeftView *)excelLeftView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger column = [_leftViews indexOfObject:excelLeftView];
    if ([self.dataSource respondsToSelector:@selector(excelView:leftCellForRowAtIndexPath:withColumn:)]) {
        return [self.dataSource excelView:self leftCellForRowAtIndexPath:indexPath withColumn:column];
    }
    return @"错误";
}
- (CGFloat)heightForLeftCellHeightInRow:(NSInteger)row {
    CGFloat cellH = cellHeight;
    if ([self.dataSource respondsToSelector:@selector(excelView:heightForContentInRow:)]) {
        cellH = [self.dataSource excelView:self heightForContentInRow:row];
    }
    return cellH;
}
- (void)layoutLeftListWithOffsetY:(CGFloat)offsetY {
    CGPoint timeOffsetY = self.leftViews[0].tableV.contentOffset;
    timeOffsetY.y = offsetY;
    for (ExcelLeftView * leftView in _leftViews) {
        leftView.tableV.contentOffset = timeOffsetY;
    }
    self.rightTableV.contentOffset = timeOffsetY;
}

#pragma 右侧tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(excelView:numberOfRowsInSection:)]) {
        return [self.dataSource excelView:self numberOfRowsInSection:section];
    }
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellH = cellHeight;
    if ([self.dataSource respondsToSelector:@selector(excelView:heightForContentInRow:)]) {
        cellH = [self.dataSource excelView:self heightForContentInRow:indexPath.row];
    }
    return cellH;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.topHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExcelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExcelCell" forIndexPath:indexPath];
    CGFloat cellH = cellHeight;
    if ([self.dataSource respondsToSelector:@selector(excelView:heightForContentInRow:)]) {
        cellH = [self.dataSource excelView:self heightForContentInRow:indexPath.row];
    }
    CGFloat right_X = 0;
    CGFloat rightWidth = 0;
    for (NSInteger index = 0; index < cell.labelArr.count; index++) {
        SubtypeView * headView = (SubtypeView *)cell.labelArr[index];
        if ([self.dataSource respondsToSelector:@selector(excelView:widthForRightRowInColumn:)]) {
            if (index > 0) {
                right_X += [self.dataSource excelView:self widthForRightRowInColumn:index-1];
            }
            rightWidth = [self.dataSource excelView:self widthForRightRowInColumn:index];
        } else {
            if (index > 0) {
                right_X += mWidth;
            }
            rightWidth = mWidth;
        }
        headView.frame = CGRectMake(right_X + 0.5 * index, 0, rightWidth - 0.5, cellH - 0.5);
        if ([self.dataSource respondsToSelector:@selector(excelView:rightCellForRowAtIndexPath:withColumn:)]) {
            cell.labelArr[index].text = [self.dataSource excelView:self rightCellForRowAtIndexPath:indexPath withColumn:index];
        } else {
            cell.labelArr[index].text = @"错";
        }
    }
    
    return cell;
}

//同步左侧右侧
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = self.rightTableV.contentOffset.y;
    CGPoint timeOffsetY = self.leftViews[0].tableV.contentOffset;
    timeOffsetY.y = offsetY;
    for (ExcelLeftView * leftView in _leftViews) {
        leftView.tableV.contentOffset = timeOffsetY;
    }
    if(offsetY == 0) {
        for (ExcelLeftView * leftView in _leftViews) {
            leftView.tableV.contentOffset = CGPointZero;
        }
    }
}


- (void)reloadLeftAndRightData {
    [self.rightTableV reloadData];
    for (ExcelLeftView * leftView in _leftViews) {
        [leftView reloadData];
    }
}
- (void)reloadAllData {
    for (NSInteger index = 0;index < _classifyViews.count;index++) {
        ClassifyView * classifyView = _classifyViews[index];
        classifyView.titLabel.text = _leftTops[index];
    }
    for (NSInteger index = 0;index < _headViews.count;index++) {
        SubtypeView * headView = _headViews[index];
        headView.text = _rightTops[index];
    }
    [self reloadLeftAndRightData];
}
- (void)reloadLayoutAndData {
    for (ExcelLeftView * leftView in _leftViews) {
        CGRect leftRect = leftView.frame;
        leftRect.size.height = self.frame.size.height - self.topHeight;
        leftView.frame = leftRect;
    }
    CGRect rightRect = _rightTableV.frame;
    rightRect.size.height = self.frame.size.height;
    _rightTableV.frame = rightRect;
    CGFloat leftTotalW = 0;
    for (NSInteger index = 0 ; index < _leftTops.count; index++) {
        if ([self.dataSource respondsToSelector:@selector(excelView:widthForLeftRowInColumn:)]) {
            leftTotalW += [self.dataSource excelView:self widthForLeftRowInColumn:index];
        } else {
            leftTotalW += leftWidth;
        }
    }
    _myScrollView.frame = CGRectMake(leftTotalW, 0, kScreenWidth-leftTotalW, self.frame.size.height);
    
    [self reloadAllData];
    //    NSLog(@"%@------- ",NSStringFromCGRect(rightRect));
}

@end
