// @ts-check

/**
 * @typedef {import('/Applications/Finicky.app/Contents/Resources/finicky.d.ts').FinickyConfig} FinickyConfig
 */

/**
 * @type {FinickyConfig}
 */
// https://github.com/johnste/finicky/wiki/Configuration-(v4)
export default {
  defaultBrowser: "/Applications/Firefox Developer Edition.app",
  rewrite: [
    {
      // Redirect all x.com urls to use xcancel.com
      match: "twitter.com/*",
      url: (url) => {
        url.host = "xcancel.com";
        return url;
      },
    },
    {
      // Redirect all x.com urls to use xcancel.com
      match: "x.com/*",
      url: (url) => {
        url.host = "xcancel.com";
        return url;
      },
    },
  ],
  handlers: [],
};

