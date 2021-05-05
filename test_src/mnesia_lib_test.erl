%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(mnesia_lib_test).   
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").
%% --------------------------------------------------------------------

%% External exports
-export([start/0]).

%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:tes cases
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
start()->
    ?debugMsg("Start setup"),
    ?assertEqual(ok,setup()),
    ?debugMsg("stop setup"),

    ?debugMsg("Start db_1"),
    ?assertEqual(ok,db_1()),
    ?debugMsg("stop db_1"),

    ?debugMsg("Start db_2"),
    ?assertEqual(ok,db_2()),
    ?debugMsg("stop db_2"),
    
   
      %% End application tests
    ?debugMsg("Start cleanup"),
    ?assertEqual(ok,cleanup()),
    ?debugMsg("Stop cleanup"),

    ?debugMsg("------>"++atom_to_list(?MODULE)++" ENDED SUCCESSFUL ---------"),
    ok.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
setup()->
    ok=support_mnesia_lib:start().


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------    
db_1()->
    ?assertEqual({atomic,ok},support_mnesia_lib:set_create(a,1)),
    ?assertEqual([{a,1}],support_mnesia_lib:set_read_all()),
    ?assertEqual({atomic,ok},support_mnesia_lib:set_create(a,2)),
    ?assertEqual([{a,2}],support_mnesia_lib:set_read_all()),
    ?assertEqual({atomic,ok},support_mnesia_lib:set_create(b,1)),
    ?assertEqual([{b,1},{a,2}],support_mnesia_lib:set_read_all()),
    ?assertEqual(2,support_mnesia_lib:set_key_read(a)),
    ?assertEqual(1,support_mnesia_lib:set_key_read(b)),
    
    ?assertEqual({atomic,ok},support_mnesia_lib:set_key_delete(a)),
    ?assertEqual([{b,1}],support_mnesia_lib:set_read_all()),

    ?assertEqual({atomic,ok},support_mnesia_lib:set_key_update(b,10)),
    ?assertEqual(10,support_mnesia_lib:set_key_read(b)),
    
    ?assertEqual({atomic,ok},support_mnesia_lib:set_key_delete(b)),
    ?assertEqual([],support_mnesia_lib:set_read_all()),
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------    
db_2()->
    ?assertEqual({atomic,ok},support_mnesia_lib:bag_create(a,1)),
    ?assertEqual([{a,1}],support_mnesia_lib:bag_read_all()),
    ?assertEqual({atomic,ok},support_mnesia_lib:bag_create(a,2)),
    ?assertEqual([{a,1},{a,2}],support_mnesia_lib:bag_read_all()),
    ?assertEqual({atomic,ok},support_mnesia_lib:bag_create(b,1)),
    ?assertEqual([{b,1},{a,1},{a,2}],support_mnesia_lib:bag_read_all()),
    ?assertEqual([1,2],support_mnesia_lib:bag_key_read(a)),
    ?assertEqual([1],support_mnesia_lib:bag_key_read(b)),
    
    ?assertEqual({atomic,[ok,ok]},support_mnesia_lib:bag_key_delete(a)),
    ?assertEqual([{b,1}],support_mnesia_lib:bag_read_all()),

    ?assertEqual({atomic,ok},support_mnesia_lib:bag_create(c,1)),
    ?assertEqual({atomic,ok},support_mnesia_lib:bag_create(c,2)),
    ?assertEqual([1,2],support_mnesia_lib:bag_key_read(c)),

    ?assertEqual({atomic,ok},support_mnesia_lib:bag_delete(c,2)),
    ?assertEqual([1],support_mnesia_lib:bag_key_read(c)),
    ?assertEqual({atomic,ok},support_mnesia_lib:bag_create(c,2)),
    ?assertEqual([1,2],support_mnesia_lib:bag_key_read(c)),

    ?assertEqual({atomic,ok},support_mnesia_lib:bag_key_update(c,1,10)),
    ?assertEqual([2,10],support_mnesia_lib:bag_key_read(c)),
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------    

cleanup()->
%    init:stop(),
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
