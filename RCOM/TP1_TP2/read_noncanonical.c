// Read from serial port in non-canonical mode
//
// Modified by: Eduardo Nuno Almeida [enalmeida@fe.up.pt]

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <termios.h>
#include <unistd.h>

// Baudrate settings are defined in <asm/termbits.h>, which is
// included by <termios.h>
#define BAUDRATE B38400
#define _POSIX_SOURCE 1 // POSIX compliant source

#define FALSE 0
#define TRUE 1

#define BUF_SIZE 256

// UA FRAME
#define FLAG 0x7E
#define ADDRESS 0x01
#define CONTROL 0x07
#define BCC1 0x01^0x07

// STATE MACHINE
#define OTHER_RCV 0
#define FLAG_RCV 1
#define A_RCV 2
#define C_RCV 3
#define BCC_OK 4
#define STOP 5


volatile int STOP = FALSE;

int main(int argc, char *argv[])
{
    // Program usage: Uses either COM1 or COM2
    const char *serialPortName = argv[1];

    if (argc < 2)
    {
        printf("Incorrect program usage\n"
               "Usage: %s <SerialPort>\n"
               "Example: %s /dev/ttyS1\n",
               argv[0],
               argv[0]);
        exit(1);
    }

    // Open serial port device for reading and writing and not as controlling tty
    // because we don't want to get killed if linenoise sends CTRL-C.
    int fd = open(serialPortName, O_RDWR | O_NOCTTY);
    if (fd < 0)
    {
        perror(serialPortName);
        exit(-1);
    }

    struct termios oldtio;
    struct termios newtio;

    // Save current port settings
    if (tcgetattr(fd, &oldtio) == -1)
    {
        perror("tcgetattr");
        exit(-1);
    }

    // Clear struct for new port settings
    memset(&newtio, 0, sizeof(newtio));

    newtio.c_cflag = BAUDRATE | CS8 | CLOCAL | CREAD;
    newtio.c_iflag = IGNPAR;
    newtio.c_oflag = 0;

    // Set input mode (non-canonical, no echo,...)
    newtio.c_lflag = 0;
    newtio.c_cc[VTIME] = 0; // Inter-character timer unused
    newtio.c_cc[VMIN] = 5;  // Blocking read until 5 chars received

    // VTIME e VMIN should be changed in order to protect with a
    // timeout the reception of the following character(s)

    // Now clean the line and activate the settings for the port
    // tcflush() discards data written to the object referred to
    // by fd but not transmitted, or data received but not read,
    // depending on the value of queue_selector:
    //   TCIFLUSH - flushes data received but not read.
    tcflush(fd, TCIOFLUSH);

    // Set new port settings
    if (tcsetattr(fd, TCSANOW, &newtio) == -1)
    {
        perror("tcsetattr");
        exit(-1);
    }

    printf("New termios structure set\n");

    // Loop for input
    unsigned char buf[BUF_SIZE + 1] = {0}; // +1: Save space for the final '\0' char
    int state = START; //machine state

    while (state != STOP)
    {
        // Returns after 5 chars have been input
        int bytes = read(fd, buf, BUF_SIZE);
        if(!bytes) continue;
        buf[bytes] = '\0'; // Set end of string to '\0', so we can printf

        switch (state) {
            case OTHER_RCV:
                printf("var=0x%2X\n",buf[0]);
                if (buf[0] == FLAG){
                    state = FLAG_RCV;
                    printf("flag read, passing to state 1\n");
                }
                else {
                    state = OTHER_RCV;
                    printf("flag not read, passing to state 0\n");
                }
                break;
            case FLAG_RCV:
                printf("var=0x%2X\n", buf[0]);
                if (buf[0] == FLAG) {
                    state = FLAG_RCV;
                    printf("flag read, passing to state 1\n");
                }
                else if (buf[0] == 0x03) {
                    state = A_RCV;
                    printf("writer address read, passing to state 2\n");
                }
                else {
                    state = OTHER_RCV;
                    printf("read unsuccessful, passing to state 0\n");
                }
                break;
            case A_RCV:
                printf("var=0x%2X\n", buf[0]);
                if (buf[0] == FLAG) {
                    state = FLAG_RCV;
                    printf("flag read, passing to state 1\n");
                }
                else if (buf[0] == 0x03) {
                    state = C_RCV;
                    printf("writer control read, passing to state 3\n");
                }
                else {
                    state = OTHER_RCV;
                    printf("read unsuccessfull, passing to state 0\n");
                }
				break;
			case C_RCV:
                printf("var=0x%2X\n", buf[0]);
                if (buf[0] == FLAG) {
                    state = FLAG_RCV;
                    printf("flag read, passing to state 1\n");
                }
                else if (buf[0] == 0x03^0x03) {
                    state = BCC_OK;
                    printf("read bcc, passing to state 4\n");
                }
                else {
                    state = OTHER_RCV;
                    printf("read unsuccessfull, passing to state 0\n");
                }
            case 4:
                printf("var=0x%2X\n", buf[0]);
                if (buf[0] == FLAG) {
                    state = STOP;
                    printf("Success!");
                }
                else {
                    state = OTHER_RCV;
                    printf("read unsuccessfull, passing to state 0\n");
                }
				break;
        }

    }

    // The while() cycle should be changed in order to respect the specifications
    // of the protocol indicated in the Lab guide
    unsigned char send_buf[BUF_SIZE] = {0};
    send_buf[0] = FLAG;
    send_buf[1] = ADDRESS;
    send_buf[2] = CONTROL;
    send_buf[3] = BCC1;
    send_buf[4] = FLAG;

    // In non-canonical mode, '\n' does not end the writing.
    // Test this condition by placing a '\n' in the middle of the buffer.
    // The whole buffer must be sent even with the '\n'.

    int bytes = write(fd, send_buf, BUF_SIZE);
    printf("%d bytes written\n", bytes);


    // Restore the old port settings
    if (tcsetattr(fd, TCSANOW, &oldtio) == -1)
    {
        perror("tcsetattr");
        exit(-1);
    }

    close(fd);

    return 0;
}
