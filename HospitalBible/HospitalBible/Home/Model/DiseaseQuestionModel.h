//
//  DiseaseQuestionModel.h
//  HospitalBible
//
//  Created by me on 17/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiseaseQuestionChoiceModel : NSObject
@property(nonatomic,strong) NSString *fIndex;
@property(nonatomic,strong) NSString *fContext;
@property(nonatomic,strong) NSString *fWeight;
@end

@interface DiseaseQuestionModel : NSObject
@property(nonatomic,strong) NSString *qindex;
@property(nonatomic,strong) NSString *img;
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *classid;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *qtype;
@property(nonatomic,strong) NSString *effective;
@property(nonatomic,strong) NSString *sort;
@property(nonatomic,strong) NSArray *choiceList;
@end

@interface DiseaseQuestionClass : NSObject
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *pname;
@property(nonatomic,strong) NSString *pdescribe;
@end
