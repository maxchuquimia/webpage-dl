# webpage-dl

Fetch a webpage's contents via CLI _after it has finished loading_.

Scraping HTML from webpages can't always be done via `curl` as it is often useful to let the page's JavaScript play out first. `webpage-dl` launches a `WKWebView` and only reads the source of the page once loading has completed.

`webpage-dl` even allows you to provide your own JavaScript expression, so scraping specific HTML nodes has never been easier.

<a href="./Marketing/demo.gif" title="(click for HD version)">
    <img src="./Marketing/demo-small.gif"/>
</a>
 

## Installation

1. Clone this repo
2. Run `make install` (requires Xcode 13+)

## Usage

```
USAGE: webpage-dl [--width <width>] [--height <height>] [--timeout <timeout>] [--delay <delay>] [--expression <expression>] <url>

ARGUMENTS:
  <url>                   The URL of the webpage to download.

OPTIONS:
  -w, --width <width>     The width of the simulated web page. (default: 500)
  -h, --height <height>   The height of the simulated web page. (default: 500)
  --timeout <timeout>     The maximum number of seconds the program should run
                          for before exiting (in the event of slow loading).
                          (default: 20.0)
  -d, --delay <delay>     An additional time to wait before executing
                          'expression'.
  --expression <expression>
                          The JavaScript expression to run. The output from
                          this expression with be printed to stdout before the
                          program exits. (default:
                          document.documentElement.outerHTML.toString())
  -h, --help              Show help information.
  ```
