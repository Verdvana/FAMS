/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include "system.h"                   //系统头文件
#include "altera_avalon_pio_regs.h"   //PIO寄存器头文件
#include "alt_types.h"                //数据类型头文件


unsigned short end_o;


/*
//----高度-----
alt_u32 adc_T,adc_P;
alt_u16 dig_T1,dig_T2,dig_T3,dig_P1,dig_P2,dig_P3,dig_P4,dig_P5,dig_P6,dig_P7,dig_P8,dig_P9;
alt_u16 var1,var2,p,T,t_fine;
*/

//----心率----
#define MAX_BRIGHTNESS 255


alt_32  n_ir_buffer_length = 100;    //data length
alt_u32 aun_ir_buffer[100]; //IR LED sensor data
alt_u32 aun_red_buffer[100];    //Red LED sensor data
alt_32 n_sp02; //SPO2 value
alt_8 ch_spo2_valid;   //indicator to show if the SP02 calculation is valid
alt_32 n_heart_rate;   //heart rate value
alt_8  ch_hr_valid;    //indicator to show if the heart rate calculation is valid
alt_u8 uch_dummy;

#define FS 20
#define BUFFER_SIZE  (FS* 5)
#define HR_FIFO_SIZE 7
#define MA4_SIZE  4 // DO NOT CHANGE
#define HAMMING_SIZE  5// DO NOT CHANGE
#define min(x,y) ((x) < (y) ? (x) : (y))

const alt_u16 auw_hamm[31]; //Hamm=  long16(512* hamming(5)');
//uch_spo2_table is computed as  -45.060*ratioAverage* ratioAverage + 30.354 *ratioAverage + 94.845 ;

const alt_u16 auw_hamm[31]={ 41,    276,    512,    276,     41 }; //Hamm=  long16(512* hamming(5)');
//uch_spo2_table is computed as  -45.060*ratioAverage* ratioAverage + 30.354 *ratioAverage + 94.845 ;

const alt_u8 uch_spo2_table[184]={ 95, 95, 95, 96, 96, 96, 97, 97, 97, 97, 97, 98, 98, 98, 98, 98, 99, 99, 99, 99,
                            99, 99, 99, 99, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,
                            100, 100, 100, 100, 99, 99, 99, 99, 99, 99, 99, 99, 98, 98, 98, 98, 98, 98, 97, 97,
                            97, 97, 96, 96, 96, 96, 95, 95, 95, 94, 94, 94, 93, 93, 93, 92, 92, 92, 91, 91,
                            90, 90, 89, 89, 89, 88, 88, 87, 87, 86, 86, 85, 85, 84, 84, 83, 82, 82, 81, 81,
                            80, 80, 79, 78, 78, 77, 76, 76, 75, 74, 74, 73, 72, 72, 71, 70, 69, 69, 68, 67,
                            66, 66, 65, 64, 63, 62, 62, 61, 60, 59, 58, 57, 56, 56, 55, 54, 53, 52, 51, 50,
                            49, 48, 47, 46, 45, 44, 43, 42, 41, 40, 39, 38, 37, 36, 35, 34, 33, 31, 30, 29,
                            28, 27, 26, 25, 23, 22, 21, 20, 19, 17, 16, 15, 14, 12, 11, 10, 9, 7, 6, 5,
                            3, 2, 1 } ;

static  alt_32 an_dx[ BUFFER_SIZE-MA4_SIZE]; // delta
static  alt_32 an_x[ BUFFER_SIZE]; //ir
static  alt_32 an_y[ BUFFER_SIZE]; //red


void maxim_heart_rate_and_oxygen_saturation(alt_u32 *pun_ir_buffer ,  alt_32 n_ir_buffer_length, alt_u32 *pun_red_buffer ,   alt_32 *pn_spo2, alt_8 *pch_spo2_valid ,  alt_32 *pn_heart_rate , alt_8  *pch_hr_valid);
void maxim_find_peaks( alt_32 *pn_locs, alt_32 *pn_npks,  alt_32 *pn_x, alt_32 n_size, alt_32 n_min_height, alt_32 n_min_distance, alt_32 n_max_num );
void maxim_peaks_above_min_height( alt_32 *pn_locs, alt_32 *pn_npks,  alt_32 *pn_x, alt_32 n_size, alt_32 n_min_height );
void maxim_remove_close_peaks( alt_32 *pn_locs, alt_32 *pn_npks,   alt_32  *pn_x, alt_32 n_min_distance );
void maxim_sort_ascend( alt_32 *pn_x, alt_32 n_size );
void maxim_sort_indices_descend(  alt_32  *pn_x, alt_32 *pn_indx, alt_32 n_size);


