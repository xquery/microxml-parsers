// This file was generated on Mon Sep 24, 2012 09:44 (UTC+02) by REx v5.16 which is Copyright (c) 1979-2012 by Gunther Rademacher <grd@gmx.net>
// REx command line: microxml.ebnf -backtrack -tree -java

import java.io.IOException;
import java.io.Writer;

public class microxml
{
  public static class ParseException extends RuntimeException
  {
    private static final long serialVersionUID = 1L;
    private int begin, end, offending, expected, state;

    public ParseException(int b, int e, int s, int o, int x)
    {
      begin = b;
      end = e;
      state = s;
      offending = o;
      expected = x;
    }

    public String getMessage()
    {
      return offending < 0 ? "lexical analysis failed" : "syntax error";
    }

    public int getBegin() {return begin;}
    public int getEnd() {return end;}
    public int getState() {return state;}
    public int getOffending() {return offending;}
    public int getExpected() {return expected;}
  }

  public static class TreeBuilder
  {
    public void startNonterminal(String tag) {}
    public void endNonterminal(String tag) {}
    public void characters(CharSequence input, int begin, int end) {}

    public void terminal(String tag, CharSequence input, int begin, int end)
    {
      if (tag.charAt(0) == '\'')
      {
        tag = "TOKEN";
      }
      startNonterminal(tag);
      characters(input, begin, end);
      endNonterminal(tag);
    }
  }

  public static class XmlSerializer extends TreeBuilder
  {
    private String delayedTag;
    private Writer out;

    public XmlSerializer(Writer w)
    {
      out = w;
      delayedTag = null;
    }

    public void startNonterminal(String tag)
    {
      if (delayedTag != null)
      {
        writeOutput("<");
        writeOutput(delayedTag);
        writeOutput(">");
      }
      delayedTag = tag;
    }

    public void endNonterminal(String tag)
    {
      if (delayedTag != null)
      {
        delayedTag = null;
        writeOutput("<");
        writeOutput(tag);
        writeOutput("/>");
      }
      else
      {
        writeOutput("</");
        writeOutput(tag);
        writeOutput(">");
      }
    }

    public void characters(CharSequence input, int begin, int end)
    {
      if (begin < end)
      {
        if (delayedTag != null)
        {
          writeOutput("<");
          writeOutput(delayedTag);
          writeOutput(">");
          delayedTag = null;
        }
        writeOutput(input.subSequence(begin, end)
                         .toString()
                         .replace("&", "&amp;")
                         .replace("<", "&lt;")
                         .replace(">", "&gt;"));
      }
    }

    private void writeOutput(String content)
    {
      try
      {
        out.write(content);
      }
      catch (IOException e)
      {
        throw new RuntimeException(e);
      }
    }
  }

  private TreeBuilder treeBuilder = null;

  public microxml(CharSequence string, TreeBuilder t)
  {
    initialize(string, t);
  }

  public void initialize(CharSequence string, TreeBuilder t)
  {
    treeBuilder = t;
    input = string;
    size = input.length();
    reset(0, 0, 0);
  }

  public CharSequence getInput()
  {
    return input;
  }

  public int getTokenOffset()
  {
    return b0;
  }

  public int getTokenEnd()
  {
    return e0;
  }

  public final void reset(int l, int b, int e)
  {
            b0 = b; e0 = b;
    l1 = l; b1 = b; e1 = e;
    l2 = 0;
    l3 = 0;
    end = e;
    ex = -1;
    memo.clear();
  }

  public void reset()
  {
    reset(0, 0, 0);
  }

  public static String getOffendingToken(ParseException e)
  {
    return e.getOffending() < 0 ? null : TOKEN[e.getOffending()];
  }

  public static String[] getExpectedTokenSet(ParseException e)
  {
    String[] expected;
    if (e.getExpected() < 0)
    {
      expected = getExpectedTokenSet(e.getState());
    }
    else
    {
      expected = new String[]{TOKEN[e.getExpected()]};
    }
    return expected;
  }

