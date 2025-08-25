const uswds = require("@uswds/compile");

/** USWDS version **/
uswds.settings.version = 3;

uswds.paths.dist.theme = "./jekyll/sass";
uswds.paths.dist.img = "./jekyll/assets/uswds/img";
uswds.paths.dist.fonts = "./jekyll/assets/uswds/fonts"
uswds.paths.dist.js = "./jekyll/assets/uswds/js";
uswds.paths.dist.css = "./jekyll/assets/uswds/css";

/** Exports **/
// exports.init = uswds.init; // Use init only once
exports.compile = uswds.compile;
exports.watch = uswds.watch;
exports.updateUswds = uswds.updateUswds;
exports.default = uswds.watch;

