xquery version "1.0" encoding "UTF-8";

(: This file was generated on Thu Sep 27, 2012 11:24 (UTC+02) by REx v5.16 which is Copyright (c) 1979-2012 by Gunther Rademacher <grd@gmx.net> :)
(: REx command line: microxml.ebnf -ll 2 -tree -xquery :)

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
  32, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 4, 5, 6, 6, 7,
  8, 6, 6, 6, 6, 6, 9, 10, 11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 6, 13, 14, 15, 16, 6, 6, 17, 17, 17, 17, 17, 17,
  18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 6, 6, 6, 6, 18, 6, 19, 17, 17, 17, 17,
  17, 20, 18, 18, 18, 18, 21, 22, 23, 24, 25, 26, 18, 27, 28, 29, 18, 18, 30, 18, 18, 6, 6, 6, 6, 0
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
  214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 214, 247, 258, 274, 290, 344, 351, 367,
  383, 258, 258, 327, 319, 430, 422, 430, 422, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430,
  430, 430, 399, 399, 399, 399, 399, 399, 399, 415, 430, 430, 430, 430, 430, 430, 430, 430, 305, 327, 327, 328, 326,
  327, 327, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 327, 327, 327,
  327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327, 327,
  327, 327, 327, 327, 327, 327, 429, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430,
  430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 430, 327, 32, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 4, 5, 6, 6, 7, 8, 6, 6, 6, 6, 6, 9, 10, 11, 12, 12, 12, 12, 12,
  12, 12, 12, 12, 12, 6, 13, 14, 15, 16, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 18, 18, 6, 6, 6, 6, 6, 6, 6, 10, 6, 6, 6,
  6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 10, 6, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 6,
  6, 6, 6, 18, 6, 19, 17, 17, 17, 17, 17, 20, 18, 18, 18, 18, 21, 22, 23, 24, 25, 26, 18, 27, 28, 29, 18, 18, 30, 18,
  18, 6, 6, 6, 6, 0, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 18, 18, 18, 18, 18, 18, 18, 18, 18,
  18, 18, 18, 18, 18, 6, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18
);

(:~
 : The codepoint to charclass mapping for codepoints above the surrogate block.
 :)
declare variable $p:MAP2 as xs:integer+ :=
(
  57344, 63744, 65008, 65279, 65280, 65536, 131072, 196608, 262144, 327680, 393216, 458752, 524288, 589824, 655360,
  720896, 786432, 851968, 917504, 983040, 1048576, 63743, 64975, 65278, 65279, 65533, 131069, 196605, 262141, 327677,
  393213, 458749, 524285, 589821, 655357, 720893, 786429, 851965, 917501, 983037, 1048573, 1114109, 6, 18, 18, 31, 18,
  18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 6, 6
);

(:~
 : The token-set-id to DFA-initial-state mapping.
 :)
declare variable $p:INITIAL as xs:integer+ :=
(
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
);

(:~
 : The DFA transition table.
 :)
