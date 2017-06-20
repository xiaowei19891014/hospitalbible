//
//  DiseaseQuestionModel.h
//  HospitalBible
//
//  Created by me on 17/6/4.
//  Copyright © 2017年 com.hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiseaseQuestionChoiceModel : NSObject
@property(nonatomic,copy) NSString *fIndex;
@property(nonatomic,copy) NSString *fContext;
@property(nonatomic,copy) NSString *fWeight;
@end

@interface DiseaseQuestionModel : NSObject
@property(nonatomic,copy) NSString *choices;
@property(nonatomic,copy) NSString *classid;
@property(nonatomic,copy) NSString *effective;
@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *img;
@property(nonatomic,copy) NSString *qindex;
@property(nonatomic,copy) NSString *qtype;
@property(nonatomic,copy) NSString *sort;
@property(nonatomic,copy) NSString *target;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong)NSMutableArray *choiceList;

@end

@interface DiseaseQuestionClass : NSObject
@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *pname;
@property(nonatomic,copy) NSString *pdescribe;
@property(nonatomic,copy) NSString *imgurl;
@property(nonatomic,strong)NSMutableArray *diseasequestionArr;
@end
