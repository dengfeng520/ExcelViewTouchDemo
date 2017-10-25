//
//  HomeTableCell.h
//  ListBtndemo
//
//  Created by rp.wang on 2017/10/17.
//  Copyright © 2017年 兰州北科维拓科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageCollectionCell.h"


@class HomeTableCell;
///代理
@protocol deleteHomeThrid <NSObject>

- (void)touchhomeThrid:(HomeTableCell *)fristcellView cellNumber:(int)CellNumber didSelectItemAtIndex:(int)index;

@end

@interface HomeTableCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (copy, nonatomic) NSDictionary *dataAry;

@property (copy, nonatomic) NSArray *widthList;

/**
 * 初始化
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
///接收数据
-(void)GetHomeTableCellData :(NSDictionary *)datadic cellNumber:(int)cellNumber widthList:(NSArray *)widthList;

@property (strong, nonatomic) UICollectionView *GreatCollectionView;
///代理
@property (nonatomic, weak) id <deleteHomeThrid> delegatehomethrid;
@end