int main()
{
  end_o=0;
  int m=0;

  alt_u32 un_min, un_max, un_prev_data;
  alt_32 n_brightness;
  float f_temp;

  while(1)
  {
	  end_o=IORD_ALTERA_AVALON_PIO_DATA(END_O_BASE);

	  if(end_o)
	  {
/*
		  //-------高度数据处理--------
		  dig_T1 = IORD_ALTERA_AVALON_PIO_DATA(DIG_T1_BASE);
		  dig_T2 = IORD_ALTERA_AVALON_PIO_DATA(DIG_T2_BASE);
		  dig_T3 = IORD_ALTERA_AVALON_PIO_DATA(DIG_T3_BASE);
		  dig_P1 = IORD_ALTERA_AVALON_PIO_DATA(DIG_P1_BASE);
		  dig_P2 = IORD_ALTERA_AVALON_PIO_DATA(DIG_P2_BASE);
		  dig_P3 = IORD_ALTERA_AVALON_PIO_DATA(DIG_P3_BASE);
		  dig_P4 = IORD_ALTERA_AVALON_PIO_DATA(DIG_P4_BASE);
		  dig_P5 = IORD_ALTERA_AVALON_PIO_DATA(DIG_P5_BASE);
		  dig_P6 = IORD_ALTERA_AVALON_PIO_DATA(DIG_P6_BASE);
		  dig_P7 = IORD_ALTERA_AVALON_PIO_DATA(DIG_P7_BASE);
		  dig_P8 = IORD_ALTERA_AVALON_PIO_DATA(DIG_P8_BASE);
		  dig_P9 = IORD_ALTERA_AVALON_PIO_DATA(DIG_P9_BASE);
		  adc_T  = IORD_ALTERA_AVALON_PIO_DATA(ADC_T_BASE);
		  adc_P  = IORD_ALTERA_AVALON_PIO_DATA(ADC_P_BASE);

		  var1 = ((adc_T)/16384-(dig_T1)/1024)*(dig_T2);
		  var2 = (((adc_T)/131072-(dig_T1)/8192)*((adc_T)
		                /131072-(dig_T1)/8192))*(dig_T3);

		  t_fine = (alt_u16)(var1+var2);

		  T = (var1+var2)/5120;

		  var1 = (t_fine/2)-64000;
		  var2 = var1*var1*(dig_P6)/32768;
		  var2 = var2 +var1*(dig_P5)*2;
		  var2 = (var2/4)+((dig_P4)*65536);
		  var1 = ((dig_P3)*var1*var1/524288.0+(dig_P2)*var1)/524288;
		  var1 = (1+var1/32768)*(dig_P1);
		  p = 1048576-adc_P;
		  p = (p-(var2/4096))*6250.0/var1;
		  var1 = (dig_P9)*p*p/2147483648;
		  var2 = p*(dig_P8)/32768;
		  p = p+(var1+var2+(dig_P7))/16;

		  printf("%d\r\n",p);
*/
		  //------心率-----



		  for(m=0;m<100;m++)
		  {

			  aun_red_buffer[m] = IORD_ALTERA_AVALON_PIO_DATA(MAX30102_0_BASE);
			  aun_ir_buffer[m]  = IORD_ALTERA_AVALON_PIO_DATA(MAX30102_1_BASE);

			  aun_red_buffer[m] = aun_red_buffer[m]&0x03FFFF;
			  aun_ir_buffer[m] = aun_ir_buffer[m]&0x03FFFF;


			  //printf("aun_red_buffer=%lx\r\n",aun_red_buffer[m]);
			  //printf("aun_ir_buffer=%lx\r\n",aun_ir_buffer[m]);

		      if(un_min>aun_red_buffer[m])
		    	  un_min=aun_red_buffer[m];    //update signal min
		      if(un_max<aun_red_buffer[m])
		    	  un_max=aun_red_buffer[m];    //update signal max

		  }
			  maxim_heart_rate_and_oxygen_saturation(aun_ir_buffer, n_ir_buffer_length, aun_red_buffer, &n_sp02, &ch_spo2_valid, &n_heart_rate, &ch_hr_valid);



			  			  //printf("HR=%d, ", n_heart_rate);
			  			  //printf("HRvalid=%i, \r\n", ch_hr_valid);

			  			  printf("SpO2=%ld, ", n_sp02);
			  			  printf("SPO2Valid=%d\r\n", ch_spo2_valid);





	  }


  }

  return 0;
}

