function model_file = adjustOpenSimTorus(model_file, shape)
    % Function modifies the torus location to improve TRP4 muscle wrapping
    import org.opensim.modeling.*

    % Read csv table containing new torus location for each shape
    csv = readtable(fullfile('..', '..', 'Python', 'torus_data.csv'));

    % Get bodyset of input model_file
    osim_model = Model(model_file);
    body_set = osim_model.getBodySet();

    % Get shape from osim model mesh_file & use to get new coords from csv
    % shape = "shape_" + string(sscanf(string(shape_mesh.get_mesh_file()), 'shape_%d'));
    csv_row = csv(strcmp(csv.shape, strcat(shape, '.stl')),:);
    trp4_torus_new = Vec3(csv_row.torus_new_x, csv_row.torus_new_y, csv_row.torus_new_z);

    % Set new translation for TRP4_TORUS in model
    trp4_torus = body_set.get('scapula').getWrapObject('TRP4_TORUS');    
    trp4_torus.set_translation(trp4_torus_new);

    % Write to model
    osim_model.finalizeConnections();
    osim_model.print(model_file);

end