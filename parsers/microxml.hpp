// This file was generated on Mon Sep 24, 2012 09:44 (UTC+02) by REx v5.16 which is Copyright (c) 1979-2012 by Gunther Rademacher <grd@gmx.net>
// REx command line: microxml.ebnf -backtrack -tree -cpp

#ifndef MICROXML_HPP
#define MICROXML_HPP

#include <stdio.h>
#include <string>
#include <map>
#include <wchar.h>

class MalformedInputException
{
public:
  MalformedInputException(size_t offset) : offset(offset) {}
  size_t getOffset() const {return offset;}

private:
  size_t offset;
};

class Utf8Encoder
{
public:
  static std::string encode(const wchar_t *unencoded)
  {
    return encode(unencoded, wcslen(unencoded));
  }

  static std::string encode(const wchar_t *unencoded, size_t size)
  {
    std::string encoded;
    encoded.reserve(size + 3);

    for (size_t i = 0; i < size; ++i)
    {
      if (encoded.size() + 4 >= encoded.capacity()) encoded.reserve(encoded.capacity() * 2);

      int w = unencoded[i];
      if (w < 0x80)
      {
        encoded += w;
      }
      else if (w < 0x800)
      {
        encoded += 0xc0 | (w >> 6);
        encoded += 0x80 | (w & 0x3f);
      }
      else if (w < 0xd800)
      {
        encoded += 0xe0 | ( w          >> 12);
        encoded += 0x80 | ((w & 0xfff) >>  6);
        encoded += 0x80 | ( w &  0x3f       );
      }
      else if (w < 0xe000)
      {
        if (++i >= size)
        {
          throw MalformedInputException(i - 1);
        }
        int w2 = unencoded[i];
        if (w2 < 0xdc00 || w2 > 0xdfff)
        {
          throw MalformedInputException(i - 1);
        }
        w = (((w  & 0x3ff) << 10) | (w2 & 0x3ff)) + 0x10000;
        encoded += 0xf0 | ( w            >> 18);
        encoded += 0x80 | ((w & 0x3ffff) >> 12);
        encoded += 0x80 | ((w &   0xfff) >>  6);
        encoded += 0x80 | ( w &    0x3f       );
      }
      else if (w < 0x10000)
      {
        encoded += 0xe0 | ( w          >> 12);
        encoded += 0x80 | ((w & 0xfff) >>  6);
        encoded += 0x80 | ( w &  0x3f       );
      }
      else if (w < 0x110000)
      {
        encoded += 0xf0 | ( w            >> 18);
        encoded += 0x80 | ((w & 0x3ffff) >> 12);
        encoded += 0x80 | ((w &   0xfff) >>  6);
        encoded += 0x80 | ( w &    0x3f       );
      }
      else
      {
        throw MalformedInputException(i);
      }
    }
    return encoded;
  }
};

class microxml
{
public:
  microxml(const wchar_t *string)
  {
    initialize(string);
  }

  ~microxml()
  {
    terminate();
  }

  class ParseException
  {
  private:
    int begin, end, offending, expected, state;
    friend class microxml;

  protected:
    ParseException(int b, int e, int s, int o, int x)
    {
      begin = b;
      end = e;
      state = s;
      offending = o;
      expected = x;
    }

  public:
    const wchar_t *getMessage()
    {
      return offending < 0 ? L"lexical analysis failed" : L"syntax error";
    }
    int getBegin() {return begin;}
    int getEnd() {return end;}
    int getState() {return state;}
    int getOffending() {return offending;}
    int getExpected() {return expected;}
  };

  const wchar_t *getInput() const
  {
    return input;
  }

  int getTokenOffset() const
  {
    return b0;
  }

  int getTokenEnd() const
  {
    return e0;
  }

  void reset(int l, int b, int e)
  {
            b0 = b; e0 = b;
    l1 = l; b1 = b; e1 = e;
    l2 = 0;
    l3 = 0;
    end = e;
    ex = -1;
    memo.clear();
  }

  void reset()
  {
    reset(0, 0, 0);
  }

  static const wchar_t *getOffendingToken(ParseException e)
  {
    return e.getOffending() < 0 ? 0 : t1[e.getOffending()];
  }

  static void getExpectedTokenSet(const ParseException &e, const wchar_t **set, int size)
  {
    if (e.expected < 0)
    {
      getExpectedTokenSet(e.state, set, size);
    }
    else if (size == 1)
    {
      set[0] = 0;
    }
    else if (size > 1)
    {
      set[0] = t1[e.expected];
      set[1] = 0;
    }
  }

