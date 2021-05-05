%% This is the application resource file (.app file) for the 'base'
%% application.
{application, master_unit_test,
[{description, "master_unit_test  " },
{vsn, "1.0.0" },
{modules, 
	  [master_unit_test_app,master_unit_test_sup,master_unit_test]},
{registered,[master_unit_test]},
{applications, [kernel,stdlib]},
{mod, {master_unit_test_app,[]}},
{start_phases, []}
]}.
