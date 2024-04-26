function model_file = adjustOpenSimJointSet(model_file, joint, value)
    import org.opensim.modeling.*

    % Get bodyset of input model_file
    osim_model = Model(model_file);
    joint_set = osim_model.getJointSet();

    % Set new translation for TRP4_TORUS in model
    coord = joint_set.get(joint).get_coordinates(0);
    coord.setDefaultValue(deg2rad(value))
    coord.setRangeMin(deg2rad(value));

    % Write to model
    osim_model.finalizeConnections();
    osim_model.print(model_file);

end