declare variable $p:TRANSITION as xs:integer+ :=
(
  550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 562, 534, 617, 550, 550, 550, 550,
  550, 550, 550, 550, 550, 550, 550, 550, 550, 562, 540, 528, 550, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550,
  550, 550, 550, 572, 548, 559, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 671, 572, 570, 550, 550,
  550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 550, 572, 548, 580, 550, 550, 550, 644, 645, 550, 550, 550,
  550, 550, 550, 550, 550, 572, 548, 550, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 550, 551, 593,
  550, 550, 550, 550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 603, 572, 615, 550, 550, 550, 550, 644, 645, 550,
  550, 550, 550, 550, 550, 550, 550, 572, 625, 688, 550, 739, 550, 630, 771, 550, 550, 550, 550, 550, 550, 550, 550,
  572, 625, 717, 550, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 550, 824, 638, 641, 550, 550, 550, 644,
  645, 550, 550, 550, 550, 550, 550, 550, 550, 572, 625, 717, 550, 907, 838, 585, 653, 550, 550, 550, 550, 550, 550,
  550, 550, 572, 548, 550, 550, 550, 666, 607, 679, 550, 550, 550, 550, 550, 550, 550, 684, 784, 550, 550, 550, 550,
  550, 644, 645, 550, 550, 550, 550, 550, 550, 550, 658, 572, 548, 550, 550, 550, 550, 644, 645, 550, 550, 550, 550,
  550, 550, 550, 809, 696, 595, 550, 550, 550, 550, 644, 919, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717,
  550, 907, 838, 585, 653, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 550, 719, 550, 738, 645, 550, 550,
  550, 550, 550, 550, 550, 714, 720, 625, 728, 550, 907, 838, 585, 653, 550, 550, 550, 550, 550, 550, 550, 714, 720,
  625, 747, 550, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 761, 550, 719, 550, 738, 645,
  550, 550, 550, 550, 550, 550, 550, 714, 720, 779, 717, 792, 805, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550,
  714, 720, 625, 717, 550, 702, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 550, 851, 817,
  832, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 846, 859, 866, 874, 645, 550, 550, 550, 550, 550,
  550, 550, 714, 720, 625, 888, 550, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 550,
  719, 550, 706, 902, 550, 550, 550, 550, 550, 550, 550, 714, 720, 625, 717, 864, 915, 550, 738, 645, 550, 550, 550,
  550, 550, 550, 550, 714, 720, 625, 717, 753, 767, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 927, 894, 625,
  930, 797, 719, 550, 738, 645, 550, 550, 550, 550, 550, 550, 550, 714, 880, 625, 717, 550, 719, 550, 738, 645, 550,
  550, 550, 550, 550, 550, 550, 550, 734, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 550, 17, 18,
  0, 0, 0, 0, 1175, 0, 0, 1175, 1175, 1175, 1175, 0, 0, 1175, 1175, 1175, 1175, 896, 17, 18, 0, 0, 0, 0, 0, 0, 0, 0, 26,
  31, 0, 31, 0, 0, 0, 0, 0, 0, 1175, 1175, 384, 18, 0, 0, 0, 0, 0, 0, 0, 896, 0, 32, 0, 36, 40, 0, 0, 0, 0, 531, 62, 63,
  0, 28, 29, 0, 0, 0, 0, 0, 0, 0, 1408, 18, 0, 0, 0, 0, 0, 18, 0, 0, 62, 768, 0, 17, 384, 0, 0, 0, 0, 0, 0, 1175, 0, 17,
  18, 531, 531, 1045, 0, 0, 0, 0, 531, 69, 0, 0, 17, 18, 0, 0, 0, 1664, 0, 0, 0, 0, 0, 62, 0, 0, 0, 65, 0, 67, 0, 62, 0,
  0, 0, 0, 1792, 0, 0, 1792, 768, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 17, 0, 17, 0, 18, 0, 62, 0, 0, 0, 22, 0, 0, 0, 0, 0,
  531, 45, 0, 1920, 1920, 1920, 0, 0, 1920, 0, 0, 0, 573, 0, 0, 0, 0, 19, 62, 0, 49, 0, 531, 1045, 0, 0, 0, 0, 0, 531,
  0, 0, 0, 0, 896, 0, 33, 0, 37, 41, 531, 0, 0, 0, 1280, 0, 0, 0, 0, 531, 62, 0, 0, 0, 0, 34, 0, 38, 42, 531, 0, 0, 50,
  0, 0, 0, 55, 0, 0, 34, 0, 38, 42, 556, 0, 0, 60, 531, 0, 0, 0, 0, 70, 0, 0, 0, 17, 18, 531, 542, 1045, 0, 0, 0, 25,
  1561, 0, 1561, 1563, 47, 0, 0, 0, 52, 0, 0, 0, 51, 0, 0, 0, 56, 57, 0, 0, 531, 0, 0, 0, 0, 0, 1920, 0, 0, 0, 34, 0, 0,
  66, 0, 38, 0, 24, 24, 0, 0, 24, 0, 896, 0, 68, 0, 42, 531, 62, 0, 0, 65, 0, 0, 0, 0, 67, 48, 0, 0, 0, 53, 0, 0, 0,
  531, 0, 0, 0, 64, 58, 0, 0, 531, 0, 0, 49, 0, 0, 0, 54, 0, 0, 0, 0, 59, 0, 0, 0, 531, 62, 0, 0, 531, 0, 0, 0, 256,
  896, 0, 35, 0, 39, 43, 531, 0, 0, 532, 0, 0, 0, 0, 896, 0, 54, 0, 59, 62, 0, 0, 0, 531, 0, 63, 0, 0, 0, 59, 0, 531, 0,
  0, 0, 0, 62, 640, 0, 0, 0, 532, 1045, 0, 0, 0, 0, 0, 531, 0, 46
);

