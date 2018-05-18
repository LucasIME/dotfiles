// Configs
S.cfga({
  "defaultToCurrentScreen" : true,
  "secondsBetweenRepeat" : 0.1,
  "checkDefaultsOnLoad" : true,
  "focusCheckWidthMax" : 3000,
  "orderScreensLeftToRight" : true
});

var monLaptop = "1920x1200";
var monTbolt  = "2560x1600";

// Operations
var lapFull = S.op("move", {
  "screen" : monLaptop,
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});
var lapChat = S.op("corner", {
  "screen" : monLaptop,
  "direction" : "top-left",
  "width" : "screenSizeX/9",
  "height" : "screenSizeY"
});
var lapMain = lapChat.dup({ "direction" : "top-right", "width" : "8*screenSizeX/9" });
var tboltFull = S.op("move", {
  "screen" : monTbolt,
  "x" : "screenOriginX",
  "y" : "screenOriginY",
  "width" : "screenSizeX",
  "height" : "screenSizeY"
});
var tboltBig = S.op("move", {
  "screen" : monTbolt,
  "x" : "screenOriginX+screenSizeX/3",
  "y" : "screenOriginY",
  "width" : "screenSizeX*2/3",
  "height" : "screenSizeY",
});
var tboltLeft = tboltFull.dup({ "width" : "screenSizeX/3" });
var tboltMid = tboltLeft.dup({ "x" : "screenOriginX+screenSizeX/3" });
var tboltRight = tboltLeft.dup({ "x" : "screenOriginX+(screenSizeX*2/3)" });
var tboltLeftTop = tboltLeft.dup({ "height" : "screenSizeY/2" });
var tboltLeftBot = tboltLeftTop.dup({ "y" : "screenOriginY+screenSizeY/2" });
var tboltMidTop = tboltMid.dup({ "height" : "screenSizeY/2" });
var tboltMidBot = tboltMidTop.dup({ "y" : "screenOriginY+screenSizeY/2" });
var tboltRightTop = tboltRight.dup({ "height" : "screenSizeY/2" });
var tboltRightBot = tboltRightTop.dup({ "y" : "screenOriginY+screenSizeY/2" });

// Batch bind everything. Less typing.
S.bnda({
  // Basic Location Bindings
  "pad0:ctrl" : lapChat,
  "[:ctrl" : lapChat,
  "pad.:ctrl" : lapMain,
  "]:ctrl" : lapMain,
  "pad1:ctrl" : tboltLeftBot,
  "pad2:ctrl" : tboltMidBot,
  "pad3:ctrl" : tboltRightBot,
  "pad4:ctrl" : tboltLeftTop,
  "pad5:ctrl" : tboltMidTop,
  "pad6:ctrl" : tboltRightTop,
  "pad7:ctrl" : tboltLeft,
  "pad8:ctrl" : tboltMid,
  "pad9:ctrl" : tboltRight,
  "pad=:ctrl" : tboltFull,

  // Push Bindings
  // NOTE: some of these may *not* work if you have not removed the expose/spaces/mission control bindings
  "right:ctrl,alt,cmd" : S.op("push", { "direction" : "right", "style" : "bar-resize:screenSizeX/2" }),
  "left:ctrl,alt,cmd" : S.op("push", { "direction" : "left", "style" : "bar-resize:screenSizeX/2" }),
  "up:ctrl,alt,cmd" : S.op("push", { "direction" : "up", "style" : "bar-resize:screenSizeY/2" }),
  "down:ctrl,alt,cmd" : S.op("push", { "direction" : "down", "style" : "bar-resize:screenSizeY/2" }),
  "l:ctrl,alt,cmd" : S.op("push", { "direction" : "right", "style" : "bar-resize:screenSizeX/2" }),
  "h:ctrl,alt,cmd" : S.op("push", { "direction" : "left", "style" : "bar-resize:screenSizeX/2" }),
  "k:ctrl,alt,cmd" : S.op("push", { "direction" : "up", "style" : "bar-resize:screenSizeY/2" }),
  "j:ctrl,alt,cmd" : S.op("push", { "direction" : "down", "style" : "bar-resize:screenSizeY/2" }),

  // Nudge Bindings
  // NOTE: some of these may *not* work if you have not removed the expose/spaces/mission control bindings
  "right:ctrl;alt" : S.op("nudge", { "x" : "+10%", "y" : "+0" }),
  "left:ctrl;alt" : S.op("nudge", { "x" : "-10%", "y" : "+0" }),
  "up:ctrl;alt" : S.op("nudge", { "x" : "+0", "y" : "-10%" }),
  "down:ctrl;alt" : S.op("nudge", { "x" : "+0", "y" : "+10%" }),
  "l:ctrl;alt" : S.op("nudge", { "x" : "+10%", "y" : "+0" }),
  "h:ctrl;alt" : S.op("nudge", { "x" : "-10%", "y" : "+0" }),
  "k:ctrl;alt" : S.op("nudge", { "x" : "+0", "y" : "-10%" }),
  "j:ctrl;alt" : S.op("nudge", { "x" : "+0", "y" : "+10%" }),

  // Throw Bindings
  // NOTE: some of these may *not* work if you have not removed the expose/spaces/mission control bindings
  "pad1:ctrl;alt" : S.op("throw", { "screen" : "2", "width" : "screenSizeX", "height" : "screenSizeY" }),
  "pad2:ctrl;alt" : S.op("throw", { "screen" : "1", "width" : "screenSizeX", "height" : "screenSizeY" }),
  "pad3:ctrl;alt" : S.op("throw", { "screen" : "0", "width" : "screenSizeX", "height" : "screenSizeY" }),
  "right:ctrl;alt;cmd" : S.op("throw", { "screen" : "right", "width" : "screenSizeX", "height" : "screenSizeY" }),
  "left:ctrl;alt;cmd" : S.op("throw", { "screen" : "left", "width" : "screenSizeX", "height" : "screenSizeY" }),
  "up:ctrl;alt;cmd" : S.op("throw", { "screen" : "up", "width" : "screenSizeX", "height" : "screenSizeY" }),
  "down:ctrl;alt;cmd" : S.op("throw", { "screen" : "down", "width" : "screenSizeX", "height" : "screenSizeY" }),

    // Window Hints
  "esc:cmd" : S.op("hint"),

  // Switch currently doesn't work well so I'm commenting it out until I fix it.
  //"tab:cmd" : S.op("switch"),

  // Grid
  "esc:ctrl" : S.op("grid")
});

// Log that we're done configuring
S.log("[SLATE] -------------- Finished Loading Config --------------");
