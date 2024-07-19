/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar    = 1;   /* -b  option; if 0, dmenu appears at bottom     */
static int fuzzy     = 1;   /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
static int centered  = 0;   /* -c option; centers dmenu on screen */
static int min_width = 500; /* minimum width when centered */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Maple Mono NF,Maple Mono NF Medium:size=12"
};
static const char *prompt       = NULL; /* -p  option; prompt to the left of input field */
static const unsigned int alpha = 0xdf; /* Amount of opacity. 0xff is opaque             */
static const char *colors[SchemeLast][2] = {
	/*                        fg         bg       */
	[SchemeNorm]          = { "#eeeeee", "#222222" },
	[SchemeSel]           = { "#eeeeee", "#007755" },
	[SchemeNormHighlight] = { "#28965a", "#222222" },
    [SchemeSelHighlight]  = { "#2ceaa3", "#007755" },
	[SchemeOut]           = { "#000000", "#00ff00" },
	[SchemeCaret]         = { "#007755", "#0000ff" },
};

static const unsigned int alphas[SchemeLast][2] = {
	[SchemeNorm] = { OPAQUE, alpha },
	[SchemeSel]  = { OPAQUE, alpha },
	[SchemeOut]  = { OPAQUE, alpha },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 5;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " /?\"&[]'{}().;:";

/* Size of the window border */
static unsigned int border_width = 0;
