xquery version "1.0" encoding "UTF-8";

(: This file was generated on Mon Sep 24, 2012 09:43 (UTC+02) by REx v5.16 which is Copyright (c) 1979-2012 by Gunther Rademacher <grd@gmx.net> :)
(: REx command line: microxml.ebnf -backtrack -xquery -tree :)

(:~
 : The parser that was generated for the microxml grammar.
 :)
module namespace p="microxml";
declare default function namespace "http://www.w3.org/2005/xpath-functions";

(:~
 : The codepoint to charclass mapping for 7 bit codepoints.
 :)
declare variable $p:MAP0 as xs:integer+ :=
(
  0, 0, 32, 32, 32, 32, 32, 0, 32, 1, 1, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
  32, 1, 2, 3, 4, 32, 32, 5, 6, 32, 32, 32, 32, 32, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 32, 12, 13, 14, 15,
  32, 32, 16, 16, 16, 16, 16, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 32,
  32, 32, 32, 18, 32, 19, 16, 16, 16, 16, 16, 20, 18, 18, 18, 18, 21, 22, 23, 24, 25, 26, 18, 27, 28, 29, 18, 18, 30,
  18, 18, 32, 32, 32, 32, 32
);

(:~
 : The codepoint to charclass mapping for codepoints below the surrogate block.
 :)
declare variable $p:MAP1 as xs:integer+ :=
(
  108, 124, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 156, 181, 181, 181, 181, 181, 214,
  215, 213, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
  214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
  214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214,
  214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 247, 266, 283, 299, 314, 352, 368,
  384, 266, 266, 266, 258, 336, 328, 336, 328, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336,
  336, 336, 411, 411, 411, 411, 411, 411, 411, 321, 336, 336, 336, 336, 336, 336, 336, 336, 395, 266, 266, 267, 265,
  266, 266, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 266, 266, 266,
  266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266, 266,
  266, 266, 266, 266, 266, 266, 335, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336,
  336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 336, 266, 0, 0, 32, 32, 32, 32, 32, 0, 32,
  1, 1, 32, 32, 32, 32, 32, 32, 32, 8, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 8, 1, 2, 3, 4,
  32, 32, 5, 6, 32, 32, 32, 32, 32, 7, 8, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 11, 32, 12, 13, 14, 15, 32, 16, 16, 16,
  16, 16, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 32, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
  18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 32, 32, 32, 32, 18, 32, 19, 16, 16, 16, 16, 16, 20,
  18, 18, 18, 18, 21, 22, 23, 24, 25, 26, 18, 27, 28, 29, 18, 18, 30, 18, 18, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
  32, 32, 18, 18, 32, 32, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
);

(:~
 : The codepoint to charclass mapping for codepoints above the surrogate block.
 :)
declare variable $p:MAP2 as xs:integer+ :=
(
  57344, 63744, 65008, 65279, 65280, 65536, 131072, 196608, 262144, 327680, 393216, 458752, 524288, 589824, 655360,
  720896, 786432, 851968, 917504, 983040, 1048576, 63743, 64975, 65278, 65279, 65533, 131069, 196605, 262141, 327677,
  393213, 458749, 524285, 589821, 655357, 720893, 786429, 851965, 917501, 983037, 1048573, 1114109, 32, 18, 18, 31, 18,
  18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 32, 32
);

(:~
 : The token-set-id to DFA-initial-state mapping.
 :)
declare variable $p:INITIAL as xs:integer+ :=
(
  1, 2, 3, 4, 5, 6, 7, 264, 9, 10, 11, 12, 13
);

(:~
 : The DFA transition table.
 :)
