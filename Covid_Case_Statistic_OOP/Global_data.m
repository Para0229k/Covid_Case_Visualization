classdef Global_data
    properties
        name    % Country/Region名稱
        tier    % 選取資料的層級，依序為Global - Country - Region
        data    % 該位置的所有資料(Cell型態)
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