classdef Global_data
    properties
        name    % Name of the country or region
        tier    % Hierarchical level of the data: Global → Country → Region
        data    % All data for this location (cell array format)
    end

    methods
        function obj = Global_data(name, data)
            obj.name = name;
            obj.data = data;
            obj.tier = Global_data.empty;
        end

        function obj = Add_tier(obj, newTier)
            obj.tier(end + 1) = newTier;
        end
    end
end