declare variable $p:TRANSITION as xs:integer+ :=
(
  829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 829, 663, 667, 828, 829, 829, 829, 829,
  699, 700, 829, 829, 829, 829, 829, 829, 829, 829, 624, 528, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829,
  829, 829, 865, 636, 828, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 829, 624, 543, 551, 829,
  829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 829, 588, 561, 829, 829, 829, 829, 699, 700, 829, 829, 829,
  829, 829, 829, 829, 826, 624, 572, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 829, 731, 584,
  596, 830, 700, 829, 608, 620, 829, 829, 829, 829, 829, 829, 829, 829, 731, 584, 754, 830, 829, 829, 632, 700, 829,
  829, 829, 829, 829, 829, 829, 576, 915, 951, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 829,
  731, 584, 754, 830, 908, 727, 644, 700, 829, 829, 829, 829, 829, 829, 829, 829, 868, 675, 754, 830, 908, 727, 692,
  829, 829, 829, 829, 829, 829, 829, 829, 829, 624, 828, 829, 829, 612, 822, 945, 700, 829, 829, 829, 829, 829, 829,
  829, 535, 709, 829, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 564, 624, 828, 829, 829, 829,
  829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 553, 722, 775, 829, 829, 829, 829, 699, 739, 829, 829, 829, 829,
  829, 829, 829, 752, 780, 584, 754, 830, 908, 727, 644, 700, 829, 829, 829, 829, 829, 829, 829, 752, 684, 675, 754,
  830, 908, 727, 692, 829, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 754, 830, 829, 829, 632, 700, 829, 829,
  829, 829, 829, 829, 829, 752, 780, 762, 770, 830, 908, 727, 644, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780,
  788, 859, 830, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 788, 796, 830, 829, 829, 632, 700,
  829, 829, 829, 829, 829, 829, 829, 752, 780, 810, 657, 838, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829,
  752, 780, 584, 754, 701, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 754, 830, 714, 852,
  632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 938, 876, 885, 600, 632, 700, 829, 829, 829, 829, 829,
  829, 829, 752, 780, 893, 901, 830, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 754, 830,
  829, 829, 923, 700, 829, 829, 829, 829, 829, 829, 829, 752, 780, 584, 882, 651, 829, 829, 632, 700, 829, 829, 829,
  829, 829, 829, 829, 752, 780, 584, 844, 802, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 931, 744, 584,
  959, 680, 829, 829, 632, 700, 829, 829, 829, 829, 829, 829, 829, 752, 816, 584, 754, 830, 829, 829, 632, 700, 829,
  829, 829, 829, 829, 829, 829, 829, 624, 828, 829, 829, 829, 829, 699, 700, 829, 829, 829, 829, 829, 829, 829, 17, 0,
  0, 0, 27, 0, 27, 0, 15, 0, 0, 0, 0, 0, 21, 17, 0, 0, 0, 0, 28, 0, 32, 36, 0, 0, 0, 0, 0, 0, 0, 1920, 0, 25, 0, 0, 0,
  0, 0, 0, 0, 1792, 0, 0, 512, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 17, 658, 658, 0, 0, 0, 0, 0, 22, 0, 0, 24, 0, 658, 41,
  0, 0, 0, 0, 0, 55, 0, 0, 0, 658, 65, 0, 0, 0, 0, 0, 0, 896, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 0, 1024, 0, 0, 16, 658, 58,
  0, 0, 0, 0, 0, 0, 1024, 0, 0, 512, 658, 58, 59, 0, 61, 0, 63, 0, 50, 0, 0, 0, 55, 0, 658, 0, 0, 43, 0, 0, 0, 1280,
  1280, 1280, 1280, 1280, 1280, 1024, 0, 0, 16, 0, 658, 658, 0, 0, 0, 0, 0, 52, 0, 0, 0, 658, 0, 1166, 0, 0, 658, 0, 59,
  0, 61, 0, 63, 0, 58, 0, 0, 0, 0, 0, 0, 0, 697, 1557, 0, 1557, 0, 1559, 0, 0, 0, 60, 0, 30, 0, 0, 0, 1920, 0, 1920, 0,
  0, 0, 0, 63, 0, 0, 0, 0, 1024, 1166, 0, 16, 58, 768, 0, 0, 0, 0, 0, 0, 659, 1024, 1166, 0, 16, 1166, 0, 0, 658, 0, 0,
  0, 0, 0, 0, 17, 658, 658, 0, 0, 29, 0, 33, 37, 658, 0, 0, 0, 0, 0, 0, 1408, 0, 0, 0, 0, 658, 1024, 1166, 0, 16, 17,
  658, 658, 0, 0, 30, 0, 34, 38, 680, 0, 0, 0, 0, 0, 0, 51, 0, 0, 0, 56, 658, 17, 658, 666, 0, 0, 0, 0, 0, 384, 658,
  1024, 1166, 0, 16, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 658, 48, 0, 0, 0, 53, 0, 0, 658, 0, 0, 0, 0, 46, 0, 62, 0,
  34, 0, 0, 64, 0, 38, 658, 0, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 1166, 0, 0, 49, 0, 0, 0, 54, 0, 0, 658, 0, 0, 0, 45, 0,
  0, 0, 0, 50, 17, 658, 658, 0, 0, 31, 0, 35, 39, 658, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 61, 0, 20, 0, 20, 1024, 0,
  1664, 16, 18, 58, 0, 45, 0, 50, 0, 55, 1166, 0, 0, 659, 0, 0, 0, 0, 658, 0, 0, 44, 0, 0, 0, 58, 896, 0, 16, 0, 17, 0,
  0, 0, 0, 0, 1664, 0, 0, 658, 0, 42, 0, 0, 0, 47
);

(:~
 : The DFA-state to expected-token-set mapping.
 :)
declare variable $p:EXPECTED as xs:integer+ :=
(
  17, 21, 25, 29, 49, 46, 37, 40, 32, 33, 39, 41, 32, 32, 38, 32, 45, 256, 4096, 520, 528, 1536, 8704, 16896, 544, 2592,
  17920, 2596, 17936, 6368, 256, 4096, 8, 8, 8, 8, 16, 8, 16, 32, 64, 64, 64, 8, 8, 32, 32, 64, 4128, 8, 16, 16, 1024
);

(:~
 : The token-string table.
 :)
declare variable $p:TOKEN as xs:string+ :=
(
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
);

(:~
 : Match next token in input string, starting at given index, using
 : the DFA entry state for the set of tokens that are expected in
 : the current context.
 :
 : @param $input the input string.
 : @param $begin the index where to start in input string.
 : @param $token-set the expected token set id.
 : @return a sequence of three: the token code of the result token,
 : with input string begin and end positions. If there is no valid
 : token, return the negative id of the DFA state that failed, along
 : with begin and end positions of the longest viable prefix.
 :)
declare function p:match($input as xs:string,
                         $begin as xs:integer,
                         $token-set as xs:integer) as xs:integer+
{
  let $result := $p:INITIAL[1 + $token-set]
  return p:transition($input,
                      $begin,
                      $begin,
                      $begin,
                      $result,
                      $result mod 128,
                      0)
};

