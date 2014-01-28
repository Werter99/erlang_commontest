%cd("C:/java/eclipseworkspace/common_tests").
-module(second_suite).
-include_lib("common_test/include/ct.hrl").

-export([all/0, init_per_testcase/2, end_per_testcase/2]).
-export([test1/1, test2/1]).

all() -> [test1, test2].

init_per_testcase(test1, Config) ->
Tab1 = ets:new(account, [ordered_set, public]),
ets:insert(Tab1, {one, 1}),
ets:insert(Tab1, {two, 0}),
[{table,Tab1} | Config];

init_per_testcase(test2, Config) ->
Tab1 = ets:new(account, [ordered_set, public]),
ets:insert(Tab1, {three, "Alamakota"}),
[{table,Tab1} | Config].

end_per_testcase(test1, Config) ->
ets:delete(?config(table, Config));

end_per_testcase(test2, Config) ->
ets:delete(?config(table, Config)).

test1(Config) ->
Tab1 = ?config(table, Config),
[{_,X}] = ets:lookup(Tab1, two),
[{_,Y}] = ets:lookup(Tab1, one),
1/Y,
1/X.

test2(Config) ->
Tab1 = ?config(table, Config),
A = ets:lookup(Tab1, three),
[{_,X}] = A,
io:format(X).
