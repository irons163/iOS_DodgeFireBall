
//
//  Footboard.m
//  DodgeFireBall
//
//  Created by irons on 2015/7/2.
//  Copyright (c) 2015年 irons. All rights reserved.
//

#import "Footboard.h"
#import "BitmapUtil.h"
#import "ToolUtil.h"

static const int NOTOOL =0;
static const int BOMB =1;
static const int CURE =2;
static const int BOMB_EXPLODE =3;

@implementation Footboard{
    BitmapUtil* bitmapUtil;
    SKTexture * bitmap, * bitmap1, * bitmap2, * bitmap3; //繪製圖片與暫存圖片兩張
    float height, width;
    int which; //哪種地板
    int animStep; //記數，為了產生圖片變化
    int toolNum;
    ToolUtil* toolUtil;
    int index;
}

-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

+(Footboard*)FootboardCreateWithX:(float) x y:(float) y w:(float) width h:(float) height{
    Footboard* footboard = [Footboard spriteNodeWithTexture:nil];
    [footboard setFrameX:x y:y w:width h:height];
    return footboard;
}

/**
 * 建構子
 * @param context 呼叫者的context
 * @param x 座標X
 * @param y 座標Y
 * @param height 地板圖片的高
 * @param width 地板圖片的寬
 */
-(void)setFrameX:(float) x y:(float) y w:(float) width h:(float) height{
//    self->x = x;
//    self->y = y;
    self->height = height;
    self->width = width;
    
    toolNum = NOTOOL;
    bitmapUtil = [BitmapUtil sharedInstance];
    
    self.position = CGPointMake(x, y);
    self.size = CGSizeMake(width, height);
    
    which = arc4random_uniform(6); //隨機 0~5，目前每種地板出現機率依樣，可做更動。
    
    [self setWhich:which];
    
    int random = arc4random_uniform(6);
    
			 if(random==1){
                 toolNum=random;
             }else if(random==2){
                 toolNum=random;
             }else{
                 toolNum=0;
             }
    
}


/**
 * 繪圖動作
 * @param canvas 要繪圖的畫布
 * @param dy 圖片Y軸移動距離
 */
//-(void)drawDy:(float) dy {
//    
//    y += dy;
//    self.position = CGPointMake(self.position.x, y);
//    //		Rect rect1 = new Rect(x,y,x+width,y+height);
//    CGRect rect1 = CGRectMake(x,y,width,height);
//    
//    if(which == 1){ //往左地板
//        //圖片有兩張，進行切換，但這裡的方法很笨，應該有更好的方法
//        //			if(animStep<10){
//        //				bitmap = bitmap1;
//        //				animStep++;
//        //			}else if(animStep>=10 && animStep<19){
//        //				bitmap = bitmap2;
//        //				animStep++;
//        //			}else{
//        //				animStep=0;
//        //			}
//        
//        if(animStep%3==0){
//            bitmap = bitmapUtil.footboard_moving_left1_bitmap;
//            animStep++;
//        }else if(animStep%3==1){
//            bitmap = bitmapUtil.footboard_moving_left2_bitmap;
//            animStep++;
//        }else{
//            bitmap = bitmapUtil.footboard_moving_left3_bitmap;
//            animStep=0;
//        }
//        
//    }else if(which == 2){
//        if(animStep%3==0){
//            bitmap = bitmapUtil.footboard_moving_right1_bitmap;
//            animStep++;
//        }else if(animStep%3==1){
//            bitmap = bitmapUtil.footboard_moving_right2_bitmap;
//            animStep++;
//        }else{
//            bitmap = bitmapUtil.footboard_moving_right3_bitmap;
//            animStep=0;
//        }
//    }else if(which == 3){ //不穩定地板
//        if(animStep<10){
//            bitmap = bitmap1; //初始圖片
//        }else if(animStep<20){
//            bitmap = bitmap2; //產生裂痕
//        }else if(animStep<28){
//            bitmap = bitmap3; //產生裂痕
//        }else if(animStep>=30){
//            bitmap=nil; //地板不見
//        }
//    }else if(which == 4){ //朽木地板
//        if(animStep%10==0){
//            bitmap = bitmap1;
//        }else if(animStep%10==1){
//            bitmap = bitmap2;
//        }else if(animStep%10==3){
//            bitmap = bitmap3;
//        }else if(animStep%10==5){
//            animStep=0;
//            bitmap=nil;
//        }
//    }
//    
//    if(bitmap!=nil)
//        self.texture = bitmap;
//}

/**
 * 計算地板甚麼時候不見，只在不穩定和朽木地板的情況下使用。
 */
