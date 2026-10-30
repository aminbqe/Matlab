src = 'C:/Users/aminbgr/Desktop/پروژه ماشین 2/new.slx';
dst = 'C:/Users/aminbgr/Desktop/پروژه ماشین 2/new_fixed.slx';

load_system(src);
mdl = 'new';

% Star command: closed below 0.8 pu, open at and above 0.8 pu.
set_param([mdl '/Compare To Constant'], 'relop', '<', 'const', '0.8');

% Break the direct speed -> switch -> machine -> speed algebraic loops.
add_block('simulink/Discrete/Memory', [mdl '/Star command memory'], ...
    'Position', [575 382 615 418], 'InitialCondition', '0');
delete_line(mdl, 'From3/1', 'Compare To Constant/1');
add_line(mdl, 'From3/1', 'Star command memory/1', 'autorouting', 'on');
add_line(mdl, 'Star command memory/1', 'Compare To Constant/1', 'autorouting', 'on');

add_block('simulink/Discrete/Memory', [mdl '/Delta command memory'], ...
    'Position', [575 492 615 528], 'InitialCondition', '0');
delete_line(mdl, 'From4/1', 'Compare To Constant1/1');
add_line(mdl, 'From4/1', 'Delta command memory/1', 'autorouting', 'on');
add_line(mdl, 'Delta command memory/1', 'Compare To Constant1/1', 'autorouting', 'on');

% Open-transition dead time: delta closes 30 ms after the threshold crossing.
add_block('simulink/Continuous/Transport Delay', [mdl '/Delta dead time'], ...
    'Position', [845 492 900 528], 'DelayTime', '0.03', 'InitialOutput', '0');
delete_line(mdl, 'Data Type Conversion1/1', 'Simulink-PS Converter1/1');
add_line(mdl, 'Data Type Conversion1/1', 'Delta dead time/1', 'autorouting', 'on');
add_line(mdl, 'Delta dead time/1', 'Simulink-PS Converter1/1', 'autorouting', 'on');

set_param(mdl, 'StopTime', '2');
save_system(mdl, dst);
close_system(mdl, 0);

load_system(dst);
try
    set_param('new_fixed', 'StopTime', '0.02');
    sim('new_fixed');
    fprintf('INITIALIZATION_OK\n');
catch ME
    fprintf(2, 'SIMULATION_ERROR:\n%s\n', ...
        getReport(ME, 'extended', 'hyperlinks', 'off'));
end
close_system('new_fixed', 0);
