//
//  PickerViewController.m
//  TestWeb
//
//  Created by huangbo on 2017/6/9.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "PickerViewController.h"
#import "MTDefine.h"

@interface PickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) NSArray *arr1;
@property (nonatomic, strong) NSArray *arr2;
@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, SCREENWIDTH, 400)];
    picker.delegate = self;
    picker.dataSource = self;
    [self.view addSubview:picker];
    
    self.arr1 = @[@"1", @"2", @"3", @"4"];
    self.arr2 = @[@[@"111", @"1111"], @[@"222", @"2222", @"22222"], @[@"333", @"3333", @"33333333"], @[@"444"]];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 100, 100, 20)];
    [self.view addSubview:slider];
    
    slider.minimumTrackTintColor = [UIColor redColor];
    slider.maximumTrackTintColor = [UIColor greenColor];
    
    slider.minimumValue = 1;
    slider.maximumValue = 100;
    slider.value = 50;
    [slider addTarget:self action:@selector(handleSlider:) forControlEvents:UIControlEventValueChanged];
}

- (void)handleSlider:(UISlider *)slider {
    NSLog(@"%lf", slider.value);
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.arr1.count;
    } else {
        return self.arr2.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.arr1[row];
    } else {
        NSArray *arr = self.arr2[row];
        return arr[0];
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [pickerView reloadAllComponents];
//    NSArray *arr = self.arr2[row];
//    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@--%@", self.arr1[row], arr[row]] preferredStyle:UIAlertControllerStyleAlert];
//    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    [self presentViewController:alertC animated:YES completion:^{
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
