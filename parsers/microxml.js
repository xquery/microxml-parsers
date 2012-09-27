// This file was generated on Thu Sep 27, 2012 11:24 (UTC+02) by REx v5.16 which is Copyright (c) 1979-2012 by Gunther Rademacher <grd@gmx.net>
// REx command line: microxml.ebnf -ll 2 -tree -javascript

function microxml(string)
{
  init(string);

  function ParseException(b, e, s, o, x)
  {
    var
      begin = b,
      end = e,
      state = s,
      offending = o,
      expected = x;

    this.getBegin = function() {return begin;};
    this.getEnd = function() {return end;};
    this.getState = function() {return state;};
    this.getExpected = function() {return expected;};
    this.getOffending = function() {return offending;};

    this.getMessage = function()
    {
      return offending < 0 ? "lexical analysis failed" : "syntax error";
    };
  }

  function init(string)
  {
    input = string;
    size = string.length;
    reset(0, 0, 0);
    delayedTag = null;
  }

  this.getInput = function()
  {
    return input;
  };

  function reset(l, b, e)
  {
                 b0 = b; e0 = b;
    l1 = l; b1 = b; e1 = e;
    l2 = 0;
    end = e;
  }

  this.getOffendingToken = function(e)
  {
    var o = e.getOffending();
    return o >= 0 ? TOKEN[o] : null;
  }

  this.getExpectedTokenSet = function(e)
  {
    var expected;
    if (e.getExpected() < 0)
    {
      expected = getExpectedTokenSet(e.getState());
    }
    else
    {
      expected = [TOKEN[e.getExpected()]];
    }
    return expected;
  }

  this.parse_document = function()
  {
    startNonterminal("document");
    lookahead1(14);                 // byteOrderMark | comment | s | '<'
    if (l1 == 1)                    // byteOrderMark
    {
      shift(1);                     // byteOrderMark
    }
    for (;;)
    {
      lookahead1(12);               // comment | s | '<'
      if (l1 == 11)                 // '<'
      {
        break;
      }
      switch (l1)
      {
      case 4:                       // comment
        shift(4);                   // comment
        break;
      default:
        shift(8);                   // s
      }
    }
    parse_element();
    for (;;)
    {
      lookahead1(11);               // comment | s | eof
      if (l1 == 9)                  // eof
      {
        break;
      }
      switch (l1)
      {
      case 4:                       // comment
        shift(4);                   // comment
        break;
      default:
        shift(8);                   // s
      }
    }
    shift(9);                       // eof
    endNonterminal("document");
    flushOutput();
  }

  function parse_element()
  {
    startNonterminal("element");
    shift(11);                      // '<'
    lookahead1(2);                  // name
    shift(7);                       // name
    parse_attributeList();
    lookahead1(13);                 // s | '/>' | '>'
    if (l1 == 8)                    // s
    {
      shift(8);                     // s
    }
    lookahead1(9);                  // '/>' | '>'
    switch (l1)
    {
    case 14:                        // '>'
      shift(14);                    // '>'
      parse_content();
      parse_endTag();
      break;
    default:
      shift(10);                    // '/>'
    }
    endNonterminal("element");
  }

  function parse_endTag()
  {
    startNonterminal("endTag");
    lookahead1(3);                  // '</'
    shift(12);                      // '</'
    lookahead1(2);                  // name
    shift(7);                       // name
    lookahead1(8);                  // s | '>'
    if (l1 == 8)                    // s
    {
      shift(8);                     // s
    }
    lookahead1(5);                  // '>'
    shift(14);                      // '>'
    endNonterminal("endTag");
  }

  function parse_content()
  {
    startNonterminal("content");
    for (;;)
    {
      lookahead1(15);               // comment | charRef | dataChar | '<' | '</'
      if (l1 == 12)                 // '</'
      {
        break;
      }
      switch (l1)
      {
      case 11:                      // '<'
        parse_element();
        break;
      case 4:                       // comment
        shift(4);                   // comment
        break;
      case 6:                       // dataChar
        shift(6);                   // dataChar
        break;
      default:
        shift(5);                   // charRef
      }
    }
    endNonterminal("content");
  }

  function parse_attributeList()
  {
    startNonterminal("attributeList");
    for (;;)
    {
      lookahead1(13);               // s | '/>' | '>'
      switch (l1)
      {
      case 8:                       // s
        lookahead2(10);             // attributeName | '/>' | '>'
        break;
      default:
        lk = l1;
      }
      if (lk != 104)                // s attributeName
      {
        break;
      }
      shift(8);                     // s
      parse_attribute();
    }
    endNonterminal("attributeList");
  }

  function parse_attribute()
  {
    startNonterminal("attribute");
    lookahead1(1);                  // attributeName
    shift(3);                       // attributeName
    lookahead1(7);                  // s | '='
    if (l1 == 8)                    // s
    {
      shift(8);                     // s
    }
    lookahead1(4);                  // '='
    shift(13);                      // '='
    lookahead1(6);                  // attributeValue | s
    if (l1 == 8)                    // s
    {
      shift(8);                     // s
    }
    lookahead1(0);                  // attributeValue
    shift(2);                       // attributeValue
    endNonterminal("attribute");
  }

  var lk, b0, e0;
  var l1, b1, e1;
  var l2, b2, e2;
  var delayedTag;

  function startNonterminal(tag)
  {
    if (delayedTag != null) writeOutput("<" + delayedTag + ">");
    delayedTag = tag;
  }

  function endNonterminal(tag)
  {
    if (delayedTag != null)
      writeOutput("<" + tag + "/>");
    else
      writeOutput("</" + tag + ">");
    delayedTag = null;
  }

  function characters(input, b, e)
  {
    if (b < e)
    {
      if (delayedTag != null) writeOutput("<" + delayedTag + ">");
      writeOutput(input.substring(b, e)
          .replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;"));
      delayedTag = null;
    }
  }

  function terminal(tag, input, b, e)
  {
    if (tag.charAt(0) == '\'') tag = "TOKEN";
    startNonterminal(tag);
    characters(input, b, e);
    endNonterminal(tag);
  }

  function error(b, e, s, l, t)
  {
    flushOutput();
    throw new ParseException(b, e, s, l, t);
  }

  function shift(t)
  {
    if (l1 == t)
    {
      if (e0 != b1)
      {
        characters(input, e0, b1);
      }
      terminal(TOKEN[l1], input, b1, e1 > size ? size : e1);
      b0 = b1; e0 = e1; l1 = l2; if (l1 != 0) {
      b1 = b2; e1 = e2; l2 = 0; }
    }
    else
    {
      error(b1, e1, 0, l1, t);
    }
  }

  function lookahead1(set)
  {
    if (l1 == 0)
    {
      l1 = match(set);
      b1 = begin;
      e1 = end;
    }
  }

  function lookahead2(set)
  {
    if (l2 == 0)
    {
      l2 = match(set);
      b2 = begin;
      e2 = end;
    }
    lk = (l2 << 5) | l1;
  }

  var input;
  var size;
  var begin;
  var end;
  var state;

  function match(tokenset)
  {
    begin = end;
    var current = end;
    var result = INITIAL[tokenset];

    for (var code = result & 127; code != 0; )
    {
      var charclass;
      var c0 = current < size ? input.charCodeAt(current) : 0;
      ++current;
      if (c0 < 0x80)
      {
        charclass = MAP0[c0];
      }
      else if (c0 < 0xd800)
      {
        var c1 = c0 >> 4;
        var c2 = c1 >> 5;
        charclass = MAP1[(c0 & 15) + MAP1[(c1 & 31) + MAP1[c2]]];
      }
      else
      {
        if (c0 < 0xdc00)
        {
          var c1 = current < size ? input.charCodeAt(current) : 0;
          if (c1 >= 0xdc00 && c1 < 0xe000)
          {
            ++current;
            c0 = ((c0 & 0x3ff) << 10) + (c1 & 0x3ff) + 0x10000;
          }
        }
        var lo = 0, hi = 20;
        for (var m = 10; ; m = (hi + lo) >> 1)
        {
          if (MAP2[m] > c0) hi = m - 1;
          else if (MAP2[21 + m] < c0) lo = m + 1;
          else {charclass = MAP2[42 + m]; break;}
          if (lo > hi) {charclass = 0; break;}
        }
      }

      state = code;
      var i0 = (charclass << 7) + code - 1;
      code = TRANSITION[(i0 & 7) + TRANSITION[i0 >> 3]];

      if (code > 127)
      {
        result = code;
        code &= 127;
        end = current;
      }
    }

    result >>= 7;
    if (result == 0)
    {
      end = current - 1;
      var c1 = end < size ? input.charCodeAt(end) : 0;
      if (c1 >= 0xdc00 && c1 < 0xe000) --end;
      error(begin, end, state, -1, -1);
    }

    return (result & 15) - 1;
  }

  var writeOutput = typeof out      != "undefined" ? function(content) {out.print(content);}
                  : typeof WScript  != "undefined" ? function(content) {WScript.StdOut.write(content);}
                  : typeof document != "undefined" ? function(content)
                                                     {
                                                       document.write
                                                       (content.replace(/&/g, "&amp;")
                                                               .replace(/</g, "&lt;")
                                                               .replace(/>/g, "&gt;"));
                                                     }
                  :                                  function(content) {};
  var flushOutput = typeof out != "undefined" ? function() {out.flush();} : function() {}

  this.writeOutput = function(content) {writeOutput(content);}
  this.flushOutput = function() {flushOutput();}

  function getExpectedTokenSet(s)
  {
    var set = new Array;
    if (s > 0)
    {
      for (var i = 0; i < 15; i += 32)
      {
        var j = i;
        for (var f = ec(i >>> 5, s); f != 0; f >>>= 1, ++j)
        {
          if ((f & 1) != 0)
          {
            set[set.length] = TOKEN[j];
          }
        }
      }
    }
    return set;
  }

  function ec(t, s)
  {
    var i0 = t * 70 + s - 1;
    var i1 = i0 >> 2;
    return EXPECTED[(i0 & 3) + EXPECTED[i1]];
  }

  var MAP0 =
  [
    /*   0 */ 32, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 4,
    /*  35 */ 5, 6, 6, 7, 8, 6, 6, 6, 6, 6, 9, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 6, 13, 14, 15, 16, 6, 6,
    /*  65 */ 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 6,
    /*  92 */ 6, 6, 6, 18, 6, 19, 17, 17, 17, 17, 17, 20, 18, 18, 18, 18, 21, 22, 23, 24, 25, 26, 18, 27, 28, 29, 18,
    /* 119 */ 18, 30, 18, 18, 6, 6, 6, 6, 0
  ];

  var MAP1 =
  [
    /*   0 */ 108, 124, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 156, 181, 181, 181, 181,
    /*  21 */ 181, 214, 215, 213, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    /*  42 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    /*  63 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    /*  84 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    /* 105 */ 214, 214, 214, 247, 258, 274, 290, 344, 351, 367, 383, 258, 258, 327, 319, 430, 422, 430, 422, 430, 430,
    /* 126 */ 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 399, 399, 399, 399, 399, 399, 399,
    /* 147 */ 415, 430, 430, 430, 430, 430, 430, 430, 430, 305, 327, 327, 328, 326, 327, 327, 430, 430, 430, 430, 430,
    /* 168 */ 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 327, 327, 327, 327, 327, 327, 327, 327,
    /* 189 */ 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327,
    /* 210 */ 327, 327, 327, 429, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430,
    /* 231 */ 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 327, 32, 0, 0, 0, 0, 0, 0, 0,
    /* 255 */ 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 4, 5, 6, 6, 7, 8, 6, 6, 6, 6, 6, 9, 10, 11,
    /* 290 */ 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 6, 13, 14, 15, 16, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 18, 18, 6,
    /* 320 */ 6, 6, 6, 6, 6, 6, 10, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 10, 6, 17, 17, 17, 17, 17, 17, 18,
    /* 352 */ 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 6, 6, 6, 6, 18, 6, 19, 17, 17, 17, 17, 17, 20, 18, 18, 18, 18, 21,
    /* 380 */ 22, 23, 24, 25, 26, 18, 27, 28, 29, 18, 18, 30, 18, 18, 6, 6, 6, 6, 0, 10, 10, 10, 10, 10, 10, 10, 10, 10,
    /* 408 */ 10, 10, 10, 10, 10, 10, 10, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 6, 18, 18, 18, 18, 18,
    /* 435 */ 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18
  ];

  var MAP2 =
  [
    /*  0 */ 57344, 63744, 65008, 65279, 65280, 65536, 131072, 196608, 262144, 327680, 393216, 458752, 524288, 589824,
    /* 14 */ 655360, 720896, 786432, 851968, 917504, 983040, 1048576, 63743, 64975, 65278, 65279, 65533, 131069, 196605,
    /* 28 */ 262141, 327677, 393213, 458749, 524285, 589821, 655357, 720893, 786429, 851965, 917501, 983037, 1048573,
    /* 41 */ 1114109, 6, 18, 18, 31, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 6, 6
  ];

  var INITIAL =
  [
    /*  0 */ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
  ];

  var TRANSITION =
  [
    /*   0 */ 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 562, 534, 617, 550, 550,
    /*  21 */ 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 562, 540, 528, 550, 550, 550, 550, 644, 645, 550,
    /*  42 */ 550, 550, 550, 550, 550, 550, 550, 572, 548, 559, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550,
    /*  63 */ 550, 671, 572, 570, 550, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 550, 572, 548, 580,
    /*  84 */ 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 550, 572, 548, 550, 550, 550, 550, 644, 645,
    /* 105 */ 550, 550, 550, 550, 550, 550, 550, 550, 551, 593, 550, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550,
    /* 126 */ 550, 550, 603, 572, 615, 550, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 550, 572, 625,
    /* 147 */ 688, 550, 739, 550, 630, 771, 550, 550, 550, 550, 550, 550, 550, 550, 572, 625, 717, 550, 719, 550, 738,
    /* 168 */ 645, 550, 550, 550, 550, 550, 550, 550, 550, 824, 638, 641, 550, 550, 550, 644, 645, 550, 550, 550, 550,
    /* 189 */ 550, 550, 550, 550, 572, 625, 717, 550, 907, 838, 585, 653, 550, 550, 550, 550, 550, 550, 550, 550, 572,
    /* 210 */ 548, 550, 550, 550, 666, 607, 679, 550, 550, 550, 550, 550, 550, 550, 684, 784, 550, 550, 550, 550, 550,
    /* 231 */ 644, 645, 550, 550, 550, 550, 550, 550, 550, 658, 572, 548, 550, 550, 550, 550, 644, 645, 550, 550, 550,
    /* 252 */ 550, 550, 550, 550, 809, 696, 595, 550, 550, 550, 550, 644, 919, 550, 550, 550, 550, 550, 550, 550, 714,
    /* 273 */ 720, 625, 717, 550, 907, 838, 585, 653, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 550, 719,
    /* 294 */ 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 728, 550, 907, 838, 585, 653, 550, 550,
    /* 315 */ 550, 550, 550, 550, 550, 714, 720, 625, 747, 550, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550,
    /* 336 */ 714, 720, 625, 761, 550, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 779, 717, 792,
    /* 357 */ 805, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 550, 702, 550, 738, 645, 550,
    /* 378 */ 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 550, 851, 817, 832, 645, 550, 550, 550, 550, 550, 550,
    /* 399 */ 550, 714, 720, 625, 717, 846, 859, 866, 874, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 888,
    /* 420 */ 550, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 550, 719, 550, 706, 902,
    /* 441 */ 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 864, 915, 550, 738, 645, 550, 550, 550, 550, 550,
    /* 462 */ 550, 550, 714, 720, 625, 717, 753, 767, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 927, 894, 625,
    /* 483 */ 930, 797, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 880, 625, 717, 550, 719, 550, 738,
    /* 504 */ 645, 550, 550, 550, 550, 550, 550, 550, 550, 734, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550,
    /* 525 */ 550, 550, 550, 17, 18, 0, 0, 0, 0, 1175, 0, 0, 1175, 1175, 1175, 1175, 0, 0, 1175, 1175, 1175, 1175, 896,
    /* 548 */ 17, 18, 0, 0, 0, 0, 0, 0, 0, 0, 26, 31, 0, 31, 0, 0, 0, 0, 0, 0, 1175, 1175, 384, 18, 0, 0, 0, 0, 0, 0, 0,
    /* 579 */ 896, 0, 32, 0, 36, 40, 0, 0, 0, 0, 531, 62, 63, 0, 28, 29, 0, 0, 0, 0, 0, 0, 0, 1408, 18, 0, 0, 0, 0, 0,
    /* 609 */ 18, 0, 0, 62, 768, 0, 17, 384, 0, 0, 0, 0, 0, 0, 1175, 0, 17, 18, 531, 531, 1045, 0, 0, 0, 0, 531, 69, 0,
    /* 637 */ 0, 17, 18, 0, 0, 0, 1664, 0, 0, 0, 0, 0, 62, 0, 0, 0, 65, 0, 67, 0, 62, 0, 0, 0, 0, 1792, 0, 0, 1792, 768,
    /* 667 */ 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 17, 0, 17, 0, 18, 0, 62, 0, 0, 0, 22, 0, 0, 0, 0, 0, 531, 45, 0, 1920,
    /* 697 */ 1920, 1920, 0, 0, 1920, 0, 0, 0, 573, 0, 0, 0, 0, 19, 62, 0, 49, 0, 531, 1045, 0, 0, 0, 0, 0, 531, 0, 0,
    /* 725 */ 0, 0, 896, 0, 33, 0, 37, 41, 531, 0, 0, 0, 1280, 0, 0, 0, 0, 531, 62, 0, 0, 0, 0, 34, 0, 38, 42, 531, 0,
    /* 754 */ 0, 50, 0, 0, 0, 55, 0, 0, 34, 0, 38, 42, 556, 0, 0, 60, 531, 0, 0, 0, 0, 70, 0, 0, 0, 17, 18, 531, 542,
    /* 783 */ 1045, 0, 0, 0, 25, 1561, 0, 1561, 1563, 47, 0, 0, 0, 52, 0, 0, 0, 51, 0, 0, 0, 56, 57, 0, 0, 531, 0, 0, 0,
    /* 812 */ 0, 0, 1920, 0, 0, 0, 34, 0, 0, 66, 0, 38, 0, 24, 24, 0, 0, 24, 0, 896, 0, 68, 0, 42, 531, 62, 0, 0, 65, 0,
    /* 842 */ 0, 0, 0, 67, 48, 0, 0, 0, 53, 0, 0, 0, 531, 0, 0, 0, 64, 58, 0, 0, 531, 0, 0, 49, 0, 0, 0, 54, 0, 0, 0, 0,
    /* 874 */ 59, 0, 0, 0, 531, 62, 0, 0, 531, 0, 0, 0, 256, 896, 0, 35, 0, 39, 43, 531, 0, 0, 532, 0, 0, 0, 0, 896, 0,
    /* 903 */ 54, 0, 59, 62, 0, 0, 0, 531, 0, 63, 0, 0, 0, 59, 0, 531, 0, 0, 0, 0, 62, 640, 0, 0, 0, 532, 1045, 0, 0, 0,
    /* 933 */ 0, 0, 531, 0, 46
  ];

  var EXPECTED =
  [
    /*  0 */ 18, 24, 28, 32, 50, 20, 45, 36, 39, 48, 49, 38, 40, 48, 48, 37, 48, 44, 4, 8, 128, 4096, 256, 1024, 8192,
    /* 25 */ 16384, 260, 8448, 16640, 17408, 17416, 784, 2320, 17664, 2322, 6256, 4, 8, 16, 32, 32, 32, 4, 4, 16, 16,
    /* 46 */ 32, 4112, 4, 4, 4, 4, 8, 8
  ];

  var TOKEN =
  [
    "(0)",
    "byteOrderMark",
    "attributeValue",
    "attributeName",
    "comment",
    "charRef",
    "dataChar",
    "name",
    "s",
    "eof",
    "'/>'",
    "'<'",
    "'</'",
    "'='",
    "'>'"
  ];
}

// End
