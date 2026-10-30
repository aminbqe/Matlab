src = 'C:/Users/aminbgr/Desktop/پروژه ماشین 2/new_fixed.slx';
dst = 'C:/Users/aminbgr/Desktop/پروژه ماشین 2/new_fixed_latched.slx';

load_system(src);
mdl = 'new_fixed';

star_cmp = [mdl '/Compare To Constant'];
delta_cmp = [mdl '/Compare To Constant1'];
star_pos = get_param(star_cmp, 'Position');
delta_pos = get_param(delta_cmp, 'Position');

delete_line(mdl, 'Star command memory/1', 'Compare To Constant/1');
delete_line(mdl, 'Compare To Constant/1', 'Data Type Conversion/1');
delete_block(star_cmp);
add_block('simulink/Discontinuities/Relay', [mdl '/Star latch'], ...
    'Position', star_pos, ...
    'OnSwitchValue', '0.8', 'OffSwitchValue', '0.1', ...
    'OnOutputValue', '0', 'OffOutputValue', '1');
add_line(mdl, 'Star command memory/1', 'Star latch/1', 'autorouting', 'on');
add_line(mdl, 'Star latch/1', 'Data Type Conversion/1', 'autorouting', 'on');

delete_line(mdl, 'Delta command memory/1', 'Compare To Constant1/1');
delete_line(mdl, 'Compare To Constant1/1', 'Data Type Conversion1/1');
delete_block(delta_cmp);
add_block('simulink/Discontinuities/Relay', [mdl '/Delta latch'], ...
    'Position', delta_pos, ...
    'OnSwitchValue', '0.8', 'OffSwitchValue', '0.1', ...
    'OnOutputValue', '1', 'OffOutputValue', '0');
add_line(mdl, 'Delta command memory/1', 'Delta latch/1', 'autorouting', 'on');
add_line(mdl, 'Delta latch/1', 'Data Type Conversion1/1', 'autorouting', 'on');

set_param(mdl, 'StopTime', '2');
save_system(mdl, dst);
close_system(mdl, 0);
