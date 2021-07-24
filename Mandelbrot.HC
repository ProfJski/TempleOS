//Mandelbrot Set Explorer for TempleOS
//By Eric Jenislawski


//Mouse over a position and press "i" to zoom in, "o" to zoom out
//Keys 1-4 change mapping of iteration values (requires recalc)
//Keys 6-9 change palettes (instant, no recalc)
//Press "m" to double the max iterations
//Press 'p" to toggle printing coords of center, scale and max iterations to screen.


//Converts RGB triplet of values (0-63) to CBGR48 TempleOS color value
CBGR48 RGB2C(U64 red, U64 green, U64 blue) {
   CBGR48 col=0;
   col.r=ClampI64(red,0,63)<<10;
   col.g=ClampI64(green,0,63)<<10;
   col.b=ClampI64(blue,0,63)<<10;
//Print("%X \n",col);
return col;
}

U64 MAP_TYPE=0;
U64 PALETTE_TYPE=0;

U64 ColorMapper(U64 in) {
   if (in==0) return 0;
   switch(MAP_TYPE) {
     case 0:
       return 1+(in%15);
       //break;
     case 1:
       return 1+(in/10)%15;
       //break;
     case 2:
       return 1+Sqrt(in)%15;
       //break;
     case 3:
       return 1+Log10(in)%15;
       //break;    
   }
return 0;
}

U0 PaletteMapper(){
   CBGR48 mypalette[16];
   mypalette[0]=RGB2C(0,0,0); //Keep index 0=BLACK
   U64 i=0;

   switch(PALETTE_TYPE) {
      case 0: // 0 = TempleOS Standard Palette
        GrPaletteSet(&gr_palette_std);
      break;
      case 1: // 1 = TempleOS Grayscale Palette
        GrPaletteSet(&gr_palette_gray);
      break;
    
      // *****************************
      //Define your own palettes below!
      // *****************************
    
      case 2: //Red-blue gradient
        for (i=1;i<16;i++) {
          mypalette[i]=RGB2C(4*(16-i),0,2*i);       
         }
        GrPaletteSet(mypalette);
      break;
      case 3: //Fiery
        for (i=1;i<16;i++) {
          mypalette[i]=RGB2C(ClampU64(8*i+16,0,63),3*i,1*i);    
        }
        GrPaletteSet(mypalette);
      break;
   }

return;
}


U64 IteratePoint(F64 x, F64 y, U64 maxiters)
//Returns iterations
{

  U64 iters=0;
  F64 a=x,b=y;
  F64 temp=x;

  while ( (iters<maxiters)&&((a*a+b*b)<4) ) {
    temp=a;
    a=a*a-b*b+x;
    b=2*temp*b+y;
    iters++;
  }

  if (iters==maxiters) {
     iters=0;
    }

return iters;
}

U0 CalcSet(F64 mx_min, F64 mx_max, F64 my_min, F64 my_max, U64 maxiters, CDC* mycontext) {
   F64 mx=0.0;
   F64 my=0.0;
   F64 scalex=(mx_max-mx_min)/GR_WIDTH;
   F64 scaley=(my_max-my_min)/GR_HEIGHT;
   U64 ival=1;
   I64 x;
   I64 y;      

   for (x=0;x<GR_WIDTH;x++) {
      mx=mx_min+scalex*x;
      for (y=0;y<GR_HEIGHT;y++) {
      my=my_min+scaley*y;

        ival=IteratePoint(mx,my,maxiters);
        //mycontext->color=ival;
        mycontext->color=ColorMapper(ival);
        GrPlot(mycontext,x,y);      
      }
   }

return;
}


U0 Mandlebrot(){
   I64 sx=GR_WIDTH/2;
   I64 sy=GR_HEIGHT/2;
   F64 mx_min=-2.0;
   F64 my_min=-2.0;
   F64 mx_max=2.0;
   F64 my_max=2.0;
   F64 scalex=(mx_max-mx_min)/GR_WIDTH;
   F64 scaley=(my_max-my_min)/GR_HEIGHT;
   U64 maxiters=250;

   F64 mcx=0,mcy=0; //Use to calculate center point when we zoom
   Bool MakingSelection=TRUE;
   Bool TimeToQuit=FALSE;
   Bool WriteDataToScreen=TRUE;
   I64 counter=0;
   I64 sc=0;

   CDC *mycontext=DCAlias;
   WinMax;
   DocClear;

   while ( (!TimeToQuit)&&(counter<50)) {
    CalcSet(mx_min, mx_max, my_min, my_max, maxiters, mycontext);
    if (WriteDataToScreen) {
      mycontext->color=WHITE;
      GrPrint(mycontext,1,1,"X=%n Y=%n Scale=1:%n MaxIter=%d",mcx,mcy,1.0/scalex,maxiters);
    }    


    //This routine follows CharDemo.HC.Z for trapping key presses
    try {
      while(MakingSelection){
        switch(GetKey(&sc)) {
          case 0:
          break;
            case 'i':  //Zoom in at mouse cursor
              MakingSelection=FALSE;
              sx=ms.pos.x;
              sy=ms.pos.y;
              mcx=mx_min+scalex*sx;
              mcy=my_min+scalex*sy;
              scalex=scalex/4.0;
              scaley=scaley/4.0;
              mx_min=mcx-scalex*(GR_WIDTH/2);
              mx_max=mcx+scalex*(GR_WIDTH/2);
              my_min=mcy-scaley*(GR_HEIGHT/2);
              my_max=mcy+scaley*(GR_HEIGHT/2);
              break;
            case 'o':  //Zoom out
              MakingSelection=FALSE;
              sx=ms.pos.x;
              sy=ms.pos.y;
              mcx=mx_min+scalex*sx;
              mcy=my_min+scalex*sy;
              scalex=scalex*4.0;
              scaley=scaley*4.0;
              mx_min=mcx-scalex*(GR_WIDTH/2);
              mx_max=mcx+scalex*(GR_WIDTH/2);
              my_min=mcy-scaley*(GR_HEIGHT/2);
              my_max=mcy+scaley*(GR_HEIGHT/2);
              break;
            case 'm': //Increase iterations x2
              MakingSelection=FALSE; //Setting this flag causes redraw
              maxiters*=2;
              break;
            case '1':
              MAP_TYPE=0;
              MakingSelection=FALSE;
              break;
            case '2':
              MAP_TYPE=1;
              MakingSelection=FALSE;              
              break;
            case '3':
              MAP_TYPE=2;
              MakingSelection=FALSE;
              break;
            case '4':
              MAP_TYPE=3;
              MakingSelection=FALSE;
            case '6':
              PALETTE_TYPE=0;
              PaletteMapper;
              break;
            case '7':
              PALETTE_TYPE=1;
              PaletteMapper;
              break;
            case '8':
              PALETTE_TYPE=2;
              PaletteMapper;
              break;
            case '9':
              PALETTE_TYPE=3;
              PaletteMapper;
              break;
            case 'P':
              WriteDataToScreen=!WriteDataToScreen;
              break;
            case CH_SHIFT_ESC:
            case CH_ESC:
               TimeToQuit=TRUE;
               goto sq_done;
         }
       }
     sq_done:
    } catch
      PutExcept;

   counter++;
   MakingSelection=TRUE;
   }

   DCFill;
   DocClear;
   DCDel(mycontext);
   PressAKey;
   DCFill;
}

Mandelbrot;