(:~
 : The DFA state transition function. If we are in a valid DFA state, save
 : it's result annotation, consume one input codepoint, calculate the next
 : state, and use tail recursion to do the same again. Otherwise, return
 : any valid result or a negative DFA state id in case of an error.
 :
 : @param $input the input string.
 : @param $begin the begin index of the current token in the input string.
 : @param $current the index of the current position in the input string.
 : @param $end the end index of the result in the input string.
 : @param $result the result code.
 : @param $current-state the current DFA state.
 : @param $previous-state the  previous DFA state.
 : @return a sequence of three: the token code of the result token,
 : with input string begin and end positions. If there is no valid
 : token, return the negative id of the DFA state that failed, along
 : with begin and end positions of the longest viable prefix.
 :)
declare function p:transition($input as xs:string,
                              $begin as xs:integer,
                              $current as xs:integer,
                              $end as xs:integer,
                              $result as xs:integer,
                              $current-state as xs:integer,
                              $previous-state as xs:integer) as xs:integer+
{
  if ($current-state = 0) then
    let $result := $result idiv 128
    return
      if ($result != 0) then
      (
        $result - 1,
        $begin,
        $end
      )
      else
      (
        - $previous-state,
        $begin,
        $current - 1
      )
  else
    let $c0 := (string-to-codepoints(substring($input, $current, 1)), 0)[1]
    let $c1 :=
      if ($c0 < 128) then
        $p:MAP0[1 + $c0]
      else if ($c0 < 55296) then
        let $c1 := $c0 idiv 16
        let $c2 := $c1 idiv 32
        return $p:MAP1[1 + $c0 mod 16 + $p:MAP1[1 + $c1 mod 32 + $p:MAP1[1 + $c2]]]
      else
        p:map2($c0, 1, 21)
    let $current := $current + 1
    let $i0 := 128 * $c1 + $current-state - 1
    let $i1 := $i0 idiv 8
    let $next-state := $p:TRANSITION[$i0 mod 8 + $p:TRANSITION[$i1 + 1] + 1]
    return
      if ($next-state > 127) then
        p:transition($input, $begin, $current, $current, $next-state, $next-state mod 128, $current-state)
      else
        p:transition($input, $begin, $current, $end, $result, $next-state, $current-state)
};

(:~
 : Recursively translate one 32-bit chunk of an expected token bitset
 : to the corresponding sequence of token strings.
 :
 : @param $result the result of previous recursion levels.
 : @param $chunk the 32-bit chunk of the expected token bitset.
 : @param $base-token-code the token code of bit 0 in the current chunk.
 : @return the set of token strings.
 :)
declare function p:token($result as xs:string*,
                         $chunk as xs:integer,
                         $base-token-code as xs:integer) as xs:string*
{
  if ($chunk = 0) then
    $result
  else
    p:token
    (
      ($result, if ($chunk mod 2 != 0) then $p:TOKEN[$base-token-code] else ()),
      if ($chunk < 0) then $chunk idiv 2 + 2147483648 else $chunk idiv 2,
      $base-token-code + 1
    )
};

(:~
 : Calculate expected token set for a given DFA state as a sequence
 : of strings.
 :
 : @param $state the DFA state.
 : @return the set of token strings
 :)
declare function p:expected-token-set($state as xs:integer) as xs:string*
{
  if ($state > 0) then
    for $t in 0 to 0
    let $i0 := $t * 66 + $state - 1
    let $i1 := $i0 idiv 4
    return p:token((), $p:EXPECTED[$i0 mod 4 + $p:EXPECTED[$i1 + 1] + 1], $t * 32 + 1)
  else
    ()
};

(:~
 : Classify codepoint by doing a tail recursive binary search for a
 : matching codepoint range entry in MAP2, the codepoint to charclass
 : map for codepoints above the surrogate block.
 :
 : @param $c the codepoint.
 : @param $lo the binary search lower bound map index.
 : @param $hi the binary search upper bound map index.
 : @return the character class.
 :)
declare function p:map2($c as xs:integer, $lo as xs:integer, $hi as xs:integer) as xs:integer
{
  if ($lo > $hi) then
    0
  else
    let $m := ($hi + $lo) idiv 2
    return
      if ($p:MAP2[$m] > $c) then
        p:map2($c, $lo, $m - 1)
      else if ($p:MAP2[21 + $m] < $c) then
        p:map2($c, $m + 1, $hi)
      else
        $p:MAP2[42 + $m]
};

(:~
 : The index of the parser state for accessing the combined
 : (i.e. level > 1) lookahead code.
 :)
declare variable $p:lk := 1;

(:~
 : The index of the parser state for accessing the position in the
 : input string of the begin of the token that has been shifted.
 :)
declare variable $p:b0 := 2;

(:~
 : The index of the parser state for accessing the position in the
 : input string of the end of the token that has been shifted.
 :)
declare variable $p:e0 := 3;

(:~
 : The index of the parser state for accessing the code of the
 : level-1-lookahead token.
 :)
declare variable $p:l1 := 4;

(:~
 : The index of the parser state for accessing the position in the
 : input string of the begin of the level-1-lookahead token.
 :)
declare variable $p:b1 := 5;

(:~
 : The index of the parser state for accessing the position in the
 : input string of the end of the level-1-lookahead token.
 :)