  public String getErrorMessage(ParseException e)
  {
    String[] tokenSet = getExpectedTokenSet(e);
    String found = getOffendingToken(e);
    String prefix = input.subSequence(0, e.getBegin()).toString();
    int line = prefix.replaceAll("[^\n]", "").length() + 1;
    int column = prefix.length() - prefix.lastIndexOf("\n");
    int size = e.getEnd() - e.getBegin();
    return e.getMessage()
         + (found == null ? "" : ", found " + found)
         + "\nwhile expecting "
         + (tokenSet.length == 1 ? tokenSet[0] : java.util.Arrays.toString(tokenSet))
         + "\n"
         + (size == 0 ? "" : "after successfully scanning " + size + " characters beginning ")
         + "at line " + line + ", column " + column + ":\n..."
         + input.subSequence(e.getBegin(), Math.min(input.length(), e.getBegin() + 64))
         + "...";
  }

  public void parse()
  {
    parse_document();
  }

  public void parse_document()
  {
    treeBuilder.startNonterminal("document");
    lookahead1(10);                 // byteOrderMark | comment | s | '<'
    if (l1 == 2)                    // byteOrderMark
    {
      shift(2);                     // byteOrderMark
    }
    for (;;)
    {
      lookahead1(8);                // comment | s | '<'
      if (l1 == 11)                 // '<'
      {
        break;
      }
      switch (l1)
      {
      case 5:                       // comment
        shift(5);                   // comment
        break;
      default:
        shift(9);                   // s
      }
    }
    parse_element();
    for (;;)
    {
      lookahead1(7);                // END | comment | s
      if (l1 == 1)                  // END
      {
        break;
      }
      switch (l1)
      {
      case 5:                       // comment
        shift(5);                   // comment
        break;
      default:
        shift(9);                   // s
      }
    }
    treeBuilder.endNonterminal("document");
  }

  private void parse_element()
  {
    treeBuilder.startNonterminal("element");
    switch (l1)
    {
    case 11:                        // '<'
      lookahead2(0);                // name
      switch (lk)
      {
      case 267:                     // '<' name
        lookahead3(9);              // s | '/>' | '>'
        break;
      }
      break;
    default:
      lk = l1;
    }
    if (lk == 9483)                 // '<' name s
    {
      lk = memoized(0, e0);
      if (lk == 0)
      {
        int b0A = b0; int e0A = e0; int l1A = l1;
        int b1A = b1; int e1A = e1; int l2A = l2;
        int b2A = b2; int e2A = e2; int l3A = l3;
        int b3A = b3; int e3A = e3;
        try
        {
          try_startTag();
          try_content();
          try_endTag();
          lk = -1;
        }
        catch (ParseException p1A)
        {
          lk = -2;
        }
        b0 = b0A; e0 = e0A; l1 = l1A; if (l1 == 0) {end = e0A;} else {
        b1 = b1A; e1 = e1A; l2 = l2A; if (l2 == 0) {end = e1A;} else {
        b2 = b2A; e2 = e2A; l3 = l3A; if (l3 == 0) {end = e2A;} else {
        b3 = b3A; e3 = e3A; end = e3A; }}}
        memoize(0, e0, lk);
      }
    }
    switch (lk)
    {
    case -1:
    case 14603:                     // '<' name '>'
      parse_startTag();
      parse_content();
      parse_endTag();
      break;
    default:
      parse_emptyElementTag();
    }
    treeBuilder.endNonterminal("element");
  }

  private void try_element()
  {
    switch (l1)
    {
    case 11:                        // '<'
      lookahead2(0);                // name
      switch (lk)
      {
      case 267:                     // '<' name
        lookahead3(9);              // s | '/>' | '>'
        break;
      }
      break;
    default:
      lk = l1;
    }
    if (lk == 9483)                 // '<' name s
    {
      lk = memoized(0, e0);
      if (lk == 0)
      {
        int b0A = b0; int e0A = e0; int l1A = l1;
        int b1A = b1; int e1A = e1; int l2A = l2;
        int b2A = b2; int e2A = e2; int l3A = l3;
        int b3A = b3; int e3A = e3;
        try
        {
          try_startTag();
          try_content();
          try_endTag();
          lk = -1;
        }
        catch (ParseException p1A)
        {
          lk = -2;
        }
        b0 = b0A; e0 = e0A; l1 = l1A; if (l1 == 0) {end = e0A;} else {
        b1 = b1A; e1 = e1A; l2 = l2A; if (l2 == 0) {end = e1A;} else {
        b2 = b2A; e2 = e2A; l3 = l3A; if (l3 == 0) {end = e2A;} else {
        b3 = b3A; e3 = e3A; end = e3A; }}}
        memoize(0, e0, lk);
      }
    }
    switch (lk)
    {
    case -1:
    case 14603:                     // '<' name '>'
      try_startTag();
      try_content();
      try_endTag();
      break;
    default:
      try_emptyElementTag();
    }
  }

