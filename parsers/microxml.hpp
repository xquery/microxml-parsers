// This file was generated on Thu Sep 27, 2012 11:23 (UTC+02) by REx v5.16 which is Copyright (c) 1979-2012 by Gunther Rademacher <grd@gmx.net>
// REx command line: microxml.ebnf -ll 2 -tree -cpp

#ifndef MICROXML_HPP
#define MICROXML_HPP

#include <stdio.h>
#include <string>
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
    end = e;
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
        break;
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
        break;
      }
    }
    shift(9);                       // eof
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
      break;
    }
    endNonterminal(L"element");
  }

  void parse_endTag()
  {
    startNonterminal(L"endTag");
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
    endNonterminal(L"endTag");
  }

  void parse_content()
  {
    startNonterminal(L"content");
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
        break;
      }
    }
    endNonterminal(L"content");
  }

  void parse_attributeList()
  {
    startNonterminal(L"attributeList");
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
        break;
      }
      if (lk != 104)                // s attributeName
      {
        break;
      }
      shift(8);                     // s
      parse_attribute();
    }
    endNonterminal(L"attributeList");
  }

  void parse_attribute()
  {
    startNonterminal(L"attribute");
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
    endNonterminal(L"attribute");
  }

  int lk, b0, e0;
  int l1, b1, e1;
  int l2, b2, e2;
  const wchar_t *delayedTag;

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

  void error(int b, int e, int s, int l, int t)
  {
    throw ParseException(b, e, s, l, t);
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
      b1 = b2; e1 = e2; l2 = 0; }
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
    int i0 = t * 70 + s - 1;
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
/*   0 */ 32, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 4, 5,
/*  36 */ 6, 6, 7, 8, 6, 6, 6, 6, 6, 9, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 6, 13, 14, 15, 16, 6, 6, 17, 17,
/*  67 */ 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 6, 6, 6, 6,
/*  95 */ 18, 6, 19, 17, 17, 17, 17, 17, 20, 18, 18, 18, 18, 21, 22, 23, 24, 25, 26, 18, 27, 28, 29, 18, 18, 30, 18, 18,
/* 123 */ 6, 6, 6, 6, 0
};

const int microxml::m1[] =
{
/*   0 */ 108, 124, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 156, 181, 181, 181, 181, 181,
/*  22 */ 214, 215, 213, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
/*  44 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
/*  66 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
/*  88 */ 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 247, 258,
/* 110 */ 274, 290, 344, 351, 367, 383, 258, 258, 327, 319, 430, 422, 430, 422, 430, 430, 430, 430, 430, 430, 430, 430,
/* 132 */ 430, 430, 430, 430, 430, 430, 430, 430, 399, 399, 399, 399, 399, 399, 399, 415, 430, 430, 430, 430, 430, 430,
/* 154 */ 430, 430, 305, 327, 327, 328, 326, 327, 327, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430,
/* 176 */ 430, 430, 430, 430, 430, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327,
/* 198 */ 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 429, 430, 430, 430, 430, 430, 430,
/* 220 */ 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430,
/* 242 */ 430, 430, 430, 430, 327, 32, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2,
/* 275 */ 3, 4, 5, 6, 6, 7, 8, 6, 6, 6, 6, 6, 9, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 6, 13, 14, 15, 16, 6,
/* 306 */ 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 18, 18, 6, 6, 6, 6, 6, 6, 6, 10, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
/* 342 */ 6, 10, 6, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 6, 6, 6, 6, 18, 6, 19, 17, 17,
/* 371 */ 17, 17, 17, 20, 18, 18, 18, 18, 21, 22, 23, 24, 25, 26, 18, 27, 28, 29, 18, 18, 30, 18, 18, 6, 6, 6, 6, 0, 10,
/* 400 */ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
/* 427 */ 18, 18, 6, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18
};

const int microxml::m2[] =
{
/*  0 */ 57344, 63744, 65008, 65279, 65280, 65536, 131072, 196608, 262144, 327680, 393216, 458752, 524288, 589824,
/* 14 */ 655360, 720896, 786432, 851968, 917504, 983040, 1048576, 63743, 64975, 65278, 65279, 65533, 131069, 196605,
/* 28 */ 262141, 327677, 393213, 458749, 524285, 589821, 655357, 720893, 786429, 851965, 917501, 983037, 1048573,
/* 41 */ 1114109, 6, 18, 18, 31, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 6, 6
};

const int microxml::a0[] =
{
/*  0 */ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
};

