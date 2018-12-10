//
//  ExcelView.h
//  ExcelTableList
//
//  Created by DS99 on 2018/10/15.
//  Copyright © 2018年 ZWM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubtypeView.h"
#import "ClassifyView.h"
#import "ExcelCell.h"
#import "ExcelLeftView.h"
#import "Constant.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ExcelViewDataSource;


@interface ExcelView : UIView

// 设置左右侧标题的数组,默认数组中的个数为0
@property (nonatomic, strong) NSArray * leftTops;
@property (nonatomic, strong) NSArray * rightTops;



@property (nonatomic, weak) id <ExcelViewDataSource> dataSource;

- (void)creatView;

// 重载左右侧数据
- (void)reloadLeftAndRightData;
// 重载所有的数据
- (void)reloadAllData;
// 重载所有的布局和数据
- (void)reloadLayoutAndData;

//- (void)reloadData;

@end


@protocol ExcelViewDataSource <NSObject>
@required
/// 一共返回多少行
- (NSInteger)excelView:(ExcelView *)excelView numberOfRowsInSection:(NSInteger)section;
//// 返回右侧内容显示的数据，在每行的cell上每列label的内容
- (NSString *)excelView:(ExcelView *)excelView rightCellForRowAtIndexPath:(NSIndexPath*)indexPath withColumn:(NSInteger)column;
//// 返回左侧内容显示的数据，在每行的cell上每列的内容
- (NSString *)excelView:(ExcelView *)excelView leftCellForRowAtIndexPath:(NSIndexPath*)indexPath withColumn:(NSInteger)column;


@optional
/// 获取左侧每列的宽度，默认是leftWidth
- (CGFloat)excelView:(ExcelView *)excelView widthForLeftRowInColumn:(NSInteger)column;
/// 获取右侧每列的宽度，默认是mWidth
- (CGFloat)excelView:(ExcelView *)excelView widthForRightRowInColumn:(NSInteger)column;
/// 获取顶部行的高度，默认是mHeight
- (CGFloat)heightForTopRowInExcelView:(ExcelView *)excelView;
/// 获取左右侧内容的行高度，默认是cellHeight
- (CGFloat)excelView:(ExcelView *)excelView heightForContentInRow:(NSInteger)row;


@end

NS_ASSUME_NONNULL_END