  private void parse_startTag()
  {
    treeBuilder.startNonterminal("startTag");
    shift(11);                      // '<'
    lookahead1(0);                  // name
    shift(8);                       // name
    parse_attributeList();
    for (;;)
    {
      lookahead1(6);                // s | '>'
      if (l1 != 9)                  // s
      {
        break;
      }
      shift(9);                     // s
    }
    shift(14);                      // '>'
    treeBuilder.endNonterminal("startTag");
  }

  private void try_startTag()
  {
    shiftT(11);                     // '<'
    lookahead1(0);                  // name
    shiftT(8);                      // name
    try_attributeList();
    for (;;)
    {
      lookahead1(6);                // s | '>'
      if (l1 != 9)                  // s
      {
        break;
      }
      shiftT(9);                    // s
    }
    shiftT(14);                     // '>'
  }

  private void parse_endTag()
  {
    treeBuilder.startNonterminal("endTag");
    lookahead1(1);                  // '</'
    shift(12);                      // '</'
    lookahead1(0);                  // name
    shift(8);                       // name
    for (;;)
    {
      lookahead1(6);                // s | '>'
      if (l1 != 9)                  // s
      {
        break;
      }
      shift(9);                     // s
    }
    shift(14);                      // '>'
    treeBuilder.endNonterminal("endTag");
  }

  private void try_endTag()
  {
    lookahead1(1);                  // '</'
    shiftT(12);                     // '</'
    lookahead1(0);                  // name
    shiftT(8);                      // name
    for (;;)
    {
      lookahead1(6);                // s | '>'
      if (l1 != 9)                  // s
      {
        break;
      }
      shiftT(9);                    // s
    }
    shiftT(14);                     // '>'
  }

  private void parse_content()
  {
    treeBuilder.startNonterminal("content");
    for (;;)
    {
      lookahead1(12);               // comment | charRef | dataChar | '<' | '</'
      if (l1 == 12)                 // '</'
      {
        break;
      }
      switch (l1)
      {
      case 11:                      // '<'
        parse_element();
        break;
      case 5:                       // comment
        shift(5);                   // comment
        break;
      case 7:                       // dataChar
        shift(7);                   // dataChar
        break;
      default:
        shift(6);                   // charRef
      }
    }
    treeBuilder.endNonterminal("content");
  }

  private void try_content()
  {
    for (;;)
    {
      lookahead1(12);               // comment | charRef | dataChar | '<' | '</'
      if (l1 == 12)                 // '</'
      {
        break;
      }
      switch (l1)
      {
      case 11:                      // '<'
        try_element();
        break;
      case 5:                       // comment
        shiftT(5);                  // comment
        break;
      case 7:                       // dataChar
        shiftT(7);                  // dataChar
        break;
      default:
        shiftT(6);                  // charRef
      }
    }
  }

  private void parse_emptyElementTag()
  {
    treeBuilder.startNonterminal("emptyElementTag");
    shift(11);                      // '<'
    lookahead1(0);                  // name
    shift(8);                       // name
    parse_attributeList();
    for (;;)
    {
      lookahead1(4);                // s | '/>'
      if (l1 != 9)                  // s
      {
        break;
      }
      shift(9);                     // s
    }
    shift(10);                      // '/>'
    treeBuilder.endNonterminal("emptyElementTag");
  }

