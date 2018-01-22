function async_gpio_in_init(cursys)

% We need to rename the gateway blocks in the yellow block
% so that they respect the heirarchical naming conventions
% required by the toolflow

% find all the gateway in/out blocks

gateway_ins = find_system(cursys, ...
        'searchdepth', 1, ...
        'FollowLinks', 'on', ...
        'lookundermasks', 'all', ...
        'masktype','Xilinx Gateway In Block');

%rename the gateway ins
for i =1:length(gateway_ins)
    gw = gateway_ins{i};
    gw_name = get_param(gw, 'Name');
    if regexp(gw_name, 'signal_in$')
        set_param(gw, 'Name', clear_name([cursys, '_signal_in']));
    else 
        parent_name = get_param(gw, 'Parent');
        errordlg(['Unknown gateway: ', parent_name, '/', gw_name]);
    end
end


%set mask picture
