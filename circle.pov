//
#version 3.7;

#include "colors.inc"
#include "skies.inc"
#include "glass.inc"


global_settings {
	assumed_gamma 2.2
	max_trace_level 9
}



camera {
	location <0,3,-20>
	look_at <0,0,0>
	angle 120
}

light_source { <1, 10, -10> color rgb 1}

sky_sphere {
    S_Cloud4
}


#declare moverange = 20;
#declare num = 16;
#declare cn = int(log(num)/log(2))+1;

#declare c = array[8]{
	Red,Green,Blue,Yellow,Cyan,Magenta,Aquamarine,Coral}

#if (1 = 1)
	#declare tick = clock;
	#declare limitN = 8;

#else
	#declare cycle = num*2-1;

	
	#declare tickunit = 1/(cycle);
	#declare tick = clock*cycle - int(clock*cycle);
	
	#declare limitN = 1+int(clock/tickunit);
	#if (clock >.5)
		#declare limitN = num*2-limitN;
	#end
	
	#warning concat("info :"  ,str(cycle,2,0) ,":[" str(limitN,2,0), "/",str(num,2,0),"] " 
					, "  ", str(clock/tickunit,2,1)
					,": (" , str(tick,2,2) , "<=", str(clock,2,2) , ") "
					,"cn:", str(cn , 2,0) , " tickunit:", str(tickunit,2,2) )
#end

#if (clock = 1.1)
#else

//blob{
//	threshold 2
	#for (i,0,limitN-1)
		#declare k = (i/ limitN  ) *pi;
		#declare ct =cos((tick + i/num)*2*pi)*moverange;
		#declare ci = mod(i,8);
		
		sphere {<ct*cos(k),ct*sin(k),0> 2.2
		//sphere {<ct,ct,0> 5 8
			pigment {Clear}
			finish { F_Glass1 }
			interior {I_Glass1 fade_color color c[ci]}
		}
	#end
	
	
	sphere {<cos(tick*2*pi)*moverange,sin(tick*2*pi)*moverange,0> 2.2
		//sphere {<ct,ct,0> 5 8
		pigment {Clear}
		finish { F_Glass1 }
		interior {I_Glass1 fade_color color c[0]}
	}

//}
#end
