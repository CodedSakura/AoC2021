-module('A').
-export([main/1]).

rep_arr(Arr, 1) -> [Arr];
rep_arr(Arr, N) when N > 1 -> [Arr|rep_arr(Arr, N-1)].

setnth(1, [_|Rest], New) -> [New|Rest];
setnth(I, [E|Rest], New) -> [E|setnth(I-1, Rest, New)].

setnth2d(1, Y, [E|Rest], New) -> [setnth(Y, E, New)|Rest];
setnth2d(X, Y, [E|Rest], New) -> [E|setnth2d(X-1, Y, Rest, New)].

ilist(0) -> [];
ilist(N) -> ilist([], N).
ilist(A, 0) -> A;
ilist(A, N) -> ilist([N|A], N-1).

board_index(B, N) -> board_index(B, N, 1).
board_index([R|B], N, X) -> 
    I = list_index(R, N),
    if
        I < 0 -> board_index(B, N, X+1);
        true -> {X, I}
    end;
board_index([], _, _) -> -1;
board_index([_|B], N, X) -> board_index(B, N, X+1).

list_index(A, N) -> list_index(A, N, 1).
list_index([V|_], N, X) when V == N -> X;
list_index([], _, _) -> -1;
list_index([_|A], N, X) -> list_index(A, N, X+1).

update_marked(_, []) -> [];
update_marked([-1|A], [M|Marked]) -> [M|update_marked(A, Marked)];
update_marked([{X,Y}|A], [M|Marked]) -> [setnth2d(X, Y, M, true)|update_marked(A, Marked)].

full_row(M) -> lists:any(fun(R) -> lists:all(fun(E) -> E end, R) end, M).

full_col(M) -> lists:any(fun(I) -> lists:all(fun(E) -> lists:nth(I, E) end, M) end, ilist(length(M))).

is_complete(M) -> full_row(M) or full_col(M).

marking({Actions,BoardCount}) -> marking(Actions, rep_arr(rep_arr(rep_arr(false, 5), 5), BoardCount), []).
marking([A|Actions], Marked, PComplete) -> 
    Complete = [is_complete(G) || G <- Marked],
    AnyComplete = lists:all(fun(B) -> B end, Complete),
    if
        AnyComplete -> {length([A|Actions]), [lists:nth(I, Complete) xor lists:nth(I, PComplete) || I <- ilist(length(Complete))], Marked};
        true -> marking(Actions, update_marked(A, Marked), Complete)
    end.

get_if_unmarked(X, Y, Board, Marked) -> 
    IsMaked = lists:nth(Y, lists:nth(X, Marked)),
    if 
        IsMaked -> 0;
        true -> lists:nth(Y, lists:nth(X, Board))
    end.

sum_unmarked(Board, Marked) ->
    lists:foldl(fun(R, Acc1) -> Acc1 + lists:foldl(fun(X, Acc2) -> Acc2 + X end, 0, R) end, 0, 
        [[get_if_unmarked(X, Y, Board, Marked) || Y <- ilist(length(lists:nth(X, Board)))] || X <- ilist(length(Board))]).


main(_) ->
    {ok, Data} = file:read_file("input.txt"),
    A = binary:split(Data, [<<"\n\n">>], [global]),
    Calls = [list_to_integer(binary_to_list(X)) || X <- binary:split(lists:nth(1, A), [<<",">>], [global])],
    Boards = [[[list_to_integer(W) || W <- [binary_to_list(Z) || Z <- binary:split(Y, [<<" ">>], [global])], length(W) > 0]
            || Y <- binary:split(X, [<<"\n">>], [global, trim])]
            || X <- lists:reverse(lists:droplast(lists:reverse(A)))],
    Actions = [[board_index(lists:nth(I, Boards), C) || I <- ilist(length(Boards))] || C <- Calls],
    {LeftActions, Complete, Marked} = marking({Actions, length(Boards)}),
    IComplete = list_index(Complete, true),
    FinAction = lists:nth(length(Actions) - LeftActions, Calls),
    io:write(sum_unmarked(lists:nth(IComplete, Boards), lists:nth(IComplete, Marked)) * FinAction),
    io:fwrite("~n").
