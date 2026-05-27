#!/usr/bin/env escript

main(_) ->
  Number = 16#8213,
  reverse_bits(Number).

reverse_bits(Number) ->
  io:format("Number = 0x~4.16.0B\r\n", [Number]),
  Bits = [ X || <<X:1>> <= <<Number:16/big-unsigned-integer>> ],
  lists:foreach(fun(X) -> io:format("~1.2.0B ", [X]) end, Bits),
  io:format("\r\n", []),
  ReversedBits = lists:reverse(Bits),
  Bin = << <<X:1>> || X <- ReversedBits >>,
  <<NewNumber:16/little-unsigned-integer>> = Bin,
  io:format("Reversed Number = 0x~4.16.0B\r\n", [NewNumber]),
  lists:foreach(fun(X) -> io:format("~1.2.0B ", [X]) end, ReversedBits),
  io:format("\r\n", []).