  void parse_document()
  {
    startNonterminal(L"document");
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
        break;
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
        break;
      }
    }
    endNonterminal(L"document");
  }

private:
  void initialize(const wchar_t *string)
  {
    input = string;
    reset();
    delayedTag = 0;
  }

  void terminate()
  {
  }

  void parse_element()
  {
    startNonterminal(L"element");
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
      break;
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
        catch (ParseException &)
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
      break;
    }
    endNonterminal(L"element");
  }

  void try_element()
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
      break;
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
        catch (ParseException &)
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
      break;
    }
  }

  void parse_startTag()
  {
    startNonterminal(L"startTag");
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
    endNonterminal(L"startTag");
  }

  void try_startTag()
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

  void parse_endTag()
  {
    startNonterminal(L"endTag");
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
    endNonterminal(L"endTag");
  }

  void try_endTag()
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

  void parse_content()
  {
    startNonterminal(L"content");
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
        break;
      }
    }
    endNonterminal(L"content");
  }

  void try_content()
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
        break;
      }
    }
  }

  void parse_emptyElementTag()
  {
    startNonterminal(L"emptyElementTag");
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
    endNonterminal(L"emptyElementTag");
  }

  void try_emptyElementTag()
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

  void parse_attributeList()
  {
    startNonterminal(L"attributeList");
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
        break;
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
          catch (ParseException &)
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
    endNonterminal(L"attributeList");
  }

  void try_attributeList()
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
        break;
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
          catch (ParseException &)
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

  void parse_attribute()
  {
    startNonterminal(L"attribute");
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
    endNonterminal(L"attribute");
  }

  void try_attribute()
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

  int lk, b0, e0;
  int l1, b1, e1;
  int l2, b2, e2;
  int l3, b3, e3;
  int bx, ex, sx, lx, tx;
  const wchar_t *delayedTag;
  std::map<int, int> memo;

  void startNonterminal(const wchar_t *tag)
  {
    if (delayedTag != 0) fprintf(stdout, "<%s>", Utf8Encoder::encode(delayedTag).c_str());
    delayedTag = tag;
  }

  void endNonterminal(const wchar_t *tag)
  {
    if (delayedTag != 0)
      fprintf(stdout, "<%s/>", Utf8Encoder::encode(tag).c_str());
    else
      fprintf(stdout, "</%s>", Utf8Encoder::encode(tag).c_str());
    delayedTag = 0;
  }

  void characters(const wchar_t *input, int b, int e)
  {
    std::string encoded = Utf8Encoder::encode(input + b, e - b);
    int size = encoded.size();

    if (size > 0 && encoded[0] != 0)
    {
      if (delayedTag != 0)
      {
        fprintf(stdout, "<%s>", Utf8Encoder::encode(delayedTag).c_str());
        delayedTag = 0;
      }

      for (int i = 0; i < size; ++i)
      {
        char c = encoded[i];
        switch (c)
        {
        case 0: break;
        case L'&': fprintf(stdout, "&amp;"); break;
        case L'<': fprintf(stdout, "&lt;"); break;
        case L'>': fprintf(stdout, "&gt;"); break;
        default: fprintf(stdout, "%c", c);
        }
      }
    }
  }

  void terminal(const wchar_t *tag, const wchar_t *input, int b, int e)
  {
    if (tag[0] == L'\'') tag = L"TOKEN";
    startNonterminal(tag);
    characters(input, b, e);
    endNonterminal(tag);
  }

  void memoize(int i, int e, int v)
  {
    memo[(e << 1) + i] = v;
  }

  int memoized(int i, int e)
  {
    std::map<int, int>::iterator v = memo.find((e << 1) + i);
    return v != memo.end() ? v->second : 0;
  }

  void error(int b, int e, int s, int l, int t)
  {
    if (e > ex)
    {
      bx = b;
      ex = e;
      sx = s;
      lx = l;
      tx = t;
    }
    throw ParseException(bx, ex, sx, lx, tx);
  }

  void shift(int t)
  {
    if (l1 == t)
    {
      if (e0 != b1)
      {
        characters(input, e0, b1);
      }
      terminal(t1[l1], input, b1, e1);
      b0 = b1; e0 = e1; l1 = l2; if (l1 != 0) {
      b1 = b2; e1 = e2; l2 = l3; if (l2 != 0) {
      b2 = b3; e2 = e3; l3 = 0; }}
    }
    else
    {
      error(b1, e1, 0, l1, t);
    }
  }

  void shiftT(int t)
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

  void lookahead1(int set)
  {
    if (l1 == 0)
    {
      l1 = match(set);
      b1 = begin;
      e1 = end;
    }
  }

  void lookahead2(int set)
  {
    if (l2 == 0)
    {
      l2 = match(set);
      b2 = begin;
      e2 = end;
    }
    lk = (l2 << 5) | l1;
  }

  void lookahead3(int set)
  {
    if (l3 == 0)
    {
      l3 = match(set);
      b3 = begin;
      e3 = end;
    }
    lk |= l3 << 10;
  }

  const wchar_t *input;
  int begin;
  int end;
  int state;

  int match(int tokenset)
  {
    begin = end;
    int current = end;
    int result = a0[tokenset];

    for (int code = result & 127; code != 0; )
    {
      int charclass;
      int c0 = input[current];
      ++current;
      if (c0 < 0x80)
      {
        charclass = m0[c0];
      }
      else if (c0 < 0xd800)
      {
        int c1 = c0 >> 4;
        charclass = m1[(c0 & 15) + m1[(c1 & 31) + m1[c1 >> 5]]];
      }
      else
      {
        if (c0 < 0xdc00)
        {
          int c1 = input[current];
          if (c1 >= 0xdc00 && c1 < 0xe000)
          {
            ++current;
            c0 = ((c0 & 0x3ff) << 10) + (c1 & 0x3ff) + 0x10000;
          }
        }
        int lo = 0, hi = 20;
        for (int m = 10; ; m = (hi + lo) >> 1)
        {
          if (m2[m] > c0) hi = m - 1;
          else if (m2[21 + m] < c0) lo = m + 1;
          else {charclass = m2[42 + m]; break;}
          if (lo > hi) {charclass = 0; break;}
        }
      }

      state = code;
      int i0 = (charclass << 7) + code - 1;
      code = a1[(i0 & 7) + a1[i0 >> 3]];
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
      int c1 = input[end];
      if (c1 >= 0xdc00 && c1 < 0xe000) --end;
      throw ParseException(begin, end, state, -1, -1);
    }

    return (result & 15) - 1;
  }

  static void getExpectedTokenSet(int s, const wchar_t **set, int size)
  {
    if (s > 0)
    {
      for (int i = 0; i < 15; i += 32)
      {
        int j = i;
        for (unsigned int f = ec(i >> 5, s); f != 0; f >>= 1, ++j)
        {
          if ((f & 1) != 0)
          {
            if (size > 1)
            {
              set[0] = t1[j];
              ++set;
              --size;
            }
          }
        }
      }
    }
    if (size > 0)
    {
      set[0] = 0;
    }
  }

  static int ec(int t, int s)
  {
    int i0 = t * 66 + s - 1;
    return t0[(i0 & 3) + t0[i0 >> 2]];
  }

  static const int m0[];
  static const int m1[];
  static const int m2[];
  static const int a0[];
  static const int a1[];
  static const int t0[];
  static const wchar_t *t1[];
};

