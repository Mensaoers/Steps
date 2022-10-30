//
//  StepsModel.m
//  Steps
//
//  Created by Garenge on 2022/10/30.
//

#import "StepsModel.h"

@interface StepsModel()

@property (nonatomic, weak) NSMutableArray *subSteps;

@end

@implementation StepsModel

- (NSMutableArray *)subSteps {
    if (nil == _subSteps) {
        _subSteps = [NSMutableArray array];
    }
    return _subSteps;
}

- (void)addSubStep:(StepsModel *)stepModel {
    NSInteger count = self.subSteps.count;
    
    for (NSInteger index = 0; index < count; index ++) {
        StepsModel *indexModel = self.subSteps[index];
        
        if ([stepModel.topStepId isEqualToString:indexModel.stepId]) {
            [self.subSteps insertObject:stepModel atIndex:index + 1];
            return;
        }
        if ([indexModel.topStepId isEqualToString:stepModel.stepId]) {
            [self.subSteps insertObject:stepModel atIndex:MAX(0, index - 1)];
            return;
        }
    }
    [self.subSteps addObject:stepModel];
}

- (NSArray *)getSubSteps {
    return self.subSteps;
}

@end
