//
//  ViewController.m
//  ExcelViewDemo
//
//  Created by 郭翰林 on 2017/2/10.
//  Copyright © 2017年 郭翰林. All rights reserved.
//

#import "ViewController.h"

/**
 *  主屏的宽
 */
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
/**
 *  主屏的高
 */
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
/**
 *  主题颜色
 */
#define UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]


@interface ViewController ()<deleteHomefrist>
@property(nonatomic,retain) NSMutableArray *leftTableDataArray;//表格第一列数据
@property(nonatomic,retain) NSMutableArray *excelDataArray;//表格数据
@property(nonatomic,retain) NSMutableArray *rightTableHeadArray;//表格第一行表头数据
@property(nonatomic,retain) NSMutableArray *allTableDataArray;//表格所有数据
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftTableDataArray=(NSMutableArray *)@[@"塔城",@"哈密",@"和田",@"阿勒泰",@"克州"];
    self.rightTableHeadArray=(NSMutableArray *)@[@"当日收入（万）",@"同比",@"环比",@"当月收入（万）",@"同比",@"环比",@"当年收入（万）",@"同比",@"环比"];
    self.excelDataArray=(NSMutableArray *)@[@[@"2.91111111111111111",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"2.9",@"2%",@"3%",@"3.0",@"4%11111111111111111111",@"5%",@"18",@"4.5%",@"6.8%"],@[@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"]];
    
    
//    self.allTableDataArray=(NSMutableArray *)@[@[@"地区",@"当日收入（万）",@"同比",@"环比",@"当月收入（万）",@"同比",@"环比",@"当年收入（万）",@"同比",@"环比"],@[@"塔城",@"2.91111111111111111111111111111111111111111111111111111111",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"哈密",@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"和田",@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"],@[@"阿勒泰",@"2.9",@"2%",@"3%",@"3.0",@"4%11111111111111111111",@"5%",@"18",@"4.5%",@"6.8%"],@[@"克州",@"2.9",@"2%",@"3%",@"3.0",@"4%",@"5%",@"18",@"4.5%",@"6.8%"]];
   
    self.allTableDataArray=[NSMutableArray arrayWithCapacity:10];
//    NSMutableArray *fristDatas=[NSMutableArray arrayWithCapacity:10];
//    [fristDatas addObject:@"标题"];
//    for (int i=0; i<22; i++) {
//        [fristDatas addObject:[NSString stringWithFormat:@"aa标题%d",i]];
//    }
//    [self.allTableDataArray addObject:fristDatas];
    for (int i=0; i<22; i++) {
        NSMutableArray *rowDatas=[NSMutableArray arrayWithCapacity:10];
        [rowDatas addObject:[NSString stringWithFormat:@"bbb标题%d",i]];
        for (int j=0; j<22;j++) {
            [rowDatas addObject:[NSString stringWithFormat:@"cc数据%d",j]];
        }
        [self.allTableDataArray addObject:rowDatas];
    }
    
//    NSLog(@"%@",self.allTableDataArray);
    
//    //代码方式添加
//    ExcelView *excelView=[[ExcelView alloc]initWithFrame:CGRectMake(0, 64, UIScreenWidth, UIScreenHeight)];
//    excelView.topTableHeadDatas=self.rightTableHeadArray;
//    excelView.leftTabHeadDatas=self.leftTableDataArray;
//    excelView.tableDatas=self.excelDataArray;
//    excelView.isLockFristColumn=NO;
//    excelView.isLockFristRow=YES;
//    excelView.isColumnTitlte=YES;
//    excelView.columnTitlte=@"地区";
//    [excelView show];
//    [self.view addSubview:excelView];

    
    //xib布局添加方式
    self.mExcelView.allTableDatas=self.allTableDataArray;
    self.mExcelView.isLockFristColumn=YES;
    self.mExcelView.isLockFristRow=YES;
    self.mExcelView.isColumnTitlte=YES;
    self.mExcelView.columnTitlte=@"地区";
    self.mExcelView.columnMaxWidth=200;
    self.mExcelView.columnMinWidth=100;
    [self.mExcelView showWithLeftBlock:^(CGPoint contentOffset) {
        NSLog(@"滚动到了最左侧！");
        NSLog(@"偏移量：%f",contentOffset.x);
    } AndWithRigthBlock:^(CGPoint contentOffset) {
        NSLog(@"滚动到了最右侧！");
        NSLog(@"偏移量：%f",contentOffset.x);
    }];
    _mExcelView.delegatehomefrist = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPlace:) name:@"refreshPlace" object:nil];
    
    

    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)warningLable:(NSString *)str
{
    
    int theLabelWith = [str boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(DEF_SCREEN_WIDTH/2-theLabelWith/2-5, DEF_SCREEN_HEIGHT/2-30, theLabelWith+10, 60)];
    label.text = str;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.backgroundColor = UIColorFromRGB(0xd1d0c5);
    label.layer.cornerRadius = 5;
    label.numberOfLines = 0;
    label.clipsToBounds = YES;
    [self.view addSubview:label];
    
    
    //动画效果，1.2秒后消失
    [UIView animateWithDuration:1.5f animations:^{
        
        label.alpha = 0;
    } completion:^(BOOL finished) {
        
        [label removeFromSuperview];
        
    }];

}

- (void)refreshPlace:(NSNotification *)msg
{
    NSDictionary *getDic = msg.object;
    
    [self warningLable:[NSString stringWithFormat:@"Row is:%@  Column is %@",getDic[@"CellNumber"],getDic[@"index"]]];
}

-(void)touchhomefrist:(ExcelView *)fristcellView cellNumber:(int)CellNumber didSelectItemAtIndex:(int)index
{
    NSLog(@"============cellnumber is %d touch number is %d",CellNumber,index);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
