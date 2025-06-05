#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>

/* entry point runs when module installed */
static int __init test_driver_init(void)
{
    printk("Hello Linux Driver!\n");
    return 0;
}

static void __exit test_driver_exit(void)
{
    printk("Goodbye Linux Driver!\n");
    return;
}

module_init(test_driver_init);
module_exit(test_driver_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("rej696");
MODULE_DESCRIPTION("Test Kernel Module");
MODULE_VERSION("1.0");
