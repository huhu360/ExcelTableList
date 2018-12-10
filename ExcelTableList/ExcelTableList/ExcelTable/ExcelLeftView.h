//
//  ExcelLeftView.h
//  ExcelTableList
//
//  Created by DS99 on 2018/10/15.
//  Copyright © 2018年 ZWM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubtypeView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ExcelLeftViewDataSource;


@interface ExcelLeftView : UIView

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, weak) id <ExcelLeftViewDataSource> dataSource;

- (void)reloadData;

@end

@interface ExcelLeftCell : UITableViewCell

@property (nonatomic, strong) SubtypeView *subtypeView;

@end

@protocol ExcelLeftViewDataSource <NSObject>
@required

/// 一共返回多少行
- (NSInteger)numberOfRowsInExcelLeftView:(ExcelLeftView *)excelLeftView;
//// 返回左侧内容显示的数据，在每行的cell上每列label的内容
- (NSString *)excelLeftView:(ExcelLeftView *)excelLeftView cellForRowAtIndexPath:(NSIndexPath*)indexPath;
/// 返回左侧数据的行高
- (CGFloat)heightForLeftCellHeightInRow:(NSInteger)row;
/// 设置左侧列表滑动布局调整
- (void)layoutLeftListWithOffsetY:(CGFloat)offsetY;


@end

NS_ASSUME_NONNULL_END
