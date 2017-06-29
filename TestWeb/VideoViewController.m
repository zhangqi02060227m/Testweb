//
//  VideoViewController.m
//  TestWeb
//
//  Created by huangbo on 17/5/31.
//  Copyright © 2017年 huangbo. All rights reserved.
//

#import "VideoViewController.h"
#import <TesseractOCR/TesseractOCR.h>

@interface VideoViewController ()<G8TesseractDelegate>
@property (nonatomic, strong) UILabel *lbl;
@end

@implementation VideoViewController

- (void)setName:(NSString *)name {
    _name = name;
    self.lbl.text = self.name;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        lbl.backgroundColor = [UIColor cyanColor];
//        [self.view addSubview:lbl];
        self.lbl = lbl;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Languages are used for recognition (e.g. eng, ita, etc.). Tesseract engine
    // will search for the .traineddata language file in the tessdata directory.
    // For example, specifying "eng+ita" will search for "eng.traineddata" and
    // "ita.traineddata". Cube engine will search for "eng.cube.*" files.
    // See https://github.com/tesseract-ocr/tessdata.
    
    // Create your G8Tesseract object using the initWithLanguage method:
    G8Tesseract *tesseract = [[G8Tesseract alloc] initWithLanguage:@"fra"];
    // Optionaly: You could specify engine to recognize with.
    // G8OCREngineModeTesseractOnly by default. It provides more features and faster
    // than Cube engine. See G8Constants.h for more information.
    //tesseract.engineMode = G8OCREngineModeTesseractOnly;
    
    // Set up the delegate to receive Tesseract's callbacks.
    // self should respond to TesseractDelegate and implement a
    // "- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract"
    // method to receive a callback to decide whether or not to interrupt
    // Tesseract before it finishes a recognition.
    tesseract.delegate = self;
    
    // Optional: Limit the character set Tesseract should try to recognize from
    //    tesseract.charWhitelist = @"0123456789";
    
    // This is wrapper for common Tesseract variable kG8ParamTesseditCharWhitelist:
    // [tesseract setVariableValue:@"0123456789" forKey:kG8ParamTesseditCharBlacklist];
    // See G8TesseractParameters.h for a complete list of Tesseract variables
    
    // Optional: Limit the character set Tesseract should not try to recognize from
    //tesseract.charBlacklist = @"OoZzBbSs";
    
    // Specify the image Tesseract should recognize on
    tesseract.image = [UIImage imageNamed:@"11.png"];
    
    // Optional: Limit the area of the image Tesseract should recognize on to a rectangle
    //    tesseract.rect = CGRectMake(0, 0, 10000, 10000);
    
    // Optional: Limit recognition time with a few seconds
    tesseract.maximumRecognitionTime = 10;
    
    // Start the recognition
    [tesseract recognize];
    
    // Retrieve the recognized text
    NSLog(@"%@", [tesseract recognizedText]);
    
    
    // You could retrieve more information about recognized text with that methods:
    NSArray *characterBoxes = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelSymbol];
    NSArray *paragraphs = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelParagraph];
    NSArray *characterChoices = tesseract.characterChoices;
    UIImage *imageWithBlocks = [tesseract imageWithBlocks:characterBoxes drawText:YES thresholded:NO];
    
}

- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;  // return YES, if you need to interrupt tesseract before it finishes
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