void maxim_heart_rate_and_oxygen_saturation(alt_u32 *pun_ir_buffer ,  alt_32 n_ir_buffer_length, alt_u32 *pun_red_buffer ,   alt_32 *pn_spo2, alt_8 *pch_spo2_valid ,  alt_32 *pn_heart_rate , alt_8  *pch_hr_valid)

{
	alt_u32 un_ir_mean ,un_only_once ;
	alt_32  k ,n_i_ratio_count;
	alt_32  i, s, m, n_exact_ir_valley_locs_count ,n_middle_idx;
	alt_32  n_th1, n_npks,n_c_min;
	alt_32  an_ir_valley_locs[15] ;
	alt_32  an_exact_ir_valley_locs[15] ;
	alt_32  an_dx_peak_locs[15] ;
	alt_32  n_peak_interval_sum;

	alt_32  n_y_ac, n_x_ac;
	alt_32  n_spo2_calc;
	alt_32  n_y_dc_max, n_x_dc_max;
	alt_32  n_y_dc_max_idx, n_x_dc_max_idx;
	alt_32  an_ratio[5],n_ratio_average;
	alt_32  n_nume,  n_denom ;
    // remove DC of ir signal
    un_ir_mean =0;
    for (k=0 ; k<n_ir_buffer_length ; k++ ) un_ir_mean += pun_ir_buffer[k] ;
    un_ir_mean =un_ir_mean/n_ir_buffer_length ;
    for (k=0 ; k<n_ir_buffer_length ; k++ )  an_x[k] =  pun_ir_buffer[k] - un_ir_mean ;

    // 4 pt Moving Average
    for(k=0; k< BUFFER_SIZE-MA4_SIZE; k++){
        n_denom= ( an_x[k]+an_x[k+1]+ an_x[k+2]+ an_x[k+3]);
        an_x[k]=  n_denom/(alt_32)4;
    }

    // get difference of smoothed IR signal

    for( k=0; k<BUFFER_SIZE-MA4_SIZE-1;  k++)
        an_dx[k]= (an_x[k+1]- an_x[k]);

    // 2-pt Moving Average to an_dx
    for(k=0; k< BUFFER_SIZE-MA4_SIZE-2; k++){
        an_dx[k] =  ( an_dx[k]+an_dx[k+1])/2 ;
    }

    // hamming window
    // flip wave form so that we can detect valley with peak detector
    for ( i=0 ; i<BUFFER_SIZE-HAMMING_SIZE-MA4_SIZE-2 ;i++){
        s= 0;
        for( k=i; k<i+ HAMMING_SIZE ;k++){
            s -= an_dx[k] *auw_hamm[k-i] ;
                     }
        an_dx[i]= s/ (alt_32)1146; // divide by sum of auw_hamm
    }


    n_th1=0; // threshold calculation
    for ( k=0 ; k<BUFFER_SIZE-HAMMING_SIZE ;k++){
        n_th1 += ((an_dx[k]>0)? an_dx[k] : ((alt_32)0-an_dx[k])) ;
    }
    n_th1= n_th1/ ( BUFFER_SIZE-HAMMING_SIZE);
    // peak location is acutally index for sharpest location of raw signal since we flipped the signal
    maxim_find_peaks( an_dx_peak_locs, &n_npks, an_dx, BUFFER_SIZE-HAMMING_SIZE, n_th1, 8, 5 );//peak_height, peak_distance, max_num_peaks

    n_peak_interval_sum =0;
    if (n_npks>=2){
        for (k=1; k<n_npks; k++)
            n_peak_interval_sum += (an_dx_peak_locs[k]-an_dx_peak_locs[k -1]);
        n_peak_interval_sum=n_peak_interval_sum/(n_npks-1);
        *pn_heart_rate=(alt_32)(6000/n_peak_interval_sum);// beats per minutes
        *pch_hr_valid  = 1;
    }
    else  {
        *pn_heart_rate = -999;
        *pch_hr_valid  = 0;
    }

    for ( k=0 ; k<n_npks ;k++)
        an_ir_valley_locs[k]=an_dx_peak_locs[k]+HAMMING_SIZE/2;


    // raw value : RED(=y) and IR(=X)
    // we need to assess DC and AC value of ir and red PPG.
    for (k=0 ; k<n_ir_buffer_length ; k++ )  {
        an_x[k] =  pun_ir_buffer[k] ;
        an_y[k] =  pun_red_buffer[k] ;
    }

    // find precise min near an_ir_valley_locs
    n_exact_ir_valley_locs_count =0;
    for(k=0 ; k<n_npks ;k++){
        un_only_once =1;
        m=an_ir_valley_locs[k];
        n_c_min= 16777216;//2^24;
        if (m+5 <  BUFFER_SIZE-HAMMING_SIZE  && m-5 >0){
            for(i= m-5;i<m+5; i++)
                if (an_x[i]<n_c_min){
                    if (un_only_once >0){
                       un_only_once =0;
                   }
                   n_c_min= an_x[i] ;
                   an_exact_ir_valley_locs[k]=i;
                }
            if (un_only_once ==0)
                n_exact_ir_valley_locs_count ++ ;
        }
    }
    if (n_exact_ir_valley_locs_count <2 ){
       *pn_spo2 =  -999 ; // do not use SPO2 since signal ratio is out of range
       *pch_spo2_valid  = 0;
       return;
    }
    // 4 pt MA
    for(k=0; k< BUFFER_SIZE-MA4_SIZE; k++){
        an_x[k]=( an_x[k]+an_x[k+1]+ an_x[k+2]+ an_x[k+3])/(alt_32)4;
        an_y[k]=( an_y[k]+an_y[k+1]+ an_y[k+2]+ an_y[k+3])/(alt_32)4;
    }

    //using an_exact_ir_valley_locs , find ir-red DC andir-red AC for SPO2 calibration ratio
    //finding AC/DC maximum of raw ir * red between two valley locations
    n_ratio_average =0;
    n_i_ratio_count =0;

    for(k=0; k< 5; k++) an_ratio[k]=0;
    for (k=0; k< n_exact_ir_valley_locs_count; k++){
        if (an_exact_ir_valley_locs[k] > BUFFER_SIZE ){
            *pn_spo2 =  -999 ; // do not use SPO2 since valley loc is out of range
            *pch_spo2_valid  = 0;
            return;
        }
    }
    // find max between two valley locations
    // and use ratio betwen AC compoent of Ir & Red and DC compoent of Ir & Red for SPO2

    for (k=0; k< n_exact_ir_valley_locs_count-1; k++){
        n_y_dc_max= -16777216 ;
        n_x_dc_max= - 16777216;
        if (an_exact_ir_valley_locs[k+1]-an_exact_ir_valley_locs[k] >10){
            for (i=an_exact_ir_valley_locs[k]; i< an_exact_ir_valley_locs[k+1]; i++){
                if (an_x[i]> n_x_dc_max) {n_x_dc_max =an_x[i];n_x_dc_max_idx =i; }
                if (an_y[i]> n_y_dc_max) {n_y_dc_max =an_y[i];n_y_dc_max_idx=i;}
            }
            n_y_ac= (an_y[an_exact_ir_valley_locs[k+1]] - an_y[an_exact_ir_valley_locs[k] ] )*(n_y_dc_max_idx -an_exact_ir_valley_locs[k]); //red
            n_y_ac=  an_y[an_exact_ir_valley_locs[k]] + n_y_ac/ (an_exact_ir_valley_locs[k+1] - an_exact_ir_valley_locs[k])  ;


            n_y_ac=  an_y[n_y_dc_max_idx] - n_y_ac;    // subracting linear DC compoenents from raw
            n_x_ac= (an_x[an_exact_ir_valley_locs[k+1]] - an_x[an_exact_ir_valley_locs[k] ] )*(n_x_dc_max_idx -an_exact_ir_valley_locs[k]); // ir
            n_x_ac=  an_x[an_exact_ir_valley_locs[k]] + n_x_ac/ (an_exact_ir_valley_locs[k+1] - an_exact_ir_valley_locs[k]);
            n_x_ac=  an_x[n_y_dc_max_idx] - n_x_ac;      // subracting linear DC compoenents from raw
            n_nume=( n_y_ac *n_x_dc_max)>>7 ; //prepare X100 to preserve floating value
            n_denom= ( n_x_ac *n_y_dc_max)>>7;
            if (n_denom>0  && n_i_ratio_count <5 &&  n_nume != 0)
            {
                an_ratio[n_i_ratio_count]= (n_nume*100)/n_denom ; //formular is ( n_y_ac *n_x_dc_max) / ( n_x_ac *n_y_dc_max) ;
                n_i_ratio_count++;
            }
        }
    }

    maxim_sort_ascend(an_ratio, n_i_ratio_count);
    n_middle_idx= n_i_ratio_count/2;

    if (n_middle_idx >1)
        n_ratio_average =( an_ratio[n_middle_idx-1] +an_ratio[n_middle_idx])/2; // use median
    else
        n_ratio_average = an_ratio[n_middle_idx ];

    if( n_ratio_average>2 && n_ratio_average <184){
        n_spo2_calc= uch_spo2_table[n_ratio_average] ;
        *pn_spo2 = n_spo2_calc ;
        *pch_spo2_valid  = 1;//  float_SPO2 =  -45.060*n_ratio_average* n_ratio_average/10000 + 30.354 *n_ratio_average/100 + 94.845 ;  // for comparison with table
    }
    else{
        *pn_spo2 =  -999 ; // do not use SPO2 since signal ratio is out of range
        *pch_spo2_valid  = 0;
    }
}