  private void try_emptyElementTag()
  {
    shiftT(11);                     // '<'
    lookahead1(0);                  // name
    shiftT(8);                      // name
    try_attributeList();
    for (;;)
    {
      lookahead1(4);                // s | '/>'
      if (l1 != 9)                  // s
      {
        break;
      }
      shiftT(9);                    // s
    }
    shiftT(10);                     // '/>'
  }

  private void parse_attributeList()
  {
    treeBuilder.startNonterminal("attributeList");
    for (;;)
    {
      lookahead1(9);                // s | '/>' | '>'
      switch (l1)
      {
      case 9:                       // s
        lookahead2(11);             // attributeName | s | '/>' | '>'
        switch (lk)
        {
        case 297:                   // s s
          lookahead3(11);           // attributeName | s | '/>' | '>'
          break;
        }
        break;
      default:
        lk = l1;
      }
      if (lk == 9513)               // s s s
      {
        lk = memoized(1, e0);
        if (lk == 0)
        {
          int b0A = b0; int e0A = e0; int l1A = l1;
          int b1A = b1; int e1A = e1; int l2A = l2;
          int b2A = b2; int e2A = e2; int l3A = l3;
          int b3A = b3; int e3A = e3;
          try
          {
            for (;;)
            {
              shiftT(9);            // s
              lookahead1(3);        // attributeName | s
              if (l1 != 9)          // s
              {
                break;
              }
            }
            try_attribute();
            lk = -1;
          }
          catch (ParseException p1A)
          {
            lk = -2;
          }
          b0 = b0A; e0 = e0A; l1 = l1A; if (l1 == 0) {end = e0A;} else {
          b1 = b1A; e1 = e1A; l2 = l2A; if (l2 == 0) {end = e1A;} else {
          b2 = b2A; e2 = e2A; l3 = l3A; if (l3 == 0) {end = e2A;} else {
          b3 = b3A; e3 = e3A; end = e3A; }}}
          memoize(1, e0, lk);
        }
      }
      if (lk != -1
       && lk != 137                 // s attributeName
       && lk != 4393)               // s s attributeName
      {
        break;
      }
      for (;;)
      {
        shift(9);                   // s
        lookahead1(3);              // attributeName | s
        if (l1 != 9)                // s
        {
          break;
        }
      }
      parse_attribute();
    }
    treeBuilder.endNonterminal("attributeList");
  }

  private void try_attributeList()
  {
    for (;;)
    {
      lookahead1(9);                // s | '/>' | '>'
      switch (l1)
      {
      case 9:                       // s
        lookahead2(11);             // attributeName | s | '/>' | '>'
        switch (lk)
        {
        case 297:                   // s s
          lookahead3(11);           // attributeName | s | '/>' | '>'
          break;
        }
        break;
      default:
        lk = l1;
      }
      if (lk == 9513)               // s s s
      {
        lk = memoized(1, e0);
        if (lk == 0)
        {
          int b0A = b0; int e0A = e0; int l1A = l1;
          int b1A = b1; int e1A = e1; int l2A = l2;
          int b2A = b2; int e2A = e2; int l3A = l3;
          int b3A = b3; int e3A = e3;
          try
          {
            for (;;)
            {
              shiftT(9);            // s
              lookahead1(3);        // attributeName | s
              if (l1 != 9)          // s
              {
                break;
              }
            }
            try_attribute();
            lk = -1;
          }
          catch (ParseException p1A)
          {
            lk = -2;
          }
          b0 = b0A; e0 = e0A; l1 = l1A; if (l1 == 0) {end = e0A;} else {
          b1 = b1A; e1 = e1A; l2 = l2A; if (l2 == 0) {end = e1A;} else {
          b2 = b2A; e2 = e2A; l3 = l3A; if (l3 == 0) {end = e2A;} else {
          b3 = b3A; e3 = e3A; end = e3A; }}}
          memoize(1, e0, lk);
        }
      }
      if (lk != -1
       && lk != 137                 // s attributeName
       && lk != 4393)               // s s attributeName
      {
        break;
      }
      for (;;)
      {
        shiftT(9);                  // s
        lookahead1(3);              // attributeName | s
        if (l1 != 9)                // s
        {
          break;
        }
      }
      try_attribute();
    }
  }