(:~
 : The DFA-state to expected-token-set mapping.
 :)
declare variable $p:EXPECTED as xs:integer+ :=
(
  18, 24, 28, 32, 50, 20, 45, 36, 39, 48, 49, 38, 40, 48, 48, 37, 48, 44, 4, 8, 128, 4096, 256, 1024, 8192, 16384, 260,
  8448, 16640, 17408, 17416, 784, 2320, 17664, 2322, 6256, 4, 8, 16, 32, 32, 32, 4, 4, 16, 16, 32, 4112, 4, 4, 4, 4, 8,
  8
);

(:~
 : The token-string table.
 :)
declare variable $p:TOKEN as xs:string+ :=
(
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
    let $i0 := $t * 70 + $state - 1
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
 : The index of the parser state for accessing the token code that
 : was expected when an error was found.
 :)
declare variable $p:error := 10;

(:~
 : The index of the parser state that points to the first entry
 : used for collecting action results.
 :)
declare variable $p:result := 11;

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
    subsequence($state, $p:l1, $p:e2 - $p:l1 + 1),
    0,
    $state[$p:e2],
    subsequence($state, $p:e2),
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
      attribute b {$state[$p:b1]},
      attribute e {$state[$p:e1]},
      if ($state[$p:l1] < 0) then
        attribute s {- $state[$p:l1]}
      else
        (attribute o {$state[$p:l1]}, attribute x {$code})
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
    subsequence($state, $p:e2 + 1)
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
 : Parse endTag.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-endTag($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:lookahead1(3, $input, $state)             (: '</' :)
  let $state := p:shift(12, $input, $state)                 (: '</' :)
  let $state := p:lookahead1(2, $input, $state)             (: name :)
  let $state := p:shift(7, $input, $state)                  (: name :)
  let $state := p:lookahead1(8, $input, $state)             (: s | '>' :)
  let $state :=
    if ($state[$p:error]) then
      $state
    else if ($state[$p:l1] = 8) then                        (: s :)
      let $state := p:shift(8, $input, $state)              (: s :)
      return $state
    else
      $state
  let $state := p:lookahead1(5, $input, $state)             (: '>' :)
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
    let $state := p:lookahead1(15, $input, $state)          (: comment | charRef | dataChar | '<' | '</' :)
    return
      if ($state[$p:l1] = 12) then                          (: '</' :)
        $state
      else
        let $state :=
          if ($state[$p:l1] = 11) then                      (: '<' :)
            let $state := p:parse-element($input, $state)
            return $state
          else if ($state[$p:l1] = 4) then                  (: comment :)
            let $state := p:shift(4, $input, $state)        (: comment :)
            return $state
          else if ($state[$p:l1] = 6) then                  (: dataChar :)
            let $state := p:shift(6, $input, $state)        (: dataChar :)
            return $state
          else if ($state[$p:error]) then
            $state
          else
            let $state := p:shift(5, $input, $state)        (: charRef :)
            return $state
        return p:parse-content-1($input, $state)
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
 : Parse attribute.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-attribute($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:lookahead1(1, $input, $state)             (: attributeName :)
  let $state := p:shift(3, $input, $state)                  (: attributeName :)
  let $state := p:lookahead1(7, $input, $state)             (: s | '=' :)
  let $state :=
    if ($state[$p:error]) then
      $state
    else if ($state[$p:l1] = 8) then                        (: s :)
      let $state := p:shift(8, $input, $state)              (: s :)
      return $state
    else
      $state
  let $state := p:lookahead1(4, $input, $state)             (: '=' :)
  let $state := p:shift(13, $input, $state)                 (: '=' :)
  let $state := p:lookahead1(6, $input, $state)             (: attributeValue | s :)
  let $state :=
    if ($state[$p:error]) then
      $state
    else if ($state[$p:l1] = 8) then                        (: s :)
      let $state := p:shift(8, $input, $state)              (: s :)
      return $state
    else
      $state
  let $state := p:lookahead1(0, $input, $state)             (: attributeValue :)
  let $state := p:shift(2, $input, $state)                  (: attributeValue :)
  return p:reduce($state, "attribute", $count)
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
    let $state := p:lookahead1(13, $input, $state)          (: s | '/>' | '>' :)
    let $state :=
      if ($state[$p:l1] = 8) then                           (: s :)
        let $state := p:lookahead2(10, $input, $state)      (: attributeName | '/>' | '>' :)
        return $state
      else
        ($state[$p:l1], subsequence($state, $p:lk + 1))
    return
      if ($state[$p:lk] != 104) then                        (: s attributeName :)
        $state
      else
        let $state := p:shift(8, $input, $state)            (: s :)
        let $state := p:parse-attribute($input, $state)
        return p:parse-attributeList-1($input, $state)
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
 : Parse element.
 :
 : @param $input the input string.
 : @param $state the parser state.
 : @return the updated parser state.
 :)
declare function p:parse-element($input as xs:string, $state as item()+) as item()+
{
  let $count := count($state)
  let $state := p:shift(11, $input, $state)                 (: '<' :)
  let $state := p:lookahead1(2, $input, $state)             (: name :)
  let $state := p:shift(7, $input, $state)                  (: name :)
  let $state := p:parse-attributeList($input, $state)
  let $state := p:lookahead1(13, $input, $state)            (: s | '/>' | '>' :)
  let $state :=
    if ($state[$p:error]) then
      $state
    else if ($state[$p:l1] = 8) then                        (: s :)
      let $state := p:shift(8, $input, $state)              (: s :)
      return $state
    else
      $state
  let $state := p:lookahead1(9, $input, $state)             (: '/>' | '>' :)
  let $state :=
    if ($state[$p:l1] = 14) then                            (: '>' :)
      let $state := p:shift(14, $input, $state)             (: '>' :)
      let $state := p:parse-content($input, $state)
      let $state := p:parse-endTag($input, $state)
      return $state
    else if ($state[$p:error]) then
      $state
    else
      let $state := p:shift(10, $input, $state)             (: '/>' :)
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
    let $state := p:lookahead1(12, $input, $state)          (: comment | s | '<' :)
    return
      if ($state[$p:l1] = 11) then                          (: '<' :)
        $state
      else
        let $state :=
          if ($state[$p:l1] = 4) then                       (: comment :)
            let $state := p:shift(4, $input, $state)        (: comment :)
            return $state
          else if ($state[$p:error]) then
            $state
          else
            let $state := p:shift(8, $input, $state)        (: s :)
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
    let $state := p:lookahead1(11, $input, $state)          (: comment | s | eof :)
    return
      if ($state[$p:l1] = 9) then                           (: eof :)
        $state
      else
        let $state :=
          if ($state[$p:l1] = 4) then                       (: comment :)
            let $state := p:shift(4, $input, $state)        (: comment :)
            return $state
          else if ($state[$p:error]) then
            $state
          else
            let $state := p:shift(8, $input, $state)        (: s :)
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
  let $state := p:lookahead1(14, $input, $state)            (: byteOrderMark | comment | s | '<' :)
  let $state :=
    if ($state[$p:error]) then
      $state
    else if ($state[$p:l1] = 1) then                        (: byteOrderMark :)
      let $state := p:shift(1, $input, $state)              (: byteOrderMark :)
      return $state
    else
      $state
  let $state := p:parse-document-1($input, $state)
  let $state := p:parse-element($input, $state)
  let $state := p:parse-document-2($input, $state)
  let $state := p:shift(9, $input, $state)                  (: eof :)
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
  let $state := p:parse-document($s, (0, 1, 1, 0, 1, 0, 0, 0, 0, false()))
  let $error := $state[$p:error]
  return
    if ($error) then
      element ERROR {$error/@*, p:error-message($s, $error)}
    else
      subsequence($state, $p:result)
};

(: End :)
