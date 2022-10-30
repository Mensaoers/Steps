//
//  StepsModel.h
//  Steps
//
//  Created by Garenge on 2022/10/30.
//

#import <Foundation/Foundation.h>
#import "OCGumbo+Query.h"
#import "OCGumboElement+query.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, StepsKeywordType) {
    StepsKeywordTypeClass = 0,
    StepsKeywordTypeId = 1,
    StepsKeywordTypeTagName = 2,
};

@interface StepsModel : NSObject

// TODO: 是否依赖于上层步骤 id

@property (nonatomic, strong) NSString *stepId;

@property (nonatomic, strong) NSString *parentStepId;

@property (nonatomic, strong) NSString *topStepId;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *htmlString;
@property (nonatomic, strong) OCGumboElement *gumboElement;

@property (nonatomic, strong) NSString *keyword;

@property (nonatomic, assign) StepsKeywordType keywordType;

// 返回值类型 (返回一个 字符串/字典)
@property (nonatomic, strong) Class returnClass;

@property (nonatomic, strong) id returnObject;

- (void)addSubStep:(StepsModel *)stepModel;
- (NSArray *)getSubSteps;

@property (nonatomic, weak) StepsModel *nextStep;

@end

NS_ASSUME_NONNULL_END