  private void parse_attribute()
  {
    treeBuilder.startNonterminal("attribute");
    shift(4);                       // attributeName
    for (;;)
    {
      lookahead1(5);                // s | '='
      if (l1 != 9)                  // s
      {
        break;
      }
      shift(9);                     // s
    }
    shift(13);                      // '='
    for (;;)
    {
      lookahead1(2);                // attributeValue | s
      if (l1 != 9)                  // s
      {
        break;
      }
      shift(9);                     // s
    }
    shift(3);                       // attributeValue
    treeBuilder.endNonterminal("attribute");
  }

  private void try_attribute()
  {
    shiftT(4);                      // attributeName
    for (;;)
    {
      lookahead1(5);                // s | '='
      if (l1 != 9)                  // s
      {
        break;
      }
      shiftT(9);                    // s
    }
    shiftT(13);                     // '='
    for (;;)
    {
      lookahead1(2);                // attributeValue | s
      if (l1 != 9)                  // s
      {
        break;
      }
      shiftT(9);                    // s
    }
    shiftT(3);                      // attributeValue
  }

  private int lk, b0, e0;
  private int l1, b1, e1;
  private int l2, b2, e2;
  private int l3, b3, e3;
  private int bx, ex, sx, lx, tx;
  private java.util.Map<Integer, Integer> memo = new java.util.HashMap<Integer, Integer>();

  private void memoize(int i, int e, int v)
  {
    memo.put((e << 1) + i, v);
  }

  private int memoized(int i, int e)
  {
    Integer v = memo.get((e << 1) + i);
    return v == null ? 0 : v;
  }

  private void error(int b, int e, int s, int l, int t)
  {
    if (e > ex)
    {
      bx = b;
      ex = e;
      sx = s;
      lx = l;
      tx = t;
    }
    throw new ParseException(bx, ex, sx, lx, tx);
  }

  private void shift(int t)
  {
    if (l1 == t)
    {
      if (e0 != b1)
      {
        treeBuilder.characters(input, e0, b1);
      }
      treeBuilder.terminal(TOKEN[l1], input, b1, e1 > size ? size : e1);
      b0 = b1; e0 = e1; l1 = l2; if (l1 != 0) {
      b1 = b2; e1 = e2; l2 = l3; if (l2 != 0) {
      b2 = b3; e2 = e3; l3 = 0; }}
    }
    else
    {
      error(b1, e1, 0, l1, t);
    }
  }

  private void shiftT(int t)
  {
    if (l1 == t)
    {
      b0 = b1; e0 = e1; l1 = l2; if (l1 != 0) {
      b1 = b2; e1 = e2; l2 = l3; if (l2 != 0) {
      b2 = b3; e2 = e3; l3 = 0; }}
    }
    else
    {
      error(b1, e1, 0, l1, t);
    }
  }

  private void lookahead1(int set)
  {
    if (l1 == 0)
    {
      l1 = match(set);
      b1 = begin;
      e1 = end;
    }
  }

  private void lookahead2(int set)
  {
    if (l2 == 0)
    {
      l2 = match(set);
      b2 = begin;
      e2 = end;
    }
    lk = (l2 << 5) | l1;
  }

  private void lookahead3(int set)
  {
    if (l3 == 0)
    {
      l3 = match(set);
      b3 = begin;
      e3 = end;
    }
    lk |= l3 << 10;
  }

  private CharSequence input = null;
  private int size = 0;
  private int begin = 0;
  private int end = 0;
  private int state = 0;

