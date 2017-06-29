//
//  TextFieldViewController.m
//  TestWeb
//
//  Created by huangbo on 2017/6/12.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "TextFieldViewController.h"
#import "MTDefine.h"
@interface TextFieldViewController () <UITextFieldDelegate>
{
    NSInteger _maxNum;
}
@property (nonatomic, strong) UITextField *field;

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    [self.navigationController.view addSubview:self.field];
    self.field.layer.borderWidth = 1;
    self.field.layer.borderColor = [UIColor grayColor].CGColor;
    self.field.delegate = self;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(textDidChange:)
//                                                 name:UITextFieldTextDidChangeNotification
//                                               object:nil];



}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%@------%@", textField.text, string);
    return YES;
}

- (void)textDidChange:(NSNotification *)notification {
    UITextField *field = notification.object;
    NSLog(@"%@", field.text);
}




- (void)searchString:(NSString *)str {
    
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
