#include <lcom/lcf.h>

#include <stdint.h>

// a bit masking is used for the first 2 functions

int(util_get_LSB)(uint16_t val, uint8_t *lsb) {
    if (lsb == NULL){
        return 1; // lsb pointer must be not null, i.e., needs to be valid
    }

    // since we want the last 8 binary digits, we only need to mask the first 8 (check next function for more explanation)
    *lsb = (val & 0x00FF);
    return 0;
}

int(util_get_MSB)(uint16_t val, uint8_t *msb) {
    if (msb == NULL){
        return 1; // msb pointer must be not null, i.e., needs to be valid
    }

    // moves 8 most Significant bits to end and then with '&' operand, makes sure that the first 8 bits are 0
    // 0x00FF = 0000000011111111, meaning that each bit with '&' 0 will be zero and each bit with '&' 1 will stay the same
    *msb = ((val >> 8) & 0x00FF);

  return 0;
}

int (util_sys_inb)(int port, uint8_t *value) {
    if (value == NULL){
        return 1; // value pointer must be not null, i.e., needs to be valid
    }
    uint32_t var;
    if(sys_inb(port, &var) != 0){
        return 1;
    }; // result is in 32 bits but value is 8 bits
    *value = (uint8_t)var;
    return 0;
}
