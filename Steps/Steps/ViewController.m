//
//  ViewController.m
//  Steps
//
//  Created by Garenge on 2022/10/30.
//

#import "ViewController.h"
#import "StepsModel.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableDictionary *stepsDictionary;

@end

@implementation ViewController

- (NSMutableDictionary *)stepsDictionary {
    if (nil == _stepsDictionary) {
        _stepsDictionary = [NSMutableDictionary dictionary];
    }
    return _stepsDictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self getContent];
}

- (void)getContent {
    
    NSString *url = @"https://www.garenge.top/picdata/";
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (nil == error) {
            NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [weakSelf beginDO:htmlString];
        }
    }];
    [dataTask resume];
}

- (void)beginDO:(NSString *)htmlString {
    
    StepsModel *step1 = [StepsModel new];
    step1.gumboElement = [[OCGumboDocument alloc] initWithHTMLString:htmlString].body;
    step1.stepId = @"001";
    step1.keyword = @"content";
    step1.keywordType = StepsKeywordTypeClass;
    step1.returnClass = [NSArray class];
    
    StepsModel *step2 = [StepsModel new];
    step2.parentStepId = @"001";
    step2.stepId = @"0011";
    step2.keyword = @"contentlabel";
    step2.keywordType = StepsKeywordTypeClass;
    step2.returnClass = [NSString class];
    
    StepsModel *step3 = [StepsModel new];
    step3.topStepId = @"0011";
    step3.stepId = @"0012";
    step3.keyword = @"contentlabel";
    step3.keywordType = StepsKeywordTypeClass;
    step3.returnClass = [NSString class];
    
    // TODO: 整理树状结构
    NSArray *steps = @[step1, step2, step3];
    for (StepsModel *step in steps) {
        self.stepsDictionary[step.stepId] = step;
    }
    
    for (StepsModel *step in steps) {
        if (step.topStepId.length > 0) {
            StepsModel *topStep = self.stepsDictionary[step.topStepId];
            topStep.nextStep = step;
        }
        if (step.parentStepId.length > 0) {
            StepsModel *supStep = self.stepsDictionary[step.parentStepId];
            [supStep addSubStep:step];
        }
    }
    
    StepsModel *currentStep = steps.firstObject;
    while (currentStep) {
        
        id topObject;
        StepsModel *topStep = self.stepsDictionary[currentStep.topStepId];
        topObject = topStep.returnObject;
        
        if (nil == topObject) {
            switch (currentStep.keywordType) {
                case StepsKeywordTypeClass:
                    if (currentStep.returnClass == [NSArray class]) {
                        currentStep.returnObject = [currentStep.gumboElement queryWithClass:currentStep.keyword];
                        if (currentStep.getSubSteps.count > 0) {
                            currentStep = currentStep.getSubSteps.firstObject;
                        } else {
                            currentStep = currentStep.nextStep;
                        }
                    } else {
                        
                    }
                    
                    break;
                    
                default:
                    break;
            }
        } else {
            if (topStep.returnClass == [NSArray class]) {
                
                for (OCGumboElement *element in (NSArray *)topStep.returnObject) {
                    
                }
                
            } else {
                
            }
        }
        
    }
}

@end