  private int match(int tokenset)
  {
    begin = end;
    int current = end;
    int result = INITIAL[tokenset];

    for (int code = result & 127; code != 0; )
    {
      int charclass;
      int c0 = current < size ? input.charAt(current) : 0;
      ++current;
      if (c0 < 0x80)
      {
        charclass = MAP0[c0];
      }
      else if (c0 < 0xd800)
      {
        int c1 = c0 >> 4;
        charclass = MAP1[(c0 & 15) + MAP1[(c1 & 31) + MAP1[c1 >> 5]]];
      }
      else
      {
        if (c0 < 0xdc00)
        {
          int c1 = current < size ? input.charAt(current) : 0;
          if (c1 >= 0xdc00 && c1 < 0xe000)
          {
            ++current;
            c0 = ((c0 & 0x3ff) << 10) + (c1 & 0x3ff) + 0x10000;
          }
          else
          {
            c0 = -1;
          }
        }

        int lo = 0, hi = 20;
        for (int m = 10; ; m = (hi + lo) >> 1)
        {
          if (MAP2[m] > c0) {hi = m - 1;}
          else if (MAP2[21 + m] < c0) {lo = m + 1;}
          else {charclass = MAP2[42 + m]; break;}
          if (lo > hi) {charclass = 0; break;}
        }
      }

      state = code;
      int i0 = (charclass << 7) + code - 1;
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
      int c1 = end < size ? input.charAt(end) : 0;
      if (c1 >= 0xdc00 && c1 < 0xe000)
      {
        --end;
      }
      error(begin, end, state, -1, -1);
    }

    return (result & 15) - 1;
  }

  private static String[] getExpectedTokenSet(int s)
  {
    java.util.ArrayList<String> expected = new java.util.ArrayList<String>();
    if (s > 0)
    {
      for (int i = 0; i < 15; i += 32)
      {
        int j = i;
        int i0 = (i >> 5) * 66 + s - 1;
        int f = EXPECTED[(i0 & 3) + EXPECTED[i0 >> 2]];
        for ( ; f != 0; f >>>= 1, ++j)
        {
          if ((f & 1) != 0)
          {
            expected.add(TOKEN[j]);
          }
        }
      }
    }
    return expected.toArray(new String[]{});
  }

  private static final int MAP0[] =
  {
    /*   0 */ 0, 0, 32, 32, 32, 32, 32, 0, 32, 1, 1, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
    /*  28 */ 32, 32, 32, 32, 1, 2, 3, 4, 32, 32, 5, 6, 32, 32, 32, 32, 32, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10,
    /*  57 */ 11, 32, 12, 13, 14, 15, 32, 32, 16, 16, 16, 16, 16, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
    /*  83 */ 18, 18, 18, 18, 18, 18, 18, 18, 32, 32, 32, 32, 18, 32, 19, 16, 16, 16, 16, 16, 20, 18, 18, 18, 18, 21,
    /* 109 */ 22, 23, 24, 25, 26, 18, 27, 28, 29, 18, 18, 30, 18, 18, 32, 32, 32, 32, 32
  };

  private static final int MAP1[] =
  {
    /*   0 */ 108, 124, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 156, 181, 181, 181, 181,
    /*  21 */ 181, 214, 215, 213, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    /*  42 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    /*  63 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    /*  84 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
    /* 105 */ 214, 214, 214, 247, 266, 283, 299, 314, 352, 368, 384, 266, 266, 266, 258, 336, 328, 336, 328, 336, 336,
    /* 126 */ 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 411, 411, 411, 411, 411, 411, 411,
    /* 147 */ 321, 336, 336, 336, 336, 336, 336, 336, 336, 395, 266, 266, 267, 265, 266, 266, 336, 336, 336, 336, 336,
    /* 168 */ 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 266, 266, 266, 266, 266, 266, 266, 266,
    /* 189 */ 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266,
    /* 210 */ 266, 266, 266, 335, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336,
    /* 231 */ 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 266, 0, 0, 32, 32, 32, 32, 32,
    /* 254 */ 0, 32, 1, 1, 32, 32, 32, 32, 32, 32, 32, 8, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
    /* 281 */ 32, 8, 1, 2, 3, 4, 32, 32, 5, 6, 32, 32, 32, 32, 32, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 32,
    /* 310 */ 12, 13, 14, 15, 32, 16, 16, 16, 16, 16, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 32,
    /* 336 */ 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
    /* 362 */ 18, 32, 32, 32, 32, 18, 32, 19, 16, 16, 16, 16, 16, 20, 18, 18, 18, 18, 21, 22, 23, 24, 25, 26, 18, 27,
    /* 388 */ 28, 29, 18, 18, 30, 18, 18, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 18, 18, 32, 32, 8, 8, 8, 8, 8,
    /* 416 */ 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
  };

