/**
 * Spotlight.js v0.6.5 (Bundle)
 * Copyright 2019 Nextapps GmbH
 * Author: Thomas Wilkerling
 * Licence: Apache-2.0
 * https://github.com/nextapps-de/spotlight
 */
(function () {
  "use strict";
  var aa = {};
  function ba(a) {
    for (var b = a.classList, c = {}, d = 0; d < b.length; d++) c[b[d]] = 1;
    a.a = c;
    a.c = b;
  }
  function f(a, b) {
    a = g(a);
    var c = "string" === typeof b;
    if (a.length) for (var d = 0; d < a.length; d++) (c ? ca : da)(a[d], b);
    else (c ? ca : da)(a, b);
  }
  function da(a, b) {
    for (var c = 0; c < b.length; c++) ca(a, b[c]);
  }
  function ca(a, b) {
    a.a || ba(a);
    a.a[b] || ((a.a[b] = 1), a.c.add(b));
  }
  function h(a, b) {
    a = g(a);
    var c = "string" === typeof b;
    if (a.length) for (var d = 0; d < a.length; d++) (c ? ea : fa)(a[d], b);
    else (c ? ea : fa)(a, b);
  }
  function fa(a, b) {
    for (var c = 0; c < b.length; c++) ea(a, b[c]);
  }
  function ea(a, b) {
    a.a || ba(a);
    a.a[b] && ((a.a[b] = 0), a.c.remove(b));
  }
  function l(a, b, c, d) {
    a = g(a);
    var e = "string" !== typeof b && Object.keys(b);
    if (a.length)
      for (var k = 0; k < a.length; k++) (e ? ha : ia)(a[k], b, e || c, d);
    else (e ? ha : ia)(a, b, e || c, d);
  }
  function ha(a, b, c, d) {
    for (var e = 0; e < c.length; e++) {
      var k = c[e];
      ia(a, k, b[k], d);
    }
  }
  function ia(a, b, c, d) {
    var e = a.f;
    e || (a.f = e = {});
    e[b] !== c &&
      ((e[b] = c),
      (a.g || (a.g = a.style)).setProperty(
        aa[b] || (aa[b] = b.replace(/([a-z])([A-Z])/g, "$1-$2").toLowerCase()),
        c,
        d ? "important" : null
      ));
  }
  var ja = 0;
  function m(a, b, c) {
    l(a, "transition", "none");
    l(a, b, c);
    ja || (ja = a.clientTop && 0);
    l(a, "transition", "");
  }
  function ka(a, b) {
    b || (b = "");
    a = g(a);
    if (a.length)
      for (var c = 0; c < a.length; c++) {
        var d = a[c],
          e = b;
        d.b !== e && ((d.b = e), (d.textContent = e));
      }
    else a.b !== b && ((a.b = b), (a.textContent = b));
  }
  function g(a) {
    return "string" === typeof a ? document.querySelectorAll(a) : a;
  }
  function la(a, b, c, d) {
    ma("add", a, b, c, d);
  }
  function na(a, b, c, d) {
    ma("remove", a, b, c, d);
  }
  function ma(a, b, c, d, e) {
    b[a + "EventListener"](c || "click", d, "undefined" === typeof e ? !0 : e);
  }
  function n(a, b) {
    a || (a = window.event);
    a &&
      (a.stopImmediatePropagation(),
      b || a.preventDefault(),
      b || (a.returnValue = !1));
    return !1;
  }
  var oa = document.createElement("style");
  oa.innerHTML =
    "@keyframes pulsate{0%,to{opacity:1}50%{opacity:.2}}#spotlight,#spotlight .preloader{top:0;width:100%;height:100%;opacity:0}#spotlight{z-index:99999;color:#fff;background-color:#000;visibility:hidden;overflow:hidden;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;transition:visibility .25s ease,opacity .25s ease;font-family:Helvetica,Arial,sans-serif;font-size:16px;font-weight:400;contain:layout size paint style;touch-action:none;-webkit-tap-highlight-color:transparent;position:fixed}#spotlight.show{opacity:1;visibility:visible;transition:none}#spotlight.show .pane,#spotlight.show .scene{will-change:transform}#spotlight.show .scene img{will-change:transform,opacity}#spotlight .preloader{position:absolute;background-position:center center;background-repeat:no-repeat;background-size:42px 42px}#spotlight .preloader.show{transition:opacity .1s linear .25s;opacity:1}#spotlight .scene{transition:transform 1s cubic-bezier(.1,1,.1,1);pointer-events:none}#spotlight .scene img{display:inline-block;position:absolute;width:auto;height:auto;max-width:100%;max-height:100%;left:50%;top:50%;opacity:1;margin:0;padding:0;border:0;transform:translate(-50%,-50%) scale(1) perspective(100vw);transition:transform 1s cubic-bezier(.1,1,.1,1),opacity 1s cubic-bezier(.3,1,.3,1);transform-style:preserve-3d;contain:layout paint style;visibility:hidden}#spotlight .header,#spotlight .pane,#spotlight .scene{position:absolute;top:0;width:100%;height:100%;contain:layout size style}#spotlight .header{height:50px;text-align:right;background-color:rgba(0,0,0,.45);transform:translateY(-100px);transition:transform .35s ease-out;contain:layout size paint style}#spotlight .header:hover,#spotlight.menu .header{transform:translateY(0)}#spotlight .header div{display:inline-block;vertical-align:middle;white-space:nowrap;width:30px;height:50px;padding-right:20px;opacity:.5}#spotlight .progress{position:absolute;top:0;width:100%;height:3px;background-color:rgba(255,255,255,.45);transform:translateX(-100%);transition:transform 1s linear}#spotlight .arrow,#spotlight .footer{position:absolute;background-color:rgba(0,0,0,.45)}#spotlight .footer{left:0;right:0;bottom:0;line-height:1.35em;padding:20px 25px;text-align:left;pointer-events:none;contain:layout paint style}#spotlight .footer .title{font-size:125%;padding-bottom:10px}#spotlight .page{float:left;width:auto;padding-left:20px;line-height:50px}#spotlight .icon{cursor:pointer;background-position:left center;background-repeat:no-repeat;background-size:21px 21px;transition:opacity .2s ease-out}#spotlight .fullscreen{background-image:url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+PHN2ZyBmaWxsPSJub25lIiBoZWlnaHQ9IjI0IiBzdHJva2U9IiNmZmYiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIyLjUiIHZpZXdCb3g9Ii0xIC0xIDI2IDI2IiB3aWR0aD0iMjQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHBhdGggZD0iTTggM0g1YTIgMiAwIDAgMC0yIDJ2M20xOCAwVjVhMiAyIDAgMCAwLTItMmgtM20wIDE4aDNhMiAyIDAgMCAwIDItMnYtM00zIDE2djNhMiAyIDAgMCAwIDIgMmgzIi8+PC9zdmc+)}#spotlight .fullscreen.on{background-image:url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+PHN2ZyBmaWxsPSJub25lIiBoZWlnaHQ9IjI0IiBzdHJva2U9IiNmZmYiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIyLjUiIHZpZXdCb3g9IjAgMCAyNCAyNCIgd2lkdGg9IjI0IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxwYXRoIGQ9Ik04IDN2M2EyIDIgMCAwIDEtMiAySDNtMTggMGgtM2EyIDIgMCAwIDEtMi0yVjNtMCAxOHYtM2EyIDIgMCAwIDEgMi0yaDNNMyAxNmgzYTIgMiAwIDAgMSAyIDJ2MyIvPjwvc3ZnPg==)}#spotlight .autofit{background-image:url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+PHN2ZyBoZWlnaHQ9Ijk2cHgiIHZpZXdCb3g9IjAgMCA5NiA5NiIgd2lkdGg9Ijk2cHgiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHBhdGggdHJhbnNmb3JtPSJyb3RhdGUoOTAgNTAgNTApIiBmaWxsPSIjZmZmIiBkPSJNNzEuMzExLDgwQzY5LjY3LDg0LjY2LDY1LjIzLDg4LDYwLDg4SDIwYy02LjYzLDAtMTItNS4zNy0xMi0xMlYzNmMwLTUuMjMsMy4zNC05LjY3LDgtMTEuMzExVjc2YzAsMi4yMSwxLjc5LDQsNCw0SDcxLjMxMSAgeiIvPjxwYXRoIHRyYW5zZm9ybT0icm90YXRlKDkwIDUwIDUwKSIgZmlsbD0iI2ZmZiIgZD0iTTc2LDhIMzZjLTYuNjMsMC0xMiw1LjM3LTEyLDEydjQwYzAsNi42Myw1LjM3LDEyLDEyLDEyaDQwYzYuNjMsMCwxMi01LjM3LDEyLTEyVjIwQzg4LDEzLjM3LDgyLjYzLDgsNzYsOHogTTgwLDYwICBjMCwyLjIxLTEuNzksNC00LDRIMzZjLTIuMjEsMC00LTEuNzktNC00VjIwYzAtMi4yMSwxLjc5LTQsNC00aDQwYzIuMjEsMCw0LDEuNzksNCw0VjYweiIvPjwvc3ZnPg==)}#spotlight .zoom-out{background-image:url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+PHN2ZyBmaWxsPSJub25lIiBoZWlnaHQ9IjI0IiBzdHJva2U9IiNmZmYiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIyIiB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48Y2lyY2xlIGN4PSIxMSIgY3k9IjExIiByPSI4Ii8+PGxpbmUgeDE9IjIxIiB4Mj0iMTYuNjUiIHkxPSIyMSIgeTI9IjE2LjY1Ii8+PGxpbmUgeDE9IjgiIHgyPSIxNCIgeTE9IjExIiB5Mj0iMTEiLz48L3N2Zz4=)}#spotlight .zoom-in{background-image:url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+PHN2ZyBmaWxsPSJub25lIiBoZWlnaHQ9IjI0IiBzdHJva2U9IiNmZmYiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIyIiB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48Y2lyY2xlIGN4PSIxMSIgY3k9IjExIiByPSI4Ii8+PGxpbmUgeDE9IjIxIiB4Mj0iMTYuNjUiIHkxPSIyMSIgeTI9IjE2LjY1Ii8+PGxpbmUgeDE9IjExIiB4Mj0iMTEiIHkxPSI4IiB5Mj0iMTQiLz48bGluZSB4MT0iOCIgeDI9IjE0IiB5MT0iMTEiIHkyPSIxMSIvPjwvc3ZnPg==)}#spotlight .theme{background-image:url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+PHN2ZyBoZWlnaHQ9IjI0cHgiIHZlcnNpb249IjEuMiIgdmlld0JveD0iMiAyIDIwIDIwIiB3aWR0aD0iMjRweCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48ZyBmaWxsPSIjZmZmIj48cGF0aCBkPSJNMTIsNGMtNC40MTgsMC04LDMuNTgyLTgsOHMzLjU4Miw4LDgsOHM4LTMuNTgyLDgtOFMxNi40MTgsNCwxMiw0eiBNMTIsMThjLTMuMzE0LDAtNi0yLjY4Ni02LTZzMi42ODYtNiw2LTZzNiwyLjY4Niw2LDYgUzE1LjMxNCwxOCwxMiwxOHoiLz48cGF0aCBkPSJNMTIsN3YxMGMyLjc1NywwLDUtMi4yNDMsNS01UzE0Ljc1Nyw3LDEyLDd6Ii8+PC9nPjwvc3ZnPg==)}#spotlight .player{background-image:url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+PHN2ZyBmaWxsPSJub25lIiBoZWlnaHQ9IjI0IiBzdHJva2U9IiNmZmYiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIyIiB2aWV3Qm94PSItMC41IC0wLjUgMjUgMjUiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48Y2lyY2xlIGN4PSIxMiIgY3k9IjEyIiByPSIxMCIvPjxwb2x5Z29uIGZpbGw9IiNmZmYiIHBvaW50cz0iMTAgOCAxNiAxMiAxMCAxNiAxMCA4Ii8+PC9zdmc+)}#spotlight .player.on{background-image:url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+PHN2ZyBmaWxsPSJub25lIiBoZWlnaHQ9IjI0IiBzdHJva2U9IiNmZmYiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIyIiB2aWV3Qm94PSItMC41IC0wLjUgMjUgMjUiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48Y2lyY2xlIGN4PSIxMiIgY3k9IjEyIiByPSIxMCIvPjxsaW5lIHgxPSIxMCIgeDI9IjEwIiB5MT0iMTUiIHkyPSI5Ii8+PGxpbmUgeDE9IjE0IiB4Mj0iMTQiIHkxPSIxNSIgeTI9IjkiLz48L3N2Zz4=);animation:pulsate 1s ease infinite}#spotlight .close{background-image:url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+PHN2ZyBmaWxsPSJub25lIiBoZWlnaHQ9IjI0IiBzdHJva2U9IiNmZmYiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIyIiB2aWV3Qm94PSIyIDIgMjAgMjAiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48bGluZSB4MT0iMTgiIHgyPSI2IiB5MT0iNiIgeTI9IjE4Ii8+PGxpbmUgeDE9IjYiIHgyPSIxOCIgeTE9IjYiIHkyPSIxOCIvPjwvc3ZnPg==)}#spotlight .preloader.show{background-image:url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzgiIGhlaWdodD0iMzgiIHZpZXdCb3g9IjAgMCAzOCAzOCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiBzdHJva2U9IiNmZmYiPjxnIGZpbGw9Im5vbmUiIGZpbGwtcnVsZT0iZXZlbm9kZCI+PGcgdHJhbnNmb3JtPSJ0cmFuc2xhdGUoMSAxKSIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2Utb3BhY2l0eT0iLjY1Ij48Y2lyY2xlIHN0cm9rZS1vcGFjaXR5PSIuMTUiIGN4PSIxOCIgY3k9IjE4IiByPSIxOCIvPjxwYXRoIGQ9Ik0zNiAxOGMwLTkuOTQtOC4wNi0xOC0xOC0xOCI+PGFuaW1hdGVUcmFuc2Zvcm0gYXR0cmlidXRlTmFtZT0idHJhbnNmb3JtIiB0eXBlPSJyb3RhdGUiIGZyb209IjAgMTggMTgiIHRvPSIzNjAgMTggMTgiIGR1cj0iMXMiIHJlcGVhdENvdW50PSJpbmRlZmluaXRlIi8+PC9wYXRoPjwvZz48L2c+PC9zdmc+)}#spotlight .arrow{top:50%;left:20px;width:50px;height:50px;border-radius:100%;cursor:pointer;margin-top:-25px;padding:10px;transform:translateX(-100px);transition:transform .35s ease-out,opacity .2s ease-out;box-sizing:border-box;background-position:center center;background-repeat:no-repeat;background-size:30px 30px;opacity:.65;background-image:url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+PHN2ZyBmaWxsPSJub25lIiBoZWlnaHQ9IjI0IiBzdHJva2U9IiNmZmYiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIyIiB2aWV3Qm94PSIwIDAgMjQgMjQiIHdpZHRoPSIyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cG9seWxpbmUgcG9pbnRzPSIxNSAxOCA5IDEyIDE1IDYiLz48L3N2Zz4=)}#spotlight .arrow-right{left:auto;right:20px;transform:translateX(100px) scaleX(-1)}#spotlight.menu .arrow-left{transform:translateX(0)}#spotlight.menu .arrow-right{transform:translateX(0) scaleX(-1)}#spotlight .arrow:active,#spotlight .arrow:hover,#spotlight .icon:active,#spotlight .icon:hover{opacity:1;animation:none}#spotlight.white{color:#fff;background-color:#fff}#spotlight.white .arrow,#spotlight.white .footer,#spotlight.white .header,#spotlight.white .preloader,#spotlight.white .progress{filter:invert(1)}.hide-scrollbars{overflow:-moz-hidden-unscrollable;-ms-overflow-style:none}.hide-scrollbars::-webkit-scrollbar{width:0}@media (max-width:800px){#spotlight .header div{width:20px}#spotlight .footer{font-size:12px}#spotlight .arrow{width:35px;height:35px;margin-top:-17.5px;background-size:15px 15px}#spotlight .preloader{background-size:30px 30px}}@media (max-width:400px),(max-height:400px){#spotlight .fullscreen{display:none!important}}";
  document.getElementsByTagName("head")[0].appendChild(oa);
  var p =
      "theme fullscreen autofit zoom-in zoom-out page title description player progress".split(
        " "
      ),
    q,
    r,
    pa,
    qa,
    u,
    v,
    y,
    z,
    A,
    B,
    C,
    D,
    E,
    F,
    ra,
    sa,
    G,
    H,
    I,
    J,
    ta,
    ua,
    va,
    K,
    L,
    M,
    wa,
    N,
    xa,
    ya,
    za,
    Aa,
    Ba,
    O,
    Ca,
    Da,
    Ea,
    P,
    Q,
    Fa,
    R,
    S,
    T,
    Ga;
  function V(a) {
    return (N || document).getElementsByClassName(a)[0];
  }
  function Ha(a, b) {
    if ((H = a.length)) {
      L || (L = (N || document).getElementsByClassName("pane"));
      var c = L.length,
        d = I.title,
        e = I.description;
      T = Array(H);
      for (var k = 0; k < H; k++) {
        var t = a[k],
          w = t.dataset;
        if (k >= c) {
          var x = L[0].cloneNode(!1);
          l(x, "left", 100 * k + "%");
          L[0].parentNode.appendChild(x);
        }
        x = void 0;
        T[k] = {
          src: (w && (w.href || w.src)) || t.src || t.href,
          title:
            (w && w.title) ||
            t.title ||
            ((x = (t || document).getElementsByTagName("img")).length &&
              x[0].alt) ||
            d ||
            "",
          description: (w && w.description) || t.description || e || "",
        };
      }
      G = b || 1;
      Ia(!0);
      Ja();
    }
  }
  function Ka(a, b, c, d) {
    if (d || a[c]) I[c] = (b && b[c]) || d;
  }
  function La(a, b) {
    I = {};
    b && Ma(b);
    Ma(a);
    Ka(a, b, "description");
    Ka(a, b, "title");
    Ka(a, b, "prefetch", !0);
    Ka(a, b, "preloader", !0);
    ua = a.onchange;
    J = I.infinite;
    J = "undefined" !== typeof J && "false" !== J;
    ta = "false" !== I.progress;
    va = 1 * I.player || 7e3;
    if ((a = I.zoom) || "" === a)
      (I["zoom-in"] = I["zoom-out"] = a), delete I.zoom;
    if ((a = I.control) || "" === a) {
      a = "string" === typeof a ? a.split(",") : a;
      for (b = 0; b < p.length; b++) I[p[b]] = "false";
      for (b = 0; b < a.length; b++) {
        var c = a[b].trim();
        "zoom" === c
          ? (I["zoom-in"] = I["zoom-out"] = "true")
          : (I[c] = "true");
      }
    }
    for (a = 0; a < p.length; a++)
      (b = p[a]), l(V(b), "display", "false" === I[b] ? "none" : "");
    (sa = I.theme) ? Na() : (sa = "white");
  }
  function Ma(a) {
    for (var b = I, c = Object.keys(a), d = 0; d < c.length; d++) {
      var e = c[d];
      b[e] = "" + a[e];
    }
  }
  function Oa() {
    var a = G;
    K = L[a - 1];
    M = K.firstElementChild;
    G = a;
    if (!M) {
      var b = "false" !== I.preloader;
      M = new Image();
      M.onload = function () {
        b && h(P, "show");
        T &&
          ((y = this.width),
          (z = this.height),
          l(this, { visibility: "visible", opacity: 1, transform: "" }),
          "false" !== I.prefetch && a < H && (new Image().src = T[a].src));
      };
      M.onerror = function () {
        K.removeChild(this);
      };
      K.appendChild(M);
      M.src = T[a - 1].src;
      b && f(P, "show");
      return !b;
    }
    return !0;
  }
  la(document, "", Pa);
  la(document, "DOMContentLoaded", Qa, { once: !0 });
  var Ra = !1;
  function Qa() {
    Ra ||
      ((N = document.createElement("div")),
      (N.id = "spotlight"),
      (N.innerHTML =
        '<div class=preloader></div><div class=scene><div class=pane></div></div><div class=header><div class=page></div><div class="icon fullscreen"></div><div class="icon autofit"></div><div class="icon zoom-out"></div><div class="icon zoom-in"></div><div class="icon theme"></div><div class="icon player"></div><div class="icon close"></div></div><div class=progress></div><div class="arrow arrow-left"></div><div class="arrow arrow-right"></div><div class=footer><div class=title></div><div class=description></div></div>'),
      l(N, "transition", "none"),
      document.body.appendChild(N),
      (wa = V("scene")),
      (xa = V("footer")),
      (ya = V("title")),
      (za = V("description")),
      (Aa = V("arrow-left")),
      (Ba = V("arrow-right")),
      (O = V("fullscreen")),
      (Ca = V("page")),
      (Da = V("player")),
      (Ea = V("progress")),
      (P = V("preloader")),
      (S = document.documentElement || document.body),
      document.cancelFullScreen ||
        (document.cancelFullScreen =
          document.exitFullscreen ||
          document.webkitCancelFullScreen ||
          document.webkitExitFullscreen ||
          document.mozCancelFullScreen ||
          function () {}),
      S.requestFullScreen ||
        (S.requestFullScreen =
          S.webkitRequestFullScreen ||
          S.msRequestFullScreen ||
          S.mozRequestFullScreen ||
          l(O, "display", "none") ||
          function () {}),
      (Ga = [
        [window, "keydown", Sa],
        [window, "wheel", Ta],
        [window, "hashchange", Ua],
        [window, "resize", Va],
        [P, "mousedown", Wa],
        [P, "mouseleave", Xa],
        [P, "mouseup", Xa],
        [P, "mousemove", Ya],
        [P, "touchstart", Wa, { passive: !1 }],
        [P, "touchcancel", Xa],
        [P, "touchend", Xa],
        [P, "touchmove", Ya, { passive: !0 }],
        [O, "", Za],
        [Aa, "", $a],
        [Ba, "", W],
        [Da, "", ab],
        [V("autofit"), "", bb],
        [V("zoom-in"), "", cb],
        [V("zoom-out"), "", db],
        [V("close"), "", eb],
        [V("theme"), "", Na],
      ]),
      (Ra = !0));
  }
  function Va() {
    u = N.clientWidth;
    v = N.clientHeight;
    M && ((y = M.width), (z = M.height), fb());
  }
  function fb() {
    l(M, "transform", "translate(-50%, -50%) scale(" + A + ")");
  }
  function X(a, b) {
    l(K, "transform", a || b ? "translate(" + a + "px, " + b + "px)" : "");
  }
  function Ia(a, b) {
    (a ? m : l)(
      wa,
      "transform",
      "translateX(" + (100 * -(G - 1) + (b || 0)) + "%)"
    );
  }
  function gb(a) {
    for (var b = 0; b < Ga.length; b++) {
      var c = Ga[b];
      (a ? la : na)(c[0], c[1], c[2], c[3]);
    }
  }
  function Pa(a) {
    var b = hb.call(a.target, ".spotlight");
    if (b) {
      var c = hb.call(b, ".spotlight-group"),
        d = (c || document).getElementsByClassName("spotlight");
      La(b.dataset, c && c.dataset);
      for (c = 0; c < d.length; c++)
        if (d[c] === b) {
          Ha(d, c + 1);
          break;
        }
      ib();
      return n(a);
    }
  }
  function Sa(a) {
    if (K)
      switch (a.keyCode) {
        case 8:
          bb();
          break;
        case 27:
          eb();
          break;
        case 32:
          "false" !== I.player && ab();
          break;
        case 37:
          $a();
          break;
        case 39:
          W();
          break;
        case 38:
        case 107:
        case 187:
          cb();
          break;
        case 40:
        case 109:
        case 189:
          db();
      }
  }
  function Ta(a) {
    K && ((a = a.deltaY), 0 > 0.5 * (0 > a ? 1 : a ? -1 : 0) ? db() : cb());
  }
  function Ua() {
    K && "#spotlight" === location.hash && eb(!0);
  }
  function ab(a) {
    ("boolean" === typeof a ? a : !Q)
      ? Q || ((Q = setInterval(W, va)), f(Da, "on"), ta && jb())
      : Q &&
        ((Q = clearInterval(Q)), h(Da, "on"), ta && m(Ea, "transform", ""));
    return Q;
  }
  function Y() {
    R ? clearTimeout(R) : f(N, "menu");
    var a = I.autohide;
    R =
      "false" !== a
        ? setTimeout(function () {
            h(N, "menu");
            R = null;
          }, 1 * a || 3e3)
        : 1;
  }
  function kb(a) {
    "boolean" === typeof a && (R = a ? R : 0);
    R ? ((R = clearTimeout(R)), h(N, "menu")) : Y();
    return n(a);
  }
  function Wa(a) {
    B = !0;
    C = !1;
    var b = lb(a);
    D = y * A <= u;
    pa = b.x;
    qa = b.y;
    return n(a, !0);
  }
  function Xa(a) {
    if (B && !C) return (B = !1), kb(a);
    D &&
      C &&
      (Ia(!0, (q / u) * 100),
      (q < -(v / 10) && W()) || (q > v / 10 && $a()) || Ia(),
      (q = 0),
      (D = !1),
      X());
    B = !1;
    return n(a);
  }
  function Ya(a) {
    if (B) {
      Fa || (Fa = requestAnimationFrame(mb));
      var b = lb(a),
        c = (y * A - u) / 2;
      C = !0;
      q -= pa - (pa = b.x);
      D
        ? (E = !0)
        : q > c
        ? (q = c)
        : 0 < u - q - y * A + c
        ? (q = u - y * A + c)
        : (E = !0);
      z * A > v &&
        ((c = (z * A - v) / 2),
        (r -= qa - (qa = b.y)),
        r > c
          ? (r = c)
          : 0 < v - r - z * A + c
          ? (r = v - z * A + c)
          : (E = !0));
    } else Y();
    return n(a, !0);
  }
  function lb(a) {
    var b = a.touches;
    b && (b = b[0]);
    return { x: b ? b.clientX : a.pageX, y: b ? b.clientY : a.pageY };
  }
  function mb(a) {
    E ? (a && (Fa = requestAnimationFrame(mb)), X(q, r)) : (Fa = null);
    E = !1;
  }
  function Za(a) {
    (
      "boolean" === typeof a
        ? a
        : document.isFullScreen ||
          document.webkitIsFullScreen ||
          document.mozFullScreen
    )
      ? (document.cancelFullScreen(), h(O, "on"))
      : (S.requestFullScreen(), f(O, "on"));
  }
  function bb(a) {
    "boolean" === typeof a && (F = !a);
    F = 1 === A && !F;
    l(M, {
      maxHeight: F ? "none" : "",
      maxWidth: F ? "none" : "",
      transform: "",
    });
    y = M.width;
    z = M.height;
    A = 1;
    r = q = 0;
    E = !0;
    X();
    Y();
  }
  function cb(a) {
    var b = A / 0.65;
    5 >= b && nb((A = b));
    a || Y();
  }
  function nb(a) {
    A = a || 1;
    fb();
  }
  function db(a) {
    var b = 0.65 * A;
    1 <= b && (nb((A = b)), (r = q = 0), (E = !0), X());
    a || Y();
  }
  function ib() {
    location.hash = "spotlight";
    location.hash = "show";
    l(N, "transition", "");
    f(S, "hide-scrollbars");
    f(N, "show");
    gb(!0);
    Va();
    Y();
  }
  function eb(a) {
    gb(!1);
    history.go(!0 === a ? -1 : -2);
    h(S, "hide-scrollbars");
    h(N, "show");
    Q && ab(!1);
    M.parentNode.removeChild(M);
    K = L = M = T = I = ua = null;
  }
  function $a() {
    if (1 < G) return Z(G - 1);
    if (Q || J) return Z(H);
  }
  function W() {
    if (G < H) return Z(G + 1);
    if (Q || J) return Z(1);
  }
  function Z(a) {
    if (!((Q && B) || a === G)) {
      Q || Y();
      Q && ta && jb();
      var b = a > G;
      G = a;
      Ja(b);
      return !0;
    }
  }
  function jb() {
    m(Ea, { transitionDuration: "", transform: "" });
    l(Ea, { transitionDuration: va + "ms", transform: "translateX(0)" });
  }
  function Na(a) {
    "boolean" === typeof a ? (ra = a) : ((ra = !ra), Y());
    ra ? f(N, sa) : h(N, sa);
  }
  function Ja(a) {
    r = q = 0;
    A = 1;
    var b = I.animation,
      c = !0,
      d = !0,
      e = !0;
    if (b || "" === b) {
      c = d = e = !1;
      b = "string" === typeof b ? b.split(",") : b;
      for (var k = 0; k < b.length; k++) {
        var t = b[k].trim();
        if ("scale" === t) c = !0;
        else if ("fade" === t) d = !0;
        else if ("slide" === t) e = !0;
        else if ("flip" === t) var w = !0;
        else if ("false" !== t) {
          c = d = e = w = !1;
          var x = t;
          break;
        }
      }
    }
    l(wa, "transition", e ? "" : "none");
    Ia();
    K && X();
    if (M) {
      l(M, { opacity: d ? 0 : 1, transform: "" });
      var U = M;
      setTimeout(function () {
        U && M !== U && U.parentNode && U.parentNode.removeChild(U);
      }, 800);
    }
    e = Oa();
    x && f(M, x);
    m(M, {
      opacity: d ? 0 : 1,
      transform:
        "translate(-50%, -50%)" +
        (c ? " scale(0.8)" : "") +
        (w && "undefined" !== typeof a
          ? " rotateY(" + (a ? "" : "-") + "90deg)"
          : ""),
      maxHeight: "",
      maxWidth: "",
    });
    e && l(M, { visibility: "visible", opacity: 1, transform: "" });
    x && h(M, x);
    X();
    l(Aa, "visibility", J || 1 !== G ? "" : "hidden");
    l(Ba, "visibility", J || G !== H ? "" : "hidden");
    a = T[G - 1];
    if ((c = (c = a.title || a.description) && "false" !== c))
      ka(ya, a.title || ""), ka(za, a.description || "");
    l(xa, "visibility", c ? "visible" : "hidden");
    ka(Ca, G + " / " + H);
    ua && ua(G);
  }
  var hb =
    Element.prototype.closest ||
    function (a) {
      var b = this;
      for (a = a.substring(1); b && 1 === b.nodeType; ) {
        if (b.classList.contains(a)) return b;
        b = b.parentElement || b.parentNode;
      }
    };
  window.Spotlight = {
    init: Qa,
    theme: Na,
    fullscreen: Za,
    autofit: bb,
    next: W,
    prev: $a,
    goto: Z,
    close: eb,
    zoom: nb,
    menu: kb,
    show: function (a, b) {
      setTimeout(function () {
        a ? (b ? La(b) : (b = {}), Ha(a, b.index)) : (I = {});
        ib();
      });
    },
    play: ab,
  };
}).call(this);
