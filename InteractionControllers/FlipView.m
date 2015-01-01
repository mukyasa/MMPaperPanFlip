//
//  FlipView.m
//  MMPaperPanFlip
//
//  Created by mukesh mandora on 23/12/14.
//  Copyright (c) 2014 madaboutapps. All rights reserved.
//

#import "FlipView.h"

@implementation FlipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    self = [super init];
    if(self){
        _arc=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 260, 130)];
        _arc.image=[UIImage imageNamed:@"arc.jpg"];
        _arc.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_arc];
        
        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(10, 140, 200, 21)];
        title.text=@"Robert Downey.Jr";
        title.font=[UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
        [self addSubview:title];
        
        UILabel *detailTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 200, 50)];
        detailTitle.text=@"Robert Downey.Jr Avenger Teaser";
        detailTitle.numberOfLines=4;
        [self addSubview:detailTitle];
        
        
        _arc.clipsToBounds=YES;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.3f;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.4;
        

//        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"arc.jpg"]];
       
    }
    
    return self;
}

@end
