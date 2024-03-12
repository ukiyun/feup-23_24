#include <lcom/lcf.h>
#include <lcom/timer.h>

#include <stdint.h>

#include "i8254.h"

int (timer_set_frequency)(uint8_t timer, uint32_t freq) {
    if (freq > TIMER_FREQ){ // testing the given frequency value
        return 1;
    }

    uint8_t controlWord;
    if(timer_get_conf(timer, &controlWord)!=0){ // save the timer's current configuration
        return 1;
    }

    // do not change 4 least significant bits, i.e, controlWord & 0x0f or lsb followed by msb
    controlWord = (controlWord & 0x0f) | TIMER_LSB_MSB;

    // load timers regs with value of the divisor to generate the freq corresponding to the desired rate
    


    return 0;
}

int (timer_subscribe_int)(uint8_t *bit_no) {
    /* To be implemented by the students */
  printf("%s is not yet implemented!\n", __func__);

  return 1;
}

int (timer_unsubscribe_int)() {
  /* To be implemented by the students */
  printf("%s is not yet implemented!\n", __func__);

  return 1;
}

void (timer_int_handler)() {
  /* To be implemented by the students */
  printf("%s is not yet implemented!\n", __func__);
}

int (timer_get_conf)(uint8_t timer, uint8_t *st) {
    if (st == NULL || timer > 2){
        return 1; // st pointer must be valid, timer can not be <0 or >2
    }

    // implementation of read back command
    uint8_t readBackCommand = (TIMER_RB_COUNT_ | TIMER_RB_CMD | TIMER_RB_SEL(timer)); // ??

    // checking if it is possible to send readBackCommand to control port
    if (sys_outb(TIMER_CTRL, readBackCommand) != 0){
        return 1;
    }

    if (util_sys_inb(TIMER_0 + timer, st)){
        return 1;
    }

    return 0;
}

int (timer_display_conf)(uint8_t timer, uint8_t st,
                        enum timer_status_field field) {

    union timer_status_field_val config;

    switch (field) {
        case (tsf_all):
            config.byte = st;
            break;

        case (tsf_initial):
            // initialization mode = bit 4,5, right shift makes bits 4,5 the last ones
            st = ((st>>4) & 0x03); // makes all bits 0 except the last 2, which maintains the previous values

            // functions
            if(st == 1){config.in_mode = LSB_only;}
            else if (st == 2){config.in_mode = MSB_only;}
            else if (st == 3){config.in_mode = MSB_after_LSB;}
            else {config.in_mode = INVAL_val;}
            break;

        case (tsf_mode):
            // operating mode = bit 1,2,3, right shift makes 1,2,3 bits the last ones (excludes bit 0)
            st = ((st>>1) & 0x07); // makes all bits 0 except the last 3, which maintains the previous values

            // only if the bits value = 6 or 7, the operating mode is different, otherwise the bits value will be the operating mode
            if (st == 6){config.count_mode = 2;}
            else if(st == 7){config.count_mode = 3;}
            else {config.count_mode = st;}
            break;

        case (tsf_base):
            // counting base = bit 0
            st = st & TIMER_BCD; // makes all bits 0 except the last bit, that maintains its value

            // bcd = 1 if bcd, 0 otherwise
            config.bcd = st;
            break;

        default:
            return 1;
    }

    if (timer_print_config(timer, field, config)!= 0){
        return 1;
    }
    return 0;
}
