{application, clock,
 [
  {description, "Windows system/steady time."},
  {vsn, "1.0.0"},
  {modules, [ clock 
            , clock_app
            , clock_sup
            ]},
  {registered, []},
  {applications, [
                  kernel,
                  stdlib
                 ]}
  , {mod, { clock_app, []}}
  , {env, [ { clock_port, "clock_port.exe" } ]}
 ]}.