  private static final int MAP2[] =
  {
    /*  0 */ 57344, 63744, 65008, 65279, 65280, 65536, 131072, 196608, 262144, 327680, 393216, 458752, 524288, 589824,
    /* 14 */ 655360, 720896, 786432, 851968, 917504, 983040, 1048576, 63743, 64975, 65278, 65279, 65533, 131069, 196605,
    /* 28 */ 262141, 327677, 393213, 458749, 524285, 589821, 655357, 720893, 786429, 851965, 917501, 983037, 1048573,
    /* 41 */ 1114109, 32, 18, 18, 31, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 32, 32
  };

  private static final int INITIAL[] =
  {
    /*  0 */ 1, 2, 3, 4, 5, 6, 7, 264, 9, 10, 11, 12, 13
  };

  private static final int TRANSITION[] =
  {
    /*   0 */ 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 663, 667, 828, 829, 829,
    /*  21 */ 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 829, 624, 528, 829, 829, 829, 829, 699, 700, 829,
    /*  42 */ 829, 829, 829, 829, 829, 829, 865, 636, 828, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829,
    /*  63 */ 829, 829, 624, 543, 551, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 829, 588, 561, 829,
    /*  84 */ 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 826, 624, 572, 829, 829, 829, 829, 699, 700,
    /* 105 */ 829, 829, 829, 829, 829, 829, 829, 829, 731, 584, 596, 830, 700, 829, 608, 620, 829, 829, 829, 829, 829,
    /* 126 */ 829, 829, 829, 731, 584, 754, 830, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 576, 915, 951,
    /* 147 */ 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 829, 731, 584, 754, 830, 908, 727, 644,
    /* 168 */ 700, 829, 829, 829, 829, 829, 829, 829, 829, 868, 675, 754, 830, 908, 727, 692, 829, 829, 829, 829, 829,
    /* 189 */ 829, 829, 829, 829, 624, 828, 829, 829, 612, 822, 945, 700, 829, 829, 829, 829, 829, 829, 829, 535, 709,
    /* 210 */ 829, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 564, 624, 828, 829, 829, 829, 829,
    /* 231 */ 699, 700, 829, 829, 829, 829, 829, 829, 829, 553, 722, 775, 829, 829, 829, 829, 699, 739, 829, 829, 829,
    /* 252 */ 829, 829, 829, 829, 752, 780, 584, 754, 830, 908, 727, 644, 700, 829, 829, 829, 829, 829, 829, 829, 752,
    /* 273 */ 684, 675, 754, 830, 908, 727, 692, 829, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 754, 830, 829,
    /* 294 */ 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 762, 770, 830, 908, 727, 644, 700, 829, 829,
    /* 315 */ 829, 829, 829, 829, 829, 752, 780, 788, 859, 830, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829,
    /* 336 */ 752, 780, 788, 796, 830, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 810, 657, 838,
    /* 357 */ 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 754, 701, 829, 829, 632, 700, 829,
    /* 378 */ 829, 829, 829, 829, 829, 829, 752, 780, 584, 754, 830, 714, 852, 632, 700, 829, 829, 829, 829, 829, 829,
    /* 399 */ 829, 752, 780, 584, 938, 876, 885, 600, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 893, 901,
    /* 420 */ 830, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 754, 830, 829, 829, 923, 700,
    /* 441 */ 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 882, 651, 829, 829, 632, 700, 829, 829, 829, 829, 829,
    /* 462 */ 829, 829, 752, 780, 584, 844, 802, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 931, 744, 584,
    /* 483 */ 959, 680, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 816, 584, 754, 830, 829, 829, 632,
    /* 504 */ 700, 829, 829, 829, 829, 829, 829, 829, 829, 624, 828, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829,
    /* 525 */ 829, 829, 829, 17, 0, 0, 0, 27, 0, 27, 0, 15, 0, 0, 0, 0, 0, 21, 17, 0, 0, 0, 0, 28, 0, 32, 36, 0, 0, 0,
    /* 555 */ 0, 0, 0, 0, 1920, 0, 25, 0, 0, 0, 0, 0, 0, 0, 1792, 0, 0, 512, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 17, 658,
    /* 586 */ 658, 0, 0, 0, 0, 0, 22, 0, 0, 24, 0, 658, 41, 0, 0, 0, 0, 0, 55, 0, 0, 0, 658, 65, 0, 0, 0, 0, 0, 0, 896,
    /* 617 */ 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 0, 1024, 0, 0, 16, 658, 58, 0, 0, 0, 0, 0, 0, 1024, 0, 0, 512, 658, 58, 59,
    /* 647 */ 0, 61, 0, 63, 0, 50, 0, 0, 0, 55, 0, 658, 0, 0, 43, 0, 0, 0, 1280, 1280, 1280, 1280, 1280, 1280, 1024, 0,
    /* 673 */ 0, 16, 0, 658, 658, 0, 0, 0, 0, 0, 52, 0, 0, 0, 658, 0, 1166, 0, 0, 658, 0, 59, 0, 61, 0, 63, 0, 58, 0, 0,
    /* 703 */ 0, 0, 0, 0, 0, 697, 1557, 0, 1557, 0, 1559, 0, 0, 0, 60, 0, 30, 0, 0, 0, 1920, 0, 1920, 0, 0, 0, 0, 63, 0,
    /* 732 */ 0, 0, 0, 1024, 1166, 0, 16, 58, 768, 0, 0, 0, 0, 0, 0, 659, 1024, 1166, 0, 16, 1166, 0, 0, 658, 0, 0, 0,
    /* 759 */ 0, 0, 0, 17, 658, 658, 0, 0, 29, 0, 33, 37, 658, 0, 0, 0, 0, 0, 0, 1408, 0, 0, 0, 0, 658, 1024, 1166, 0,
    /* 787 */ 16, 17, 658, 658, 0, 0, 30, 0, 34, 38, 680, 0, 0, 0, 0, 0, 0, 51, 0, 0, 0, 56, 658, 17, 658, 666, 0, 0, 0,
    /* 816 */ 0, 0, 384, 658, 1024, 1166, 0, 16, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 658, 48, 0, 0, 0, 53, 0, 0,
    /* 845 */ 658, 0, 0, 0, 0, 46, 0, 62, 0, 34, 0, 0, 64, 0, 38, 658, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 1166, 0, 0,
    /* 876 */ 49, 0, 0, 0, 54, 0, 0, 658, 0, 0, 0, 45, 0, 0, 0, 0, 50, 17, 658, 658, 0, 0, 31, 0, 35, 39, 658, 0, 0, 0,
    /* 906 */ 0, 0, 0, 59, 0, 0, 0, 0, 61, 0, 20, 0, 20, 1024, 0, 1664, 16, 18, 58, 0, 45, 0, 50, 0, 55, 1166, 0, 0,
    /* 934 */ 659, 0, 0, 0, 0, 658, 0, 0, 44, 0, 0, 0, 58, 896, 0, 16, 0, 17, 0, 0, 0, 0, 0, 1664, 0, 0, 658, 0, 42, 0,
    /* 964 */ 0, 0, 47
  };

  private static final int EXPECTED[] =
  {
    /*  0 */ 17, 21, 25, 29, 49, 46, 37, 40, 32, 33, 39, 41, 32, 32, 38, 32, 45, 256, 4096, 520, 528, 1536, 8704, 16896,
    /* 24 */ 544, 2592, 17920, 2596, 17936, 6368, 256, 4096, 8, 8, 8, 8, 16, 8, 16, 32, 64, 64, 64, 8, 8, 32, 32, 64,
    /* 48 */ 4128, 8, 16, 16, 1024
  };

  private static final String TOKEN[] =
  {
    "(0)",
    "END",
    "byteOrderMark",
    "attributeValue",
    "attributeName",
    "comment",
    "charRef",
    "dataChar",
    "name",
    "s",
    "'/>'",
    "'<'",
    "'</'",
    "'='",
    "'>'"
  };
}

// End