void maxim_find_peaks(alt_32 *pn_locs, alt_32 *pn_npks, alt_32 *pn_x, alt_32 n_size, alt_32 n_min_height, alt_32 n_min_distance, alt_32 n_max_num)

{
    maxim_peaks_above_min_height( pn_locs, pn_npks, pn_x, n_size, n_min_height );
    maxim_remove_close_peaks( pn_locs, pn_npks, pn_x, n_min_distance );
    *pn_npks = min( *pn_npks, n_max_num );
}

void maxim_peaks_above_min_height(alt_32 *pn_locs, alt_32 *pn_npks, alt_32  *pn_x, alt_32 n_size, alt_32 n_min_height)

{
	alt_32 i = 1, n_width;
    *pn_npks = 0;

    while (i < n_size-1){
        if (pn_x[i] > n_min_height && pn_x[i] > pn_x[i-1]){            // find left edge of potential peaks
            n_width = 1;
            while (i+n_width < n_size && pn_x[i] == pn_x[i+n_width])    // find flat peaks
                n_width++;
            if (pn_x[i] > pn_x[i+n_width] && (*pn_npks) < 15 ){                            // find right edge of peaks
                pn_locs[(*pn_npks)++] = i;
                // for flat peaks, peak location is left edge
                i += n_width+1;
            }
            else
                i += n_width;
        }
        else
            i++;
    }
}

