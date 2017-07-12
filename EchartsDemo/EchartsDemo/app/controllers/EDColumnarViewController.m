//
//  EDColumnarViewController.m
//  EchartsDemo
//
//  Created by mason on 2017/7/11.
//
//

#import "EDColumnarViewController.h"
#import "iOS-Echarts.h"


@interface EDColumnarViewController ()
<
UIScrollViewDelegate
>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) PYEchartsView *kEchartView;

@end

@implementation EDColumnarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatScrollView];
    [self createView];
    [self.kEchartView loadEcharts];
  
}

- (void)createView {
    PYOption  *option = [[PYOption alloc] init];
    option.calculable = NO;
    /** 直角坐标系内绘图网格, 说明见下图 */
    PYGrid *grid = [[PYGrid alloc] init];
    // 左上角位置
    grid.x = @(45);
    grid.y = @(20);
    // 右下角位置
    grid.x2 = @(20);
    grid.y2 = @(30);
    grid.borderWidth = @(0);
    
    // 添加到图标选择中
    option.grid = grid;
    
    PYAxis *xAxis = [[PYAxis alloc] init];
    xAxis.type = PYAxisTypeCategory;
    
    xAxis.boundaryGap = @(YES);
    // 分隔线:垂直分割线
    xAxis.splitLine.show = NO;
    // 坐标轴线:一条紧挨坐标轴的蓝色线
    xAxis.axisLine.show = NO;
    
    NSArray *menuData = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    xAxis.data = [menuData mutableCopy];
    xAxis.axisTick = [[PYAxisTick alloc] init];
    xAxis.axisTick.show = NO;
    option.xAxis = [@[xAxis] mutableCopy];
    
    
    PYAxis *yAxis = [[PYAxis alloc] init];
    yAxis.type = PYAxisTypeValue;
    yAxis.axisLine.show = NO;
    option.yAxis = [@[yAxis] mutableCopy];

    
    PYCartesianSeries *series = [[PYCartesianSeries alloc] init];
    series.name = @"蒸发量";
    series.type = PYSeriesTypeBar;
    series.barWidth = @(5.f);
    PYTooltip *toolTip = [[PYTooltip alloc] init];
    toolTip.borderRadius = @(5.f);
    series.data = [@[@2.0, @4.9, @"-", @23.2, @25.6, @76.7, @135.6, @162.2, @32.6, @20.0, @6.4, @3.3] mutableCopy];
    [option setSeries:[@[series] mutableCopy]];

    /** 初始化图表 */
    self.kEchartView = [[PYEchartsView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 300)];
    // 添加到 scrollView 上
    [self.view addSubview:self.kEchartView];
    // 图表选项添加到图表上
    [self.kEchartView setOption:option];

}

- (void)creatScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width , 300)];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 2, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
}


@end