const int microxml::m0[] =
{
/*   0 */ 0, 0, 32, 32, 32, 32, 32, 0, 32, 1, 1, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
/*  29 */ 32, 32, 32, 1, 2, 3, 4, 32, 32, 5, 6, 32, 32, 32, 32, 32, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 32,
/*  59 */ 12, 13, 14, 15, 32, 32, 16, 16, 16, 16, 16, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
/*  86 */ 18, 18, 18, 18, 18, 32, 32, 32, 32, 18, 32, 19, 16, 16, 16, 16, 16, 20, 18, 18, 18, 18, 21, 22, 23, 24, 25,
/* 113 */ 26, 18, 27, 28, 29, 18, 18, 30, 18, 18, 32, 32, 32, 32, 32
};

const int microxml::m1[] =
{
/*   0 */ 108, 124, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 156, 181, 181, 181, 181, 181,
/*  22 */ 214, 215, 213, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
/*  44 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
/*  66 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
/*  88 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 247, 266,
/* 110 */ 283, 299, 314, 352, 368, 384, 266, 266, 266, 258, 336, 328, 336, 328, 336, 336, 336, 336, 336, 336, 336, 336,
/* 132 */ 336, 336, 336, 336, 336, 336, 336, 336, 411, 411, 411, 411, 411, 411, 411, 321, 336, 336, 336, 336, 336, 336,
/* 154 */ 336, 336, 395, 266, 266, 267, 265, 266, 266, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336,
/* 176 */ 336, 336, 336, 336, 336, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266,
/* 198 */ 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 335, 336, 336, 336, 336, 336, 336,
/* 220 */ 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336,
/* 242 */ 336, 336, 336, 336, 266, 0, 0, 32, 32, 32, 32, 32, 0, 32, 1, 1, 32, 32, 32, 32, 32, 32, 32, 8, 32, 32, 32, 32,
/* 270 */ 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 8, 1, 2, 3, 4, 32, 32, 5, 6, 32, 32, 32, 32, 32, 7, 8, 9, 10,
/* 300 */ 10, 10, 10, 10, 10, 10, 10, 10, 11, 32, 12, 13, 14, 15, 32, 16, 16, 16, 16, 16, 17, 18, 18, 18, 18, 18, 18,
/* 327 */ 18, 18, 18, 18, 18, 18, 18, 18, 32, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
/* 354 */ 18, 18, 18, 18, 18, 18, 18, 18, 18, 32, 32, 32, 32, 18, 32, 19, 16, 16, 16, 16, 16, 20, 18, 18, 18, 18, 21,
/* 381 */ 22, 23, 24, 25, 26, 18, 27, 28, 29, 18, 18, 30, 18, 18, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 18,
/* 408 */ 18, 32, 32, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
};

