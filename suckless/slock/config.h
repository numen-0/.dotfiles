static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* Background image path, should be available to the user above */
static const char* background_image = "/home/numen/stuff/pictures/wall/lock.png";

/* Patch: auto-timeout */
/* should [command] be run only once? */
static const int runonce = 0;
/* length of time (seconds) until [command] is executed */
static const int timeoffset = 30;
/* command to be run after [timeoffset] seconds has passed */
static const char *command = "/usr/bin/xset dpms force off";

/* default message */
static const char * message = "";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
// static const char * font_name = "sans-serif:size:pixelsize=24:antialias=true:autohint=true";
static const char * font_name = "Maple Mono NF:size=96";

static const char *res_name  = "slock";  // Resource name
static const char *res_class = "slock";  // Resource class