declare variable $p:e1 := 6;

(:~
 : The index of the parser state for accessing the code of the
 : level-2-lookahead token.
 :)
declare variable $p:l2 := 7;

(:~
 : The index of the parser state for accessing the position in the
 : input string of the begin of the level-2-lookahead token.
 :)
declare variable $p:b2 := 8;

(:~
 : The index of the parser state for accessing the position in the
 : input string of the end of the level-2-lookahead token.
 :)
declare variable $p:e2 := 9;

(:~
 : The index of the parser state for accessing the code of the
 : level-3-lookahead token.
 :)
declare variable $p:l3 := 10;

(:~
 : The index of the parser state for accessing the position in the
 : input string of the begin of the level-3-lookahead token.
 :)
declare variable $p:b3 := 11;

(:~
 : The index of the parser state for accessing the position in the
 : input string of the end of the level-3-lookahead token.
 :)
declare variable $p:e3 := 12;

(:~
 : The index of the parser state for accessing the token code that
 : was expected when an error was found.
 :)
declare variable $p:error := 13;

(:~
 : The index of the parser state for accessing the memoization
 : of backtracking results.
 :)
declare variable $p:memo := 14;

(:~
 : The index of the parser state that points to the first entry
 : used for collecting action results.
 :)
declare variable $p:result := 15;

(:~
 : Create a textual error message from a parsing error.
 :
 : @param $input the input string.
 : @param $error the parsing error descriptor.
 : @return the error message.
 :)
declare function p:error-message($input as xs:string, $error as element(error)) as xs:string
{
  let $begin := xs:integer($error/@b)
  let $context := string-to-codepoints(substring($input, 1, $begin - 1))
  let $linefeeds := index-of($context, 10)
  let $line := count($linefeeds) + 1
  let $column := ($begin - $linefeeds[last()], $begin)[1]
  return
    if ($error/@o) then
      concat
      (
        "syntax error, found ", $p:TOKEN[$error/@o + 1], "&#10;",
        "while expecting ", $p:TOKEN[$error/@x + 1], "&#10;",
        if ($error/@e = $begin) then
          ""
        else
          concat("after successfully scanning ", string($error/@e - $begin), " characters "),
        "at line ", string($line), ", column ", string($column), "&#10;",
        "...", substring($input, $begin, 32), "..."
      )
    else
      let $expected := p:expected-token-set($error/@s)
      return
        concat
        (
          "lexical analysis failed&#10;",
          "while expecting ",
          "["[exists($expected[2])],
          string-join($expected, ", "),
          "]"[exists($expected[2])],
          "&#10;",
          if ($error/@e = $begin) then
            ""
          else
            concat("after successfully scanning ", string($error/@e - $begin), " characters "),
          "at line ", string($line), ", column ", string($column), "&#10;",
          "...", substring($input, $begin, 32), "..."
        )
};

(:~
 : Shift one token, i.e. compare lookahead token 1 with expected
 : token and in case of a match, shift lookahead tokens down such that
 : l1 becomes the current token, and higher lookahead tokens move down.
 : When lookahead token 1 does not match the expected token, raise an
 : error by saving the expected token code in the error field of the
 : parser state.
 :
 : @param $code the expected token.
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:shift($code as xs:integer, $input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else if ($state[$p:l1] = $code) then
  (
    subsequence($state, $p:l1, $p:e3 - $p:l1 + 1),
    0,
    $state[$p:e3],
    subsequence($state, $p:e3),
    if ($state[$p:e0] != $state[$p:b1]) then
      text {substring($input, $state[$p:e0], $state[$p:b1] - $state[$p:e0])}
    else
      (),
    let $name := $p:TOKEN[1 + $state[$p:l1]]
    let $content := substring($input, $state[$p:b1], $state[$p:e1] - $state[$p:b1])
    return
      if (starts-with($name, "'")) then
        element TOKEN {$content}
      else
        element {$name} {$content}
  )
  else
  (
    subsequence($state, 1, $p:error - 1),
    element error
    {
      if ($state[$p:e1] < $state[$p:memo]/@e) then
        $state[$p:memo]/@*
      else
      (
        attribute b {$state[$p:b1]},
        attribute e {$state[$p:e1]},
        if ($state[$p:l1] < 0) then
          attribute s {- $state[$p:l1]}
        else
          (attribute o {$state[$p:l1]}, attribute x {$code})
      )
    },
    subsequence($state, $p:error + 1)
  )
};

(:~
 : Lookahead one token on level 1.
 :
 : @param $set the code of the DFA entry state for the set of valid tokens.
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:lookahead1($set as xs:integer, $input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:l1] != 0) then
    $state
  else
    let $match := p:match($input, $state[$p:b1], $set)
    return
    (
      $match[1],
      subsequence($state, $p:lk + 1, $p:l1 - $p:lk - 1),
      $match,
      0, $match[3], 0,
      subsequence($state, $p:e2 + 1)
    )
};