const int microxml::m2[] =
{
/*  0 */ 57344, 63744, 65008, 65279, 65280, 65536, 131072, 196608, 262144, 327680, 393216, 458752, 524288, 589824,
/* 14 */ 655360, 720896, 786432, 851968, 917504, 983040, 1048576, 63743, 64975, 65278, 65279, 65533, 131069, 196605,
/* 28 */ 262141, 327677, 393213, 458749, 524285, 589821, 655357, 720893, 786429, 851965, 917501, 983037, 1048573,
/* 41 */ 1114109, 32, 18, 18, 31, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 32, 32
};

const int microxml::a0[] =
{
/*  0 */ 1, 2, 3, 4, 5, 6, 7, 264, 9, 10, 11, 12, 13
};

const int microxml::a1[] =
{
/*   0 */ 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 663, 667, 828, 829, 829, 829,
/*  22 */ 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 829, 624, 528, 829, 829, 829, 829, 699, 700, 829, 829, 829,
/*  44 */ 829, 829, 829, 829, 865, 636, 828, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 829, 624,
/*  66 */ 543, 551, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 829, 588, 561, 829, 829, 829, 829, 699,
/*  88 */ 700, 829, 829, 829, 829, 829, 829, 829, 826, 624, 572, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829,
/* 110 */ 829, 829, 829, 731, 584, 596, 830, 700, 829, 608, 620, 829, 829, 829, 829, 829, 829, 829, 829, 731, 584, 754,
/* 132 */ 830, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 576, 915, 951, 829, 829, 829, 829, 699, 700, 829,
/* 154 */ 829, 829, 829, 829, 829, 829, 829, 731, 584, 754, 830, 908, 727, 644, 700, 829, 829, 829, 829, 829, 829, 829,
/* 176 */ 829, 868, 675, 754, 830, 908, 727, 692, 829, 829, 829, 829, 829, 829, 829, 829, 829, 624, 828, 829, 829, 612,
/* 198 */ 822, 945, 700, 829, 829, 829, 829, 829, 829, 829, 535, 709, 829, 829, 829, 829, 829, 699, 700, 829, 829, 829,
/* 220 */ 829, 829, 829, 829, 564, 624, 828, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 553, 722,
/* 242 */ 775, 829, 829, 829, 829, 699, 739, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 754, 830, 908, 727, 644,
/* 264 */ 700, 829, 829, 829, 829, 829, 829, 829, 752, 684, 675, 754, 830, 908, 727, 692, 829, 829, 829, 829, 829, 829,
/* 286 */ 829, 829, 752, 780, 584, 754, 830, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 762, 770,
/* 308 */ 830, 908, 727, 644, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 788, 859, 830, 829, 829, 632, 700, 829,
/* 330 */ 829, 829, 829, 829, 829, 829, 752, 780, 788, 796, 830, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829,
/* 352 */ 752, 780, 810, 657, 838, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 754, 701, 829,
/* 374 */ 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 754, 830, 714, 852, 632, 700, 829, 829, 829,
/* 396 */ 829, 829, 829, 829, 752, 780, 584, 938, 876, 885, 600, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780,
/* 418 */ 893, 901, 830, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 754, 830, 829, 829, 923,
/* 440 */ 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 882, 651, 829, 829, 632, 700, 829, 829, 829, 829, 829,
/* 462 */ 829, 829, 752, 780, 584, 844, 802, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 931, 744, 584, 959,
/* 484 */ 680, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 816, 584, 754, 830, 829, 829, 632, 700, 829,
/* 506 */ 829, 829, 829, 829, 829, 829, 829, 624, 828, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829,
/* 528 */ 17, 0, 0, 0, 27, 0, 27, 0, 15, 0, 0, 0, 0, 0, 21, 17, 0, 0, 0, 0, 28, 0, 32, 36, 0, 0, 0, 0, 0, 0, 0, 1920, 0,
/* 561 */ 25, 0, 0, 0, 0, 0, 0, 0, 1792, 0, 0, 512, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 17, 658, 658, 0, 0, 0, 0, 0, 22,
/* 593 */ 0, 0, 24, 0, 658, 41, 0, 0, 0, 0, 0, 55, 0, 0, 0, 658, 65, 0, 0, 0, 0, 0, 0, 896, 0, 0, 0, 66, 0, 0, 0, 0, 0,
/* 626 */ 0, 0, 1024, 0, 0, 16, 658, 58, 0, 0, 0, 0, 0, 0, 1024, 0, 0, 512, 658, 58, 59, 0, 61, 0, 63, 0, 50, 0, 0, 0,
/* 656 */ 55, 0, 658, 0, 0, 43, 0, 0, 0, 1280, 1280, 1280, 1280, 1280, 1280, 1024, 0, 0, 16, 0, 658, 658, 0, 0, 0, 0, 0,
/* 683 */ 52, 0, 0, 0, 658, 0, 1166, 0, 0, 658, 0, 59, 0, 61, 0, 63, 0, 58, 0, 0, 0, 0, 0, 0, 0, 697, 1557, 0, 1557, 0,
/* 713 */ 1559, 0, 0, 0, 60, 0, 30, 0, 0, 0, 1920, 0, 1920, 0, 0, 0, 0, 63, 0, 0, 0, 0, 1024, 1166, 0, 16, 58, 768, 0,
/* 742 */ 0, 0, 0, 0, 0, 659, 1024, 1166, 0, 16, 1166, 0, 0, 658, 0, 0, 0, 0, 0, 0, 17, 658, 658, 0, 0, 29, 0, 33, 37,
/* 771 */ 658, 0, 0, 0, 0, 0, 0, 1408, 0, 0, 0, 0, 658, 1024, 1166, 0, 16, 17, 658, 658, 0, 0, 30, 0, 34, 38, 680, 0, 0,
/* 800 */ 0, 0, 0, 0, 51, 0, 0, 0, 56, 658, 17, 658, 666, 0, 0, 0, 0, 0, 384, 658, 1024, 1166, 0, 16, 0, 0, 0, 0, 17, 0,
/* 830 */ 0, 0, 0, 0, 0, 0, 0, 658, 48, 0, 0, 0, 53, 0, 0, 658, 0, 0, 0, 0, 46, 0, 62, 0, 34, 0, 0, 64, 0, 38, 658, 0,
/* 862 */ 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 1166, 0, 0, 49, 0, 0, 0, 54, 0, 0, 658, 0, 0, 0, 45, 0, 0, 0, 0, 50, 17,
/* 894 */ 658, 658, 0, 0, 31, 0, 35, 39, 658, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 61, 0, 20, 0, 20, 1024, 0, 1664, 16, 18,
/* 924 */ 58, 0, 45, 0, 50, 0, 55, 1166, 0, 0, 659, 0, 0, 0, 0, 658, 0, 0, 44, 0, 0, 0, 58, 896, 0, 16, 0, 17, 0, 0, 0,
/* 955 */ 0, 0, 1664, 0, 0, 658, 0, 42, 0, 0, 0, 47
};

const int microxml::t0[] =
{
/*  0 */ 17, 21, 25, 29, 49, 46, 37, 40, 32, 33, 39, 41, 32, 32, 38, 32, 45, 256, 4096, 520, 528, 1536, 8704, 16896,
/* 24 */ 544, 2592, 17920, 2596, 17936, 6368, 256, 4096, 8, 8, 8, 8, 16, 8, 16, 32, 64, 64, 64, 8, 8, 32, 32, 64, 4128,
/* 49 */ 8, 16, 16, 1024
};

const wchar_t *microxml::t1[] =
{
  L"(0)",
  L"END",
  L"byteOrderMark",
  L"attributeValue",
  L"attributeName",
  L"comment",
  L"charRef",
  L"dataChar",
  L"name",
  L"s",
  L"'/>'",
  L"'<'",
  L"'</'",
  L"'='",
  L"'>'"
};

#endif

// End