void maxim_remove_close_peaks(alt_32 *pn_locs, alt_32 *pn_npks, alt_32 *pn_x, alt_32 n_min_distance)
{
    alt_32 i, j, n_old_npks, n_dist;

    /* Order peaks from large to small */
    maxim_sort_indices_descend( pn_x, pn_locs, *pn_npks );

    for ( i = -1; i < *pn_npks; i++ ){
        n_old_npks = *pn_npks;
        *pn_npks = i+1;
        for ( j = i+1; j < n_old_npks; j++ ){
            n_dist =  pn_locs[j] - ( i == -1 ? -1 : pn_locs[i] ); // lag-zero peak of autocorr is at index -1
            if ( n_dist > n_min_distance || n_dist < -n_min_distance )
                pn_locs[(*pn_npks)++] = pn_locs[j];
        }
    }

    // Resort indices longo ascending order
    maxim_sort_ascend( pn_locs, *pn_npks );
}

void maxim_sort_ascend(alt_32 *pn_x,alt_32 n_size)

{
	alt_32 i, j, n_temp;
    for (i = 1; i < n_size; i++) {
        n_temp = pn_x[i];
        for (j = i; j > 0 && n_temp < pn_x[j-1]; j--)
            pn_x[j] = pn_x[j-1];
        pn_x[j] = n_temp;
    }
}

void maxim_sort_indices_descend(alt_32 *pn_x, alt_32 *pn_indx, alt_32 n_size)

{
	alt_32 i, j, n_temp;
    for (i = 1; i < n_size; i++) {
        n_temp = pn_indx[i];
        for (j = i; j > 0 && pn_x[n_temp] > pn_x[pn_indx[j-1]]; j--)
            pn_indx[j] = pn_indx[j-1];
        pn_indx[j] = n_temp;
    }
}