-(void) setCount{
    if(which==3 || which==4){
        animStep++;}
    
    if(which == 1){ //往左地板
        //圖片有兩張，進行切換，但這裡的方法很笨，應該有更好的方法
        //			if(animStep<10){
        //				bitmap = bitmap1;
        //				animStep++;
        //			}else if(animStep>=10 && animStep<19){
        //				bitmap = bitmap2;
        //				animStep++;
        //			}else{
        //				animStep=0;
        //			}
        
        if(animStep%3==0){
            bitmap = bitmapUtil.footboard_moving_left1_bitmap;
            animStep++;
        }else if(animStep%3==1){
            bitmap = bitmapUtil.footboard_moving_left2_bitmap;
            animStep++;
        }else{
            bitmap = bitmapUtil.footboard_moving_left3_bitmap;
            animStep=0;
        }
        
    }else if(which == 2){
        if(animStep%3==0){
            bitmap = bitmapUtil.footboard_moving_right1_bitmap;
            animStep++;
        }else if(animStep%3==1){
            bitmap = bitmapUtil.footboard_moving_right2_bitmap;
            animStep++;
        }else{
            bitmap = bitmapUtil.footboard_moving_right3_bitmap;
            animStep=0;
        }
    }else if(which == 3){ //不穩定地板
        if(animStep<10){
            bitmap = bitmap1; //初始圖片
        }else if(animStep<20){
            bitmap = bitmap2; //產生裂痕
        }else if(animStep<28){
            bitmap = bitmap3; //產生裂痕
        }else if(animStep>=30){
            bitmap=nil; //地板不見
        }
    }else if(which == 4){ //朽木地板
        if(animStep%10==0){
            bitmap = bitmap1;
        }else if(animStep%10==1){
            bitmap = bitmap2;
        }else if(animStep%10==3){
            bitmap = bitmap3;
        }else if(animStep%10==5){
            animStep=0;
            bitmap=nil;
        }
    }
    
    if(bitmap!=nil)
        self.texture = bitmap;
    else {
        self.texture = nil;
    }
}

-(void) setWhich:(int) witch{
    self->which = witch;
    
    if (which == 0) {  //普通地板
        bitmap = bitmapUtil.footboard_normal_bitmap;
    } else if (which == 1) { //往左地板
        bitmap1 = bitmapUtil.footboard_moving_left1_bitmap;
        bitmap2 = bitmapUtil.footboard_moving_left2_bitmap;
        bitmap3 = bitmapUtil.footboard_moving_left3_bitmap;
        bitmap = bitmap1;
    } else if (which == 2){ //往右地板
        bitmap = bitmapUtil.footboard_moving_right1_bitmap;
    }else if(which == 3){ //不穩定地板
        bitmap1 = bitmapUtil.footboard_unstable1_bitmap;
        bitmap2=bitmapUtil.footboard_unstable2_bitmap;
        bitmap3=bitmapUtil.footboard_unstable3_bitmap;
        bitmap = bitmap1;
    }else if(which==4){ //滑動地板
        //			 bitmap = BitmapUtil.footboard_spring_bitmap;
        bitmap1 = bitmapUtil.footboard_wood_bitmap;
        bitmap2=bitmapUtil.footboard_wood2_bitmap;
        bitmap3=bitmapUtil.footboard_wood3_bitmap;
        bitmap = bitmapUtil.footboard_wood_bitmap;
    }else if(which==5){ //陷阱地板
        bitmap = bitmapUtil.footboard_spiked_bitmap;
    }
    
    self.texture = bitmap;
}

-(void)setToolNum:(int) num{
    toolNum = num;
}

-(int)toolNum{
    //    toolNum = num;
    return toolNum;
}

+(int)NOTOOL{
    return NOTOOL;
}

+(int)BOMB{
    return BOMB;
}

+(int)CURE{
    return CURE;
}

+(int)BOMB_EXPLODE{
    return BOMB_EXPLODE;
}

//-(float)x{
//    return x;
//}
//
//-(float)y{
//    return y;
//}

-(int)which{
    return which;
}

-(SKTexture *)bitmap{
    return bitmap;
}

-(ToolUtil*)tool{
    return toolUtil;
}

-(void)setTool:(ToolUtil*) toolUtil{
    self->toolUtil = toolUtil;
}

-(void)setPosition:(CGPoint)position{
    if(toolUtil!=nil){
        toolUtil.position = CGPointMake(position.x + self.size.width/2 - toolUtil.size.width/2, position.y);
    }
    
    [super setPosition:position];
}

-(void)setIndex:(int)index{
    self->index = index;
}

-(int)getIndex{
    return index;
}

//-(CGPoint)position{
//    return self.position;
//}

@end

