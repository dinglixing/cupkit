#include "app.h"

static char app_cmd_buf[APP_CMD_BUF_SIZE];
static cupkee_device_t *tty;

static void app_systick_proc(void)
{
    /* add user code here */
}

static int app_event_handle(event_info_t *e)
{
    switch(e->type) {
    case EVENT_SYSTICK: app_systick_proc(); break;
    default: break;
    }
    return 0;
}

static int app_cmd_hello(int ac, char **av)
{
    (void) ac;
    (void) av;

    console_log("hello cupkee!\r\n");

    return 0;
}

static cupkee_command_entry_t app_cmd_entrys[] = {
    {"hello", app_cmd_hello}
};

static void app_pin_mapping(void)
{
    /**********************************************************
     * Map pin of debug LED
     *********************************************************/
    //hw_led_map(0, 0);

    /**********************************************************
     * Map pin of GPIOs
     *********************************************************/
    //hw_pin_map(0, 0, 0); // PIN0(GPIO A0)
    //hw_pin_map(1, 0, 1); // PIN0(GPIO A1)
    // ...
    //hw_pin_map(15, 0, 15); // PIN0(GPIO A15)
}

static void app_console_init(void)
{
#ifdef USE_USB_CONSOLE
    tty = cupkee_device_request("usb-cdc", 0);
#else
    tty = cupkee_device_request("uart", 0);
    tty->config.data.uart.baudrate = 115200;
    tty->config.data.uart.stop_bits = DEVICE_OPT_STOPBITS_1;
    tty->config.data.uart.data_bits = 8;
#endif
    cupkee_device_enable(tty);

    cupkee_command_init(1, app_cmd_entrys, APP_CMD_BUF_SIZE, app_cmd_buf);
    cupkee_history_init();
    cupkee_console_init(tty, cupkee_command_handle);
}

int main(void)
{
    cupkee_init();

    app_pin_mapping();

    app_console_init();

    /**********************************************************
     * User event handle register
     *********************************************************/
    cupkee_event_handle_register(app_event_handle);

    /**********************************************************
     * user device create & setup
     *********************************************************/


    console_log("APP start!\r\n");
    /**********************************************************
     * Let's Go!
     *********************************************************/
    cupkee_loop();

    /**********************************************************
     * Should not go here, make gcc happy!
     *********************************************************/
    return 0;
}