(:~
 : Lookahead one token on level 2 with whitespace skipping.
 :
 : @param $set the code of the DFA entry state for the set of valid tokens.
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:lookahead2($set as xs:integer, $input as xs:string, $state as item()+) as item()+
{
  let $match :=
    if ($state[$p:l2] != 0) then
      subsequence($state, $p:l2, $p:e2 - $p:l2 + 1)
    else
      p:match($input, $state[$p:e1], $set)
  return
  (
    $match[1] * 32 + $state[$p:l1],
    subsequence($state, $p:lk + 1, $p:l2 - $p:lk - 1),
    $match,
    0, $match[3], 0,
    subsequence($state, $p:e3 + 1)
  )
};

(:~
 : Lookahead one token on level 3 with whitespace skipping.
 :
 : @param $set the code of the DFA entry state for the set of valid tokens.
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:lookahead3($set as xs:integer, $input as xs:string, $state as item()+) as item()+
{
  let $match :=
    if ($state[$p:l3] != 0) then
      subsequence($state, $p:l3, $p:e3 - $p:l3 + 1)
    else
      p:match($input, $state[$p:e2], $set)
  return
  (
    $match[1] * 1024 + $state[$p:lk],
    subsequence($state, $p:lk + 1, $p:l3 - $p:lk - 1),
    $match,
    subsequence($state, $p:e3 + 1)
  )
};

(:~
 : Reduce the result stack. Pop $count element, wrap them in a
 : new element named $name, and push the new element.
 :
 : @param $state the parser state.
 : @param $name the name of the result node.
 : @param $count the number of child nodes.
 : @return the updated parser state.
 :)
declare function p:reduce($state as item()+, $name as xs:string, $count as xs:integer) as item()+
{
  subsequence($state, 1, $count),
  element {$name}
  {
    subsequence($state, $count + 1)
  }
};

(:~
 : Strip result from parser state, in order to avoid carrying it while
 : backtracking.
 :
 : @param $state the parser state after an alternative failed.
 : @return the updated parser state.
 :)
declare function p:strip-result($state as item()+) as item()+
{
  subsequence($state, 1, $p:memo)
};

(:~
 : Restore parser state after unsuccessfully trying an alternative,
 : merging any memoization that was collected on the way.
 :
 : @param $backtrack the parser state before backtracking started.
 : @param $state the parser state after an alternative failed.
 : @return the updated parser state.
 :)
declare function p:restore($backtrack as item()+,
                           $state as item()+) as item()+
{
  subsequence($backtrack, 1, $p:memo - 1),
  element memo{$state[$p:error]/@*, $state[$p:memo]/value}
};

(:~
 : Memoize the backtracking result that was computed at decision point
 : $i for input position $state[$p:e0].
 :
 : @param $backtrack the parser state before backtracking started.
 : @param $state the parser state after successfully trying an alternative.
 : @param $v the id of the successful alternative.
 : @param $i the decision point id.
 : @return the updated parser state.
 :)
declare function p:memoize($backtrack as item()+,
                           $state as item()+,
                           $v as xs:integer,
                           $i as xs:integer) as item()+
{
  $v,
  subsequence($backtrack, $p:lk + 1, $p:memo - $p:lk - 1),
  element memo
  {
    $state[$p:memo]/value,
    element value {attribute key {$backtrack[$p:e0] * 2 + $i}, $v}
  },
  subsequence($backtrack, $p:memo + 1)
};

(:~
 : Retrieve memoized backtracking result for decision point $i
 : and input position $state[$p:e0] into $state[$p:lk].
 :
 : @param $state the parser state.
 : @param $i the decision point id.
 : @return the updated parser state.
 :)
declare function p:memoized($state as item()+, $i as xs:integer) as item()+
{
  let $value := data($state[$p:memo]/value[@key = $state[$p:e0] * 2 + $i])
  return
  (
    if ($value) then $value else 0,
    subsequence($state, $p:lk + 1)
  )
};

(:~
 : Parse the 1st loop of production emptyElementTag (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-emptyElementTag-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(4, $input, $state)           (: s | '/>' :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        let $state := p:shift(9, $input, $state)            (: s :)
        return p:parse-emptyElementTag-1($input, $state)
};

(:~
 : Try parsing the 1st loop of production emptyElementTag (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-emptyElementTag-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(4, $input, $state)           (: s | '/>' :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        let $state := p:shift(9, $input, $state)            (: s :)
        return p:try-emptyElementTag-1($input, $state)
};

(:~
 : Parse emptyElementTag.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-emptyElementTag($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:shift(11, $input, $state)                 (: '<' :)
  let $state := p:lookahead1(0, $input, $state)             (: name :)
  let $state := p:shift(8, $input, $state)                  (: name :)
  let $state := p:parse-attributeList($input, $state)
  let $state := p:parse-emptyElementTag-1($input, $state)
  let $state := p:shift(10, $input, $state)                 (: '/>' :)
  return p:reduce($state, "emptyElementTag", $count)
};

(:~
 : Try parsing emptyElementTag.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-emptyElementTag($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:shift(11, $input, $state)                 (: '<' :)
  let $state := p:lookahead1(0, $input, $state)             (: name :)
  let $state := p:shift(8, $input, $state)                  (: name :)
  let $state := p:try-attributeList($input, $state)
  let $state := p:try-emptyElementTag-1($input, $state)
  let $state := p:shift(10, $input, $state)                 (: '/>' :)
  return p:reduce($state, "emptyElementTag", $count)
};

(:~
 : Parse the 1st loop of production endTag (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-endTag-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(6, $input, $state)           (: s | '>' :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        let $state := p:shift(9, $input, $state)            (: s :)
        return p:parse-endTag-1($input, $state)
};

(:~
 : Try parsing the 1st loop of production endTag (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-endTag-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(6, $input, $state)           (: s | '>' :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        let $state := p:shift(9, $input, $state)            (: s :)
        return p:try-endTag-1($input, $state)
};

(:~
 : Parse endTag.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-endTag($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:lookahead1(1, $input, $state)             (: '</' :)
  let $state := p:shift(12, $input, $state)                 (: '</' :)
  let $state := p:lookahead1(0, $input, $state)             (: name :)
  let $state := p:shift(8, $input, $state)                  (: name :)
  let $state := p:parse-endTag-1($input, $state)
  let $state := p:shift(14, $input, $state)                 (: '>' :)
  return p:reduce($state, "endTag", $count)
};

(:~
 : Try parsing endTag.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-endTag($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:lookahead1(1, $input, $state)             (: '</' :)
  let $state := p:shift(12, $input, $state)                 (: '</' :)
  let $state := p:lookahead1(0, $input, $state)             (: name :)
  let $state := p:shift(8, $input, $state)                  (: name :)
  let $state := p:try-endTag-1($input, $state)
  let $state := p:shift(14, $input, $state)                 (: '>' :)
  return p:reduce($state, "endTag", $count)
};

(:~
 : Parse the 1st loop of production content (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-content-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(12, $input, $state)          (: comment | charRef | dataChar | '<' | '</' :)
    return
      if ($state[$p:l1] = 12) then                          (: '</' :)
        $state
      else
        let $state :=
          if ($state[$p:l1] = 11) then                      (: '<' :)
            let $state := p:parse-element($input, $state)
            return $state
          else if ($state[$p:l1] = 5) then                  (: comment :)
            let $state := p:shift(5, $input, $state)        (: comment :)
            return $state
          else if ($state[$p:l1] = 7) then                  (: dataChar :)
            let $state := p:shift(7, $input, $state)        (: dataChar :)
            return $state
          else if ($state[$p:error]) then
            $state
          else
            let $state := p:shift(6, $input, $state)        (: charRef :)
            return $state
        return p:parse-content-1($input, $state)
};

(:~
 : Try parsing the 1st loop of production content (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-content-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(12, $input, $state)          (: comment | charRef | dataChar | '<' | '</' :)
    return
      if ($state[$p:l1] = 12) then                          (: '</' :)
        $state
      else
        let $state :=
          if ($state[$p:l1] = 11) then                      (: '<' :)
            let $state := p:try-element($input, $state)
            return $state
          else if ($state[$p:l1] = 5) then                  (: comment :)
            let $state := p:shift(5, $input, $state)        (: comment :)
            return $state
          else if ($state[$p:l1] = 7) then                  (: dataChar :)
            let $state := p:shift(7, $input, $state)        (: dataChar :)
            return $state
          else if ($state[$p:error]) then
            $state
          else
            let $state := p:shift(6, $input, $state)        (: charRef :)
            return $state
        return p:try-content-1($input, $state)
};

(:~
 : Parse content.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-content($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:parse-content-1($input, $state)
  return p:reduce($state, "content", $count)
};

(:~
 : Try parsing content.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-content($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:try-content-1($input, $state)
  return p:reduce($state, "content", $count)
};

(:~
 : Parse the 1st loop of production attribute (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-attribute-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(5, $input, $state)           (: s | '=' :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        let $state := p:shift(9, $input, $state)            (: s :)
        return p:parse-attribute-1($input, $state)
};

(:~
 : Try parsing the 1st loop of production attribute (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-attribute-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(5, $input, $state)           (: s | '=' :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        let $state := p:shift(9, $input, $state)            (: s :)
        return p:try-attribute-1($input, $state)
};

(:~
 : Parse the 2nd loop of production attribute (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-attribute-2($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(2, $input, $state)           (: attributeValue | s :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        let $state := p:shift(9, $input, $state)            (: s :)
        return p:parse-attribute-2($input, $state)
};

(:~
 : Try parsing the 2nd loop of production attribute (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-attribute-2($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(2, $input, $state)           (: attributeValue | s :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        let $state := p:shift(9, $input, $state)            (: s :)
        return p:try-attribute-2($input, $state)
};

(:~
 : Parse attribute.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-attribute($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:shift(4, $input, $state)                  (: attributeName :)
  let $state := p:parse-attribute-1($input, $state)
  let $state := p:shift(13, $input, $state)                 (: '=' :)
  let $state := p:parse-attribute-2($input, $state)
  let $state := p:shift(3, $input, $state)                  (: attributeValue :)
  return p:reduce($state, "attribute", $count)
};

(:~
 : Try parsing attribute.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-attribute($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:shift(4, $input, $state)                  (: attributeName :)
  let $state := p:try-attribute-1($input, $state)
  let $state := p:shift(13, $input, $state)                 (: '=' :)
  let $state := p:try-attribute-2($input, $state)
  let $state := p:shift(3, $input, $state)                  (: attributeValue :)
  return p:reduce($state, "attribute", $count)
};

(:~
 : Parse the 2nd loop of production attributeList (one or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-attributeList-2($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:shift(9, $input, $state)                (: s :)
    let $state := p:lookahead1(3, $input, $state)           (: attributeName | s :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        p:parse-attributeList-2($input, $state)
};

(:~
 : Try parsing the 2nd loop of production attributeList (one or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-attributeList-2($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:shift(9, $input, $state)                (: s :)
    let $state := p:lookahead1(3, $input, $state)           (: attributeName | s :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        p:try-attributeList-2($input, $state)
};

(:~
 : Parse the 1st loop of production attributeList (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-attributeList-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(9, $input, $state)           (: s | '/>' | '>' :)
    let $state :=
      if ($state[$p:l1] = 9) then                           (: s :)
        let $state := p:lookahead2(11, $input, $state)      (: attributeName | s | '/>' | '>' :)
        let $state :=
          if ($state[$p:lk] = 297) then                     (: s s :)
            let $state := p:lookahead3(11, $input, $state)  (: attributeName | s | '/>' | '>' :)
            return $state
          else
            $state
        return $state
      else
        ($state[$p:l1], subsequence($state, $p:lk + 1))
    let $state :=
      if ($state[$p:error]) then
        $state
      else if ($state[$p:lk] = 9513) then                   (: s s s :)
        let $state := p:memoized($state, 1)
        return
          if ($state[$p:lk] != 0) then
            $state
          else
            let $backtrack := $state
            let $state := p:strip-result($state)
            let $state := p:try-attributeList-2($input, $state)
            let $state := p:try-attribute($input, $state)
            return
              if (not($state[$p:error])) then
                p:memoize($backtrack, $state, -1, 1)
              else
                p:memoize($backtrack, $state, -2, 1)
      else
        $state
    return
      if ($state[$p:lk] != -1
      and $state[$p:lk] != 137                              (: s attributeName :)
      and $state[$p:lk] != 4393) then                       (: s s attributeName :)
        $state
      else
        let $state := p:parse-attributeList-2($input, $state)
        let $state := p:parse-attribute($input, $state)
        return p:parse-attributeList-1($input, $state)
};

(:~
 : Try parsing the 1st loop of production attributeList (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-attributeList-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(9, $input, $state)           (: s | '/>' | '>' :)
    let $state :=
      if ($state[$p:l1] = 9) then                           (: s :)
        let $state := p:lookahead2(11, $input, $state)      (: attributeName | s | '/>' | '>' :)
        let $state :=
          if ($state[$p:lk] = 297) then                     (: s s :)
            let $state := p:lookahead3(11, $input, $state)  (: attributeName | s | '/>' | '>' :)
            return $state
          else
            $state
        return $state
      else
        ($state[$p:l1], subsequence($state, $p:lk + 1))
    let $state :=
      if ($state[$p:error]) then
        $state
      else if ($state[$p:lk] = 9513) then                   (: s s s :)
        let $state := p:memoized($state, 1)
        return
          if ($state[$p:lk] != 0) then
            $state
          else
            let $backtrack := $state
            let $state := p:strip-result($state)
            let $state := p:try-attributeList-2($input, $state)
            let $state := p:try-attribute($input, $state)
            return
              if (not($state[$p:error])) then
                p:memoize($backtrack, $state, -1, 1)
              else
                p:memoize($backtrack, $state, -2, 1)
      else
        $state
    return
      if ($state[$p:lk] != -1
      and $state[$p:lk] != 137                              (: s attributeName :)
      and $state[$p:lk] != 4393) then                       (: s s attributeName :)
        $state
      else
        let $state := p:try-attributeList-2($input, $state)
        let $state := p:try-attribute($input, $state)
        return p:try-attributeList-1($input, $state)
};

(:~
 : Parse attributeList.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-attributeList($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:parse-attributeList-1($input, $state)
  return p:reduce($state, "attributeList", $count)
};

(:~
 : Try parsing attributeList.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-attributeList($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:try-attributeList-1($input, $state)
  return p:reduce($state, "attributeList", $count)
};

(:~
 : Parse the 1st loop of production startTag (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-startTag-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(6, $input, $state)           (: s | '>' :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        let $state := p:shift(9, $input, $state)            (: s :)
        return p:parse-startTag-1($input, $state)
};

(:~
 : Try parsing the 1st loop of production startTag (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-startTag-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(6, $input, $state)           (: s | '>' :)
    return
      if ($state[$p:l1] != 9) then                          (: s :)
        $state
      else
        let $state := p:shift(9, $input, $state)            (: s :)
        return p:try-startTag-1($input, $state)
};

(:~
 : Parse startTag.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-startTag($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:shift(11, $input, $state)                 (: '<' :)
  let $state := p:lookahead1(0, $input, $state)             (: name :)
  let $state := p:shift(8, $input, $state)                  (: name :)
  let $state := p:parse-attributeList($input, $state)
  let $state := p:parse-startTag-1($input, $state)
  let $state := p:shift(14, $input, $state)                 (: '>' :)
  return p:reduce($state, "startTag", $count)
};

(:~
 : Try parsing startTag.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-startTag($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:shift(11, $input, $state)                 (: '<' :)
  let $state := p:lookahead1(0, $input, $state)             (: name :)
  let $state := p:shift(8, $input, $state)                  (: name :)
  let $state := p:try-attributeList($input, $state)
  let $state := p:try-startTag-1($input, $state)
  let $state := p:shift(14, $input, $state)                 (: '>' :)
  return p:reduce($state, "startTag", $count)
};

(:~
 : Parse element.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-element($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state :=
    if ($state[$p:l1] = 11) then                            (: '<' :)
      let $state := p:lookahead2(0, $input, $state)         (: name :)
      let $state :=
        if ($state[$p:lk] = 267) then                       (: '<' name :)
          let $state := p:lookahead3(9, $input, $state)     (: s | '/>' | '>' :)
          return $state
        else
          $state
      return $state
    else
      ($state[$p:l1], subsequence($state, $p:lk + 1))
  let $state :=
    if ($state[$p:error]) then
      $state
    else if ($state[$p:lk] = 9483) then                     (: '<' name s :)
      let $state := p:memoized($state, 0)
      return
        if ($state[$p:lk] != 0) then
          $state
        else
          let $backtrack := $state
          let $state := p:strip-result($state)
          let $state := p:try-startTag($input, $state)
          let $state := p:try-content($input, $state)
          let $state := p:try-endTag($input, $state)
          return
            if (not($state[$p:error])) then
              p:memoize($backtrack, $state, -1, 0)
            else
              p:memoize($backtrack, $state, -2, 0)
    else
      $state
  let $state :=
    if ($state[$p:lk] = -1
     or $state[$p:lk] = 14603) then                         (: '<' name '>' :)
      let $state := p:parse-startTag($input, $state)
      let $state := p:parse-content($input, $state)
      let $state := p:parse-endTag($input, $state)
      return $state
    else if ($state[$p:error]) then
      $state
    else
      let $state := p:parse-emptyElementTag($input, $state)
      return $state
  return p:reduce($state, "element", $count)
};

(:~
 : Try parsing element.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:try-element($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state :=
    if ($state[$p:l1] = 11) then                            (: '<' :)
      let $state := p:lookahead2(0, $input, $state)         (: name :)
      let $state :=
        if ($state[$p:lk] = 267) then                       (: '<' name :)
          let $state := p:lookahead3(9, $input, $state)     (: s | '/>' | '>' :)
          return $state
        else
          $state
      return $state
    else
      ($state[$p:l1], subsequence($state, $p:lk + 1))
  let $state :=
    if ($state[$p:error]) then
      $state
    else if ($state[$p:lk] = 9483) then                     (: '<' name s :)
      let $state := p:memoized($state, 0)
      return
        if ($state[$p:lk] != 0) then
          $state
        else
          let $backtrack := $state
          let $state := p:strip-result($state)
          let $state := p:try-startTag($input, $state)
          let $state := p:try-content($input, $state)
          let $state := p:try-endTag($input, $state)
          return
            if (not($state[$p:error])) then
              p:memoize($backtrack, $state, -1, 0)
            else
              p:memoize($backtrack, $state, -2, 0)
    else
      $state
  let $state :=
    if ($state[$p:lk] = -1
     or $state[$p:lk] = 14603) then                         (: '<' name '>' :)
      let $state := p:try-startTag($input, $state)
      let $state := p:try-content($input, $state)
      let $state := p:try-endTag($input, $state)
      return $state
    else if ($state[$p:error]) then
      $state
    else
      let $state := p:try-emptyElementTag($input, $state)
      return $state
  return p:reduce($state, "element", $count)
};

(:~
 : Parse the 1st loop of production document (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-document-1($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(8, $input, $state)           (: comment | s | '<' :)
    return
      if ($state[$p:l1] = 11) then                          (: '<' :)
        $state
      else
        let $state :=
          if ($state[$p:l1] = 5) then                       (: comment :)
            let $state := p:shift(5, $input, $state)        (: comment :)
            return $state
          else if ($state[$p:error]) then
            $state
          else
            let $state := p:shift(9, $input, $state)        (: s :)
            return $state
        return p:parse-document-1($input, $state)
};

(:~
 : Parse the 2nd loop of production document (zero or more). Use
 : tail recursion for iteratively updating the parser state.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-document-2($input as xs:string, $state as item()+) as item()+
{
  if ($state[$p:error]) then
    $state
  else
    let $state := p:lookahead1(7, $input, $state)           (: END | comment | s :)
    return
      if ($state[$p:l1] = 1) then                           (: END :)
        $state
      else
        let $state :=
          if ($state[$p:l1] = 5) then                       (: comment :)
            let $state := p:shift(5, $input, $state)        (: comment :)
            return $state
          else if ($state[$p:error]) then
            $state
          else
            let $state := p:shift(9, $input, $state)        (: s :)
            return $state
        return p:parse-document-2($input, $state)
};

(:~
 : Parse document.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-document($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:lookahead1(10, $input, $state)            (: byteOrderMark | comment | s | '<' :)
  let $state :=
    if ($state[$p:error]) then
      $state
    else if ($state[$p:l1] = 2) then                        (: byteOrderMark :)
      let $state := p:shift(2, $input, $state)              (: byteOrderMark :)
      return $state
    else
      $state
  let $state := p:parse-document-1($input, $state)
  let $state := p:parse-element($input, $state)
  let $state := p:parse-document-2($input, $state)
  return p:reduce($state, "document", $count)
};

(:~
 : Parse start symbol document from given string.
 :
 : @param $s the string to be parsed.
 : @return the result as generated by parser actions.
 :)
declare function p:parse-document($s as xs:string) as item()*
{
  let $state := p:parse-document($s, (0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, false(), <memo/>))
  let $error := $state[$p:error]
  return
    if ($error) then
      element ERROR {$error/@*, p:error-message($s, $error)}
    else
      subsequence($state, $p:result)
};

(: End :)
