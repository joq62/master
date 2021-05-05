%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(misc_log_test).   
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").
-include("../include/log.hrl").
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
    
    ok=misc_log:start().


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------    

db_1()->
    ?assertEqual({atomic,ok},?LogAlert("alert 1")),
    ?assertEqual({atomic,ok},?LogTicket("ticket 1")),
    ?assertEqual({atomic,ok},?LogInfo("info 1")),
    ?assertMatch([{alert,_,new,
		   _,misc_log_test,db_1,_,"alert 1"},
		  {info,_,new,
		   _,misc_log_test,db_1,_,"info 1"},
		  {ticket,_,new,
		   _,misc_log_test,db_1,_,"ticket 1"}],misc_log:read_all()),
    
    ?assertMatch([
		  {info,_,new,_,misc_log_test,db_1,_,"info 1"},
		  {ticket,_,new,_,misc_log_test,db_1,_,"ticket 1"},
		  {alert,_,new,_,misc_log_test,db_1,_,"alert 1"}
		 ],misc_log:print_new()),

    ?assertMatch([{alert,_,_,misc_log_test,db_1,_,"alert 1"}],misc_log:severity_read(alert)),
    ?assertMatch([{ticket,_,_,misc_log_test,db_1,_,"ticket 1"}],misc_log:severity_read(ticket)),
    ?assertMatch([{info,_,_,misc_log_test,db_1,_,"info 1"}],misc_log:severity_read(info)),

    ?assertMatch([],misc_log:print_new()),

    ?assertEqual({atomic,ok},?LogAlert("alert 2")),
    ?assertMatch([{alert,_,read,_,misc_log_test,db_1,_,"alert 1"},
                      {alert,_,new,_,misc_log_test,db_1,_,"alert 2"},
                      {info,_,read,_,misc_log_test,db_1,_,"info 1"},
                      {ticket,_,read,_,misc_log_test,db_1,_,"ticket 1"}],misc_log:read_all()),
    ?assertMatch([{alert,_,new,_,misc_log_test,db_1,_,"alert 2"}
		 ],misc_log:print_new()),

    ?assertMatch([{alert,_,_,misc_log_test,db_1,_,"alert 2"}],misc_log:severity_read(alert)),
    ?assertMatch([],misc_log:severity_read(ticket)),
    ?assertMatch([],misc_log:severity_read(info)),
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------    
db_2()->
    ?assertMatch([{alert,_,read,_,misc_log_test,db_1,_,"alert 2"},
		  {info,_,read,_,misc_log_test,db_1,_,"info 1"}],misc_log:print(2)),
    ?assertMatch([{alert,_,read,_,misc_log_test,db_1,_,"alert 2"},
		  {alert,_,read,_,misc_log_test,db_1,_,"alert 1"}],misc_log:print(alert,2)),
    
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------    

cleanup()->
    init:stop(),
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
