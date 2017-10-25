//
//  HomeTableCell.m
//  ListBtndemo
//
//  Created by rp.wang on 2017/10/17.
//  Copyright © 2017年 兰州北科维拓科技股份有限公司. All rights reserved.
//

#import "HomeTableCell.h"

@implementation HomeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       
    }
    return self;
}

-(void)GetHomeTableCellData :(NSDictionary *)datadic cellNumber:(int)cellNumber widthList:(NSArray *)widthList
{
    //初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //初始化collectionView
    float widthnuber = [widthList[0]floatValue];
    self.GreatCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, widthList.count * widthnuber ,45) collectionViewLayout:layout];
    [self addSubview:self.GreatCollectionView];
    self.GreatCollectionView.backgroundColor = [UIColor whiteColor];
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [self.GreatCollectionView registerClass:[HomePageCollectionCell class] forCellWithReuseIdentifier:@"HomePageCollectionCellID"];
    self.GreatCollectionView.showsVerticalScrollIndicator = NO;
    self.GreatCollectionView.showsHorizontalScrollIndicator = NO;
    self.GreatCollectionView.contentSize = CGSizeMake(self.GreatCollectionView.frame.size.width,0);
    //设置代理
    self.GreatCollectionView.delegate = self;
    self.GreatCollectionView.dataSource = self;
    _GreatCollectionView.scrollEnabled = NO;
    
    self.GreatCollectionView.tag = cellNumber;
    self.dataAry = datadic;
    self.widthList = widthList;
    [self.GreatCollectionView reloadData];
}

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSArray *lsList = _dataAry[@"zhuangtai"];
//    return lsList.count;
    return 22;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionCell *collcell = (HomePageCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCollectionCellID" forIndexPath:indexPath];
//    NSArray *lsList = _dataAry[@"zhuangtai"];
//    if([[NSString stringWithFormat:@"%@",lsList[indexPath.row][@"displayorder"]] isEqualToString:[NSString stringWithFormat:@"%@",_dataAry[@"pitchOn"]]])
//    {
//        collcell.backgroundColor = [UIColor redColor];
//    }else
//    {
//        collcell.backgroundColor = [UIColor blueColor];
//    }

//    [collcell InitGreatCollCellView:lsList[indexPath.row]];
    
    if(indexPath.row % 2 == 0)
    {
        collcell.backgroundColor = [UIColor redColor];

    }else
    {
        collcell.backgroundColor = [UIColor lightGrayColor];

    }
    [collcell InitGreatCollCellView:nil];

    return collcell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float cellwidthnumber = [self.widthList[indexPath.row]floatValue];
    return CGSizeMake(cellwidthnumber - 1, 45);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size = {0.5, 0.5};
    return size;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5f;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionCell * cell = (HomePageCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if([self.delegatehomethrid respondsToSelector:@selector(touchhomeThrid:cellNumber:didSelectItemAtIndex:)])
    {
        [self.delegatehomethrid touchhomeThrid:self cellNumber:(int)_GreatCollectionView.tag didSelectItemAtIndex:(int)indexPath.row];
    }
    
    NSDictionary *pointdic = @{@"CellNumber":[NSString stringWithFormat:@"%d",(int)_GreatCollectionView.tag],@"index":[NSString stringWithFormat:@"%d",(int)indexPath.row]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshPlace" object:pointdic];

    
}
@end