const int microxml::a1[] =
{
/*   0 */ 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 562, 534, 617, 550, 550, 550,
/*  22 */ 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 562, 540, 528, 550, 550, 550, 550, 644, 645, 550, 550, 550,
/*  44 */ 550, 550, 550, 550, 550, 572, 548, 559, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 671, 572,
/*  66 */ 570, 550, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 550, 572, 548, 580, 550, 550, 550, 644,
/*  88 */ 645, 550, 550, 550, 550, 550, 550, 550, 550, 572, 548, 550, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550,
/* 110 */ 550, 550, 550, 551, 593, 550, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 603, 572, 615, 550,
/* 132 */ 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 550, 572, 625, 688, 550, 739, 550, 630, 771, 550,
/* 154 */ 550, 550, 550, 550, 550, 550, 550, 572, 625, 717, 550, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550,
/* 176 */ 550, 824, 638, 641, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 550, 572, 625, 717, 550, 907,
/* 198 */ 838, 585, 653, 550, 550, 550, 550, 550, 550, 550, 550, 572, 548, 550, 550, 550, 666, 607, 679, 550, 550, 550,
/* 220 */ 550, 550, 550, 550, 684, 784, 550, 550, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 658, 572,
/* 242 */ 548, 550, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 809, 696, 595, 550, 550, 550, 550, 644,
/* 264 */ 919, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 550, 907, 838, 585, 653, 550, 550, 550, 550, 550,
/* 286 */ 550, 550, 714, 720, 625, 717, 550, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 728,
/* 308 */ 550, 907, 838, 585, 653, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 747, 550, 719, 550, 738, 645, 550,
/* 330 */ 550, 550, 550, 550, 550, 550, 714, 720, 625, 761, 550, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550,
/* 352 */ 714, 720, 779, 717, 792, 805, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 550, 702,
/* 374 */ 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 550, 851, 817, 832, 645, 550, 550, 550,
/* 396 */ 550, 550, 550, 550, 714, 720, 625, 717, 846, 859, 866, 874, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720,
/* 418 */ 625, 888, 550, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 550, 719, 550, 706,
/* 440 */ 902, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 864, 915, 550, 738, 645, 550, 550, 550, 550, 550,
/* 462 */ 550, 550, 714, 720, 625, 717, 753, 767, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 927, 894, 625, 930,
/* 484 */ 797, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 880, 625, 717, 550, 719, 550, 738, 645, 550,
/* 506 */ 550, 550, 550, 550, 550, 550, 550, 734, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550,
/* 528 */ 17, 18, 0, 0, 0, 0, 1175, 0, 0, 1175, 1175, 1175, 1175, 0, 0, 1175, 1175, 1175, 1175, 896, 17, 18, 0, 0, 0, 0,
/* 554 */ 0, 0, 0, 0, 26, 31, 0, 31, 0, 0, 0, 0, 0, 0, 1175, 1175, 384, 18, 0, 0, 0, 0, 0, 0, 0, 896, 0, 32, 0, 36, 40,
/* 585 */ 0, 0, 0, 0, 531, 62, 63, 0, 28, 29, 0, 0, 0, 0, 0, 0, 0, 1408, 18, 0, 0, 0, 0, 0, 18, 0, 0, 62, 768, 0, 17,
/* 616 */ 384, 0, 0, 0, 0, 0, 0, 1175, 0, 17, 18, 531, 531, 1045, 0, 0, 0, 0, 531, 69, 0, 0, 17, 18, 0, 0, 0, 1664, 0,
/* 645 */ 0, 0, 0, 0, 62, 0, 0, 0, 65, 0, 67, 0, 62, 0, 0, 0, 0, 1792, 0, 0, 1792, 768, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0,
/* 677 */ 17, 0, 17, 0, 18, 0, 62, 0, 0, 0, 22, 0, 0, 0, 0, 0, 531, 45, 0, 1920, 1920, 1920, 0, 0, 1920, 0, 0, 0, 573,
/* 706 */ 0, 0, 0, 0, 19, 62, 0, 49, 0, 531, 1045, 0, 0, 0, 0, 0, 531, 0, 0, 0, 0, 896, 0, 33, 0, 37, 41, 531, 0, 0, 0,
/* 737 */ 1280, 0, 0, 0, 0, 531, 62, 0, 0, 0, 0, 34, 0, 38, 42, 531, 0, 0, 50, 0, 0, 0, 55, 0, 0, 34, 0, 38, 42, 556, 0,
/* 768 */ 0, 60, 531, 0, 0, 0, 0, 70, 0, 0, 0, 17, 18, 531, 542, 1045, 0, 0, 0, 25, 1561, 0, 1561, 1563, 47, 0, 0, 0,
/* 796 */ 52, 0, 0, 0, 51, 0, 0, 0, 56, 57, 0, 0, 531, 0, 0, 0, 0, 0, 1920, 0, 0, 0, 34, 0, 0, 66, 0, 38, 0, 24, 24, 0,
/* 828 */ 0, 24, 0, 896, 0, 68, 0, 42, 531, 62, 0, 0, 65, 0, 0, 0, 0, 67, 48, 0, 0, 0, 53, 0, 0, 0, 531, 0, 0, 0, 64,
/* 859 */ 58, 0, 0, 531, 0, 0, 49, 0, 0, 0, 54, 0, 0, 0, 0, 59, 0, 0, 0, 531, 62, 0, 0, 531, 0, 0, 0, 256, 896, 0, 35,
/* 890 */ 0, 39, 43, 531, 0, 0, 532, 0, 0, 0, 0, 896, 0, 54, 0, 59, 62, 0, 0, 0, 531, 0, 63, 0, 0, 0, 59, 0, 531, 0, 0,
/* 921 */ 0, 0, 62, 640, 0, 0, 0, 532, 1045, 0, 0, 0, 0, 0, 531, 0, 46
};

const int microxml::t0[] =
{
/*  0 */ 18, 24, 28, 32, 50, 20, 45, 36, 39, 48, 49, 38, 40, 48, 48, 37, 48, 44, 4, 8, 128, 4096, 256, 1024, 8192,
/* 25 */ 16384, 260, 8448, 16640, 17408, 17416, 784, 2320, 17664, 2322, 6256, 4, 8, 16, 32, 32, 32, 4, 4, 16, 16, 32,
/* 47 */ 4112, 4, 4, 4, 4, 8, 8
};

const wchar_t *microxml::t1[] =
{
  L"(0)",
  L"byteOrderMark",
  L"attributeValue",
  L"attributeName",
  L"comment",
  L"charRef",
  L"dataChar",
  L"name",
  L"s",
  L"eof",
  L"'/>'",
  L"'<'",
  L"'</'",
  L"'='",
  L"'>'"
};

#endif

// End
