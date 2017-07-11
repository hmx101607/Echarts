//
//  EDHomeViewController.m
//  EchartsDemo
//
//  Created by mason on 2017/7/10.
//
//

#import "EDHomeViewController.h"
#import "EDPolylineViewController.h"
#import "EDColumnarViewController.h"

@interface EDHomeViewController ()


@end

@implementation EDHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)polylineAction:(UIButton *)sender {
    EDPolylineViewController *polylineVC = [EDPolylineViewController create];
    polylineVC.title = @"折线图";
    [self.navigationController pushViewController:polylineVC animated:YES];
}

- (IBAction)columnarAction:(UIButton *)sender {
    EDColumnarViewController *columnarVC = [EDColumnarViewController create];
    columnarVC.title = @"柱状图";
    [self.navigationController pushViewController:columnarVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
